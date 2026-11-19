# LAPORAN MODUL 1 UNIT 1.3
## PENERJEMAHAN KEBUTUHAN BISNIS MENJADI KEBUTUHAN ANALITIK

### Identitas Laporan

Nama : Annisa Almaghvirah  
NIM : 240306037  
Program Studi : Teknologi Informasi  
Modul : 1  
Unit : 1.3  
Tanggal Praktikum : [Isi tanggal]

### Studi Kasus

Universitas Digital Nusantara menemukan bahwa evaluasi akademik masih banyak dilakukan secara terpisah oleh masing-masing program studi. Kaprodi dapat melihat nilai mahasiswa, tetapi belum memiliki informasi terintegrasi untuk mengetahui mata kuliah yang paling sering menjadi hambatan, mahasiswa yang membutuhkan pendampingan lebih awal, hubungan aktivitas pembelajaran melalui LMS dengan hasil nilai, serta pola kelulusan tepat waktu.

Wakil Rektor Bidang Akademik meminta tim Data Warehouse menyiapkan dasar kebutuhan analitik untuk mendukung peningkatan keberhasilan studi dan kelulusan tepat waktu. Pada tahap ini, tim belum diminta membangun Star Schema atau ETL. Fokus Unit 1.3 adalah menerjemahkan permasalahan bisnis menjadi kebutuhan informasi dan kebutuhan data yang dapat ditelusuri ke dataset UADW v1.0.

Keputusan yang akan didukung meliputi:
1. Menentukan mata kuliah yang perlu mendapatkan evaluasi atau program remedial.
2. Mengidentifikasi kelompok mahasiswa yang membutuhkan pendampingan akademik lebih awal.
3. Menentukan program studi dan angkatan yang menunjukkan penurunan performa akademik.
4. Mengevaluasi apakah aktivitas LMS dapat digunakan sebagai indikator pendukung risiko akademik.
5. Mengevaluasi pola kelulusan tepat waktu berdasarkan program studi dan angkatan.

Batas kasus: fokus utama analisis adalah keberhasilan akademik dan kelulusan tepat waktu. Data pembayaran tidak digunakan sebagai kebutuhan utama pada Unit 1.3.

---

## 1. Identifikasi Stakeholder

Langkah pertama adalah menentukan pihak-pihak yang berkepentingan terhadap informasi akademik yang akan dihasilkan. Stakeholder yang berhasil diidentifikasi adalah sebagai berikut.

| Stakeholder | Information Need | Decision Supported | Priority |
|---|---|---|---|
| Wakil Rektor Bidang Akademik | Informasi performa akademik dan kelulusan tepat waktu secara keseluruhan berdasarkan program studi dan angkatan | Menentukan kebijakan peningkatan keberhasilan studi dan kelulusan tepat waktu | High |
| Kepala Program Studi (Kaprodi) | Informasi mata kuliah dengan tingkat ketidaklulusan tinggi, perkembangan nilai, dan pola kelulusan mahasiswa | Menentukan mata kuliah yang perlu dievaluasi atau diberikan program remedial | High |
| Dosen Pengampu | Informasi sebaran nilai, tingkat ketidaklulusan, serta aktivitas mahasiswa pada LMS | Mengevaluasi metode pengajaran, materi pembelajaran, dan proses penilaian | Medium |
| Dosen Pembimbing Akademik / Bagian Akademik | Informasi mahasiswa yang memiliki nilai rendah atau beberapa mata kuliah tidak lulus | Menentukan mahasiswa yang perlu memperoleh pendampingan akademik lebih awal | Medium |
| Tim Data Warehouse | Informasi kualitas, kelengkapan, dan kesiapan data sumber | Menentukan prioritas pemeriksaan data dan kandidat model analitik | Medium |

## 2. Problem Statement

Berdasarkan studi kasus, pertanyaan pemantik dijawab sebagai berikut.

**1. Bagaimana kondisi sekarang? (Kondisi)**

Evaluasi akademik masih dilakukan secara terpisah oleh masing-masing program studi. Informasi mahasiswa, KRS, nilai, aktivitas LMS, dan kelulusan tersedia dalam tabel sumber yang berbeda sehingga belum memberikan gambaran akademik secara menyeluruh.

**2. Apa yang belum dapat dilakukan? (Masalah)**

Universitas belum memiliki informasi terintegrasi untuk mengidentifikasi mata kuliah dengan tingkat ketidaklulusan tinggi, menentukan mahasiswa yang membutuhkan pendampingan lebih awal, melihat hubungan aktivitas LMS dengan hasil nilai, serta membandingkan pola kelulusan tepat waktu berdasarkan program studi dan angkatan.

**3. Apa akibatnya bagi organisasi? (Dampak)**

Proses evaluasi akademik menjadi kurang efektif karena pihak universitas kesulitan menentukan prioritas perbaikan pembelajaran. Pendampingan kepada mahasiswa juga berpotensi terlambat, sementara program peningkatan kelulusan tepat waktu belum dapat ditentukan berdasarkan informasi yang menyeluruh.

**4. Informasi apa yang dibutuhkan untuk memperbaiki kondisi tersebut? (Kebutuhan Analitik)**

Diperlukan informasi mengenai persentase ketidaklulusan setiap mata kuliah, perkembangan performa akademik berdasarkan program studi dan semester, persentase kelulusan tepat waktu, serta pola hubungan antara aktivitas LMS dengan hasil nilai mahasiswa.

**Problem Statement**

Saat ini evaluasi akademik masih dilakukan secara terpisah oleh masing-masing program studi, tetapi universitas belum memiliki informasi terintegrasi untuk mengetahui mata kuliah yang memiliki tingkat ketidaklulusan tinggi, mahasiswa yang membutuhkan pendampingan lebih awal, hubungan aktivitas LMS dengan hasil nilai, serta pola kelulusan tepat waktu. Akibatnya, proses evaluasi dan pemberian intervensi akademik belum dapat dilakukan secara optimal. Oleh karena itu, diperlukan analisis terintegrasi terhadap data mahasiswa, KRS, nilai, aktivitas LMS, dan kelulusan agar pihak universitas dapat menentukan keputusan berdasarkan informasi akademik yang lebih lengkap.

## 3. Business Process

Business Process disusun menggunakan rumus:

**Actor melakukan Event terhadap Object pada Time.**

**1. Kejadian bisnis apa yang menghasilkan data?**

Kegiatan bisnis yang menghasilkan data meliputi pengambilan mata kuliah melalui KRS, pemberian nilai akhir mahasiswa, aktivitas pembelajaran melalui LMS, dan pencatatan kelulusan mahasiswa.

**2. Siapa aktor yang berperan?**

Aktor yang terlibat adalah mahasiswa, dosen pengampu, dosen pembimbing akademik, bagian akademik, dan sistem LMS.

**3. Apa yang menjadi objek dari studi kasus?**

