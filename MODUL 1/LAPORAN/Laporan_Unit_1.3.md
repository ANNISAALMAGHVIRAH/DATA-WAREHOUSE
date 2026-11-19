# LAPORAN MODUL 1 UNIT 1.3

## Identitas Laporan

Nama : Annisa Almaghvirah 
NIM : 240306037  
Kelas : A  
Kelompok : 4  
Program Studi : Teknologi Informasi  
Modul : 1  
Unit : 1.3  
Tanggal Praktikum : 5 November 2026  

---

## Studi Kasus

Universitas Digital Nusantara menemukan bahwa proses evaluasi akademik masih dilakukan secara terpisah oleh setiap program studi. Kaprodi memang dapat mengakses nilai mahasiswa, tetapi belum tersedia informasi yang terintegrasi untuk mengetahui mata kuliah yang sering menjadi kendala, kelompok mahasiswa yang membutuhkan pendampingan lebih awal, keterkaitan aktivitas LMS dengan hasil akademik, serta faktor yang berkaitan dengan keterlambatan kelulusan.

Wakil Rektor Bidang Akademik kemudian meminta tim Data Warehouse menyiapkan kebutuhan informasi dan data sebagai dasar pengembangan analitik untuk meningkatkan keberhasilan studi serta kelulusan tepat waktu. Pada tahap ini, tim belum diminta membuat Star Schema maupun ETL. Fokus Unit 1.3 adalah mengidentifikasi kebutuhan informasi dan data berdasarkan dataset UADW v1.0.

Keputusan yang ingin didukung meliputi:
- Menentukan mata kuliah yang membutuhkan evaluasi atau program remedial.
- Mengidentifikasi kelompok mahasiswa yang perlu memperoleh pendampingan akademik lebih awal.
- Menemukan periode, angkatan, atau program studi yang mengalami penurunan performa.
- Menilai hubungan aktivitas LMS dengan risiko akademik mahasiswa.
- Mengamati pola yang berkaitan dengan kelulusan tepat waktu.

Batas kasus: pembahasan difokuskan pada keberhasilan akademik dan kelulusan tepat waktu. Data pembayaran tidak digunakan dalam laporan ini.

## 1. Identifikasi Stakeholder

Tahap awal dalam menganalisis kebutuhan bisnis adalah mengenali pihak-pihak yang berkepentingan terhadap informasi akademik. Setiap stakeholder mempunyai kebutuhan informasi dan kewenangan keputusan yang berbeda. Hasil identifikasinya adalah sebagai berikut:

| Stakeholder | Information Need | Decision Supported | Priority |
|---|---|---|---|
| Wakil Rektor Bidang Akademik | Informasi menyeluruh mengenai hasil akademik dan kelulusan tepat waktu dari seluruh program studi dan angkatan | Menyusun kebijakan untuk meningkatkan keberhasilan studi dan kelulusan mahasiswa | High |
| Kepala Program Studi (Kaprodi) | Informasi mata kuliah dengan kegagalan tinggi, perkembangan nilai mahasiswa, serta tingkat kelulusan tepat waktu | Menentukan mata kuliah yang perlu dievaluasi dan kelompok akademik yang membutuhkan perhatian | High |
| Dosen Pengampu / Koordinator Mata Kuliah | Informasi distribusi nilai, jumlah mahasiswa tidak lulus, dan aktivitas pembelajaran melalui LMS | Memperbaiki proses pembelajaran, metode penilaian, dan materi perkuliahan | Medium |
| Dosen Pembimbing Akademik / Bagian Akademik | Informasi kelompok mahasiswa yang memiliki nilai rendah atau keterlibatan LMS yang minim | Menentukan mahasiswa yang perlu memperoleh bimbingan akademik lebih awal | Medium |
| Tim Data Warehouse | Informasi mengenai kondisi, kelengkapan, dan kesiapan data akademik | Menetapkan prioritas perbaikan data dan menentukan kandidat model analitik | Medium |

## 2. Problem Statement

Berdasarkan permasalahan dalam studi kasus, berikut jawaban dari pertanyaan pemantik yang digunakan untuk merumuskan problem statement.

1. Bagaimana kondisi sekarang? [Kondisi]

   > Evaluasi hasil akademik masih dilaksanakan secara terpisah oleh masing-masing program studi. Informasi nilai, KRS, aktivitas LMS, dan data kelulusan belum tersedia dalam satu sumber informasi yang terintegrasi.

2. Apa yang belum dapat dilakukan? [Masalah]

   > Universitas belum dapat mengidentifikasi mata kuliah dengan tingkat kegagalan tinggi secara menyeluruh, mendeteksi kelompok mahasiswa yang berpotensi mengalami masalah akademik, mengukur keterkaitan aktivitas LMS dengan nilai, serta menganalisis pola kelulusan mahasiswa.

3. Apa akibatnya bagi organisasi? [Dampak]

   > Pemberian pendampingan kepada mahasiswa berisiko dapat terlambat, penanganan mata kuliah bermasalah menjadi kurang terarah, dan pimpinan kesulitan menentukan kebijakan peningkatan kelulusan berdasarkan informasi yang konsisten.

4. Informasi apa yang dibutuhkan untuk memperbaiki kondisi tersebut? [Kebutuhan Analitik]

   > Dibutuhkan informasi mengenai persentase ketidaklulusan setiap mata kuliah, perkembangan performa akademik berdasarkan program studi dan angkatan, persentase kelulusan tepat waktu, serta hubungan aktivitas LMS dengan hasil nilai mahasiswa.

Untuk menyusun pernyataan masalah digunakan pendekatan:

**Current Condition → Problem → Impact → Analytical Need**

Sehingga **Problem Statement** yang diperoleh adalah:

> Saat ini proses evaluasi akademik masih berjalan secara terpisah di setiap program studi, sehingga universitas belum mempunyai gambaran menyeluruh mengenai kondisi akademik mahasiswa. Akibatnya, identifikasi mata kuliah bermasalah, pemberian pendampingan kepada mahasiswa, dan evaluasi kelulusan tepat waktu belum dapat dilakukan secara optimal. Oleh karena itu, diperlukan analisis terintegrasi terhadap data KRS, nilai, aktivitas LMS, dan kelulusan untuk menghasilkan informasi mengenai tingkat ketidaklulusan, perkembangan performa akademik, keterlibatan mahasiswa dalam pembelajaran, serta ketepatan waktu penyelesaian studi.

## 3. Business Process

Business Process digunakan untuk menggambarkan aktivitas utama yang menghasilkan data dalam kegiatan akademik. Penyusunannya memperhatikan hubungan antara kegiatan, pelaku, objek, dan waktu pelaksanaan.

**Business Process = Event/Kegiatan Bisnis + Actor + Object + Time**

1. **Kejadian bisnis apa yang menghasilkan data**

   > Aktivitas yang menghasilkan data meliputi proses pengisian KRS, pemberian nilai akhir mata kuliah, kegiatan pembelajaran melalui LMS, dan pencatatan kelulusan mahasiswa.

2. **Siapa aktor yang berperan**

   > Pihak yang terlibat yaitu mahasiswa, dosen pengampu, bagian akademik, serta sistem Learning Management System (LMS).

