#!/usr/bin/env python3
"""Set up and run the WikiPiye Django API and Flutter application."""

from __future__ import annotations

import argparse
import getpass
import os
import secrets
import shutil
import socket
import subprocess
import sys
import time
from typing import NoReturn
from pathlib import Path
from urllib.parse import quote


ROOT = Path(__file__).resolve().parent
API_DIR = ROOT / "wikipiye_api"
APP_DIR = ROOT / "app"
ENV_EXAMPLE = API_DIR / ".env.example"
ENV_FILE = API_DIR / ".env"
DUMP_FILE = API_DIR / "dump" / "wiki_articles.dump"
DATABASE_NAME = "wikipiye"


def fail(message: str) -> NoReturn:
    raise RuntimeError(message)


def run(command: list[str], *, cwd: Path | None = None, env: dict[str, str] | None = None) -> None:
    print(f"\n> {' '.join(command)}")
    subprocess.run(command, cwd=cwd, env=env, check=True)


def require_command(command: str, help_text: str) -> str:
    path = shutil.which(command)
    if path is None:
        fail(f"Could not find '{command}' on PATH. {help_text}")
    return path


def require_postgres_command(command: str) -> str:
    """Find a PostgreSQL executable on PATH or in standard Windows installs."""
    path = shutil.which(command)
    if path:
        return path

    if os.name == "nt":
        program_files = {
            os.environ.get("ProgramFiles"),
            os.environ.get("ProgramW6432"),
            os.environ.get("ProgramFiles(x86)"),
            r"C:\Program Files",
            r"C:\Program Files (x86)",
        }
        for version in ("16", "17", "18"):
            for directory in program_files:
                if directory:
                    candidate = Path(directory) / "PostgreSQL" / version / "bin" / f"{command}.exe"
                    if candidate.is_file():
                        print(f"Using PostgreSQL {version} executable: {candidate}")
                        return str(candidate)

    fail(
        f"Could not find '{command}' on PATH or in standard PostgreSQL 16, 17, or 18 "
        "installation directories. Install PostgreSQL client tools or add its bin "
        "directory to PATH."
    )


def ask_database_credentials() -> tuple[str, str, str, int, str]:
    print("\nPostgreSQL connection details")
    host = input("Host [localhost]: ").strip() or "localhost"
    port_text = input("Port [5432]: ").strip() or "5432"
    try:
        port = int(port_text)
    except ValueError:
        fail("PostgreSQL port must be a number.")
    username = input("Username: ").strip()
    if not username:
        fail("PostgreSQL username cannot be empty.")
    password = getpass.getpass("Password (leave blank if not required): ")
    return host, username, password, port, DATABASE_NAME


def create_virtual_environment() -> Path:
    venv_dir = ROOT / ".venv"
    if not venv_dir.exists():
        print(f"\nCreating Python virtual environment in {venv_dir}")
        run([sys.executable, "-m", "venv", str(venv_dir)])
    python_name = "python.exe" if os.name == "nt" else "python"
    python = venv_dir / "Scripts" / python_name if os.name == "nt" else venv_dir / "bin" / python_name
    if not python.exists():
        fail(f"Virtual environment Python was not created at {python}.")
    return python


def write_environment(host: str, username: str, password: str, port: int) -> None:
    if not ENV_EXAMPLE.exists():
        fail(f"Missing environment template: {ENV_EXAMPLE}")

    values = {
        "DATABASE_URL": (
            f"postgresql://{quote(username, safe='')}:{quote(password, safe='')}"
            f"@{host}:{port}/{DATABASE_NAME}"
        ),
        "SECRET_KEY": secrets.token_urlsafe(48),
    }
    lines = ENV_EXAMPLE.read_text(encoding="utf-8").splitlines()
    output: list[str] = []
    seen: set[str] = set()
    for line in lines:
        key, separator, _ = line.partition("=")
        if separator and key in values:
            output.append(f"{key}={values[key]}")
            seen.add(key)
        else:
            output.append(line)
    for key, value in values.items():
        if key not in seen:
            output.append(f"{key}={value}")
    ENV_FILE.write_text("\n".join(output) + "\n", encoding="utf-8")
    print(f"Created {ENV_FILE}")