Objek yang dianalisis meliputi mata kuliah yang diambil mahasiswa, hasil penilaian akademik, aktivitas pembelajaran melalui LMS, serta status dan informasi kelulusan mahasiswa.

**4. Kapan kejadian bisnis terjadi?**

Kegiatan KRS dan penilaian berlangsung pada setiap semester. Aktivitas LMS tercatat selama proses pembelajaran berlangsung, sedangkan pencatatan kelulusan dilakukan ketika mahasiswa telah menyelesaikan persyaratan akademik.

Berdasarkan proses tersebut, domain bisnis yang berhasil diidentifikasi adalah:

**1. KRS**

Mahasiswa melakukan pengambilan mata kuliah yang ditawarkan pada awal semester. Kegiatan tersebut menghasilkan data mengenai mahasiswa, mata kuliah yang dipilih, semester, kelas, dan status pengambilan mata kuliah.

**2. Penilaian**

Dosen pengampu memberikan nilai akhir kepada mahasiswa berdasarkan hasil pembelajaran pada mata kuliah tertentu. Nilai tersebut dicatat dalam bentuk nilai angka, nilai huruf, dan status kelulusan pada setiap semester.

**3. Aktivitas Pembelajaran LMS**

Mahasiswa melakukan aktivitas pembelajaran melalui LMS, seperti login, melihat materi, mengirim tugas, mengerjakan kuis, dan berpartisipasi dalam forum selama periode perkuliahan. Aktivitas tersebut menghasilkan catatan mengenai waktu, jenis kegiatan, durasi, dan skor kuis jika tersedia.

**4. Kelulusan**

Bagian akademik mencatat mahasiswa yang telah menyelesaikan studi beserta informasi tanggal kelulusan, IPK akhir, masa studi, predikat, dan status ketepatan waktu kelulusan.

## 4. Business Objective

Business Objective menjelaskan tujuan yang ingin dicapai oleh universitas berdasarkan permasalahan yang telah diidentifikasi.

Tujuan bisnis yang dirumuskan adalah:

**BO01** — Meningkatkan kemampuan program studi dalam mengidentifikasi mata kuliah yang memiliki tingkat ketidaklulusan tinggi agar evaluasi pembelajaran dan program remedial dapat dilakukan secara tepat.

**BO02** — Memperkuat pemantauan performa akademik mahasiswa agar mahasiswa yang berisiko mengalami kesulitan akademik dapat diketahui dan memperoleh pendampingan lebih awal.

**BO03** — Mengevaluasi pola kelulusan tepat waktu berdasarkan program studi dan angkatan agar universitas dapat menyusun program peningkatan keberhasilan studi.

**BO04** — Mengevaluasi hubungan aktivitas pembelajaran melalui LMS dengan hasil nilai akademik agar aktivitas LMS dapat dipertimbangkan sebagai indikator pendukung pemantauan performa mahasiswa.

## 5. Decision Requirement

Decision Requirement menjelaskan keputusan yang perlu dibuat oleh stakeholder berdasarkan informasi yang tersedia.

Kebutuhan keputusan yang dirumuskan adalah:

**DR01** — Kaprodi perlu menentukan mata kuliah yang memiliki tingkat ketidaklulusan tinggi berdasarkan persentase ketidaklulusan pada setiap semester.

**DR02** — Wakil Rektor Bidang Akademik perlu menentukan program studi dan angkatan yang membutuhkan program peningkatan akademik berdasarkan perubahan persentase ketidaklulusan dan hasil performa mahasiswa.

**DR03** — Wakil Rektor Bidang Akademik perlu mengevaluasi program studi dan angkatan berdasarkan persentase kelulusan tepat waktu serta rata-rata masa studi mahasiswa.

**DR04** — Dosen Pengampu dan Kaprodi perlu menentukan apakah aktivitas LMS layak digunakan sebagai indikator pendukung risiko akademik berdasarkan pola hubungan aktivitas pembelajaran dengan nilai mahasiswa.

**DR05** — Dosen Pembimbing Akademik dan Bagian Akademik perlu menentukan kelompok mahasiswa yang membutuhkan pendampingan berdasarkan perbedaan hasil nilai semester awal dan predikat kelulusan.

## 6. Analytical Questions

Analytical Question disusun menggunakan rumus:

**Metric + Dimension + Time + Comparison**

Pertanyaan analitis dibuat menggunakan pola trend, comparison, ranking, dan relationship.

**1. Trend**

Bagaimana perubahan persentase ketidaklulusan mahasiswa berdasarkan program studi dari semester 2021G sampai semester 2024E?

**2. Comparison**

Bagaimana perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi pada kelompok mahasiswa yang telah lulus?

**3. Ranking**

Mata kuliah apa yang memiliki persentase ketidaklulusan tertinggi pada setiap semester?

**4. Relationship**

Bagaimana pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada mata kuliah yang sama?

**5. Comparison**

Bagaimana perbedaan rata-rata nilai angka pada semester awal antara mahasiswa dengan kelompok predikat kelulusan yang berbeda?

Berdasarkan pertanyaan tersebut, Analytical Question dapat dirangkum sebagai berikut.

| AQ | Analytical Question | Stakeholder | Decision | Priority |
|---|---|---|---|---|
| AQ01 | Mata kuliah apa yang memiliki persentase ketidaklulusan tertinggi pada setiap semester? (Ranking) | Kaprodi | DR01 | High |
| AQ02 | Bagaimana perubahan persentase ketidaklulusan setiap program studi dari semester 2021G sampai 2024E? (Trend) | Wakil Rektor Bidang Akademik | DR02 | High |
| AQ03 | Bagaimana perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi? (Comparison) | Wakil Rektor Bidang Akademik dan Kaprodi | DR03 | High |
| AQ04 | Bagaimana pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada setiap mata kuliah? (Relationship) | Dosen Pengampu dan Kaprodi | DR04 | Medium |
| AQ05 | Bagaimana perbedaan rata-rata nilai angka pada semester awal antar kelompok predikat kelulusan? (Comparison) | Dosen Pembimbing Akademik dan Bagian Akademik | DR05 | High |

## 7. Key Performance Indicator (KPI)

KPI disusun menggunakan pendekatan *top-down* dengan alur:

**Business Objective → Decision Requirement → Analytical Question → Memilih Bentuk Metrik yang Adil → Formulasi KPI.**

### KPI01 — Course Failure Rate

**Business Objective (BO01)** = Meningkatkan kemampuan program studi dalam mengidentifikasi mata kuliah yang memiliki tingkat ketidaklulusan tinggi.

**Decision Requirement (DR01)** = Kaprodi perlu menentukan mata kuliah yang memiliki tingkat ketidaklulusan tinggi berdasarkan persentase ketidaklulusan pada setiap semester.

**Analytical Question (AQ01)** = Mata kuliah apa yang memiliki persentase ketidaklulusan tertinggi pada setiap semester?

**1. Membedah tujuan bisnis (BO01)**

