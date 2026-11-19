-- =========================================================
-- MODUL 1 - UNIT 1.2
-- SQL: DATA PROFILING DAN DATA QUALITY ASSESSMENT
-- Studi Kasus: Database Akademik Perguruan Tinggi
-- DBMS: PostgreSQL | Schema: src
-- Dataset: program_studi, semester, mahasiswa, dosen,
--          mata_kuliah, krs, nilai, aktivitas_lms,
--          pembayaran, kelulusan
-- =========================================================


-- Menyiapkan dan Memverifikasi Environment Praktikum
SELECT version();

-- Memeriksa database dan user aktif
select
    current_database() as database_aktif,
    current_user as user_aktif;

-- Memastikan schema src tersedia
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'src';

-- =========================================================
-- A. PROFILING STRUKTUR DAN UKURAN DATASET
-- =========================================================

-- SOAL 1. Menghitung jumlah record setiap tabel
SELECT 'program_studi' AS nama_dataset, COUNT(*) AS jumlah_record FROM src.program_studi
UNION ALL SELECT 'semester', COUNT(*) FROM src.semester
UNION ALL SELECT 'mahasiswa', COUNT(*) FROM src.mahasiswa
UNION ALL SELECT 'dosen', COUNT(*) FROM src.dosen
UNION ALL SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah
UNION ALL SELECT 'krs', COUNT(*) FROM src.krs
UNION ALL SELECT 'nilai', COUNT(*) FROM src.nilai
UNION ALL SELECT 'aktivitas_lms', COUNT(*) FROM src.aktivitas_lms
UNION ALL SELECT 'pembayaran', COUNT(*) FROM src.pembayaran
UNION ALL SELECT 'kelulusan', COUNT(*) FROM src.kelulusan;


-- SOAL 2. Menghitung jumlah kolom setiap tabel
SELECT table_name AS nama_tabel, COUNT(*) AS jumlah_kolom
FROM information_schema.columns
WHERE table_schema = 'src'
GROUP BY table_name
ORDER BY table_name ASC;


-- =========================================================
-- B. MAHASISWA - UNIQUENESS
-- =========================================================

-- SOAL 3. Mengukur keunikan NIM
SELECT
    COUNT(*) AS jumlah_seluruh_record,
    COUNT(DISTINCT nim) AS jumlah_nim_unik,
    COUNT(*) - COUNT(DISTINCT nim) AS indikasi_kelebihan_record_duplikat
FROM src.mahasiswa;


-- SOAL 4. Mengidentifikasi NIM duplikat
SELECT nim, COUNT(*) AS jumlah_kemunculan
FROM src.mahasiswa
GROUP BY nim
HAVING COUNT(*) > 1
ORDER BY jumlah_kemunculan DESC, nim ASC;


-- =========================================================
-- C. MAHASISWA - COMPLETENESS
-- =========================================================

-- SOAL 5. Memeriksa kelengkapan kota asal mahasiswa
SELECT COUNT(*) AS jumlah_kota_asal_kosong
FROM src.mahasiswa
WHERE kota_asal_raw IS NULL
   OR BTRIM(kota_asal_raw) = '';


-- =========================================================
-- D. MAHASISWA - DISTRIBUTION DAN STANDARDISASI
-- =========================================================

-- SOAL 6. Distribusi mahasiswa berdasarkan program studi
SELECT prodi_raw, COUNT(*) AS jumlah_mahasiswa
FROM src.mahasiswa
GROUP BY prodi_raw
ORDER BY jumlah_mahasiswa DESC, prodi_raw;


-- SOAL 7. Menghitung variasi penulisan program studi
SELECT COUNT(DISTINCT prodi_raw) AS jumlah_variasi_nama_prodi
FROM src.mahasiswa
WHERE prodi_raw IS NOT NULL
  AND BTRIM(prodi_raw) <> '';


-- SOAL 8. Distribusi jenis kelamin mahasiswa
SELECT jk_raw, COUNT(*) AS jumlah_mahasiswa
FROM src.mahasiswa
GROUP BY jk_raw
ORDER BY jumlah_mahasiswa DESC, jk_raw;


