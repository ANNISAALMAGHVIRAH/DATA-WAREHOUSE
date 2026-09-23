-- UADW v1.0 - Modul Praktikum 01
CREATE SCHEMA IF NOT EXISTS src;
DROP TABLE IF EXISTS src.program_studi;
CREATE TABLE src.program_studi (kode_prodi TEXT,nama_prodi TEXT,fakultas TEXT,departemen TEXT,status TEXT);
DROP TABLE IF EXISTS src.semester;
CREATE TABLE src.semester (semester_id TEXT,tahun_akademik TEXT,term TEXT,urutan_tahun TEXT,tanggal_mulai TEXT,tanggal_selesai TEXT);
DROP TABLE IF EXISTS src.mahasiswa;
CREATE TABLE src.mahasiswa (nim TEXT,nama TEXT,jk_raw TEXT,tanggal_lahir_raw TEXT,kota_asal_raw TEXT,kode_prodi_raw TEXT,prodi_raw TEXT,angkatan TEXT,tanggal_masuk_raw TEXT,status_raw TEXT,email_kampus TEXT);
DROP TABLE IF EXISTS src.dosen;
CREATE TABLE src.dosen (nidn TEXT,nama_dosen TEXT,jk_raw TEXT,unit_prodi_raw TEXT,jabatan_akademik TEXT,tanggal_masuk_raw TEXT,status TEXT);
DROP TABLE IF EXISTS src.mata_kuliah;
CREATE TABLE src.mata_kuliah (kode_mk TEXT,nama_mk TEXT,kode_prodi TEXT,sks TEXT,semester_rekomendasi TEXT,kategori TEXT,aktif TEXT);



-- DATA INVENTORY LENGKAP
SELECT 'program_studi' AS "Tabel", COUNT(*) AS "Jumlah Baris",
    5 AS "Jumlah Kolom",
    'kode_prodi' AS "Natural Key Candidat",
    'Reference Data' AS "Peran Bisnis"
FROM src.program_studi
UNION ALL
SELECT 'semester', COUNT(*),
    6,
    'semester_id',
    'Reference Data'
FROM src.semester
UNION ALL
SELECT 'mahasiswa', COUNT(*),
    11,
    'nim',
    'Master Data'
FROM src.mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*),
    7,
    'nidn',
    'Master Data'
FROM src.dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*),
    7,
    'kode_mk',
    'Master Data'
FROM src.mata_kuliah;




-- Guide Excercise D - Eksplorasi Awal
-- mencari jumlah mahasiswa dan duplikat
SELECT COUNT(*) AS raw_rows,
COUNT(DISTINCT nim) AS distinct_nim,
COUNT(*) - COUNT(DISTINCT nim) AS selisih
from src.mahasiswa;
--cari missing data kolom kota_raw
SELECT COUNT(*) AS missing_kota
FROM src.mahasiswa
WHERE TRIM(COALESCE(kota_asal_raw,'')) = '';
--variasi label program studi
SELECT prodi_raw, COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY prodi_raw
ORDER BY prodi_raw;




--jumlah baris dari 5 tabel sumber
SELECT 'program_studi' AS tabel, COUNT(*) AS jumlah_baris
FROM src.program_studi
UNION ALL
SELECT 'semester', COUNT(*)
FROM src.semester
UNION ALL
SELECT 'mahasiswa', COUNT(*)
FROM src.mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*)
FROM src.dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*)
FROM src.mata_kuliah;



--jumlah nim unik mahasiswa.csv
select COUNT(*) AS jumlah_baris,
    COUNT(DISTINCT nim) AS jumlah_nim_unik,
    CASE
        WHEN COUNT(*) = COUNT(DISTINCT nim)
        THEN 'Sama'
        ELSE 'Tidak sama'
    END AS keterangan
FROM src.mahasiswa;



--baris mahasiswa yang excess duplicate jika NIM dianggap natural key?
select COUNT(*) AS raw_rows,
    COUNT(DISTINCT nim) AS distinct_nim,
    COUNT(*) - COUNT(DISTINCT nim) AS excess_duplicate_rows
FROM src.mahasiswa;