Kata kunci dari tujuan bisnis ini adalah performa mata kuliah. Performa mata kuliah dapat dilihat dari keberhasilan mahasiswa dalam memenuhi standar kelulusan. Apabila persentase mahasiswa yang tidak lulus cukup tinggi, mata kuliah tersebut perlu mendapatkan perhatian dan evaluasi.

**2. Menangkap kebutuhan keputusan (DR01)**

Kaprodi membutuhkan informasi yang dapat menunjukkan mata kuliah dengan tingkat ketidaklulusan tinggi. Informasi tersebut dapat digunakan untuk menentukan mata kuliah yang perlu dievaluasi atau diberikan program remedial.

**3. Menerjemahkan ke pertanyaan analitis (AQ01)**

- Measure: Jumlah mahasiswa tidak lulus dan total mahasiswa yang memiliki nilai akhir.
- Dimension: Mata kuliah dan program studi.
- Time: Semester dan tahun akademik.
- Cara analisis: Membandingkan dan mengurutkan persentase ketidaklulusan dari yang tertinggi.

**4. Memilih bentuk metrik yang adil**

Metrik yang digunakan adalah persentase ketidaklulusan, bukan hanya jumlah mahasiswa yang tidak lulus. Hal ini karena setiap mata kuliah memiliki jumlah peserta yang berbeda. Dengan menggunakan persentase, perbandingan tingkat ketidaklulusan menjadi lebih proporsional.

**5. Merumuskan KPI final**

- **KPI Name:** Persentase Ketidaklulusan per Mata Kuliah (*Course Failure Rate*).
- **Definisi:** Persentase mahasiswa yang tidak memenuhi standar kelulusan pada suatu mata kuliah dibandingkan dengan seluruh mahasiswa yang memiliki nilai akhir pada mata kuliah tersebut dalam semester yang sama.

**Formula:**

- Numerator: Jumlah mahasiswa unik pada kombinasi NIM, kode mata kuliah, dan semester dengan status tidak lulus.
- Denominator: Jumlah seluruh mahasiswa unik pada kombinasi NIM, kode mata kuliah, dan semester yang memiliki nilai akhir valid.
- Aggregation: Jumlah mahasiswa tidak lulus dibagi jumlah seluruh mahasiswa yang memiliki nilai akhir, kemudian dikalikan 100%.

\[
\text{Course Failure Rate} =
\frac{\text{Jumlah Mahasiswa Tidak Lulus}}
{\text{Total Mahasiswa dengan Nilai Akhir Valid}}
\times 100\%
\]

**Konteks:**
- Waktu: Tahun akademik dan semester.
- Mata kuliah: Kode dan nama mata kuliah.
- Program studi: Program studi mahasiswa.

**Caveat:**
- Terdapat 20 nilai angka kosong dan 12 nilai di luar rentang 0–100 sehingga perlu dikeluarkan dari perhitungan sementara sampai divalidasi.
- Terdapat 20 ketidaksesuaian antara nilai angka dan nilai huruf sehingga aturan penentuan kelulusan perlu dikonfirmasi.
- Status kelulusan harus mengikuti aturan akademik resmi.
- Mata kuliah dengan jumlah peserta sedikit perlu diperiksa karena perubahan beberapa mahasiswa dapat menghasilkan persentase yang cukup besar.
- Duplikasi pada data KRS perlu diperiksa sebelum digunakan sebagai pembanding jumlah peserta.

### KPI02 — On-Time Graduation Rate

**Business Objective (BO03)** = Mengevaluasi pola kelulusan tepat waktu agar universitas dapat menyusun program peningkatan keberhasilan studi.

**Decision Requirement (DR03)** = Wakil Rektor Bidang Akademik perlu mengevaluasi program studi dan angkatan berdasarkan persentase kelulusan tepat waktu serta rata-rata masa studi mahasiswa.

**Analytical Question (AQ03)** = Bagaimana perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?

**1. Membedah tujuan bisnis (BO03)**

Tujuan bisnis ini berfokus pada keberhasilan mahasiswa dalam menyelesaikan pendidikan sesuai dengan waktu yang telah ditentukan. Informasi mengenai ketepatan waktu kelulusan dapat digunakan untuk mengevaluasi keberhasilan proses akademik.

**2. Menangkap kebutuhan keputusan (DR03)**

Wakil Rektor Bidang Akademik membutuhkan informasi mengenai persentase kelulusan tepat waktu dan rata-rata masa studi pada setiap program studi. Informasi tersebut digunakan untuk mengetahui kondisi kelulusan dan menentukan program peningkatan keberhasilan studi.

**3. Menerjemahkan ke pertanyaan analitis (AQ03)**

- Measure: Jumlah lulusan tepat waktu, total lulusan unik, dan rata-rata masa studi.
- Dimension: Program studi dan angkatan.
- Time: Periode atau tahun kelulusan.
- Cara analisis: Membandingkan persentase kelulusan dan rata-rata masa studi antarprogram studi.

**4. Memilih bentuk metrik yang adil**

Metrik yang digunakan adalah persentase kelulusan tepat waktu karena jumlah lulusan setiap program studi dapat berbeda. Rata-rata masa studi digunakan sebagai ukuran tambahan agar evaluasi tidak hanya berfokus pada jumlah lulusan.

**5. Merumuskan KPI final**

- **KPI Name:** Persentase Kelulusan Tepat Waktu (*On-Time Graduation Rate*).
- **Definisi:** Persentase mahasiswa yang menyelesaikan studi tepat waktu dibandingkan dengan seluruh mahasiswa unik yang tercatat lulus pada kelompok yang dianalisis.

**Formula:**

- Numerator: Jumlah mahasiswa unik dengan `status_tepat_waktu = 'Ya'`.
- Denominator: Jumlah seluruh mahasiswa unik yang tercatat pada tabel kelulusan.
- Aggregation: Jumlah lulusan tepat waktu dibagi jumlah seluruh lulusan unik, kemudian dikalikan 100%.

\[
\text{On-Time Graduation Rate} =
\frac{\text{Jumlah Lulusan Unik Tepat Waktu}}
{\text{Jumlah Seluruh Lulusan Unik}}
\times 100\%
\]

**Konteks:**
- Program studi.
- Angkatan mahasiswa.
- Periode kelulusan.
- Lama studi dalam bulan.

**Caveat:**
- Terdapat 2 baris berlebih akibat duplikasi pada tabel kelulusan sehingga identitas mahasiswa perlu diperiksa sebelum agregasi.
- Terdapat 347 record kelulusan dengan 345 mahasiswa unik.
- Seluruh record yang tersedia berstatus tepat waktu. Setelah duplikasi diperhitungkan, 345 mahasiswa unik tercatat lulus tepat waktu.
- Data kelulusan yang tersedia belum memiliki kelompok mahasiswa terlambat sebagai pembanding.
- Seluruh lulusan yang tersedia berasal dari angkatan 2021 dengan masa studi 46–47 bulan. Oleh karena itu, rata-rata masa studi perlu digunakan sebagai ukuran tambahan.
- Definisi masa studi normal dan aturan penentuan status tepat waktu perlu dikonfirmasi kepada bagian akademik.

