# WikiPiye
WikiPiye adalah aplikasi clone dari Wikipedia dalam Flutter menggunakan custom API. Fiturnya meliputi membaca artikel, edit artikel, membuat artikel, dan histori artikel.

## Tim
Tim kami beranggotakan 5 orang dalam menyusun aplikasi ini yaitu:
1. Anugerah Tallenta Agung (24051214132)
2. Mutiah
3. Sayyidina Aldhito
4. Rafinara Ardhani
5. Yolanda

## Cara Menjalankan
Syarat utama dalam menjalankan proyek ini adalah Flutter SDK, Python, PostgreSQL dan pip telah terinstall di PC masing-masing.

Clone repository ini dengan menggunakan terminal atau di dalam VS Code
``` bash 
git clone https://github.com/Codecooo/WikiPiye.git
```

### Setup otomatis (Windows, macOS, dan Linux)

Pastikan Python, Flutter, dan PostgreSQL sudah terpasang. PostgreSQL client tools
(`pg_restore`) harus tersedia di `PATH`, atau terpasang pada lokasi standar
Windows PostgreSQL versi 16, 17, atau 18. Dari direktori root repository, jalankan:

```bash
python setup_project.py
```

Script ini akan membuat virtual environment `.venv`, memasang dependency API dan
Flutter, meminta kredensial PostgreSQL, membuat database `wikipiye`, membuat
`wikipiye_api/.env`, menjalankan migration, memuat
`wikipiye_api/dump/wiki_articles.dump`, lalu menjalankan API dan Flutter.

Untuk hanya menyiapkan project tanpa menjalankannya:

```bash
python setup_project.py --setup-only
```

Jika memiliki beberapa perangkat Flutter, tentukan perangkat yang digunakan:

```bash
python setup_project.py --device-id <device-id>
```