3. **Apa yang menjadi objek dari studi kasus**

   > Objek yang dianalisis meliputi mata kuliah yang diambil mahasiswa, hasil penilaian, aktivitas pembelajaran melalui LMS, dan status penyelesaian studi.

4. **Kapan kejadian bisnis terjadi**

   > Data akademik mencakup semester 2021 Ganjil sampai 2024 Genap. Aktivitas LMS tercatat pada 15 Agustus 2021 sampai 10 Juni 2025, sedangkan data kelulusan tercatat pada Juni 2025.

Sehingga proses bisnis yang berhasil diidentifikasi pada domain berikut adalah:

1. **KRS**

   > Mahasiswa melakukan pemilihan dan pengambilan mata kuliah yang tersedia pada awal semester. Aktivitas tersebut menghasilkan catatan mata kuliah yang diambil berdasarkan `tanggal_ambil_raw` dan `semester_id`.

2. **Penilaian**

   > Dosen pengampu melakukan penilaian terhadap mahasiswa berdasarkan hasil pembelajaran pada mata kuliah tertentu. Hasil akhirnya dicatat dalam bentuk nilai angka, nilai huruf, dan status kelulusan pada akhir semester melalui `tanggal_input_raw` dan `semester_id`.

3. **Aktivitas Pembelajaran LMS**

   > Mahasiswa menggunakan LMS untuk melaksanakan kegiatan pembelajaran, seperti login, melihat materi, mengumpulkan tugas, mengerjakan kuis, dan berpartisipasi dalam forum selama masa perkuliahan.

4. **Kelulusan**

   > Bagian akademik mencatat mahasiswa yang telah menyelesaikan seluruh persyaratan studi. Informasi yang dihasilkan mencakup IPK akhir, masa studi, predikat kelulusan, dan status tepat waktu berdasarkan `tanggal_lulus_raw`.

## 4. Business Objective

Business Objective merupakan sasaran yang ingin diwujudkan organisasi melalui pemanfaatan informasi analitik. Berdasarkan permasalahan yang ditemukan, tujuan bisnis dirumuskan sebagai berikut:

**Business Objective:**

> **BO01** — Meningkatkan kemampuan program studi dalam menemukan mata kuliah dengan hasil akademik rendah agar evaluasi pembelajaran dan kegiatan remedial dapat dilakukan secara terarah.
>
> **BO02** — Memperkuat kemampuan universitas dalam mengenali mahasiswa dan kelompok akademik yang berisiko agar pendampingan dapat diberikan sebelum masalah akademik semakin besar.
>
> **BO03** — Mengevaluasi kondisi kelulusan tepat waktu agar universitas dapat menyusun strategi untuk meningkatkan keberhasilan penyelesaian studi.
>
> **BO04** — Mengkaji keterkaitan aktivitas pembelajaran LMS dengan hasil nilai agar tingkat keterlibatan mahasiswa dapat dimanfaatkan sebagai informasi tambahan dalam mendeteksi risiko akademik.

## 5. Decision Requirement

Decision Requirement menjelaskan keputusan yang perlu diambil oleh stakeholder berdasarkan informasi analitik yang tersedia. Penyusunannya menggunakan pola:

**[Stakeholder] perlu menentukan [keputusan] berdasarkan [informasi].**

Berdasarkan kebutuhan tersebut, diperoleh beberapa Decision Requirement berikut:

> **DR01** — Kaprodi perlu memilih mata kuliah yang menjadi prioritas evaluasi berdasarkan persentase mahasiswa yang tidak lulus pada setiap mata kuliah dan semester.
>
> **DR02** — Wakil Rektor Bidang Akademik perlu menetapkan program studi dan angkatan yang membutuhkan program peningkatan akademik berdasarkan perkembangan persentase ketidaklulusan serta tingkat kelulusan tepat waktu.
>
> **DR03** — Dosen Pembimbing Akademik dan Bagian Akademik perlu menentukan kelompok mahasiswa yang membutuhkan pendampingan berdasarkan perbedaan hasil nilai semester awal pada setiap kelompok predikat kelulusan serta perbandingan lulusan tepat waktu dan terlambat apabila datanya tersedia.
>
> **DR04** — Dosen Pengampu dan Kaprodi perlu memutuskan kelayakan aktivitas LMS sebagai indikator tambahan risiko akademik berdasarkan pola keterkaitannya dengan nilai mahasiswa.

## 6. Analytical Questions

Analytical Questions dibuat untuk mengubah kebutuhan keputusan menjadi pertanyaan yang dapat dijawab menggunakan data dan pengukuran tertentu. Penyusunannya memperhatikan metric, dimension, time, dan comparison.

Empat pola pertanyaan yang digunakan adalah:

1. **Trend**

   > Bagaimana perkembangan persentase ketidaklulusan berdasarkan program studi mulai semester 2021G hingga semester 2024E?

2. **Comparison**

   > Bagaimana perbedaan persentase kelulusan tepat waktu antara program studi A dan program studi B?

3. **Ranking**

   > Mata kuliah apa yang menempati posisi tertinggi berdasarkan persentase ketidaklulusan pada masing-masing semester?

4. **Relationship**

   > Bagaimana keterkaitan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada mata kuliah yang diikuti?

Sehingga Analytical Questions dapat dirangkum dalam tabel berikut:

| AQ | Analytical Question | Stakeholder | Decision | Priority |
|---|---|---|---|---|
| AQ01 | Mata kuliah apa yang mempunyai persentase ketidaklulusan paling tinggi pada setiap semester? (Ranking) | Kaprodi | DR01 | High |
| AQ02 | Bagaimana perkembangan persentase ketidaklulusan pada setiap program studi dari semester 2021G sampai 2024E? (Trend) | Wakil Rektor Bidang Akademik | DR02 | High |
| AQ03 | Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi pada setiap program studi? (Comparison) | Wakil Rektor Bidang Akademik; Kaprodi | DR02 | High |
| AQ04 | Apakah terdapat pola hubungan antara jumlah atau total durasi aktivitas LMS dengan nilai angka mahasiswa pada masing-masing mata kuliah? (Relationship) | Dosen Pengampu; Kaprodi | DR04 | Medium |
| AQ05 | Bagaimana perbedaan rata-rata nilai angka pada semester awal jika dilihat berdasarkan kelompok predikat kelulusan mahasiswa? (Comparison) | Dosen Pembimbing Akademik / Bagian Akademik | DR03 | High |

## 7. Key Performance Indicator (KPI)

KPI digunakan untuk mengukur pencapaian tujuan bisnis melalui indikator yang dapat dihitung dan dibandingkan. Penyusunannya mengikuti pendekatan Top-Down, yaitu dimulai dari Business Objective, Decision Requirement, Analytical Question, pemilihan metrik yang adil, kemudian formulasi KPI.

**Alur penyusunan:**

Business Objective → Decision Requirement → Analytical Questions → Memilih Bentuk Metriks yang Adil → Formulasi KPI.

### 1. KPI Course Failure Rate

**Business Objective (BO01)** = Meningkatkan kemampuan program studi dalam mengidentifikasi mata kuliah yang memiliki hasil akademik rendah.