### KPI03 — LMS Engagement per Mata Kuliah

**Business Objective (BO04)** = Mengevaluasi hubungan aktivitas LMS dengan performa nilai agar aktivitas LMS dapat dipertimbangkan sebagai indikator pendukung risiko akademik.

**Decision Requirement (DR04)** = Dosen Pengampu dan Kaprodi perlu menentukan apakah aktivitas LMS layak digunakan sebagai indikator pendukung risiko akademik berdasarkan pola hubungan aktivitas LMS dengan nilai mahasiswa.

**Analytical Question (AQ04)** = Bagaimana pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada setiap mata kuliah?

**1. Membedah tujuan bisnis (BO04)**

Kata kunci dari tujuan bisnis ini adalah aktivitas LMS dan performa nilai. Aktivitas LMS dapat digunakan untuk melihat keterlibatan mahasiswa dalam proses pembelajaran, sedangkan nilai angka digunakan untuk melihat hasil akademiknya.

**2. Menangkap kebutuhan keputusan (DR04)**

Dosen Pengampu dan Kaprodi membutuhkan informasi mengenai pola aktivitas LMS mahasiswa dan hasil nilai pada mata kuliah yang sama. Informasi tersebut dapat digunakan untuk mengevaluasi apakah aktivitas LMS dapat menjadi indikator pendukung pemantauan akademik.

**3. Menerjemahkan ke pertanyaan analitis (AQ04)**

- Measure: Jumlah aktivitas LMS, durasi aktivitas, dan nilai angka mahasiswa.
- Dimension: Mahasiswa, mata kuliah, dan jenis aktivitas LMS.
- Time: Semester atau periode aktivitas.
- Cara analisis: Melihat hubungan antara aktivitas LMS dengan hasil nilai pada mata kuliah yang sama.

**4. Memilih bentuk metrik yang adil**

Metrik yang digunakan adalah rata-rata aktivitas LMS per mahasiswa pada suatu mata kuliah. Penggunaan rata-rata lebih sesuai daripada jumlah aktivitas keseluruhan karena jumlah mahasiswa yang mengikuti setiap mata kuliah dapat berbeda.

**5. Merumuskan KPI final**

- **KPI Name:** Rata-Rata Aktivitas LMS per Mahasiswa per Mata Kuliah (*LMS Engagement*).
- **Definisi:** Mengukur rata-rata jumlah aktivitas LMS yang dilakukan setiap mahasiswa pada suatu mata kuliah dalam periode tertentu untuk menggambarkan keterlibatan mahasiswa dalam proses pembelajaran.

**Formula:**

- Numerator: Jumlah event LMS unik berdasarkan `lms_event_id` pada mata kuliah dan semester tertentu.
- Denominator: Jumlah mahasiswa unik yang terdaftar pada mata kuliah dan semester tersebut berdasarkan KRS yang telah diperiksa duplikasinya.
- Aggregation: Jumlah event LMS unik dibagi jumlah mahasiswa unik yang terdaftar.

\[
\text{LMS Engagement} =
\frac{\text{Jumlah Event LMS Unik}}
{\text{Jumlah Mahasiswa Terdaftar}}
\]

**Konteks:**
- Mata kuliah.
- Jenis aktivitas LMS (`tipe_event`).
- Semester.
- Waktu aktivitas.
- Nilai angka mahasiswa sebagai pembanding.

**Caveat:**
- Terdapat 30 baris duplikat identik pada tabel aktivitas LMS sehingga perlu diperiksa sebelum digunakan dalam perhitungan.
- Denominator sebaiknya menggunakan mahasiswa yang terdaftar pada KRS, bukan hanya mahasiswa yang memiliki aktivitas LMS.
- Data KRS juga memiliki 25 baris berlebih akibat duplikasi sehingga perlu diperiksa.
- `skor_kuis` hanya tersedia pada aktivitas `quiz_attempt`, sehingga perhitungan skor kuis harus dibatasi pada jenis aktivitas tersebut.
- Aktivitas yang tinggi tidak selalu menunjukkan nilai akademik yang tinggi.
- Hubungan statistik antara aktivitas LMS dan nilai tidak dapat langsung dianggap sebagai hubungan sebab-akibat.

## 8. Data Requirement

Data Requirement diturunkan dari kebutuhan measure, context, time, dan filter/comparison pada setiap Analytical Question dan KPI.

**1. AQ01 dan KPI01**

Analytical Question (AQ01): Mata kuliah apa yang memiliki persentase ketidaklulusan tertinggi pada setiap semester?

KPI: Course Failure Rate.

Komponen yang dibutuhkan:
- Jumlah mahasiswa tidak lulus.
- Jumlah seluruh mahasiswa yang memiliki nilai akhir valid.
- Persentase ketidaklulusan.

Kebutuhan data:
- Measure: Jumlah mahasiswa, jumlah mahasiswa tidak lulus, nilai angka, dan persentase ketidaklulusan.
- Context: Mata kuliah dan program studi.
- Time: Semester dan tahun akademik.
- Filter/Comparison: Nilai valid 0–100 dan status kelulusan yang telah divalidasi.

Data yang diperlukan:
- `nim` dari tabel `nilai` untuk mengidentifikasi mahasiswa.
- `kode_mk` dari tabel `nilai` untuk menentukan mata kuliah.
- `semester_id` dari tabel `nilai` untuk menentukan periode penilaian.
- `nilai_angka` dari tabel `nilai` untuk mengetahui hasil penilaian.
- `status_lulus` dari tabel `nilai` untuk menentukan status kelulusan sementara.
- `kode_mk` dan `nama_mk` dari tabel `mata_kuliah` untuk memberikan informasi mata kuliah.

**2. AQ02 dan KPI01 (Tren Ketidaklulusan per Program Studi)**

Analytical Question (AQ02): Bagaimana perubahan persentase ketidaklulusan setiap program studi dari semester 2021G sampai 2024E?

Kebutuhan data:
- Measure: Jumlah mahasiswa tidak lulus, jumlah seluruh mahasiswa dengan nilai valid, dan persentase ketidaklulusan.
- Context: Program studi dan angkatan.
- Time: Tahun akademik dan semester.
- Filter/Comparison: Periode semester dan nilai yang valid.

Data yang diperlukan:
- `nim`, `kode_mk`, `semester_id`, `nilai_angka`, dan `status_lulus` dari tabel `nilai`.
- `kode_prodi_raw` dan `angkatan` dari tabel `mahasiswa`.
- `kode_prodi` dan `nama_prodi` dari tabel `program_studi`.
- `tahun_akademik`, `term`, dan `urutan_tahun` dari tabel `semester`.

**3. AQ03 dan KPI02 (Kelulusan Tepat Waktu)**