-- SOAL 9. Distribusi status mahasiswa
SELECT status_raw, COUNT(*) AS jumlah_record
FROM src.mahasiswa
GROUP BY status_raw
ORDER BY jumlah_record DESC, status_raw;


-- SOAL 10. Distribusi kode program studi
SELECT kode_prodi_raw, COUNT(*) AS jumlah_mahasiswa
FROM src.mahasiswa
GROUP BY kode_prodi_raw
ORDER BY jumlah_mahasiswa DESC, kode_prodi_raw;


-- SOAL 11. Nama program studi yang tidak sesuai standar
SELECT COUNT(*) AS jumlah_prodi_tidak_ditemukan
FROM src.mahasiswa m
WHERE m.prodi_raw IS NOT NULL
  AND BTRIM(m.prodi_raw) <> ''
  AND NOT EXISTS (
      SELECT 1
      FROM src.program_studi p
      WHERE p.nama_prodi = m.prodi_raw
  );


-- =========================================================
-- E. MAHASISWA - KONSISTENSI FORMAT TANGGAL
-- =========================================================

-- SOAL 12. Mengidentifikasi variasi format tanggal masuk
WITH klasifikasi AS (
    SELECT
        CASE
            WHEN tanggal_masuk_raw ~ '^\d{4}-\d{2}-\d{2}$'        THEN 'YYYY-MM-DD'
            WHEN tanggal_masuk_raw ~ '^\d{2}/\d{2}/\d{4}$'        THEN 'DD/MM/YYYY'
            WHEN tanggal_masuk_raw ~ '^\d{2}-[A-Za-z]{3}-\d{4}$'   THEN 'DD-Mon-YYYY'
            ELSE 'OTHER'
        END AS format_tanggal
    FROM src.mahasiswa
)
SELECT
    f.format_tanggal,
    COUNT(k.format_tanggal) AS jumlah_record
FROM (VALUES ('YYYY-MM-DD'), ('DD/MM/YYYY'), ('DD-Mon-YYYY'), ('OTHER')) AS f(format_tanggal)
LEFT JOIN klasifikasi k ON k.format_tanggal = f.format_tanggal
GROUP BY f.format_tanggal
ORDER BY jumlah_record DESC;

-- Interpretasi:
    -- Berdasarkan hasil query, ditemukan tiga variasi format tanggal masuk mahasiswa. 
    -- Format yang paling banyak digunakan adalah YYYY-MM-DD sebanyak 1.429 data. 
    -- Hal ini menunjukkan bahwa penulisan tanggal masuk mahasiswa belum sepenuhnya seragam sehingga perlu dilakukan standarisasi pada tahap pengolahan data selanjutnya.


-- =========================================================
-- F. KRS - DUPLIKASI DATA
-- =========================================================

-- SOAL 13. Membandingkan jumlah record KRS dengan KRS unik
SELECT
    COUNT(*) AS jumlah_seluruh_record_krs,
    COUNT(DISTINCT krs_id) AS jumlah_krs_id_unik
FROM src.krs;


-- SOAL 14. Mengidentifikasi duplikasi pengambilan mata kuliah
SELECT nim, kode_mk, semester_id, COUNT(*) AS jumlah_kemunculan
FROM src.krs
GROUP BY nim, kode_mk, semester_id
HAVING COUNT(*) > 1
ORDER BY jumlah_kemunculan DESC, nim, kode_mk, semester_id;


-- SOAL 15. Menghitung jumlah record KRS yang berlebih akibat duplikasi
SELECT COALESCE(SUM(jumlah_kemunculan - 1), 0) AS total_kelebihan_record_duplikat
FROM (
    SELECT COUNT(*) AS jumlah_kemunculan
    FROM src.krs
    GROUP BY nim, kode_mk, semester_id
    HAVING COUNT(*) > 1
) AS kelompok_duplikat;


-- =========================================================
-- G. NILAI - COMPLETENESS DAN VALIDITY
-- =========================================================

-- SOAL 16. Menghitung nilai angka yang kosong
SELECT COUNT(*) AS jumlah_nilai_angka_kosong
FROM src.nilai
WHERE nilai_angka IS NULL;


-- SOAL 17. Mengidentifikasi nilai angka di luar rentang 0 sampai 100
SELECT COUNT(*) AS jumlah_nilai_di_luar_rentang
FROM src.nilai
WHERE nilai_angka IS NOT NULL
  AND (nilai_angka < 0 OR nilai_angka > 100);


