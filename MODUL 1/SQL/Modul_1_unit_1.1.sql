-- ===================================================================
-- MODUL 1 - UNIT 1.1
-- LATIHAN SOAL SQL: PERSIAPAN SOURCE LAYER DAN INITIAL DATA PROFILING
-- ===================================================================


-- ============================================================
-- A. VERIFIKASI ENVIRONMENT POSTGRESQL
-- ============================================================

-- SOAL 1: Memeriksa versi PostgreSQL
SELECT version();

-- SOAL 2: Memeriksa database dan user aktif
SELECT
    current_database() AS database_aktif,
    current_user AS user_aktif;

-- SOAL 3: Memeriksa keberadaan schema src
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'src';


-- ============================================================
-- B. MEMBUAT SOURCE LAYER
-- ============================================================

-- SOAL 4: Membuat schema dan tabel sumber

-- 1. Membuat schema src
CREATE SCHEMA IF NOT EXISTS src;

-- 2. Membuat sepuluh tabel sumber 
-- Membuat tabel program_studi
CREATE TABLE IF NOT EXISTS src.program_studi (
    kode_prodi TEXT,
    nama_prodi TEXT,
    fakultas TEXT,
    departemen TEXT,
    status TEXT
);

-- Membuat tabel semester
CREATE TABLE IF NOT EXISTS src.semester (
    semester_id TEXT,
    tahun_akademik TEXT,
    term TEXT,
    urutan_tahun INTEGER,
    tanggal_mulai TEXT,
    tanggal_selesai TEXT
);

-- Membuat tabel mahasiswa
CREATE TABLE IF NOT EXISTS src.mahasiswa (
    nim TEXT,
    nama TEXT,
    jk_raw TEXT,
    tanggal_lahir_raw TEXT,
    kota_asal_raw TEXT,
    kode_prodi_raw TEXT,
    prodi_raw TEXT,
    angkatan TEXT,
    tanggal_masuk_raw TEXT,
    status_raw TEXT,
    email_kampus TEXT
);

-- Membuat tabel dosen
CREATE TABLE IF NOT EXISTS src.dosen (
    nidn TEXT,
    nama_dosen TEXT,
    jk_raw TEXT,
    unit_prodi_raw TEXT,
    jabatan_akademik TEXT,
    tanggal_masuk_raw TEXT,
    status TEXT
);

-- Membuat tabel mata_kuliah
CREATE TABLE IF NOT EXISTS src.mata_kuliah (
    kode_mk TEXT,
    nama_mk TEXT,
    kode_prodi TEXT,
    sks INTEGER,
    semester_rekomendasi INTEGER,
    kategori TEXT,
    aktif TEXT
);

-- Membuat tabel krs
CREATE TABLE IF NOT EXISTS src.krs (
    krs_id TEXT,
    nim TEXT,
    kode_mk TEXT,
    semester_id TEXT,
    kelas TEXT,
    status_krs TEXT,
    tanggal_ambil_raw TEXT,
    sumber_sistem TEXT
);

-- Membuat tabel nilai
CREATE TABLE IF NOT EXISTS src.nilai (
    nilai_id TEXT,
    nim TEXT,
    kode_mk TEXT,
    semester_id TEXT,
    nilai_angka NUMERIC(6,2),
    nilai_huruf TEXT,
    status_lulus TEXT,
    tanggal_input_raw TEXT
);

-- 9. Membuat tabel aktivitas_lms
CREATE TABLE IF NOT EXISTS src.aktivitas_lms (
    lms_event_id TEXT,
    nim TEXT,
    kode_mk TEXT,
    semester_id TEXT,
    waktu_event TEXT,
    tipe_event TEXT,
    durasi_menit INTEGER,
    skor_kuis NUMERIC(6,2),
    platform TEXT
);

-- Membuat tabel pembayaran
CREATE TABLE IF NOT EXISTS src.pembayaran (
    pembayaran_id TEXT,
    nim TEXT,
    semester_id TEXT,
    tanggal_bayar_raw TEXT,
    nominal_tagihan BIGINT,
    nominal_bayar BIGINT,
    status_pembayaran TEXT,
    kanal TEXT
);

