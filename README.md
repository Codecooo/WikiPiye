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

1. Clone repository ini dengan menggunakan terminal atau di dalam VS Code
``` bash 
git clone https://github.com/Codecooo/WikiPiye.git
```
Cara muat data dump psql ARTIKEL DAN SECTIONS.

Keep in mind ini cuma untuk data ARTIKEL dan SECTIONS nya tidak mencakup seluruh tabel yang ada di database.

1. Cara paling mudah dan cepat menggunakan pg_restore bawaan dari Postgres. Pastikan telah membuat database WikiPiye terlebih dahulu.
* Terapkan migration terlebih dahulu
``` bash
python manage.py migrate
```

* Muat dump artikelnya.
``` bash
pg_restore -U username -h localhost -d wikipiye --clean -v wikipiye_api\dump\wiki_articles.dump
```

* Kalau pg_restore not found pake manual:
``` shell
"C:\Program Files\PostgreSQL\16\bin\pg_restore.exe" -U username -h localhost -d wikipiye --clean -v wikipiye_api\dump\wiki_articles.dump
```

2. Menggunakan script Python
Cara ini gk direkomendasikan SOALE LAMA POL kalau lebih dari seribu artikel. Enggak tahu apa emg internet ku atau laptop ku emg lemot tapi tak peringatin cara ini lama. Ini command untuk seed data artikel langsung dari Wikipedia. Pastikan direktori CMD berada di wikipiye_api. Dan pastikan sudah membuat database wikipiye.

* Terapkan migration terlebih dahulu
``` bash
python manage.py migrate
```

* Jalankan command seed artikel
``` bash
python manage.py seed_articles --limit 5000 # Atur sesuai kemampuan kalau ingin cepat cukup ratusan saja
```