Analytical Question (AQ03): Bagaimana perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?

Kebutuhan data:
- Measure: Jumlah lulusan unik, jumlah lulusan tepat waktu, persentase kelulusan tepat waktu, dan rata-rata masa studi.
- Context: Program studi dan angkatan.
- Time: Periode kelulusan.
- Filter/Comparison: Satu record kelulusan per NIM setelah pemeriksaan duplikasi.

Data yang diperlukan:
- `nim` dari tabel `kelulusan` untuk identitas lulusan.
- `status_tepat_waktu` untuk mengetahui ketepatan waktu kelulusan.
- `masa_studi_bulan` untuk menghitung durasi studi.
- `ipk_final` dan `predikat` untuk informasi hasil akhir studi.
- `tanggal_lulus_raw` untuk periode kelulusan.
- `angkatan` dan `kode_prodi_raw` dari tabel `mahasiswa`.
- Referensi `kode_prodi` dan `nama_prodi` dari tabel `program_studi`.

**4. AQ04 dan KPI03 (Aktivitas LMS dan Nilai)**

Analytical Question (AQ04): Bagaimana pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada setiap mata kuliah?

Kebutuhan data:
- Measure: Jumlah event, durasi aktivitas, skor kuis, nilai angka, dan jumlah mahasiswa terdaftar.
- Context: Mahasiswa, mata kuliah, dan jenis aktivitas.
- Time: Semester dan waktu aktivitas.
- Filter/Comparison: `lms_event_id` unik dan skor kuis hanya dihitung pada aktivitas `quiz_attempt`.

Data yang diperlukan:
- `lms_event_id`, `nim`, `kode_mk`, `semester_id`, `waktu_event`, `tipe_event`, `durasi_menit`, dan `skor_kuis` dari tabel `aktivitas_lms`.
- `nim`, `kode_mk`, `semester_id`, dan `nilai_angka` dari tabel `nilai`.
- `nim`, `kode_mk`, dan `semester_id` dari tabel `krs` untuk menentukan mahasiswa yang terdaftar pada mata kuliah.
- Data mahasiswa untuk informasi program studi dan angkatan.

**5. AQ05 (Nilai Semester Awal dan Predikat Kelulusan)**

Analytical Question (AQ05): Bagaimana perbedaan rata-rata nilai angka pada semester awal antara mahasiswa dengan kelompok predikat kelulusan yang berbeda?

Kebutuhan data:
- Measure: Rata-rata nilai angka mahasiswa pada semester awal.
- Context: Predikat kelulusan.
- Time: Semester awal, misalnya dua semester pertama setiap mahasiswa.
- Filter/Comparison: Nilai valid dan data kelulusan unik.

Data yang diperlukan:
- `nim`, `semester_id`, dan `nilai_angka` dari tabel `nilai`.
- `nim`, `predikat`, dan `ipk_final` dari tabel `kelulusan`.
- `semester_id` dan `urutan_tahun` dari tabel `semester`.

Catatan: Analisis predikat kelulusan dapat dilakukan dengan data yang tersedia setelah pemeriksaan duplikasi dan validitas nilai. Namun, perbandingan mahasiswa tepat waktu dengan mahasiswa terlambat belum dapat dilakukan karena seluruh lulusan yang tercatat berstatus tepat waktu.

**Tabel Ringkasan Data Requirement**

| AQ | Measure | Context | Time | Filter/Comparison | Required Data |
|---|---|---|---|---|---|
| AQ01 | Jumlah mahasiswa, jumlah tidak lulus, failure rate | Mata kuliah, program studi | Semester | Nilai valid dan status lulus | `nim`, `kode_mk`, `semester_id`, `nilai_angka`, `status_lulus` |
| AQ02 | Jumlah tidak lulus dan failure rate | Program studi, angkatan | Semester | Periode 2021G–2024E | Data nilai, mahasiswa, program studi, semester |
| AQ03 | Jumlah lulusan, lulusan tepat waktu, rata-rata masa studi | Program studi, angkatan | Periode kelulusan | NIM unik | `nim`, `status_tepat_waktu`, `masa_studi_bulan`, `tanggal_lulus_raw`, angkatan, prodi |
| AQ04 | Jumlah event, durasi, skor kuis, nilai angka, jumlah peserta | Mahasiswa, mata kuliah, tipe aktivitas | Semester dan waktu aktivitas | Event unik, skor khusus kuis, KRS unik | Data `aktivitas_lms`, `nilai`, dan `krs` |
| AQ05 | Rata-rata nilai angka | Predikat kelulusan | Semester awal | Nilai valid dan lulusan unik | `nim`, `semester_id`, `nilai_angka`, `predikat`, `ipk_final` |

## 9. Source Mapping

Source Mapping digunakan untuk menghubungkan kebutuhan data dengan tabel sumber, kolom yang diperlukan, dan fungsi masing-masing kolom.

| Data Requirement | Source | Column | Role |
|---|---|---|---|
| Identitas mahasiswa | `mahasiswa`, `nilai` | `nim` | Integration key |
| Identitas mata kuliah | `nilai`, `mata_kuliah` | `kode_mk` | Course identifier |
| Nama mata kuliah | `mata_kuliah` | `nama_mk` | Analytical context |
| Semester | `nilai`, `krs`, `semester` | `semester_id` | Time key |
| Tahun akademik | `semester` | `tahun_akademik`, `term` | Time context |
| Nilai angka | `nilai` | `nilai_angka` | Measure |
| Nilai huruf | `nilai` | `nilai_huruf` | Validation |
| Status lulus | `nilai` | `status_lulus` | KPI component |
| Program studi | `mahasiswa`, `program_studi` | `kode_prodi_raw`, `kode_prodi`, `nama_prodi` | Analytical context |
| Angkatan | `mahasiswa` | `angkatan` | Analytical context |
| Status tepat waktu | `kelulusan` | `status_tepat_waktu` | KPI component |
| Predikat kelulusan | `kelulusan` | `predikat` | Analytical context |
| IPK akhir | `kelulusan` | `ipk_final` | Measure |
| Masa studi | `kelulusan` | `masa_studi_bulan` | Measure |
| Tanggal kelulusan | `kelulusan` | `tanggal_lulus_raw` | Time context |
| Aktivitas LMS | `aktivitas_lms` | `lms_event_id` | Event identifier |
| Jenis aktivitas LMS | `aktivitas_lms` | `tipe_event` | Analytical context |
| Waktu aktivitas LMS | `aktivitas_lms` | `waktu_event` | Time key |
| Durasi aktivitas | `aktivitas_lms` | `durasi_menit` | Measure |
| Skor kuis | `aktivitas_lms` | `skor_kuis` | Measure |
| Peserta mata kuliah | `krs` | `nim`, `kode_mk`, `semester_id` | Denominator KPI LMS |

## 10. Data Fitness

Data Fitness digunakan untuk menilai kesiapan setiap sumber data berdasarkan hasil Data Profiling dan Data Quality Assessment pada Unit 1.2.