-- Membuat tabel kelulusan
CREATE TABLE IF NOT EXISTS src.kelulusan (
    kelulusan_id TEXT,
    nim TEXT,
    tanggal_lulus_raw TEXT,
    ipk_final NUMERIC(4,2),
    masa_studi_bulan INTEGER,
    predikat TEXT,
    status_tepat_waktu TEXT
);

-- 3. Memeriksa seluruh tabel yang berhasil dibuat
SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema = 'src'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;



-- ============================================================
-- C. Mengimpor Dataset Raw 
-- ============================================================

-- Soal 5. Mengimpor sepuluh file CSV ke source layer

SELECT 'program_studi' AS nama_tabel, COUNT(*) AS jumlah_baris FROM src.program_studi
UNION ALL
SELECT 'semester', COUNT(*) FROM src.semester
UNION ALL
SELECT 'mahasiswa', COUNT(*) FROM src.mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*) FROM src.dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah
UNION ALL
SELECT 'krs', COUNT(*) FROM src.krs
UNION ALL
SELECT 'nilai', COUNT(*) FROM src.nilai
UNION ALL
SELECT 'aktivitas_lms', COUNT(*) FROM src.aktivitas_lms
UNION ALL
SELECT 'pembayaran', COUNT(*) FROM src.pembayaran
UNION ALL
SELECT 'kelulusan', COUNT(*) FROM src.kelulusan;


-- ============================================================
-- D. Inventarisasi dan Verifikasi Source
-- ============================================================

-- Soal 6. Menginventarisasi tabel pada schema src
SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema = 'src'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;

--Untuk laporan – Interpretasi: Query tersebut digunakan untuk menampilkan seluruh tabel yang terdapat pada schema src. 
  --Hasil inventarisasi menunjukkan bahwa terdapat 10 tabel sumber yang telah dibuat. 
  --Seluruh tabel tersebut digunakan sebagai tempat penyimpanan data awal sebelum dilakukan proses pengolahan lebih lanjut.


-- Soal 7. Memverifikasi jumlah baris pada lima tabel master/reference
	--Lima tabel yang diperiksa adalah program_studi, semester, mahasiswa, dosen, dan mata_kuliah.

SELECT 'program_studi' AS tabel, COUNT(*) AS jumlah_baris FROM src.program_studi
UNION ALL SELECT 'semester',    COUNT(*) FROM src.semester
UNION ALL SELECT 'mahasiswa',   COUNT(*) FROM src.mahasiswa
UNION ALL SELECT 'dosen',       COUNT(*) FROM src.dosen
UNION ALL SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah
ORDER BY tabel;


-- Soal 8. Memverifikasi jumlah baris seluruh sepuluh tabel sumber
SELECT 'program_studi' AS tabel, COUNT(*) AS jumlah_baris FROM src.program_studi
UNION ALL
SELECT 'semester', COUNT(*) FROM src.semester
UNION ALL
SELECT 'mahasiswa', COUNT(*) FROM src.mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*) FROM src.dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah
UNION ALL
SELECT 'krs', COUNT(*) FROM src.krs
UNION ALL
SELECT 'nilai', COUNT(*) FROM src.nilai
UNION ALL
SELECT 'aktivitas_lms', COUNT(*) FROM src.aktivitas_lms
UNION ALL
SELECT 'pembayaran', COUNT(*) FROM src.pembayaran
UNION ALL
SELECT 'kelulusan', COUNT(*) FROM src.kelulusan
ORDER BY tabel;


-- Soal 9. Menghitung jumlah kolom setiap tabel sumber
SELECT
    table_name,
    COUNT(*) AS jumlah_kolom
FROM information_schema.columns
WHERE table_schema = 'src'
GROUP BY table_name
ORDER BY table_name;


--Soal 10. Memeriksa struktur kolom tabel mahasiswa
SELECT
    ordinal_position AS posisi_kolom,
    column_name      AS nama_kolom,
    data_type        AS tipe_data