**Decision Requirement (DR01)** = Kaprodi perlu memilih mata kuliah yang mempunyai persentase ketidaklulusan tinggi secara konsisten.

**Analytical Question (AQ01)** = Mata kuliah apa yang mempunyai persentase ketidaklulusan paling tinggi pada setiap semester?

Berdasarkan ketiga komponen tersebut, penyusunan KPI dilakukan melalui tahapan berikut:

1. **Menganalisis tujuan bisnis (BO01)**

   **Pernyataan:** Meningkatkan kemampuan program studi dalam menemukan mata kuliah dengan hasil akademik rendah.

   Fokus utama dari tujuan tersebut adalah kondisi performa mata kuliah. Performa yang rendah dapat diketahui melalui banyaknya mahasiswa yang tidak berhasil memenuhi standar kelulusan.

   **Informasi yang ingin diperoleh:** Mata kuliah yang mempunyai jumlah atau proporsi mahasiswa gagal paling tinggi sehingga dapat menjadi prioritas evaluasi.

2. **Mengidentifikasi kebutuhan keputusan (DR01)**

   **Pernyataan:** Kaprodi perlu memilih mata kuliah yang mempunyai persentase ketidaklulusan tinggi secara konsisten.

   Bagian penting dari keputusan tersebut adalah tingkat kegagalan mahasiswa. Informasi yang dibutuhkan bukan hanya jumlah mahasiswa yang gagal, melainkan perbandingannya terhadap seluruh peserta mata kuliah.

   **Informasi yang ingin diperoleh:** Persentase mahasiswa yang tidak lulus pada masing-masing mata kuliah dan semester.

3. **Mengubah kebutuhan menjadi pertanyaan analitis (AQ01)**

   **Pernyataan:** Mata kuliah apa yang mempunyai persentase ketidaklulusan paling tinggi pada setiap semester?

   Pertanyaan tersebut menunjukkan komponen analisis yang diperlukan:
   - Measure: Persentase ketidaklulusan.
   - Dimension: Mata kuliah dan semester.
   - Metode analisis: Mengurutkan mata kuliah berdasarkan persentase kegagalan tertinggi.

4. **Menentukan bentuk metrik yang adil**

   Dalam pengukuran tingkat ketidaklulusan terdapat dua pilihan, yaitu jumlah mahasiswa yang gagal atau persentase mahasiswa yang gagal.

   Bentuk yang digunakan adalah **persentase** karena jumlah peserta setiap mata kuliah tidak selalu sama. Sebagai contoh, kegagalan 15 mahasiswa dari 20 peserta menghasilkan persentase 75%, sedangkan kegagalan 20 mahasiswa dari 200 peserta hanya menghasilkan 10%. Dengan demikian, persentase memberikan perbandingan yang lebih proporsional.

5. **Merumuskan KPI Final**

   **KPI Name:**

   Persentase Ketidaklulusan per Mata Kuliah (Course Failure Rate).

   **Definisi:**

   Indikator ini menunjukkan besarnya proporsi mahasiswa yang tidak berhasil mencapai standar kelulusan pada suatu mata kuliah dibandingkan dengan jumlah mahasiswa yang mempunyai nilai akhir valid pada mata kuliah tersebut dalam semester yang sama.

   **Formula:**

   - Numerator: Jumlah record nilai pada grain unik mahasiswa–mata kuliah–semester dengan `status_lulus` bernilai `Tidak Lulus`.
   - Denominator: Jumlah mahasiswa unik pada grain mahasiswa–mata kuliah–semester yang mempunyai `nilai_angka` valid (0–100) dan `status_lulus` terisi.
   - Aggregation: Menggunakan COUNT pada entitas nilai, kemudian hasil pembagian dikalikan 100%.

   \[
   \left(\frac{\text{COUNT(Mahasiswa Tidak Lulus)}}{\text{COUNT(Total Mahasiswa Peserta Mata Kuliah)}}\right)\times100\%
   \]

   **Konteks:**

   - Dimensi waktu: Tahun akademik dan semester Ganjil/Genap.
   - Dimensi mata kuliah: Kode mata kuliah, nama mata kuliah, dan jenis mata kuliah.
   - Dimensi program studi dan dosen pengampu untuk membantu evaluasi hasil pembelajaran.

   **Caveat:**

   - Jumlah peserta yang sedikit dapat menyebabkan persentase ketidaklulusan terlihat sangat tinggi meskipun hanya sedikit mahasiswa yang gagal.
   - Sebanyak 20 nilai kosong dan 12 nilai di luar rentang 0–100 perlu dikeluarkan dari perhitungan.
   - Terdapat 20 ketidaksesuaian antara nilai angka dan huruf serta 17 ketidaksesuaian antara nilai huruf dan status kelulusan. Oleh karena itu, `status_lulus` digunakan sebagai indikator sementara dan aturan resminya perlu dikonfirmasi.
   - Perubahan kurikulum maupun standar kelulusan dapat memengaruhi hasil perbandingan antarsemester.

### 2. KPI On-Time Graduation Rate

**Business Objective (BO03)** = Mengevaluasi pola kelulusan tepat waktu agar universitas dapat menyusun strategi peningkatan keberhasilan penyelesaian studi.

**Decision Requirement (DR02)** = Wakil Rektor Bidang Akademik perlu menentukan program studi dan angkatan yang membutuhkan program peningkatan berdasarkan tingkat kelulusan tepat waktu.

**Analytical Question (AQ03)** = Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi pada setiap program studi?

Tahapan penyusunan KPI adalah sebagai berikut:

1. **Menganalisis tujuan bisnis (BO03)**

   Fokus tujuan ini adalah mengetahui keberhasilan mahasiswa dalam menyelesaikan pendidikan sesuai dengan masa studi yang ditentukan. Informasi tersebut diperlukan untuk mengevaluasi pencapaian kelulusan pada tingkat universitas maupun program studi.

2. **Mengidentifikasi kebutuhan keputusan (DR02)**

   Pimpinan universitas membutuhkan informasi perbandingan kelulusan antarprogram studi dan angkatan untuk menentukan kelompok yang perlu mendapatkan perhatian.

3. **Mengubah kebutuhan menjadi pertanyaan analitis (AQ03)**

   Komponen analisis yang digunakan:
   - Measure: Persentase kelulusan tepat waktu dan rata-rata masa studi.
   - Dimension: Program studi dan angkatan.
   - Metode analisis: Perbandingan antarprogram studi.

4. **Menentukan bentuk metrik yang adil**

   Pengukuran menggunakan persentase karena jumlah lulusan pada setiap program studi berbeda. Selain itu, rata-rata masa studi digunakan sebagai informasi tambahan agar evaluasi tidak hanya berfokus pada jumlah lulusan.