| Source | Evidence Unit 1.2 | Fitness | Required Action |
|---|---|---|---|
| `mahasiswa` | 15 kelompok NIM duplikat, 30 kota asal kosong, 30 label prodi untuk 6 program studi resmi, 6 label jenis kelamin, serta variasi format tanggal | Conditional Ready | Memeriksa duplikasi NIM, menyiapkan mapping program studi dan jenis kelamin, serta memvalidasi format tanggal |
| `program_studi` | Memiliki 6 data referensi program studi resmi | Ready | Digunakan sebagai acuan nama dan kode program studi |
| `mata_kuliah` | Memiliki 208 record dan digunakan sebagai referensi mata kuliah; kualitas atribut perlu dipastikan sesuai kebutuhan analisis | Conditional Ready | Memeriksa keunikan kode mata kuliah dan kesesuaian referensi |
| `semester` | Memiliki 8 record referensi semester dan digunakan untuk mengelompokkan periode akademik | Ready | Digunakan sebagai acuan dimensi waktu akademik |
| `krs` | Terdapat 25 baris berlebih akibat duplikasi kombinasi data dan tidak ditemukan orphan pada relasi yang diuji | Conditional Ready | Memeriksa duplikasi sebelum menghitung jumlah mahasiswa peserta mata kuliah |
| `nilai` | Terdapat 20 nilai kosong, 12 nilai di luar rentang 0–100, dan 20 ketidaksesuaian nilai angka dengan huruf | Conditional Ready | Memvalidasi nilai dan menentukan aturan resmi penentuan status kelulusan |
| `aktivitas_lms` | Terdapat 30 baris duplikat identik; seluruh skor kuis pada aktivitas kuis tersedia dan aktivitas non-kuis tidak memiliki skor | Conditional Ready | Memeriksa duplikasi event serta membedakan aktivitas kuis dan non-kuis |
| `kelulusan – On-Time Profile` | Terdapat 347 record dengan 345 mahasiswa unik; seluruh record memiliki status tepat waktu | Conditional Ready | Memeriksa duplikasi dan memastikan ketepatan status kelulusan |
| `kelulusan – On-Time vs Late` | Seluruh record berstatus tepat waktu dan belum terdapat data lulusan terlambat | Not Ready | Membutuhkan data lulusan terlambat atau data tambahan dari periode berikutnya |

**Keterangan Fitness:**

- **Ready:** Data sudah dapat digunakan untuk kebutuhan analisis yang ditentukan.
- **Conditional Ready:** Data dapat digunakan setelah pemeriksaan atau penanganan masalah kualitas tertentu.
- **Not Ready:** Data belum dapat digunakan untuk analisis yang dimaksud karena informasi pembanding belum tersedia.

Berdasarkan hasil profiling, sebagian besar sumber memiliki status Conditional Ready karena masih membutuhkan pemeriksaan kualitas. Sementara itu, analisis perbandingan lulusan tepat waktu dan terlambat berstatus Not Ready karena seluruh record kelulusan yang tersedia memiliki status tepat waktu.

## 11. Candidate Model

Candidate Model dibuat untuk menentukan gambaran awal model analitik berdasarkan rumus:

**Analytical Question → Business Event → Grain → Dimension → Fact → Measure.**

Pada tahap ini belum dibuat Star Schema final. Model hanya berupa kandidat yang dapat digunakan sebagai dasar perancangan data warehouse berikutnya.

### AQ01 — Course Failure Rate

**Analytical Question:** Mata kuliah apa yang memiliki persentase ketidaklulusan tertinggi pada setiap semester?

**Business Event:** Mahasiswa memperoleh nilai akhir pada suatu mata kuliah.

**Candidate Grain:** Satu baris data mewakili nilai akhir satu mahasiswa untuk satu mata kuliah pada satu semester.

**Candidate Fact:** Fact_Penilaian atau Fact_Nilai_Mahasiswa.

**Candidate Dimensions:**
- Dim_Mahasiswa
- Dim_Mata_Kuliah
- Dim_Semester
- Dim_Program_Studi

**Candidate Measures:**
- `nilai_angka`
- `status_lulus`
- Jumlah peserta
- Jumlah mahasiswa tidak lulus
- Course Failure Rate

### AQ02 — Tren Ketidaklulusan per Program Studi

**Analytical Question:** Bagaimana perubahan persentase ketidaklulusan setiap program studi dari semester 2021G sampai 2024E?

**Business Event:** Mahasiswa memperoleh nilai akhir pada mata kuliah di setiap semester.

**Candidate Grain:** Satu nilai akhir mahasiswa untuk satu mata kuliah pada satu semester, sama dengan AQ01.

**Candidate Fact:** Fact_Penilaian.

**Candidate Dimensions:**
- Dim_Mahasiswa
- Dim_Program_Studi
- Dim_Semester
- Dim_Mata_Kuliah

**Candidate Measures:**
- Jumlah mahasiswa peserta
- Jumlah mahasiswa tidak lulus
- Nilai rata-rata
- Course Failure Rate

**Catatan:** Hasil analisis dapat dikelompokkan berdasarkan program studi dan semester untuk melihat perubahan performa akademik dari waktu ke waktu.

### AQ03 — On-Time Graduation

**Analytical Question:** Bagaimana perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?

**Business Event:** Mahasiswa dinyatakan lulus oleh universitas.

**Candidate Grain:** Satu record kelulusan untuk satu mahasiswa.

**Candidate Fact:** Fact_Kelulusan.

**Candidate Dimensions:**
- Dim_Mahasiswa
- Dim_Program_Studi
- Dim_Angkatan
- Dim_Tanggal_Lulus

**Candidate Measures:**
- `status_tepat_waktu`
- `masa_studi_bulan`
- `ipk_final`
- Jumlah lulusan unik
- On-Time Graduation Rate

**Catatan:** Seluruh data kelulusan yang tersedia berstatus tepat waktu. Oleh karena itu, rata-rata masa studi dapat digunakan sebagai ukuran tambahan untuk memberikan gambaran durasi penyelesaian studi.

### AQ04 — LMS Engagement dan Nilai

**Analytical Question:** Bagaimana pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa pada setiap mata kuliah?

**Business Event:** Mahasiswa melakukan aktivitas pembelajaran melalui LMS.

**Candidate Grain:** Satu record mewakili satu event aktivitas LMS berdasarkan satu `lms_event_id`.

**Candidate Fact:** Fact_Aktivitas_LMS.

**Candidate Dimensions:**
- Dim_Mahasiswa
- Dim_Mata_Kuliah
- Dim_Jenis_Aktivitas
- Dim_Waktu
- Dim_Semester

**Candidate Measures:**
- `durasi_menit`
- `skor_kuis` khusus aktivitas `quiz_attempt`
- Jumlah event LMS
- Rata-rata aktivitas per mahasiswa