FROM information_schema.columns
WHERE table_schema = 'src'
  AND table_name = 'mahasiswa'
ORDER BY ordinal_position;


-- ============================================================
-- E. INITIAL PROFILING DATA MAHASISWA
-- ============================================================

-- SOAL 11. MEMERIKSA CANDIDATE KEY
SELECT
    COUNT(*) AS raw_rows,
    COUNT(DISTINCT nim) AS distinct_nim,
    COUNT(*) - COUNT(DISTINCT nim) AS excess_duplicate_rows
FROM src.mahasiswa;

-- SOAL 12. MENGETAHUI RENTANG TAHUN ANGKATAN MAHASISW
SELECT
    MIN(CAST(angkatan AS INTEGER)) AS angkatan_min,
    MAX(CAST(angkatan AS INTEGER)) AS angkatan_max
FROM src.mahasiswa;


-- SOAL 13. MENGHITUNG DATA KOTA ASAL YANG KOSONG
SELECT COUNT(*) AS missing_kota
FROM src.mahasiswa
WHERE TRIM(COALESCE(kota_asal_raw, '')) = '';


-- SOAL 14. MENGHITUNG VARIASI LABEL PROGRAM STUDI
SELECT COUNT(DISTINCT prodi_raw) AS distinct_prodi_raw
FROM src.mahasiswa;


-- SOAL 15. MENGHITUNG JUMLAH PROGRAM STUDI PADA TABEL REFERENSI
SELECT COUNT(*) AS canonical_programs
FROM src.program_studi;


-- SOAL 16. MENAMPILKAN DISTRIBUSI LABEL PROGRAM STUDI MENTAH
SELECT
    prodi_raw,
    COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY prodi_raw
ORDER BY prodi_raw;


-- SOAL 17. MENAMPILKAN VARIASI JENIS KELAMIN MAHASISWA
SELECT
    jk_raw,
    COUNT(*) AS jumlah
FROM src.mahasiswa
GROUP BY jk_raw
ORDER BY jk_raw;


-- SOAL 18. MENAMPILKAN SAMPEL RECORD TABEL MAHASISWA
SELECT * FROM src.mahasiswa
LIMIT 5;


-- ============================================================
-- F. PROFILING UKURAN SOURCE DAN RELASI AWAL ANTAR-TABEL
-- ============================================================

-- SOAL 19. MENGIDENTIFIKASI SOURCE DENGAN JUMLAH BARIS TERBESAR
SELECT 'program_studi' AS source, COUNT(*) AS rows FROM src.program_studi
UNION ALL SELECT 'semester', COUNT(*) FROM src.semester
UNION ALL SELECT 'mahasiswa', COUNT(*) FROM src.mahasiswa
UNION ALL SELECT 'dosen', COUNT(*) FROM src.dosen
UNION ALL SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah
UNION ALL SELECT 'krs', COUNT(*) FROM src.krs
UNION ALL SELECT 'nilai', COUNT(*) FROM src.nilai
UNION ALL SELECT 'aktivitas_lms', COUNT(*) FROM src.aktivitas_lms
UNION ALL SELECT 'pembayaran', COUNT(*) FROM src.pembayaran
UNION ALL SELECT 'kelulusan', COUNT(*) FROM src.kelulusan
ORDER BY rows DESC;


-- SOAL 20. MENGIDENTIFIKASI INDIKASI RELASI MAHASISWA DENGAN TABEL TRANSAKSI
SELECT 'krs' AS source, COUNT(DISTINCT nim) AS distinct_nim
FROM src.krs
UNION all SELECT 'nilai', COUNT(DISTINCT nim) FROM src.nilai
UNION all SELECT 'aktivitas_lms', COUNT(DISTINCT nim) FROM src.aktivitas_lms
UNION all SELECT 'pembayaran', COUNT(DISTINCT nim) FROM src.pembayaran
UNION all SELECT 'kelulusan', COUNT(DISTINCT nim) FROM src.kelulusan;