5. **Merumuskan KPI Final**

   **KPI Name:**

   Persentase Kelulusan Tepat Waktu (On-Time Graduation Rate).

   **Definisi:**

   Mengukur bagian lulusan yang berhasil menyelesaikan pendidikan sesuai batas waktu yang ditetapkan dibandingkan dengan seluruh mahasiswa yang tercatat lulus pada kelompok yang dianalisis.

   **Formula:**

   - Numerator: Jumlah mahasiswa unik dengan `status_tepat_waktu` = `Ya`.
   - Denominator: Jumlah seluruh mahasiswa unik yang tercatat pada tabel kelulusan.
   - Aggregation: COUNT(DISTINCT nim), kemudian dihitung dalam bentuk persentase.

   \[
   \left(\frac{\text{COUNT(DISTINCT NIM Lulus Tepat Waktu)}}{\text{COUNT(DISTINCT NIM Lulus)}}\right)\times100\%
   \]

   **Konteks:**

   - Program studi.
   - Tahun angkatan.
   - Periode kelulusan.
   - Rata-rata masa studi dalam bulan.

   **Caveat:**

   - Data kelulusan hanya tersedia untuk periode Juni 2025 sehingga belum mewakili seluruh angkatan.
   - Terdapat dua baris kelulusan duplikat dari 347 record dan 345 NIM unik sehingga harus dilakukan deduplikasi.
   - Seluruh 347 record berstatus `Ya`, sehingga KPI menghasilkan 100% dan belum dapat membedakan performa antarprogram studi.
   - Seluruh lulusan berasal dari angkatan 2021 dengan masa studi 46–47 bulan.
   - Definisi resmi masa studi normal dan kesesuaian `status_tepat_waktu` dengan `masa_studi_bulan` masih perlu diperiksa.
   - Rata-rata masa studi perlu digunakan sebagai ukuran tambahan sampai data mahasiswa terlambat lulus tersedia.

### 3. KPI LMS Engagement per Mata Kuliah

**Business Objective (BO04)** = Mengkaji hubungan aktivitas pembelajaran LMS dengan hasil nilai agar keterlibatan mahasiswa dapat digunakan sebagai informasi pendukung dalam mendeteksi risiko akademik.

**Decision Requirement (DR04)** = Dosen Pengampu dan Kaprodi perlu memutuskan apakah aktivitas LMS dapat dijadikan indikator tambahan risiko akademik berdasarkan pola hubungannya dengan nilai mahasiswa.

**Analytical Question (AQ04)** = Bagaimana pola hubungan antara jumlah atau total durasi aktivitas LMS dengan nilai angka mahasiswa pada masing-masing mata kuliah?

Tahapan penyusunan KPI adalah sebagai berikut:

1. **Menganalisis tujuan bisnis (BO04)**

   Tujuan ini berfokus pada keterlibatan mahasiswa dalam pembelajaran digital dan kaitannya dengan hasil akademik. Aktivitas LMS dapat memberikan gambaran mengenai seberapa aktif mahasiswa mengikuti kegiatan pembelajaran.

2. **Mengidentifikasi kebutuhan keputusan (DR04)**

   Dosen dan Kaprodi membutuhkan bukti mengenai pola aktivitas LMS dan hasil nilai sebelum menjadikan aktivitas tersebut sebagai salah satu indikator risiko akademik.

3. **Mengubah kebutuhan menjadi pertanyaan analitis (AQ04)**

   Komponen yang digunakan:
   - Measure: Jumlah aktivitas LMS, durasi aktivitas, dan nilai angka.
   - Dimension: Mata kuliah dan tipe aktivitas.
   - Metode analisis: Mengamati hubungan antara aktivitas LMS dan nilai.

4. **Menentukan bentuk metrik yang adil**

   Pengukuran menggunakan rata-rata jumlah aktivitas per mahasiswa, bukan total aktivitas keseluruhan. Hal ini dilakukan karena jumlah mahasiswa yang mengikuti setiap mata kuliah berbeda. Mahasiswa yang tidak memiliki aktivitas LMS tetap dimasukkan ke dalam denominator selama terdaftar pada KRS.

5. **Merumuskan KPI Final**

   **KPI Name:**

   Rata-rata Aktivitas LMS per Mahasiswa per Mata Kuliah (LMS Engagement).

   **Definisi:**

   Menggambarkan rata-rata jumlah aktivitas pembelajaran yang dilakukan setiap mahasiswa pada suatu mata kuliah melalui LMS. Informasi ini digunakan untuk melihat tingkat keterlibatan mahasiswa dalam kegiatan pembelajaran digital.

   **Formula:**

   - Numerator: `COUNT(DISTINCT lms_event_id)` pada mata kuliah tertentu.
   - Denominator: Jumlah mahasiswa unik yang terdaftar pada mata kuliah dan semester berdasarkan KRS yang telah dibersihkan.
   - Aggregation: Jumlah event dibagi jumlah mahasiswa terdaftar. Perhitungan dapat dilengkapi dengan rata-rata `durasi_menit`.

   \[
   \frac{\text{COUNT(DISTINCT lms\_event\_id)}}{\text{COUNT(DISTINCT NIM pada KRS)}}
   \]

   **Konteks:**

   - Mata kuliah.
   - Jenis aktivitas (`tipe_event`).
   - Periode semester atau waktu aktivitas.
   - Nilai angka mahasiswa pada mata kuliah yang sama.

   **Caveat:**

   - Sebanyak 30 event LMS yang terduplikasi harus ditangani sebelum perhitungan.
   - Mahasiswa yang tidak melakukan aktivitas LMS tetap perlu masuk denominator selama terdaftar dalam KRS.
   - `skor_kuis` hanya tersedia pada aktivitas `quiz_attempt`, sehingga perhitungannya harus dibatasi pada tipe tersebut.
   - Hubungan aktivitas LMS dengan nilai tidak otomatis menunjukkan bahwa aktivitas tersebut menjadi penyebab tinggi atau rendahnya hasil akademik.

## 8. Data Requirement

Data Requirement digunakan untuk menentukan informasi apa saja yang harus tersedia agar setiap KPI dan Analytical Question dapat dihitung. Identifikasi dilakukan dengan memperhatikan ukuran yang digunakan, konteks analisis, waktu, serta kriteria perbandingan.

### 1. AQ01 dan KPI01

**Analytical Question (AQ01)** = Mata kuliah apa yang mempunyai persentase ketidaklulusan paling tinggi pada setiap semester?

**KPI:** Persentase Ketidaklulusan per Mata Kuliah (Course Failure Rate).

Komponen yang dibutuhkan:
1. Jumlah mahasiswa yang tidak lulus.
2. Jumlah seluruh mahasiswa yang memiliki nilai akhir valid pada mata kuliah tersebut.

Berdasarkan kebutuhan tersebut, diperoleh:

- Measure: Jumlah mahasiswa, nilai angka, jumlah mahasiswa tidak lulus, dan failure rate.
- Context: Mata kuliah dan program studi.
- Time: Semester.
- Comparison/filter: Nilai angka valid 0–100 dan status kelulusan yang terisi. `status_lulus` digunakan sebagai indikator sementara.

Data yang diperlukan:
- `nim` dari tabel `nilai`, sebagai identitas mahasiswa yang dihitung.
- `kode_mk` dari tabel `nilai`, sebagai identitas mata kuliah.
- `semester_id` dari tabel `nilai`, untuk menentukan periode penilaian.
- `nilai_angka` dan `status_lulus` dari tabel `nilai`, untuk menghitung jumlah mahasiswa tidak lulus dan total peserta yang memenuhi kriteria.
- `nilai_huruf` digunakan untuk pemeriksaan kesesuaian hasil penilaian.