def create_database(python: Path, host: str, username: str, password: str, port: int) -> None:
    script = """
import os
import psycopg
from psycopg import sql

host = os.environ["WIKIPIYE_DB_HOST"]
port = int(os.environ["WIKIPIYE_DB_PORT"])
username = os.environ["WIKIPIYE_DB_USERNAME"]
password = os.environ["WIKIPIYE_DB_PASSWORD"]
database_name = os.environ["WIKIPIYE_DB_NAME"]
connection = psycopg.connect(
    host=host, port=port, user=username, password=password, dbname="postgres"
)
connection.autocommit = True
with connection.cursor() as cursor:
    cursor.execute("SELECT 1 FROM pg_database WHERE datname = %s", (database_name,))
    if cursor.fetchone() is None:
        cursor.execute(sql.SQL("CREATE DATABASE {}").format(sql.Identifier(database_name)))
        print(f"Created PostgreSQL database '{database_name}'.")
    else:
        print(f"PostgreSQL database '{database_name}' already exists; keeping it.")
connection.close()
"""
    env = os.environ.copy()
    env.update(
        {
            "WIKIPIYE_DB_HOST": host,
            "WIKIPIYE_DB_PORT": str(port),
            "WIKIPIYE_DB_USERNAME": username,
            "WIKIPIYE_DB_PASSWORD": password,
            "WIKIPIYE_DB_NAME": DATABASE_NAME,
        }
    )
    run(
        [
            str(python),
            "-c",
            script,
        ],
        cwd=API_DIR,
        env=env,
    )


def migrate_and_restore(
    python: Path,
    pg_restore: str,
    host: str,
    username: str,
    password: str,
    port: int,
) -> None:
    run([str(python), "manage.py", "migrate", "--no-input"], cwd=API_DIR)
    restore_env = os.environ.copy()
    restore_env["PGPASSWORD"] = password
    run(
        [
            pg_restore,
            "--clean",
            "--if-exists",
            "--no-owner",
            "--host",
            host,
            "--port",
            str(port),
            "--username",
            username,
            "--dbname",
            DATABASE_NAME,
            str(DUMP_FILE),
        ],
        cwd=ROOT,
        env=restore_env,
    )


def wait_for_port(host: str, port: int, process: subprocess.Popen[bytes], timeout: float = 30) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if process.poll() is not None:
            fail("The Django API stopped before it became ready.")
        try:
            with socket.create_connection((host, port), timeout=1):
                return
        except OSError:
            time.sleep(0.5)
    fail(f"The Django API did not become ready at http://{host}:{port}.")


def run_project(python: Path, flutter: str, api_host: str, api_port: int, device_id: str | None) -> None:
    api_process = subprocess.Popen(
        [str(python), "manage.py", "runserver", f"{api_host}:{api_port}", "--noreload"],
        cwd=API_DIR,
    )
    flutter_process: subprocess.Popen[bytes] | None = None
    try:
        wait_for_port(api_host, api_port, api_process)
        flutter_command = [flutter, "run"]
        if device_id:
            flutter_command.extend(["-d", device_id])
        flutter_process = subprocess.Popen(flutter_command, cwd=APP_DIR)
        print("\nWikiPiye is running. Press Ctrl+C to stop both processes.")
        flutter_process.wait()
    except KeyboardInterrupt:
        print("\nStopping WikiPiye...")
    finally:
        if flutter_process is not None and flutter_process.poll() is None:
            flutter_process.terminate()
        if api_process.poll() is None:
            api_process.terminate()
        for process in (flutter_process, api_process):
            if process is not None:
                process.wait()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--setup-only", action="store_true", help="Set up dependencies and data without starting the apps.")
    parser.add_argument("--device-id", help="Flutter device id passed to 'flutter run -d'.")
    parser.add_argument("--api-host", default="127.0.0.1", help="Django bind host (default: 127.0.0.1).")
    parser.add_argument("--api-port", type=int, default=8000, help="Django bind port (default: 8000).")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    if not API_DIR.exists() or not APP_DIR.exists():
        fail("Run this script from the WikiPiye repository; app/ and wikipiye_api/ are required.")
    if not DUMP_FILE.exists():
        fail(f"Missing PostgreSQL dump: {DUMP_FILE}")

    flutter = require_command("flutter", "Install Flutter and add it to PATH.")
    pg_restore = require_postgres_command("pg_restore")
    host, username, password, port, _ = ask_database_credentials()
    python = create_virtual_environment()
    run([str(python), "-m", "pip", "install", "--upgrade", "pip"], cwd=ROOT)
    run([str(python), "-m", "pip", "install", "-r", "requirements.txt"], cwd=API_DIR)
    run([flutter, "pub", "get"], cwd=APP_DIR)
    write_environment(host, username, password, port)
    create_database(python, host, username, password, port)
    migrate_and_restore(python, pg_restore, host, username, password, port)

    print("\nSetup completed successfully.")
    if args.setup_only:
        print("Run the API with '.venv/bin/python wikipiye_api/manage.py runserver' (Windows: .venv\\Scripts\\python.exe).")
        print("Run the Flutter app with 'flutter run' from app/.")
        return 0
    run_project(python, flutter, args.api_host, args.api_port, args.device_id)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, subprocess.CalledProcessError) as error:
        print(f"\nSetup failed: {error}", file=sys.stderr)
        raise SystemExit(1) from error