**Catatan:** Hubungan antara aktivitas LMS dan nilai dapat dianalisis dengan mengagregasikan aktivitas per mahasiswa dan mata kuliah, kemudian menghubungkannya dengan data penilaian menggunakan identitas mahasiswa dan mata kuliah yang sama.

### AQ05 — Nilai Semester Awal dan Predikat Kelulusan

**Analytical Question:** Bagaimana perbedaan rata-rata nilai angka pada semester awal antar kelompok predikat kelulusan?

**Business Event:** Mahasiswa memperoleh nilai akademik pada semester awal dan kemudian tercatat sebagai lulusan.

**Candidate Grain:** Nilai mahasiswa pada semester awal terlebih dahulu diagregasikan menjadi satu ringkasan per mahasiswa, kemudian dihubungkan dengan satu record kelulusan per mahasiswa.

**Candidate Fact:**
- Fact_Penilaian yang diagregasikan berdasarkan mahasiswa pada semester awal.
- Fact_Kelulusan yang memiliki satu record per mahasiswa.

**Candidate Dimensions:**
- Dim_Mahasiswa
- Dim_Semester
- Dim_Predikat_Kelulusan

**Candidate Measures:**
- Rata-rata `nilai_angka`
- `ipk_final`
- Jumlah mahasiswa berdasarkan predikat kelulusan

**Catatan:** Penggabungan data penilaian dan kelulusan harus memperhatikan perbedaan grain. Nilai semester awal sebaiknya diringkas terlebih dahulu per mahasiswa sebelum dihubungkan dengan data kelulusan agar tidak terjadi penggandaan baris (*fan-out*).

## 12. Traceability

Traceability digunakan untuk memastikan bahwa setiap kebutuhan analitik memiliki hubungan yang jelas dari permasalahan bisnis hingga kandidat model data.

Rumus:

**Problem → Business Objective → Stakeholder → Decision Requirement → Analytical Question → KPI/Metric → Data Requirement → Source Mapping → Data Fitness → Candidate Model.**

### 1. TR01 — Course Failure

- Problem: Mata kuliah dengan tingkat ketidaklulusan tinggi belum mudah diidentifikasi.
- Business Objective: BO01.
- Stakeholder: Kaprodi.
- Decision: Menentukan mata kuliah yang menjadi prioritas evaluasi atau remedial.
- Analytical Question: AQ01, mata kuliah dengan persentase ketidaklulusan tertinggi pada setiap semester.
- KPI: Course Failure Rate.
- Data Requirement: NIM, kode mata kuliah, semester, nilai angka, dan status kelulusan.
- Source Mapping: `nilai`, `mata_kuliah`, dan `semester`.
- Data Fitness: Tabel `nilai` Conditional Ready; tabel `semester` Ready; tabel `mata_kuliah` perlu pemeriksaan atribut sesuai kebutuhan analisis.
- Candidate Process: Penilaian.
- Candidate Grain: Satu nilai akhir mahasiswa untuk satu mata kuliah pada satu semester.
- Candidate Fact: Fact_Penilaian.
- Candidate Dimension: Mahasiswa, mata kuliah, semester, dan program studi.
- Candidate Measure: Nilai angka, status lulus, jumlah peserta, jumlah tidak lulus, dan Course Failure Rate.

**Penjelasan TR01:**

Karena mata kuliah dengan tingkat ketidaklulusan tinggi belum mudah diketahui, Kaprodi membutuhkan informasi untuk menentukan mata kuliah yang perlu menjadi prioritas evaluasi. Untuk mendukung keputusan tersebut, diperlukan analisis mengenai persentase ketidaklulusan tertinggi pada setiap semester menggunakan KPI Course Failure Rate. Data yang dibutuhkan meliputi NIM, kode mata kuliah, semester, nilai angka, dan status kelulusan yang berasal dari tabel `nilai`, `mata_kuliah`, serta `semester`. Berdasarkan hasil profiling Unit 1.2, tabel `nilai` masih berstatus Conditional Ready karena ditemukan nilai kosong, nilai di luar rentang, dan ketidaksesuaian nilai angka dengan huruf. Oleh karena itu, data perlu divalidasi terlebih dahulu. Kandidat model yang digunakan adalah Fact_Penilaian dengan grain satu nilai akhir mahasiswa untuk satu mata kuliah pada satu semester.

### 2. TR02 — Tren Ketidaklulusan per Program Studi

- Problem: Perubahan performa akademik antarprogram studi dan semester belum mudah dipantau.
- Business Objective: BO02.
- Stakeholder: Wakil Rektor Bidang Akademik.
- Decision: Menentukan program studi dan periode yang membutuhkan evaluasi akademik.
- Analytical Question: AQ02, perubahan persentase ketidaklulusan setiap program studi dari semester 2021G sampai 2024E.
- KPI/Metric: Course Failure Rate berdasarkan program studi dan semester.
- Data Requirement: NIM, kode mata kuliah, semester, nilai angka, status kelulusan, kode program studi, dan angkatan.
- Source Mapping: `nilai`, `mahasiswa`, `program_studi`, dan `semester`.
- Data Fitness: Tabel `nilai` dan `mahasiswa` Conditional Ready; tabel `program_studi` dan `semester` Ready.
- Candidate Process: Penilaian.
- Candidate Grain: Satu nilai akhir mahasiswa untuk satu mata kuliah pada satu semester.
- Candidate Fact: Fact_Penilaian.
- Candidate Dimension: Mahasiswa, program studi, mata kuliah, dan semester.
- Candidate Measure: Jumlah peserta, jumlah mahasiswa tidak lulus, nilai rata-rata, dan failure rate.

**Penjelasan TR02:**

Karena perubahan performa akademik antarprogram studi belum mudah dipantau dari satu semester ke semester berikutnya, Wakil Rektor Bidang Akademik membutuhkan informasi untuk menentukan program studi yang perlu mendapatkan perhatian. Analisis dilakukan dengan membandingkan persentase ketidaklulusan dari semester 2021G sampai 2024E. Data yang dibutuhkan berasal dari tabel `nilai`, `mahasiswa`, `program_studi`, dan `semester`. Berdasarkan hasil profiling, tabel mahasiswa memiliki variasi penulisan program studi dan duplikasi NIM, sedangkan tabel nilai masih memiliki beberapa masalah validitas. Tabel program studi dan semester dapat digunakan sebagai referensi. Kandidat model yang digunakan adalah Fact_Penilaian dengan grain satu nilai akhir mahasiswa untuk satu mata kuliah pada satu semester.

### 3. TR03 — On-Time Graduation

