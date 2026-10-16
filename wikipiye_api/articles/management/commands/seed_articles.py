import random
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
from bs4 import BeautifulSoup
from bs4.element import NavigableString
from django.core.management.base import BaseCommand
from django.db import transaction

from articles.models import Article, ArticleSection, EditProtectionLevel

UNWANTED_SELECTORS = [
    "style", "script", "link", "meta",
    "table.infobox", "table.ambox", "div.hatnote",
    "span.mw-editsection", "sup.reference", ".navbox",
]

IGNORED_HEADINGS = {"Referensi", "Pranala luar", "Lihat pula", "Catatan kaki", "Bacaan lanjutan"}
IGNORED_PREFIXES = (
    "Istimewa:", "Halaman_Utama", "Berkas:", "Kategori:",
    "Wikipedia:", "Bantuan:", "Pembicaraan:", "Pengguna:", "Portal:"
)

try:
    import lxml
    HTML_PARSER = "lxml"
except ImportError:
    HTML_PARSER = "html.parser"


def node_to_quill_delta(element):
    ops = []

    def parse_node(node, current_attributes):
        if node is None:
            return

        if isinstance(node, NavigableString):
            text = str(node)
            if text:
                op = {"insert": text}
                if current_attributes:
                    op["attributes"] = current_attributes.copy()
                ops.append(op)
            return

        attrs = current_attributes.copy()
        tag = getattr(node, "name", None)
        if not tag:
            return

        if tag in ["b", "strong"]:
            attrs["bold"] = True
        elif tag in ["i", "em"]:
            attrs["italic"] = True
        elif tag == "a" and node.has_attr("href"):
            href = node["href"]
            if href.startswith("./"):
                href = f"https://id.wikipedia.org/wiki/{href[2:]}"
            attrs["link"] = href

        if tag in ["p", "div"]:
            for child in node.children:
                parse_node(child, attrs)
            ops.append({"insert": "\n"})
        elif tag in ["h1", "h2", "h3", "h4"]:
            try:
                level = int(tag[1])
            except ValueError:
                level = 1
            for child in node.children:
                parse_node(child, attrs)
            ops.append({"insert": "\n", "attributes": {"header": level}})
        elif tag in ["ul", "ol"]:
            list_type = "bullet" if tag == "ul" else "ordered"
            for li in node.find_all("li", recursive=False):
                for child in li.children:
                    parse_node(child, attrs)
                ops.append({"insert": "\n", "attributes": {"list": list_type}})
        elif hasattr(node, "children"):
            for child in node.children:
                parse_node(child, attrs)

    parse_node(element, {})
    return {"ops": ops or [{"insert": "\n"}]}