-- SOAL 18. Statistik deskriptif nilai mahasiswa yang valid
SELECT
    COUNT(*) AS jumlah_record_nilai_valid,
    MIN(nilai_angka) AS nilai_terendah,
    MAX(nilai_angka) AS nilai_tertinggi,
    AVG(nilai_angka) AS nilai_rata_rata
FROM src.nilai
WHERE nilai_angka BETWEEN 0 AND 100;


-- =========================================================
-- H. NILAI - KONSISTENSI NILAI ANGKA, HURUF, DAN KELULUSAN
-- =========================================================

-- SOAL 19. Memeriksa konsistensi nilai angka dengan nilai huruf
WITH nilai_valid AS (
    SELECT
        nilai_id,
        NULLIF(TRIM(nilai_angka::text), '')::numeric AS angka,
        TRIM(nilai_huruf) AS huruf
    FROM src.nilai
)
SELECT COUNT(*) AS letter_mismatch FROM nilai_valid
WHERE angka BETWEEN 0 AND 100
  AND huruf IS DISTINCT FROM CASE
        WHEN angka >= 85 THEN 'A'
        WHEN angka >= 80 THEN 'AB'
        WHEN angka >= 75 THEN 'B'
        WHEN angka >= 70 THEN 'BC'
        WHEN angka >= 60 THEN 'C'
        WHEN angka >= 50 THEN 'D'
        ELSE 'E'
      END;


-- SOAL 20. Memeriksa konsistensi nilai angka dengan status kelulusan
WITH nilai_valid AS (
    SELECT
        NULLIF(TRIM(nilai_angka::text), '')::numeric AS angka,
        TRIM(status_lulus) AS status_lulus
    FROM src.nilai
)
SELECT COUNT(*) AS status_mismatch
FROM nilai_valid
WHERE angka BETWEEN 0 AND 100
  AND ( (angka >= 60 AND status_lulus IS DISTINCT FROM 'Lulus')
     OR (angka <  60 AND status_lulus IS DISTINCT FROM 'Tidak Lulus') );


-- =========================================================
-- I. NILAI - DUPLIKASI DATA
-- =========================================================

-- SOAL 21. Mengidentifikasi duplikasi record nilai
SELECT nim, kode_mk, semester_id, COUNT(*) AS jumlah_kemunculan
FROM src.nilai
GROUP BY nim, kode_mk, semester_id
HAVING COUNT(*) > 1
ORDER BY jumlah_kemunculan DESC, nim, kode_mk, semester_id;


-- =========================================================
-- J. REFERENTIAL INTEGRITY - KRS, NILAI, MAHASISWA,
--    MATA KULIAH, DAN SEMESTER
-- =========================================================

-- SOAL 22. NIM KRS yang tidak terdaftar di mahasiswa
SELECT COUNT(*) AS krs_nim_tidak_terdaftar
FROM src.krs k
LEFT JOIN src.mahasiswa m ON k.nim = m.nim
WHERE m.nim IS NULL;


-- SOAL 23. NIM pada tabel nilai yang tidak terdaftar di mahasiswa
SELECT COUNT(*) AS nim_tidak_terdaftar
FROM src.nilai n
LEFT JOIN src.mahasiswa m ON n.nim = m.nim
WHERE m.nim IS NULL;

-- SOAL 24. Kode mata kuliah pada nilai yang tidak memiliki referensi
SELECT COUNT(*) AS orphan_nilai_mk
FROM src.nilai n
LEFT JOIN src.mata_kuliah mk ON n.kode_mk = mk.kode_mk
WHERE mk.kode_mk IS NULL;


-- SOAL 25. Semester pada nilai yang tidak memiliki referensi
SELECT COUNT(*) AS orphan_nilai_semester
FROM src.nilai n
LEFT JOIN src.semester s ON n.semester_id = s.semester_id
WHERE s.semester_id IS NULL;


-- =========================================================
-- K. AKTIVITAS LMS - UNIQUENESS DAN DISTRIBUTION
-- =========================================================