### 2. AQ02 dan KPI01 (Tren Ketidaklulusan per Program Studi)

**Analytical Question (AQ02)** = Bagaimana perkembangan persentase ketidaklulusan pada setiap program studi dari semester 2021G sampai 2024E?

Kebutuhan data yang digunakan:

- Measure: Jumlah mahasiswa tidak lulus, jumlah peserta, dan persentase ketidaklulusan.
- Context: Program studi.
- Time: Semester 2021G sampai 2024E.
- Comparison/filter: Nilai valid dan urutan semester yang benar.

Data yang dibutuhkan:
- `nim`, `kode_mk`, `semester_id`, dan `status_lulus` dari tabel `nilai`.
- `kode_prodi_raw` dari tabel `mahasiswa` untuk mengetahui program studi mahasiswa.
- `kode_prodi` dan `nama_prodi` dari tabel `program_studi` sebagai referensi program studi.

### 3. AQ03 dan KPI02 (Kelulusan Tepat Waktu)

**Analytical Question (AQ03)** = Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi pada setiap program studi?

Kebutuhan data yang digunakan:

- Measure: Jumlah lulusan unik, jumlah lulusan tepat waktu, dan rata-rata masa studi.
- Context: Program studi dan angkatan.
- Time: Periode kelulusan.
- Comparison/filter: Satu record kelulusan untuk setiap NIM setelah deduplikasi.

Data yang diperlukan:
- `nim`, `status_tepat_waktu`, `masa_studi_bulan`, `ipk_final`, `predikat`, dan `tanggal_lulus_raw` dari tabel `kelulusan`.
- `angkatan` dan `kode_prodi_raw` dari tabel `mahasiswa`.
- `kode_prodi` dan `nama_prodi` dari tabel `program_studi`.

### 4. AQ04 dan KPI03 (Aktivitas LMS dengan Nilai)

**Analytical Question (AQ04)** = Bagaimana pola hubungan antara jumlah atau total durasi aktivitas LMS dengan nilai angka mahasiswa pada setiap mata kuliah?

Kebutuhan data yang digunakan:

- Measure: Jumlah event, durasi aktivitas, skor kuis, nilai angka, dan jumlah mahasiswa terdaftar.
- Context: Mata kuliah dan tipe aktivitas.
- Time: Semester.
- Comparison/filter: Event unik berdasarkan `lms_event_id`; skor kuis hanya untuk `quiz_attempt`.

Data yang diperlukan:
- `lms_event_id`, `nim`, `kode_mk`, `semester_id`, `waktu_event`, `tipe_event`, `durasi_menit`, dan `skor_kuis` dari tabel `aktivitas_lms`.
- `nim`, `kode_mk`, `semester_id`, dan `nilai_angka` dari tabel `nilai`.
- `nim`, `kode_mk`, dan `semester_id` dari tabel `krs` untuk menentukan jumlah mahasiswa yang terdaftar.

Penggabungan data dilakukan berdasarkan `nim`, `kode_mk`, dan `semester_id`.

### 5. AQ05 (Nilai Semester Awal Berdasarkan Predikat Kelulusan)

**Analytical Question (AQ05)** = Bagaimana perbedaan rata-rata nilai angka pada semester awal berdasarkan kelompok predikat kelulusan?

Kebutuhan data yang digunakan:

- Measure: Rata-rata nilai angka.
- Context: Predikat kelulusan (Cukup, Memuaskan, dan Sangat Memuaskan).
- Time: Dua semester pertama setiap mahasiswa.
- Comparison/filter: Nilai angka valid 0–100 dan lulusan unik.

Data yang diperlukan:
- `nim`, `semester_id`, dan `nilai_angka` dari tabel `nilai`.
- `nim`, `predikat`, dan `ipk_final` dari tabel `kelulusan`.
- `semester_id` dan `urutan_tahun` dari tabel `semester`.

Catatan: Perbandingan antara mahasiswa yang lulus tepat waktu dan terlambat belum dapat dilakukan karena seluruh data kelulusan yang tersedia berstatus tepat waktu.

Seluruh kebutuhan data dirangkum dalam tabel berikut:

| AQ | Measure | Context | Time | Filter/Comparison | Required Data |
|---|---|---|---|---|---|
| AQ01 | Jumlah mahasiswa, jumlah tidak lulus, failure rate | Mata kuliah, prodi | Semester | Nilai valid 0–100; `status_lulus` sebagai indikator sementara | `nim`, `kode_mk`, `semester_id`, `nilai_angka`, `status_lulus` |
| AQ02 | Failure rate per prodi | Program studi | Semester 2021G–2024E | Nilai valid dan urutan semester | `nim`, `kode_mk`, `semester_id`, `status_lulus`, `kode_prodi_raw`, `kode_prodi`, `nama_prodi` |
| AQ03 | Jumlah lulusan, lulusan tepat waktu, rata-rata masa studi | Program studi, angkatan | Periode kelulusan | Satu record per NIM | `nim`, `status_tepat_waktu`, `masa_studi_bulan`, `tanggal_lulus_raw`, `angkatan`, `kode_prodi_raw` |
| AQ04 | Jumlah event, durasi, skor kuis, nilai angka, jumlah mahasiswa terdaftar | Mata kuliah, tipe event | Semester | `lms_event_id` unik; skor hanya untuk `quiz_attempt`; denominator dari KRS unik | `lms_event_id`, `nim`, `kode_mk`, `semester_id`, `tipe_event`, `durasi_menit`, `skor_kuis`, `nilai_angka`, data KRS |
| AQ05 | Rata-rata nilai angka | Predikat kelulusan | Dua semester awal | Nilai valid dan lulusan unik | `nim`, `semester_id`, `nilai_angka`, `predikat` |

## 9. Source Mapping

Source Mapping dilakukan untuk memastikan setiap kebutuhan data memiliki sumber yang jelas. Pemetaan ini menghubungkan informasi yang diperlukan dengan tabel dan kolom yang tersedia pada dataset UADW v1.0.

Pendekatan yang digunakan adalah:

**Data yang dibutuhkan → Tabel/file sumber → Kolom → Fungsi data.**

Hasil pemetaan sumber data adalah sebagai berikut:

| Data Requirement | Source | Column | Role |
|---|---|---|---|
| Identitas mahasiswa | `nilai`; `mahasiswa` | `nim` | Integration key |
| Identitas mata kuliah | `nilai`; `mata_kuliah` | `kode_mk` | Course identifier |
| Nama mata kuliah | `mata_kuliah` | `nama_mk` | Analytical context |
| Informasi semester | `nilai`; `semester` | `semester_id` | Time key |
| Hasil penilaian | `nilai` | `nilai_angka` | Measure |
| Status kelulusan mata kuliah | `nilai` | `status_lulus`, `nilai_huruf` | KPI component |
| Program studi mahasiswa | `mahasiswa`; `program_studi` | `kode_prodi_raw`, `kode_prodi`, `nama_prodi` | Analytical context |
| Angkatan mahasiswa | `mahasiswa` | `angkatan` | Analytical context |
| Status kelulusan tepat waktu | `kelulusan` | `status_tepat_waktu` | KPI component |
| Predikat dan IPK akhir | `kelulusan` | `predikat`, `ipk_final` | Analytical context / Measure |
| Lama masa studi | `kelulusan` | `masa_studi_bulan` | Measure |
| Identitas aktivitas LMS | `aktivitas_lms` | `lms_event_id` | Measure (jumlah event) |
| Peserta mata kuliah | `krs` | `nim`, `kode_mk`, `semester_id` | Denominator KPI LMS |
| Lama aktivitas LMS | `aktivitas_lms` | `durasi_menit` | Measure |
| Semester aktivitas LMS | `aktivitas_lms` | `semester_id` | Time key |
| Kategori aktivitas | `aktivitas_lms` | `tipe_event` | Analytical context |

## 10. Data Fitness

Data Fitness dilakukan untuk menilai apakah sumber data yang akan digunakan telah mempunyai kualitas dan kelengkapan yang memadai. Penilaian ini mengacu pada hasil Data Profiling yang telah dilakukan pada Modul 1 Unit 1.2.

Hasil pemeriksaan kesiapan data adalah sebagai berikut:

| Source | Evidence Unit 1.2 | Fitness | Required Action |
|---|---|---|---|
| mahasiswa | Ditemukan 15 NIM duplikat persis (1.965 record dibandingkan 1.950 NIM unik); terdapat 30 variasi label untuk 6 program studi; 208 `kode_prodi_raw` bermasalah karena spasi atau huruf kecil; 30 kota asal kosong dan 3 format tanggal berbeda | Conditional Ready | Melakukan deduplikasi berdasarkan `nim`, menyeragamkan kode prodi menggunakan TRIM dan UPPER, serta memperbaiki format tanggal |
| program_studi | Terdapat 6 record dengan kode dan nama program studi yang unik serta tidak ditemukan masalah berarti | Ready | Digunakan sebagai referensi utama program studi |
| mata_kuliah | `kode_mk` bersifat unik, tidak ditemukan orphan dari KRS, nilai, maupun LMS; 63 nama mata kuliah berulang antarprodi karena digunakan pada program studi berbeda | Ready | Menggunakan `kode_mk` sebagai identitas utama mata kuliah |
| semester | Terdapat 8 record semester dari 2021G sampai 2024E dengan kondisi bersih dan tidak ditemukan orphan dari KRS maupun nilai | Ready | Digunakan sebagai referensi dimensi waktu |
| krs | Ditemukan 25 record duplikat persis dari 57.025 record menjadi 57.000 record unik; tidak terdapat orphan dan ditemukan 3 format tanggal | Conditional Ready | Menghapus duplikasi sebelum menghitung peserta mata kuliah dan menyeragamkan tanggal |
| nilai | Memiliki key unik sebanyak 57.000 record; terdapat 20 nilai kosong, 12 nilai di luar rentang 0–100, 20 ketidaksesuaian angka-huruf, dan 17 ketidaksesuaian huruf-status | Conditional Ready | Mengeluarkan nilai kosong dan tidak valid dari KPI serta memastikan aturan resmi penentuan kelulusan |
| aktivitas_lms | Ditemukan 30 event duplikat persis; skor kuis hanya terisi pada `quiz_attempt`; durasi dan skor berada dalam rentang yang sesuai serta tidak ditemukan orphan | Conditional Ready | Menghilangkan event duplikat berdasarkan `lms_event_id` sebelum proses perhitungan |
| kelulusan – profile on-time | Terdapat 347 record tetapi hanya 345 NIM unik; ditemukan 2 duplikasi persis, 1 format tanggal bermasalah, seluruh status bernilai `Ya`, dan masa studi berkisar 46–47 bulan | Conditional Ready | Melakukan deduplikasi berdasarkan NIM dan memeriksa konsistensi data masa studi serta IPK |
| kelulusan – on-time vs late | Seluruh 347 record memiliki status tepat waktu `Ya`; belum terdapat kelompok mahasiswa yang terlambat lulus dan data hanya mencakup angkatan 2021 pada Juni 2025 | Not Ready | Mengonfirmasi kepada bagian akademik apakah data mahasiswa terlambat belum tersedia atau belum tercatat |

Keterangan:

- **Ready**: Data dapat digunakan tanpa perbaikan besar.
- **Conditional Ready**: Data dapat digunakan setelah dilakukan pembersihan atau pemeriksaan tertentu.
- **Not Ready**: Data belum dapat digunakan untuk kebutuhan analisis yang ditentukan karena informasi penting belum tersedia.

Berdasarkan hasil tersebut, sebagian besar data dapat dimanfaatkan setelah melalui proses pembersihan. Satu kebutuhan yang belum dapat dipenuhi adalah perbandingan kelulusan tepat waktu dengan kelulusan terlambat karena dataset belum memiliki kategori mahasiswa terlambat lulus.

## 11. Candidate Model

Candidate Model disusun untuk menentukan gambaran awal model data yang berpotensi digunakan dalam analisis. Pada tahap ini belum dilakukan pembangunan Star Schema secara final. Fokusnya adalah menentukan business event, grain, fact, dimension, dan measure berdasarkan Analytical Question.

Penyusunan menggunakan alur:

**Analytical Question → Business Event → Grain → Dimension → Fact → Measure.**

### AQ01

**Analytical Question:**

> Mata kuliah apa yang memiliki failure rate tertinggi pada setiap semester?

**Business Event:**

> Mahasiswa memperoleh hasil penilaian akhir pada mata kuliah.

**Candidate Grain:**

> Satu record menggambarkan nilai akhir seorang mahasiswa pada satu mata kuliah dalam satu semester.

**Candidate Fact:**

> Fact_Penilaian atau Fact_Nilai_Mahasiswa.

**Candidate Dimensions:**

- Dim_Mahasiswa
- Dim_Mata_Kuliah
- Dim_Semester
- Dim_Program_Studi

**Candidate Measures:**

- `nilai_angka`
- `is_lulus`
- Record count

### AQ02

**Analytical Question:**

> Bagaimana perkembangan persentase ketidaklulusan pada setiap program studi dari semester 2021G sampai 2024E?

**Business Event:**

> Mahasiswa mendapatkan nilai akhir pada mata kuliah yang diambil selama semester berlangsung.

**Candidate Grain:**

> Satu record menunjukkan hasil penilaian seorang mahasiswa untuk satu mata kuliah pada satu semester, sama dengan grain AQ01.

**Candidate Fact:**

> Fact_Penilaian.

**Candidate Dimensions:**

- Dim_Mahasiswa
- Dim_Program_Studi
- Dim_Semester

**Candidate Measures:**

- `is_tidak_lulus`
- Jumlah peserta
- Failure rate

### AQ03

**Analytical Question:**

> Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi pada setiap program studi?

**Business Event:**

> Mahasiswa menyelesaikan seluruh persyaratan akademik dan dinyatakan lulus oleh bagian akademik.

**Candidate Grain:**

> Satu record mewakili satu peristiwa kelulusan untuk satu mahasiswa.