--rentang angkatan pada base load
SELECT
    MIN(CAST(angkatan AS INTEGER)) AS angkatan_terendah,
    MAX(CAST(angkatan AS INTEGER)) AS angkatan_tertinggi
FROM src.mahasiswa
WHERE TRIM(COALESCE(angkatan, '')) <> '';
--melihat seluruh angkatan yang tersedia
SELECT
    angkatan,
    COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY angkatan
ORDER BY angkatan;



--mahasiswa yang kota_asal_raw-nya kosong
SELECT COUNT(*) AS missing_kota
FROM src.mahasiswa
WHERE TRIM(COALESCE(kota_asal_raw, '')) = '';



--Banyak label prodi_raw yang berbeda (Bandingkan dengan jumlah program studi canonical.)
SELECT
    COUNT(DISTINCT TRIM(prodi_raw)) AS jumlah_label_prodi_raw
FROM src.mahasiswa;
-- Melihat jumlah program studi canonical:
SELECT
    COUNT(*) AS jumlah_prodi_canonical
FROM src.program_studi;
--Agar langsung dibandingkan:
SELECT
    (SELECT COUNT(DISTINCT TRIM(prodi_raw))
     FROM src.mahasiswa) AS label_prodi_raw,
    (SELECT COUNT(*)
     FROM src.program_studi) AS prodi_canonical;
--Untuk melihat variasi labelnya:
SELECT
    prodi_raw,
    COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY prodi_raw
ORDER BY prodi_raw;




--Tiga pola lain bahwa source data belum siap dimasukkan ke Dimension Table.
--Duplikasi NIM
SELECT nim, COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY nim
HAVING COUNT(*) > 1
ORDER BY jumlah DESC;
--Penulisan nama program studi tidak seragam
SELECT prodi_raw, COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY prodi_raw
ORDER BY prodi_raw;
--Data jenis kelamin yang tidak konsisten
select jk_raw, COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY jk_raw
ORDER BY jk_raw;
--Status mahasiswa yang bervariasi
select status_raw, COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY status_raw
ORDER BY status_raw;
--Tanggal lahir kosong
SELECT COUNT(*) AS tanggal_lahir_kosong
FROM src.mahasiswa
WHERE TRIM(COALESCE(tanggal_lahir_raw, '')) = '';




--Kelompokkan lima file menjadi master/reference data atau transactional data.
select 'program_studi' AS nama_tabel, COUNT(*) AS jumlah_data,
    'Reference Data' AS kelompok,
    'Karena merupakan tabel rujukan nama dan kode jurusan' AS alasan
FROM src.program_studi

UNION ALL
select 'semester', COUNT(*),
    'Reference Data',
    'Karena merupakan tabel rujukan periode akademik kampus'
FROM src.semester

UNION ALL
select 'mahasiswa', COUNT(*),
    'Master Data',
    'Karena merupakan entitas utama pelaku akademik'
FROM src.mahasiswa
UNION all

select 'dosen', COUNT(*),
    'Master Data',
    'Karena merupakan entitas utama tenaga pengajar'
FROM src.dosen

UNION ALL
select 'mata_kuliah', COUNT(*),
    'Master Data',
    'Karena merupakan entitas utama materi kurikulum dan SKS'
FROM src.mata_kuliah;



--lima pertanyaan analitik
SELECT 1 AS no,
       'Berapa jumlah mahasiswa yang mengambil setiap mata kuliah?' AS pertanyaan_analitik,
       'KRS' AS dataset_tambahan
UNION ALL
SELECT 2,
       'Berapa nilai yang diperoleh mahasiswa setiap mata kuliah?',
       'Nilai'
UNION ALL
SELECT 3,
       'Bagaimana tingkat kehadiran mahasiswa setiap semester?',
       'Presensi'
UNION ALL
SELECT 4,
       'Berapa jumlah mahasiswa yang melakukan pembayaran kuliah?',
       'Pembayaran'
UNION ALL
SELECT 5,
       'Bagaimana perkembangan IPK mahasiswa dari semester ke semester?',
       'KHS';