-- SOAL 26. Mengukur duplikasi aktivitas LMS
SELECT
    COUNT(*)                          AS raw_rows,
    COUNT(DISTINCT lms_event_id)      AS distinct_event_id,
    COUNT(*) - COUNT(DISTINCT lms_event_id) AS duplicate_excess
FROM src.aktivitas_lms;


-- SOAL 27. Menganalisis distribusi tipe aktivitas LMS
SELECT
    tipe_event,
    COUNT(*) AS jumlah
FROM src.aktivitas_lms
GROUP BY tipe_event
ORDER BY jumlah DESC, tipe_event;


-- SOAL 28. Memeriksa kelengkapan skor kuis pada aktivitas quiz_attempt
SELECT COUNT(*) AS quiz_missing_score
FROM src.aktivitas_lms
WHERE tipe_event = 'quiz_attempt'
  AND (skor_kuis IS NULL OR TRIM(skor_kuis::text) = '');


-- SOAL 29. Mengidentifikasi skor pada aktivitas selain kuis
SELECT COUNT(*) AS nonquiz_with_score
FROM src.aktivitas_lms
WHERE tipe_event <> 'quiz_attempt'
  AND skor_kuis IS NOT NULL
  AND TRIM(skor_kuis::text) <> '';


-- =========================================================
-- L. PEMBAYARAN - VALIDITY DAN COMPLETENESS
-- =========================================================

-- SOAL 30. Mengidentifikasi nominal pembayaran negatif
SELECT COUNT(*) AS negative_payment
FROM src.pembayaran
WHERE nominal_bayar < 0;


-- SOAL 31. Memeriksa tanggal pembayaran yang kosong
SELECT COUNT(*) AS positive_payment_missing_date
FROM src.pembayaran
WHERE nominal_bayar > 0
  AND (tanggal_bayar_raw IS NULL OR TRIM(tanggal_bayar_raw) = '');


-- SOAL 32. Menganalisis distribusi status pembayaran
SELECT status_pembayaran, COUNT(*) AS jumlah_record
FROM src.pembayaran
GROUP BY status_pembayaran
ORDER BY jumlah DESC, status_pembayaran;


-- =========================================================
-- M. KELULUSAN - UNIQUENESS DAN DISTRIBUTION
-- =========================================================

-- SOAL 33. Memeriksa duplikasi data kelulusan berdasarkan NIM
SELECT
    COUNT(*)                         AS raw_rows,
    COUNT(DISTINCT nim)              AS distinct_graduate_nim,
    COUNT(*) - COUNT(DISTINCT nim)   AS duplicate_excess
FROM src.kelulusan;


-- SOAL 34. Menganalisis status kelulusan tepat waktu
SELECT status_tepat_waktu, COUNT(*) AS jumlah_mahasiswa
FROM src.kelulusan
GROUP BY status_tepat_waktu
ORDER BY jumlah_mahasiswa DESC, status_tepat_waktu;


-- =========================================================
-- N. RELASI ANTAR-TABEL - REFERENTIAL INTEGRITY
-- =========================================================

-- SOAL 35. Memeriksa aktivitas LMS dengan NIM yang tidak terdaftar
SELECT COUNT(*) AS orphan_lms_student
FROM src.aktivitas_lms a
LEFT JOIN src.mahasiswa m ON a.nim = m.nim
WHERE m.nim IS NULL;


-- SOAL 36. Memeriksa aktivitas LMS dengan mata kuliah yang tidak terdaftar
SELECT COUNT(*) AS orphan_lms_course
FROM src.aktivitas_lms a
LEFT JOIN src.mata_kuliah mk ON a.kode_mk = mk.kode_mk
WHERE mk.kode_mk IS NULL;


-- SOAL 37. Memeriksa pembayaran dengan NIM yang tidak terdaftar
SELECT COUNT(*) AS orphan_payment_student
FROM src.pembayaran p
LEFT JOIN src.mahasiswa m ON p.nim = m.nim
WHERE m.nim IS NULL;


-- SOAL 38. Memeriksa data kelulusan dengan NIM yang tidak terdaftar
SELECT COUNT(*) AS orphan_graduation_student
FROM src.kelulusan k
LEFT JOIN src.mahasiswa m ON k.nim = m.nim
WHERE m.nim IS NULL;