- Problem: Pola kelulusan tepat waktu berdasarkan program studi dan angkatan belum dapat dievaluasi secara menyeluruh.
- Business Objective: BO03.
- Stakeholder: Wakil Rektor Bidang Akademik dan Kaprodi.
- Decision: Mengevaluasi program studi dan angkatan berdasarkan ketepatan waktu kelulusan serta masa studi.
- Analytical Question: AQ03, perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi.
- KPI: On-Time Graduation Rate.
- Data Requirement: NIM, status tepat waktu, masa studi, tanggal kelulusan, angkatan, dan program studi.
- Source Mapping: `kelulusan`, `mahasiswa`, dan `program_studi`.
- Data Fitness: Tabel `kelulusan` dan `mahasiswa` Conditional Ready; tabel `program_studi` Ready. Perbandingan lulusan tepat waktu dengan terlambat berstatus Not Ready.
- Candidate Process: Kelulusan.
- Candidate Grain: Satu record kelulusan untuk satu mahasiswa.
- Candidate Fact: Fact_Kelulusan.
- Candidate Dimension: Mahasiswa, program studi, angkatan, dan tanggal kelulusan.
- Candidate Measure: Status tepat waktu, masa studi, IPK akhir, jumlah lulusan, dan On-Time Graduation Rate.

**Penjelasan TR03:**

Karena pola kelulusan tepat waktu berdasarkan program studi belum dapat dibandingkan secara menyeluruh, Wakil Rektor Bidang Akademik membutuhkan informasi untuk mengevaluasi ketepatan waktu kelulusan dan lama studi mahasiswa. Analisis dilakukan menggunakan KPI On-Time Graduation Rate serta rata-rata masa studi. Data yang diperlukan berasal dari tabel `kelulusan`, `mahasiswa`, dan `program_studi`. Hasil profiling menunjukkan bahwa tabel kelulusan memiliki 347 record dengan 345 mahasiswa unik akibat 2 baris duplikat. Seluruh record yang tersedia berstatus tepat waktu, sehingga data belum dapat digunakan untuk membandingkan lulusan tepat waktu dan terlambat. Kandidat model yang digunakan adalah Fact_Kelulusan dengan grain satu record kelulusan untuk satu mahasiswa.

### 4. TR04 — LMS Engagement dan Nilai

- Problem: Hubungan aktivitas pembelajaran LMS dengan hasil nilai akademik belum dapat dievaluasi secara terintegrasi.
- Business Objective: BO04.
- Stakeholder: Dosen Pengampu dan Kaprodi.
- Decision: Menentukan apakah aktivitas LMS dapat digunakan sebagai indikator pendukung pemantauan risiko akademik.
- Analytical Question: AQ04, pola hubungan antara jumlah atau durasi aktivitas LMS dengan nilai angka mahasiswa.
- KPI: LMS Engagement per Mata Kuliah.
- Data Requirement: Identitas mahasiswa, kode mata kuliah, semester, jumlah aktivitas, durasi, skor kuis, dan nilai angka.
- Source Mapping: `aktivitas_lms`, `nilai`, `krs`, dan `mahasiswa`.
- Data Fitness: Tabel `aktivitas_lms`, `nilai`, dan `krs` Conditional Ready; tabel mahasiswa juga memerlukan pemeriksaan kualitas.
- Candidate Process: Aktivitas Pembelajaran LMS.
- Candidate Grain: Satu event aktivitas LMS berdasarkan satu `lms_event_id`.
- Candidate Fact: Fact_Aktivitas_LMS.
- Candidate Dimension: Mahasiswa, mata kuliah, jenis aktivitas, waktu, dan semester.
- Candidate Measure: Jumlah event, durasi aktivitas, skor kuis, dan rata-rata aktivitas per mahasiswa.

**Penjelasan TR04:**

Karena hubungan aktivitas LMS dengan hasil nilai akademik belum dapat dievaluasi secara terintegrasi, Dosen Pengampu dan Kaprodi membutuhkan informasi untuk mengetahui pola keterlibatan mahasiswa dalam pembelajaran. Analisis dilakukan dengan membandingkan jumlah atau durasi aktivitas LMS dengan nilai angka pada mata kuliah yang sama menggunakan KPI LMS Engagement. Data yang dibutuhkan berasal dari tabel `aktivitas_lms`, `nilai`, `krs`, dan `mahasiswa`. Berdasarkan hasil profiling, tabel aktivitas LMS memiliki 30 baris duplikat identik, tabel KRS memiliki 25 baris berlebih, dan tabel nilai masih memiliki beberapa masalah validitas. Oleh karena itu, pemeriksaan data diperlukan sebelum perhitungan dilakukan. Kandidat model yang digunakan adalah Fact_Aktivitas_LMS dengan grain satu event aktivitas LMS berdasarkan satu `lms_event_id`.

### 5. TR05 — Nilai Semester Awal dan Predikat Kelulusan

- Problem: Perbedaan performa akademik pada semester awal berdasarkan hasil akhir kelulusan belum diketahui.
- Business Objective: BO02 dan BO03.
- Stakeholder: Dosen Pembimbing Akademik dan Bagian Akademik.
- Decision: Menentukan kelompok mahasiswa yang membutuhkan evaluasi atau pendampingan berdasarkan hasil akademik awal.
- Analytical Question: AQ05, perbedaan rata-rata nilai angka semester awal antar kelompok predikat kelulusan.
- KPI/Metric: Rata-rata nilai angka semester awal berdasarkan predikat kelulusan.
- Data Requirement: NIM, semester, nilai angka, predikat kelulusan, dan IPK akhir.
- Source Mapping: `nilai`, `semester`, dan `kelulusan`.
- Data Fitness: Tabel `nilai` Conditional Ready; tabel `kelulusan` Conditional Ready; tabel `semester` Ready.
- Candidate Process: Penilaian dan Kelulusan.
- Candidate Grain: Ringkasan nilai semester awal per mahasiswa yang dihubungkan dengan satu record kelulusan per mahasiswa.
- Candidate Fact: Fact_Penilaian dan Fact_Kelulusan.
- Candidate Dimension: Mahasiswa, semester, dan predikat kelulusan.
- Candidate Measure: Rata-rata nilai angka semester awal, IPK akhir, dan jumlah mahasiswa berdasarkan predikat.

**Penjelasan TR05:**

Karena perbedaan hasil akademik mahasiswa pada semester awal berdasarkan predikat kelulusan belum diketahui, Dosen Pembimbing Akademik dan Bagian Akademik membutuhkan informasi untuk mengevaluasi pola performa akademik mahasiswa. Analisis dilakukan dengan membandingkan rata-rata nilai angka pada semester awal berdasarkan kelompok predikat kelulusan. Data yang diperlukan berasal dari tabel `nilai`, `semester`, dan `kelulusan`. Berdasarkan hasil profiling, tabel nilai masih memiliki nilai kosong dan nilai yang tidak valid, sedangkan tabel kelulusan memiliki 2 baris duplikat. Oleh karena itu, data perlu diperiksa sebelum dilakukan penggabungan. Kandidat model menggunakan Fact_Penilaian yang diagregasikan per mahasiswa dan Fact_Kelulusan dengan satu record per mahasiswa. Penggabungan dilakukan melalui identitas mahasiswa agar tidak terjadi penggandaan data akibat perbedaan grain.