class Command(BaseCommand):
    help = "Seeding 5000 artikel terpopuler dari Wikipedia Bahasa Indonesia beserta view count"

    def add_arguments(self, parser):
        parser.add_argument("--limit", type=int, default=5000)
        parser.add_argument("--workers", type=int, default=5, help="Jumlah thread concurrent fetch (Disarankan 5 agar tidak dikena rate-limit)")

    def handle(self, *args, **options):
        limit = options["limit"]
        max_workers = options["workers"]

        headers = {
            "User-Agent": "WikiPiyeApp/1.0 (https://wikipiye.id; contact@wikipiye.id)"
        }

        self.stdout.write(self.style.WARNING(f"\n[1/3] Mengambil daftar {limit} judul artikel & total view count..."))
        titles_views_map = self._get_top_titles(limit, headers)
        top_titles = list(titles_views_map.keys())[:limit]
        self.stdout.write(self.style.SUCCESS(f"[✔] Berhasil mendapatkan {len(top_titles)} judul!"))

        self.stdout.write(self.style.WARNING(f"\n[2/3] Mengambil kategori artikel per batch (50 judul/batch)..."))
        categories_map = self._fetch_categories_bulk(top_titles, headers)

        self.stdout.write(self.style.WARNING(f"\n[3/3] Mengunduh, mengolah DOM, & menyimpan batch (Concurrent workers: {max_workers})..."))

        # Setup HTTP session with rate-limit retry logic
        session = requests.Session()
        session.headers.update(headers)
        
        retry_strategy = Retry(
            total=5,
            backoff_factor=1,
            status_forcelist=[429, 500, 502, 503, 504],
            raise_on_status=False
        )
        adapter = HTTPAdapter(max_retries=retry_strategy, pool_connections=max_workers, pool_maxsize=max_workers)
        session.mount("https://", adapter)
        session.mount("http://", adapter)

        batch_data = []
        count = 0

        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = {
                executor.submit(
                    self._fetch_and_parse_article, 
                    session, 
                    title, 
                    categories_map.get(title, ["Umum"]), 
                    titles_views_map.get(title, 0)
                ): title
                for title in top_titles
            }

            for future in as_completed(futures):
                try:
                    result = future.result()
                    if result:
                        batch_data.append(result)
                        count += 1

                        if len(batch_data) >= 100:
                            self._save_batch(batch_data)
                            batch_data.clear()
                            self.stdout.write(f"  -> Terimpor {count}/{len(top_titles)} artikel...")
                except Exception as e:
                    self.stdout.write(self.style.ERROR(f"Error executing worker: {e}"))

        if batch_data:
            self._save_batch(batch_data)

        self.stdout.write(self.style.SUCCESS(f"\n[✔] Selesai! Total {count} artikel berhasil diimpor!"))

    def _get_top_titles(self, limit, headers):
        """Mengekstrak judul artikel dan mengagregasi total view count dari Wikimedia Pageviews API."""
        titles_views = {}
        months = ["2024/01", "2023/12", "2023/11", "2023/10", "2023/09", "2023/08", "2023/07", "2023/06"]

        # 1. Fetch titles & view counts from Pageviews API
        for month in months:
            if len(titles_views) >= limit:
                break
            url = f"https://wikimedia.org/api/rest_v1/metrics/pageviews/top/id.wikipedia.org/all-access/{month}/all-days"
            try:
                res = requests.get(url, headers=headers, timeout=10)
                if res.status_code == 200:
                    for item in res.json().get("items", [{}])[0].get("articles", []):
                        art_title = item.get("article", "")
                        views = item.get("views", 0)
                        if art_title and not art_title.startswith(IGNORED_PREFIXES):
                            clean_title = art_title.replace("_", " ")
                            titles_views[clean_title] = titles_views.get(clean_title, 0) + views
                            if len(titles_views) >= limit:
                                break
            except Exception as e:
                self.stdout.write(self.style.ERROR(f"Error fetching pageviews month {month}: {e}"))

        # 2. Fallback via Wikipedia Category API if limit not reached
        if len(titles_views) < limit:
            self.stdout.write(self.style.WARNING(f"Pageviews menghasilkan {len(titles_views)} artikel. Mengambil sisa dari Kategori Wikipedia..."))
            categories_fallback = [
                "Tokoh_Indonesia", "Kota_di_Indonesia", "Pahlawan_Nasional_Indonesia", 
                "Budaya_Indonesia", "Sejarah_Indonesia", "Rintisan_geografi_Indonesia",
                "Kabupaten_di_Indonesia", "Kecamatan_di_Indonesia", "Film_Indonesia"
            ]
            
            for cat in categories_fallback:
                if len(titles_views) >= limit:
                    break
                
                cat_url = f"https://id.wikipedia.org/w/api.php?action=query&list=categorymembers&cmtitle=Kategori:{cat}&cmlimit=500&format=json"
                try:
                    res_cat = requests.get(cat_url, headers=headers, timeout=10)
                    if res_cat.status_code == 200:
                        members = res_cat.json().get("query", {}).get("categorymembers", [])
                        for member in members:
                            m_title = member.get("title", "")
                            if m_title and not m_title.startswith(IGNORED_PREFIXES):
                                if m_title not in titles_views:
                                    # Default view count untuk artikel kategori fallback
                                    titles_views[m_title] = random.randint(500, 5000)
                            if len(titles_views) >= limit:
                                break
                except Exception as e:
                    self.stdout.write(self.style.ERROR(f"Error fetching category {cat}: {e}"))

        return titles_views

    def _fetch_categories_bulk(self, titles, headers):
        categories_map = {}
        chunk_size = 50

        for i in range(0, len(titles), chunk_size):
            chunk = titles[i:i + chunk_size]
            params = {
                "action": "query",
                "titles": "|".join(chunk),
                "prop": "categories",
                "cllimit": "10",
                "format": "json"
            }
            url = "https://id.wikipedia.org/w/api.php"

            try:
                res = requests.get(url, params=params, headers=headers, timeout=10)
                if res.status_code == 200:
                    pages = res.json().get("query", {}).get("pages", {})
                    for _, page_info in pages.items():
                        title = page_info.get("title")
                        cats = []
                        for cat in page_info.get("categories", []):
                            cat_title = cat.get("title", "").replace("Kategori:", "").strip()
                            if not any(cat_title.startswith(prefix) for prefix in [
                                "Halaman", "Artikel", "Rintisan", "Pemeliharaan", "Semua", "AC dengan"
                            ]):
                                cats.append(cat_title)
                        if title:
                            categories_map[title] = cats or ["Umum"]
            except Exception as e:
                self.stdout.write(self.style.ERROR(f"Category fetch error: {e}"))

        return categories_map

    def _fetch_and_parse_article(self, session, title, categories, views_count):
        encoded_title = requests.utils.quote(title, safe="")
        summary_url = f"https://id.wikipedia.org/api/rest_v1/page/summary/{encoded_title}"
        html_url = f"https://id.wikipedia.org/api/rest_v1/page/html/{encoded_title}"

        try:
            res_sum = session.get(summary_url, timeout=10)
            if res_sum.status_code != 200:
                if res_sum.status_code in [429, 403]:
                    self.stdout.write(self.style.ERROR(f"Throttled/Blocked ({res_sum.status_code}) on title: {title}"))
                return None
            data_sum = res_sum.json()

            res_html = session.get(html_url, timeout=10)
            html_content = res_html.text if res_html.status_code == 200 else ""

            if not html_content:
                return None

            soup = BeautifulSoup(html_content, HTML_PARSER)

            infobox_data = self._extract_infobox_from_soup(soup)

            for selector in UNWANTED_SELECTORS:
                for element in soup.select(selector):
                    element.decompose()

            main_content = soup.find("div", class_="mw-parser-output") or soup
            sections = self._split_dom_into_sections(main_content)

            article_obj = Article(
                title=data_sum.get("title", title),
                summary=data_sum.get("extract", ""),
                banner_image_url=data_sum.get("thumbnail", {}).get("source") if data_sum.get("thumbnail") else None,
                category=categories,
                infobox_data=infobox_data,
                view_count=views_count,
                edit_protection_level=random.choices(list(EditProtectionLevel), weights=[0.85, 0.10, 0.05])[0] # 85% open, 10% semi, 5% full
            )

            return article_obj, sections

        except Exception as e:
            self.stdout.write(self.style.ERROR(f"Error processing article '{title}': {e}"))
            return None

    @staticmethod
    def _extract_infobox_from_soup(soup):
        infobox_table = soup.find("table", class_=lambda c: c and "infobox" in c)
        if not infobox_table:
            return {}

        infobox_data = {}
        for row in infobox_table.find_all("tr"):
            header = row.find("th")
            data = row.find("td")
            if header and data:
                key = header.get_text(strip=True)
                for ref in data.find_all(["sup", "style", "script"]):
                    ref.decompose()
                value = data.get_text(" ", strip=True)
                if key and value:
                    infobox_data[key] = value
        return infobox_data

    @staticmethod
    def _split_dom_into_sections(main_content):
        sections = []
        all_sections = main_content.find_all("section")

        if all_sections:
            for sec in all_sections:
                heading_elem = None
                for child in sec.children:
                    if getattr(child, "name", None) in ["h2", "h3", "h4"]:
                        heading_elem = child
                        break

                if not heading_elem:
                    heading_elem = sec.find(["h2", "h3", "h4"])

                if heading_elem:
                    heading = heading_elem.get_text(strip=True).replace("[sunting]", "").strip()
                    try:
                        level = int(heading_elem.name[1])
                    except (ValueError, IndexError, TypeError):
                        level = 2
                else:
                    heading = "Pendahuluan"
                    level = 1

                nodes = [
                    child for child in sec.children 
                    if child != heading_elem and getattr(child, "name", None) != "section"
                ]

                if heading not in IGNORED_HEADINGS and nodes:
                    sections.append({
                        "heading": heading,
                        "level": level,
                        "nodes": nodes
                    })

            if sections:
                return sections

        current_heading = "Pendahuluan"
        current_level = 1
        current_nodes = []

        for element in main_content.children:
            tag_name = getattr(element, "name", None)
            if tag_name in ["h2", "h3", "h4"]:
                if current_nodes and current_heading not in IGNORED_HEADINGS:
                    sections.append({
                        "heading": current_heading,
                        "level": current_level,
                        "nodes": current_nodes
                    })
                    current_nodes = []
                current_heading = element.get_text(strip=True).replace("[sunting]", "").strip()
                try:
                    current_level = int(tag_name[1])
                except (ValueError, IndexError, TypeError):
                    current_level = 2
            else:
                current_nodes.append(element)

        if current_nodes and current_heading not in IGNORED_HEADINGS:
            sections.append({
                "heading": current_heading,
                "level": current_level,
                "nodes": current_nodes
            })

        return sections or [{"heading": "Pendahuluan", "level": 1, "nodes": list(main_content.children)}]

    def _save_batch(self, batch_data):
        with transaction.atomic():
            articles_list = [item[0] for item in batch_data]
            created_articles = Article.objects.bulk_create(articles_list)

            sections_list = []
            for article, sections in zip(created_articles, [item[1] for item in batch_data]):
                for sec in sections:
                    delta_ops = []
                    for node in sec["nodes"]:
                        delta_ops.extend(node_to_quill_delta(node)["ops"])

                    sections_list.append(
                        ArticleSection(
                            article=article,
                            heading=sec["heading"],
                            level=sec["level"],
                            content_delta={"ops": delta_ops or [{"insert": "\n"}]}
                        )
                    )

            ArticleSection.objects.bulk_create(sections_list)