**Candidate Fact:**

> Fact_Kelulusan.

**Candidate Dimensions:**

- Dim_Mahasiswa
- Dim_Program_Studi
- Dim_Angkatan
- Dim_Tanggal_Lulus

**Candidate Measures:**

- `is_tepat_waktu`
- `masa_studi_bulan`
- `ipk_final`
- Jumlah lulusan

Catatan: Seluruh lulusan dalam dataset saat ini berstatus tepat waktu. Oleh karena itu, masa studi menjadi ukuran tambahan yang lebih informatif untuk membandingkan kelompok lulusan.

### AQ04

**Analytical Question:**

> Bagaimana pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada setiap mata kuliah?

**Business Event:**

> Mahasiswa melaksanakan aktivitas pembelajaran melalui sistem LMS.

**Candidate Grain:**

> Satu record merepresentasikan satu aktivitas LMS berdasarkan satu `lms_event_id`.

**Candidate Fact:**

> Fact_Aktivitas_LMS.

**Candidate Dimensions:**

- Dim_Mahasiswa
- Dim_Mata_Kuliah
- Dim_Tipe_Aktivitas
- Dim_Tanggal/Waktu

**Candidate Measures:**

- `durasi_menit`
- `skor_kuis` (khusus `quiz_attempt`)
- Jumlah event

Catatan: Untuk menghubungkan aktivitas LMS dengan nilai, data aktivitas perlu diagregasi terlebih dahulu berdasarkan mahasiswa dan mata kuliah. Hasil agregasi tersebut kemudian dibandingkan dengan Fact_Penilaian melalui dimensi mahasiswa dan mata kuliah.

### AQ05

**Analytical Question:**

> Bagaimana perbedaan rata-rata nilai angka pada semester awal berdasarkan kelompok predikat kelulusan mahasiswa?

**Business Event:**

> Mahasiswa memperoleh nilai akhir pada semester awal dan kemudian dinyatakan lulus.

**Candidate Grain:**

> Nilai pada dua semester awal dirangkum terlebih dahulu menjadi satu record per mahasiswa, kemudian dihubungkan dengan satu record kelulusan mahasiswa.

**Candidate Fact:**

> Fact_Penilaian yang diagregasi berdasarkan mahasiswa dan Fact_Kelulusan yang memiliki satu record untuk setiap mahasiswa.

**Candidate Dimensions:**

- Dim_Mahasiswa
- Dim_Semester
- Dim_Predikat_Kelulusan

**Candidate Measures:**

- `nilai_angka`
- `ipk_final`

Catatan: Kedua fact tidak boleh langsung digabungkan pada tingkat detail karena dapat mengakibatkan penggandaan record atau fan-out. Penggabungan dilakukan setelah nilai semester awal diringkas pada tingkat mahasiswa.

## 12. Traceability

Traceability berfungsi untuk memperlihatkan keterkaitan antara masalah bisnis, kebutuhan keputusan, pertanyaan analitis, indikator kinerja, kebutuhan data, sumber data, kualitas data, hingga kandidat model yang akan digunakan.

Alur yang digunakan:

**Problem → Business Objective → Stakeholder → Decision Requirement → Analytical Question → KPI/Metric → Data Requirement → Source Mapping → Data Fitness → Candidate Model.**

### 1. TR01 – Course Failure

- Problem → Mata kuliah dengan risiko ketidaklulusan tinggi belum mudah diketahui.
- Business Objective → BO01, meningkatkan kemampuan program studi dalam mengidentifikasi mata kuliah bermasalah.
- Stakeholder → Kaprodi.
- Decision → Menentukan mata kuliah yang menjadi prioritas evaluasi.
- AQ → Mengetahui mata kuliah dengan failure rate tertinggi pada setiap semester.
- KPI → Course Failure Rate.
- Data → NIM, kode mata kuliah, semester, nilai angka, dan status kelulusan.
- Source → `nilai`, `mata_kuliah`, dan `semester`.
- Fitness → Data nilai Conditional Ready, sedangkan mata kuliah dan semester Ready.
- Candidate Process → Penilaian.
- Candidate Grain → Satu nilai akhir mahasiswa untuk satu mata kuliah dalam satu semester.

Karena program studi belum mempunyai informasi yang cukup untuk mengetahui mata kuliah dengan tingkat ketidaklulusan tinggi, Kaprodi membutuhkan peningkatan kemampuan evaluasi pembelajaran agar mata kuliah yang bermasalah dapat segera ditangani. Keputusan yang harus diambil adalah menentukan mata kuliah yang menjadi prioritas evaluasi berdasarkan persentase kegagalannya. Untuk mendukung keputusan tersebut, diperlukan jawaban mengenai mata kuliah dengan failure rate tertinggi pada setiap semester menggunakan KPI Course Failure Rate. Data yang dibutuhkan mencakup NIM, kode mata kuliah, semester, nilai angka, dan status kelulusan yang bersumber dari tabel `nilai`, `mata_kuliah`, serta `semester`. Berdasarkan hasil profiling, tabel nilai memiliki kondisi Conditional Ready karena ditemukan nilai kosong, nilai di luar rentang, dan ketidaksesuaian antarjenis nilai. Sementara itu, tabel mata_kuliah dan semester telah berstatus Ready.

Oleh karena itu, kandidat model yang dapat digunakan adalah:

- **Grain:** Satu record berisi nilai akhir seorang mahasiswa pada satu mata kuliah dalam satu semester.
- **Fact:** Fact_Penilaian atau Fact_Nilai_Mahasiswa.
- **Dimension:** Dim_Mahasiswa, Dim_Mata_Kuliah, dan Dim_Semester.
- **Measure:** `nilai_angka`, `is_lulus`, jumlah peserta, jumlah mahasiswa tidak lulus, dan Course Failure Rate (%).

### 2. TR02 – On-Time Graduation

- Problem → Pola kelulusan mahasiswa yang terlambat belum dapat dianalisis secara menyeluruh antarprogram studi.
- Business Objective → BO03, mengevaluasi pola kelulusan tepat waktu.
- Stakeholder → Wakil Rektor Bidang Akademik.
- Decision → Menentukan program studi dan angkatan yang membutuhkan program peningkatan keberhasilan studi.
- AQ → Membandingkan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi.
- KPI → On-Time Graduation Rate.
- Data → NIM, status tepat waktu, masa studi, angkatan, dan kode program studi.
- Source → `kelulusan`, `mahasiswa`, dan `program_studi`.
- Fitness → Data kelulusan dan mahasiswa Conditional Ready; program_studi Ready.
- Candidate Process → Kelulusan.
- Candidate Grain → Satu record kelulusan untuk setiap mahasiswa.

Karena informasi mengenai kelulusan tepat waktu belum dapat digunakan untuk membandingkan mahasiswa yang terlambat dengan mahasiswa yang lulus sesuai target, Wakil Rektor Bidang Akademik membutuhkan evaluasi terhadap pola penyelesaian studi. Keputusan yang perlu dibuat adalah menentukan program studi dan angkatan yang memerlukan program penguatan akademik. Analisis dilakukan dengan membandingkan persentase kelulusan tepat waktu serta rata-rata masa studi menggunakan KPI On-Time Graduation Rate. Data yang diperlukan terdiri atas NIM, status tepat waktu, masa studi, angkatan, dan identitas program studi yang berasal dari tabel `kelulusan`, `mahasiswa`, dan `program_studi`.

Berdasarkan hasil profiling, tabel kelulusan memiliki dua record duplikat dan seluruh data yang tersedia berstatus tepat waktu. Tabel mahasiswa juga membutuhkan pembersihan karena terdapat NIM duplikat dan kode program studi yang belum seragam. Adapun tabel program_studi sudah berada dalam kondisi Ready.

Kandidat model yang dapat disusun adalah:

- **Grain:** Satu record kelulusan untuk satu mahasiswa.
- **Fact:** Fact_Kelulusan.
- **Dimension:** Dim_Mahasiswa, Dim_Program_Studi, Dim_Angkatan, dan Dim_Tanggal_Lulus.
- **Measure:** `is_tepat_waktu`, `masa_studi_bulan`, `ipk_final`, jumlah lulusan, dan On-Time Graduation Rate (%).

### 3. TR03 – LMS Engagement dan Nilai

- Problem → Belum diketahui secara jelas apakah keterlibatan mahasiswa di LMS mempunyai hubungan dengan hasil nilai akademik.
- Business Objective → BO04, mengevaluasi keterkaitan aktivitas LMS dengan performa nilai.
- Stakeholder → Dosen Pengampu dan Kaprodi.
- Decision → Menentukan apakah aktivitas LMS dapat dimanfaatkan sebagai indikator pendukung risiko akademik.
- AQ → Mengamati pola hubungan aktivitas LMS dengan nilai angka pada setiap mata kuliah.
- KPI → LMS Engagement per Mata Kuliah.
- Data → ID event LMS, NIM, kode mata kuliah, durasi, skor kuis, dan nilai angka.
- Source → `aktivitas_lms` dan `nilai`.
- Fitness → Aktivitas LMS Conditional Ready karena terdapat 30 duplikasi; nilai Conditional Ready karena masih ditemukan data bermasalah.
- Candidate Process → Aktivitas Pembelajaran LMS.
- Candidate Grain → Satu record aktivitas LMS berdasarkan satu `lms_event_id`.

Karena belum tersedia informasi yang menunjukkan hubungan antara keterlibatan mahasiswa dalam LMS dengan hasil akademik, Dosen Pengampu dan Kaprodi perlu melakukan evaluasi terhadap kedua informasi tersebut. Keputusan yang akan dibuat adalah menentukan apakah aktivitas LMS layak digunakan sebagai indikator tambahan untuk mendeteksi risiko akademik. Untuk itu dibutuhkan jawaban mengenai pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa melalui KPI LMS Engagement.

Data yang diperlukan meliputi `lms_event_id`, NIM, kode mata kuliah, durasi aktivitas, skor kuis, dan nilai angka. Informasi tersebut berasal dari tabel `aktivitas_lms` dan `nilai`. Hasil profiling menunjukkan bahwa aktivitas LMS memiliki 30 event duplikat, sedangkan tabel nilai masih mempunyai nilai kosong, nilai di luar batas valid, serta ketidaksesuaian antara nilai angka, huruf, dan status kelulusan.

Kandidat model yang dapat digunakan adalah:

- **Grain:** Satu record mewakili satu aktivitas LMS.
- **Fact:** Fact_Aktivitas_LMS.
- **Dimension:** Dim_Mahasiswa, Dim_Mata_Kuliah, Dim_Tipe_Aktivitas, dan Dim_Tanggal.
- **Measure:** Jumlah event, `durasi_menit`, dan `skor_kuis`.

Hubungan dengan nilai dianalisis dengan mengagregasi aktivitas LMS terlebih dahulu berdasarkan mahasiswa dan mata kuliah, kemudian menghubungkannya dengan Fact_Penilaian melalui dimensi bersama.

### 4. TR04 – Deteksi Dini Mahasiswa Berisiko

- Problem → Kelompok mahasiswa yang memerlukan pendampingan akademik sejak awal belum dapat diidentifikasi dengan baik.
- Business Objective → BO02, memperkuat identifikasi mahasiswa dan kelompok akademik yang berisiko.
- Stakeholder → Dosen Pembimbing Akademik dan Bagian Akademik.
- Decision → Menentukan kelompok mahasiswa yang membutuhkan pendampingan lebih awal.
- AQ → Membandingkan rata-rata nilai semester awal berdasarkan kelompok predikat kelulusan.
- KPI → Rata-rata nilai angka semester awal berdasarkan predikat kelulusan (metrik turunan dari KPI01).
- Data → NIM, semester, nilai angka, dan predikat kelulusan.
- Source → `nilai`, `kelulusan`, dan `semester`.
- Fitness → Data nilai dan kelulusan Conditional Ready; data semester Ready.
- Candidate Process → Penilaian dan Kelulusan.
- Candidate Grain → Ringkasan nilai dua semester awal per mahasiswa yang dihubungkan dengan satu record kelulusan.

Karena belum tersedia informasi yang cukup untuk mengenali kelompok mahasiswa yang membutuhkan pendampingan akademik lebih awal, Dosen Pembimbing Akademik dan Bagian Akademik perlu memperkuat proses deteksi dini. Keputusan yang harus diambil adalah menentukan kelompok mahasiswa yang perlu memperoleh perhatian berdasarkan hasil akademik pada semester awal. Analisis dilakukan dengan membandingkan rata-rata nilai angka pada dua semester awal berdasarkan kelompok predikat kelulusan.

Data yang diperlukan terdiri atas NIM, semester, nilai angka, dan predikat kelulusan. Sumbernya berasal dari tabel `nilai`, `kelulusan`, dan `semester`. Berdasarkan hasil profiling, tabel nilai dan kelulusan masih berstatus Conditional Ready karena membutuhkan pembersihan dan pemeriksaan lebih lanjut. Sementara itu, tabel semester sudah berstatus Ready.

Perbandingan mahasiswa tepat waktu dengan mahasiswa terlambat belum dapat dilakukan karena seluruh data kelulusan yang tersedia memiliki status tepat waktu.

Kandidat model yang dapat digunakan adalah Fact_Penilaian yang terlebih dahulu diringkas menjadi rata-rata nilai semester awal per mahasiswa, kemudian dihubungkan dengan Fact_Kelulusan yang memiliki satu record per mahasiswa melalui Dim_Mahasiswa. Dimensi pendukung yang digunakan adalah Dim_Semester dan Dim_Predikat_Kelulusan.

- **Grain:** Ringkasan nilai dua semester pertama untuk setiap mahasiswa yang telah dihubungkan dengan satu data kelulusan.
- **Fact:** Fact_Penilaian dan Fact_Kelulusan.
- **Dimension:** Dim_Mahasiswa, Dim_Semester, dan Dim_Predikat_Kelulusan.
- **Measure:** Rata-rata nilai angka semester awal dan `ipk_final`.

Penggabungan kedua fact harus dilakukan setelah data penilaian diagregasi agar tidak menimbulkan penggandaan record atau fan-out.
