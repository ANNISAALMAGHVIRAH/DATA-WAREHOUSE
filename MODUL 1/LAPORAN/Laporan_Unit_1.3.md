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

Universitas Digital Nusantara masih menghadapi kendala dalam melakukan evaluasi akademik secara menyeluruh. Informasi mengenai kegiatan perkuliahan, nilai mahasiswa, aktivitas pembelajaran melalui LMS, dan kelulusan masih tersimpan dalam sumber data yang berbeda. Kondisi ini membuat setiap program studi lebih sering melakukan evaluasi berdasarkan informasi yang dimiliki masing-masing.

Kaprodi memang dapat mengakses hasil nilai mahasiswa, tetapi informasi tersebut belum cukup untuk mengetahui persoalan akademik secara lebih luas. Misalnya, belum mudah diketahui mata kuliah yang berulang kali memiliki jumlah mahasiswa tidak lulus cukup tinggi, kelompok mahasiswa yang membutuhkan bimbingan lebih awal, serta kemungkinan hubungan antara keaktifan mahasiswa di LMS dengan hasil nilai yang diperoleh. Informasi mengenai kecenderungan mahasiswa menyelesaikan studi tepat waktu juga belum dapat dibandingkan secara menyeluruh.

Untuk mengatasi permasalahan tersebut, Wakil Rektor Bidang Akademik meminta tim Data Warehouse menyiapkan kebutuhan informasi dan data yang dapat digunakan sebagai dasar peningkatan keberhasilan studi mahasiswa. Pekerjaan pada Unit 1.3 berfokus pada identifikasi kebutuhan analitik berdasarkan dataset UADW v1.0. Pada tahap ini, tim belum diminta membuat Star Schema maupun menjalankan proses ETL.

Beberapa keputusan yang ingin didukung melalui analisis ini meliputi:

- Menentukan mata kuliah yang perlu dievaluasi atau diberikan program remedial.
- Mengetahui kelompok mahasiswa yang membutuhkan bimbingan akademik sejak awal.
- Mengidentifikasi program studi, periode, atau angkatan yang mengalami penurunan hasil akademik.
- Memeriksa apakah aktivitas mahasiswa pada LMS dapat dimanfaatkan sebagai indikator tambahan untuk melihat risiko akademik.
- Meninjau kondisi dan kecenderungan kelulusan tepat waktu mahasiswa.

Ruang lingkup pembahasan dipusatkan pada keberhasilan akademik dan kelulusan mahasiswa. Data pembayaran tidak menjadi kebutuhan utama dalam analisis ini dan hanya dapat digunakan sebagai informasi tambahan apabila diperlukan.

---

## 1. Identifikasi Stakeholder

Sebelum menentukan informasi yang harus disediakan, perlu diketahui terlebih dahulu pihak-pihak yang akan menggunakan hasil analisis. Setiap stakeholder mempunyai kebutuhan informasi dan kepentingan keputusan yang berbeda.

| Stakeholder | Information Need | Decision Supported | Priority |
|---|---|---|---|
| Wakil Rektor Bidang Akademik | Rekapitulasi performa mahasiswa, perkembangan hasil akademik antarprogram studi, serta gambaran kelulusan berdasarkan angkatan | Menyusun kebijakan akademik dan program peningkatan kelulusan tepat waktu di tingkat universitas | High |
| Ketua Program Studi (Kaprodi) | Daftar mata kuliah dengan persentase ketidaklulusan tinggi serta perubahan hasil akademik mahasiswa setiap semester | Memilih mata kuliah yang perlu dievaluasi dan menentukan kelompok mahasiswa yang perlu diperhatikan | High |
| Dosen Pengampu/Koordinator Mata Kuliah | Distribusi nilai, jumlah mahasiswa yang tidak memenuhi standar kelulusan, serta aktivitas mahasiswa selama pembelajaran melalui LMS | Memperbaiki metode mengajar, materi perkuliahan, dan sistem evaluasi | Medium |
| Dosen Pembimbing Akademik/Bagian Akademik | Informasi mahasiswa dengan hasil nilai rendah dan keterlibatan pembelajaran yang kurang | Menentukan mahasiswa yang perlu dihubungi atau diberikan pendampingan akademik | Medium |
| Tim Data Warehouse | Informasi kelengkapan, konsistensi, dan kualitas data akademik dari setiap sumber | Menentukan data yang perlu dibersihkan dan menyiapkan rancangan model analisis | Medium |

---

## 2. Problem Statement

Berdasarkan studi kasus yang diberikan, pertanyaan pemantik dapat dijawab sebagai berikut.

**1. Bagaimana kondisi sekarang? (Kondisi)**

Saat ini informasi akademik Universitas Digital Nusantara masih tersebar pada beberapa tabel atau sumber data. Setiap program studi melakukan evaluasi berdasarkan data yang tersedia di lingkungannya masing-masing. Data nilai, KRS, aktivitas LMS, dan kelulusan belum dimanfaatkan dalam satu analisis yang saling terhubung.

**2. Apa yang belum dapat dilakukan? (Masalah)**

Universitas belum dapat mengidentifikasi secara mudah mata kuliah yang memiliki tingkat ketidaklulusan tinggi, mahasiswa yang perlu mendapatkan perhatian lebih awal, serta hubungan antara aktivitas LMS dan hasil penilaian. Selain itu, pola penyelesaian studi tepat waktu berdasarkan program studi dan angkatan juga belum dapat dilihat secara lengkap.

**3. Apa akibatnya bagi organisasi? (Dampak)**

Akibatnya, tindakan perbaikan akademik berpotensi dilakukan setelah masalah muncul dan tidak selalu menyasar kelompok yang tepat. Program studi juga kesulitan menentukan mata kuliah yang harus diprioritaskan untuk evaluasi. Di tingkat universitas, keterbatasan informasi membuat penyusunan kebijakan peningkatan keberhasilan studi menjadi kurang terarah.

**4. Informasi apa yang dibutuhkan untuk memperbaiki kondisi tersebut? (Kebutuhan Analitik)**

Universitas memerlukan informasi mengenai persentase mahasiswa tidak lulus pada setiap mata kuliah, perkembangan performa akademik berdasarkan program studi dan semester, persentase kelulusan tepat waktu, serta keterkaitan antara aktivitas LMS dan nilai mahasiswa. Informasi tersebut perlu dapat dikelompokkan berdasarkan mata kuliah, program studi, angkatan, dan periode akademik.

**Problem Statement**

> Universitas Digital Nusantara masih melakukan evaluasi akademik dengan memanfaatkan data yang terpisah-pisah, sehingga pihak pengelola belum dapat melihat permasalahan akademik secara menyeluruh. Kondisi ini menyulitkan universitas dalam menemukan mata kuliah yang perlu diperbaiki, mengenali mahasiswa yang membutuhkan pendampingan, serta mengevaluasi kelulusan tepat waktu. Dampaknya, keputusan perbaikan akademik berisiko terlambat dan kurang tepat sasaran. Oleh karena itu, diperlukan analisis data yang dapat menyajikan tingkat ketidaklulusan mata kuliah, perkembangan performa mahasiswa, aktivitas LMS, dan informasi kelulusan secara terukur serta dapat dibandingkan berdasarkan program studi dan periode akademik.

---

## 3. Business Process

Business Process pada studi kasus ini diidentifikasi melalui kegiatan yang menghasilkan data, pihak yang menjalankan kegiatan, objek yang terlibat, serta waktu terjadinya kegiatan.

**1. Kejadian bisnis apa yang menghasilkan data?**

> Data akademik dihasilkan dari beberapa aktivitas, yaitu mahasiswa melakukan pengisian KRS, dosen memberikan penilaian akhir, mahasiswa menggunakan LMS selama pembelajaran, serta bagian akademik mencatat mahasiswa yang telah menyelesaikan studi.

**2. Siapa aktor yang berperan?**

> Pihak yang terlibat dalam proses tersebut adalah mahasiswa sebagai peserta kegiatan akademik, dosen sebagai pengajar dan pemberi nilai, bagian akademik sebagai pengelola data perkuliahan dan kelulusan, serta sistem LMS sebagai media pencatatan aktivitas pembelajaran.

**3. Apa yang menjadi objek dari studi kasus?**

> Objek yang dianalisis meliputi mata kuliah yang dipilih mahasiswa, hasil penilaian setiap mata kuliah, aktivitas mahasiswa pada LMS, serta status dan informasi kelulusan mahasiswa.

**4. Kapan kejadian bisnis terjadi?**

> Pengambilan KRS dan penilaian berlangsung mengikuti periode semester. Data akademik mencakup semester 2021 Ganjil sampai 2024 Genap. Aktivitas LMS tercatat mulai 15 Agustus 2021 hingga 10 Juni 2025, sedangkan data kelulusan yang tersedia berasal dari periode Juni 2025.

Sehingga, proses bisnis yang berhasil diidentifikasi pada masing-masing domain adalah sebagai berikut.

**1. KRS**

> Pada awal semester, mahasiswa menentukan mata kuliah yang akan diikuti melalui proses pengisian KRS. Data ini mencatat mahasiswa yang mengambil suatu mata kuliah, termasuk periode pengambilannya. Informasi yang dapat digunakan antara lain `tanggal_ambil_raw` dan `semester_id`. Data KRS juga diperlukan untuk mengetahui jumlah peserta suatu mata kuliah.

**2. Penilaian**

> Setelah kegiatan perkuliahan selesai, dosen memberikan nilai akhir kepada mahasiswa. Hasil penilaian dapat berupa nilai angka, nilai huruf, dan status kelulusan. Informasi penilaian dicatat melalui atribut `tanggal_input_raw` dan `semester_id`. Data ini menjadi dasar untuk menghitung tingkat ketidaklulusan dan membandingkan hasil akademik mahasiswa.

**3. Aktivitas Pembelajaran LMS**

> Selama proses pembelajaran, mahasiswa melakukan berbagai kegiatan melalui LMS. Aktivitas yang tercatat meliputi `login`, `view_material`, `assignment_submit`, `quiz_attempt`, dan `forum_post`. Setiap aktivitas dapat digunakan untuk melihat tingkat keterlibatan mahasiswa dalam pembelajaran digital, termasuk durasi aktivitas dan skor kuis apabila tersedia.

**4. Kelulusan**

> Proses kelulusan terjadi ketika mahasiswa telah memenuhi persyaratan akademik untuk menyelesaikan pendidikan. Bagian akademik mencatat tanggal kelulusan, IPK akhir, masa studi, predikat, dan status tepat waktu. Informasi tersebut dapat digunakan untuk mengevaluasi keberhasilan mahasiswa dalam menyelesaikan studi. Atribut tanggal kelulusan yang tersedia adalah `tanggal_lulus_raw`.

---

## 4. Business Objective

Business Objective menjelaskan hasil yang ingin dicapai universitas melalui pemanfaatan informasi akademik. Tujuan tersebut dirumuskan menggunakan tindakan yang ingin dilakukan, objek yang diperbaiki, dan manfaat yang diharapkan.

**Business Objective dari studi kasus ini adalah:**

1. **BO01 – Meningkatkan kemampuan program studi dalam memantau hasil pembelajaran setiap mata kuliah** agar mata kuliah dengan tingkat ketidaklulusan tinggi dapat segera diketahui dan dijadikan prioritas evaluasi.

2. **BO02 – Memperkuat proses identifikasi mahasiswa yang mengalami kesulitan akademik** agar dosen pembimbing dan bagian akademik dapat memberikan pendampingan sebelum permasalahan semakin besar.

3. **BO03 – Mengevaluasi pencapaian kelulusan mahasiswa berdasarkan program studi dan angkatan** agar universitas mempunyai dasar dalam menyusun kebijakan untuk meningkatkan keberhasilan penyelesaian studi.

4. **BO04 – Menilai pemanfaatan aktivitas LMS sebagai informasi pendukung evaluasi akademik** agar keterlibatan mahasiswa dalam pembelajaran digital dapat dibandingkan dengan hasil nilai yang diperoleh.

---

## 5. Decision Requirement

Decision Requirement berisi keputusan yang perlu dibuat oleh stakeholder berdasarkan informasi yang tersedia. Kebutuhan keputusan dalam studi kasus ini dirumuskan sebagai berikut.

1. **DR01 – Kaprodi perlu menentukan mata kuliah yang menjadi prioritas evaluasi** berdasarkan persentase mahasiswa tidak lulus pada setiap mata kuliah dan semester, sehingga mata kuliah yang memiliki masalah berulang dapat ditangani lebih dahulu.

2. **DR02 – Wakil Rektor Bidang Akademik perlu memilih program studi atau angkatan yang membutuhkan peningkatan performa akademik** berdasarkan perubahan tingkat ketidaklulusan dan persentase kelulusan tepat waktu.

3. **DR03 – Dosen Pembimbing Akademik dan Bagian Akademik perlu menentukan kelompok mahasiswa yang membutuhkan pendampingan** berdasarkan perbandingan nilai pada semester awal menurut predikat kelulusan, yaitu Cukup, Memuaskan, dan Sangat Memuaskan. Perbandingan lulusan tepat waktu dan terlambat dapat dilakukan apabila data kedua kelompok tersedia.

4. **DR04 – Dosen Pengampu dan Kaprodi perlu menilai kelayakan aktivitas LMS sebagai indikator tambahan risiko akademik** berdasarkan hubungan jumlah atau durasi aktivitas pembelajaran dengan nilai mahasiswa pada mata kuliah yang sama.

---

## 6. Analytical Questions

Analytical Questions disusun dari kebutuhan keputusan agar informasi yang diperlukan dapat diukur dan dianalisis. Pertanyaan mencakup perubahan dari waktu ke waktu, perbandingan kelompok, pengurutan berdasarkan nilai tertentu, dan hubungan antarvariabel.

**1. Trend**

> Bagaimana perubahan persentase mahasiswa yang tidak lulus pada setiap program studi dari semester 2021 Ganjil sampai semester 2024 Genap?

**2. Comparison**

> Bagaimana perbedaan persentase kelulusan tepat waktu dan rata-rata masa studi antara satu program studi dengan program studi lainnya?

**3. Ranking**

> Mata kuliah apa yang memiliki persentase ketidaklulusan paling tinggi pada masing-masing semester?

**4. Relationship**

> Bagaimana hubungan antara jumlah atau durasi aktivitas mahasiswa pada LMS dengan nilai angka yang diperoleh pada mata kuliah yang diikuti?

**5. Comparison**

> Bagaimana perbedaan rata-rata nilai mahasiswa pada dua semester pertama apabila dikelompokkan berdasarkan predikat kelulusan?

Sehingga Analytical Questions tersebut dapat dirangkum dalam tabel berikut.

| AQ | Analytical Question | Stakeholder | Decision | Priority |
|---|---|---|---|---|
| AQ01 | Mata kuliah mana yang mempunyai persentase mahasiswa tidak lulus paling tinggi pada setiap semester? | Kaprodi | Menentukan mata kuliah yang perlu didahulukan untuk evaluasi | High |
| AQ02 | Bagaimana perkembangan persentase mahasiswa tidak lulus pada setiap program studi dari 2021 Ganjil hingga 2024 Genap? | Wakil Rektor Bidang Akademik | Menentukan program studi atau angkatan yang membutuhkan peningkatan performa | High |
| AQ03 | Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi berdasarkan data lulusan? | Wakil Rektor Bidang Akademik dan Kaprodi | Mengevaluasi keberhasilan penyelesaian studi | High |
| AQ04 | Apakah jumlah atau durasi aktivitas LMS mempunyai hubungan dengan nilai mahasiswa pada mata kuliah yang sama? | Dosen Pengampu dan Kaprodi | Menilai aktivitas LMS sebagai indikator pendukung risiko akademik | Medium |
| AQ05 | Apakah rata-rata nilai mahasiswa pada semester awal berbeda berdasarkan predikat kelulusan? | Dosen Pembimbing Akademik/Bagian Akademik | Menentukan kelompok mahasiswa yang membutuhkan pendampingan | High |

---

## 7. Key Performance Indicator (KPI)

KPI digunakan sebagai ukuran untuk mengetahui apakah tujuan bisnis yang telah ditentukan dapat dievaluasi secara terukur. Penyusunannya menggunakan pendekatan top-down, yaitu dimulai dari Business Objective, dilanjutkan ke Decision Requirement, Analytical Question, pemilihan bentuk pengukuran, kemudian perumusan KPI.

Alur penyusunan:

> Business Objective → Decision Requirement → Analytical Question → Pemilihan Metrik → Formulasi KPI.

### 1. KPI Course Failure Rate

**Business Objective (BO01)**

Meningkatkan kemampuan program studi dalam memantau hasil pembelajaran agar mata kuliah yang memiliki tingkat ketidaklulusan tinggi dapat segera diketahui.

**Decision Requirement (DR01)**

Kaprodi perlu memilih mata kuliah yang harus menjadi prioritas evaluasi berdasarkan persentase mahasiswa yang tidak memenuhi standar kelulusan.

**Analytical Question (AQ01)**

Mata kuliah mana yang mempunyai persentase mahasiswa tidak lulus paling tinggi pada setiap semester?

Berdasarkan hubungan tersebut, KPI Course Failure Rate disusun melalui beberapa tahapan berikut.

**1. Memahami tujuan bisnis (BO01)**

Pernyataan tujuan bisnis berfokus pada kemampuan program studi dalam memantau keberhasilan pembelajaran. Salah satu tanda bahwa suatu mata kuliah perlu dievaluasi adalah ketika banyak peserta tidak berhasil mencapai standar kelulusan.

Dengan demikian, informasi yang dibutuhkan bukan hanya nilai rata-rata mahasiswa, melainkan juga seberapa besar bagian peserta yang tidak lulus pada mata kuliah tersebut.

**2. Menentukan kebutuhan keputusan (DR01)**

Kaprodi membutuhkan dasar untuk memilih mata kuliah yang harus mendapatkan perhatian terlebih dahulu. Untuk itu, informasi jumlah mahasiswa tidak lulus perlu dibandingkan dengan jumlah seluruh peserta yang mempunyai nilai akhir valid.

Hasil pengukuran tersebut dapat membantu Kaprodi membedakan mata kuliah yang benar-benar memiliki masalah tingkat ketidaklulusan tinggi dengan mata kuliah yang hanya mempunyai jumlah peserta lebih banyak.

**3. Mengubah kebutuhan menjadi pertanyaan analitis (AQ01)**

Pertanyaan mengenai mata kuliah dengan persentase ketidaklulusan tertinggi menunjukkan kebutuhan pengukuran berikut:

- **Measure:** Jumlah mahasiswa tidak lulus dan persentase ketidaklulusan.
- **Dimension:** Mata kuliah dan semester.
- **Metode analisis:** Mengurutkan persentase ketidaklulusan dari nilai tertinggi.

**4. Menentukan bentuk metrik yang sesuai**

Pengukuran dapat menggunakan jumlah mahasiswa tidak lulus atau persentase ketidaklulusan. Namun, jumlah absolut saja belum cukup untuk membandingkan mata kuliah karena jumlah peserta setiap mata kuliah berbeda.

Sebagai contoh, terdapat 15 mahasiswa tidak lulus dari 20 peserta, sedangkan mata kuliah lain memiliki 20 mahasiswa tidak lulus dari 200 peserta. Jika hanya melihat jumlah mahasiswa, mata kuliah kedua terlihat memiliki masalah lebih besar. Padahal, persentase ketidaklulusan mata kuliah pertama adalah 75%, sedangkan mata kuliah kedua hanya 10%.

Oleh sebab itu, persentase dipilih sebagai metrik utama karena memberikan perbandingan yang lebih proporsional antar mata kuliah.

**5. Merumuskan KPI**

**KPI Name (Nama Pengukuran)**

> Persentase Ketidaklulusan per Mata Kuliah (*Course Failure Rate*).

**Definition (Definisi Bisnis)**

> Course Failure Rate merupakan ukuran yang menunjukkan bagian mahasiswa yang tidak berhasil memenuhi standar kelulusan pada suatu mata kuliah dibandingkan dengan seluruh mahasiswa yang memiliki nilai akhir valid pada mata kuliah tersebut. Pengukuran ini digunakan untuk menemukan mata kuliah yang membutuhkan evaluasi berdasarkan kondisi ketidaklulusan setiap semester.

**Formula (Formulasi)**

- **Numerator (Pembilang):** Jumlah catatan mahasiswa unik pada kombinasi mahasiswa, mata kuliah, dan semester yang memiliki `status_lulus` = `Tidak Lulus`.
- **Denominator (Penyebut):** Jumlah mahasiswa unik pada kombinasi mahasiswa, mata kuliah, dan semester yang mempunyai `nilai_angka` valid dalam rentang 0–100 dan memiliki status kelulusan.
- **Aggregation (Agregasi):** Jumlah mahasiswa tidak lulus dibagi jumlah peserta dengan nilai valid, kemudian dikalikan 100%.

**Rumus Matematis:**

\[
\text{Course Failure Rate} =
\frac{\text{Jumlah Mahasiswa Tidak Lulus}}
{\text{Jumlah Peserta dengan Nilai Valid}}
\times 100\%
\]

**Context (Konteks Analisis)**

KPI ini dapat dilihat berdasarkan beberapa dimensi:

- **Dimensi Waktu:** Tahun akademik dan semester untuk mengamati perubahan tingkat ketidaklulusan.
- **Dimensi Mata Kuliah:** Kode, nama, dan jenis mata kuliah untuk mengetahui mata kuliah yang perlu dievaluasi.
- **Dimensi Program Studi:** Program studi tempat mahasiswa terdaftar.
- **Dimensi Dosen:** Dosen pengampu atau koordinator mata kuliah apabila informasi tersebut tersedia.

**Caveat (Batasan Penggunaan)**

- Mata kuliah dengan peserta kurang dari 10 mahasiswa perlu ditafsirkan secara hati-hati karena sedikit perubahan jumlah mahasiswa tidak lulus dapat menghasilkan perubahan persentase yang besar.
- Ditemukan 20 nilai kosong dan 12 nilai di luar rentang 0–100. Data tersebut tidak dimasukkan ke dalam perhitungan.
- Terdapat 20 ketidaksesuaian antara nilai angka dan nilai huruf serta 17 ketidaksesuaian antara nilai huruf dan status kelulusan. Karena itu, `status_lulus` digunakan sebagai indikator sementara dan perlu dikonfirmasi kepada pemilik data.
- Pada 56.968 nilai angka valid, status kelulusan mengikuti ambang sementara 60. Standar kelulusan resmi tetap harus dipastikan sebelum KPI digunakan untuk pelaporan resmi.
- Perubahan kurikulum atau standar kelulusan antarsemester dapat memengaruhi hasil perbandingan historis.

### 2. KPI On-Time Graduation Rate

**Business Objective (BO03)**

Mengevaluasi pencapaian kelulusan mahasiswa berdasarkan program studi dan angkatan agar universitas dapat mengetahui kondisi penyelesaian studi.

**Decision Requirement (DR02)**

Wakil Rektor Bidang Akademik perlu menentukan program studi atau angkatan yang memerlukan peningkatan keberhasilan studi berdasarkan informasi kelulusan tepat waktu.

**Analytical Question (AQ03)**

Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?

**KPI Name (Nama Pengukuran)**

> Persentase Kelulusan Tepat Waktu (*On-Time Graduation Rate*).

**Definition (Definisi Bisnis)**

> On-Time Graduation Rate menunjukkan persentase mahasiswa yang tercatat menyelesaikan studi tepat waktu dibandingkan dengan seluruh mahasiswa yang telah tercatat lulus pada kelompok analisis yang sama.

**Formula (Formulasi)**

- **Numerator (Pembilang):** Jumlah NIM unik dengan `status_tepat_waktu` = `Ya`.
- **Denominator (Penyebut):** Jumlah seluruh NIM unik pada tabel kelulusan dalam kelompok yang sedang dianalisis.
- **Aggregation (Agregasi):** Jumlah lulusan tepat waktu dibagi jumlah seluruh lulusan unik, kemudian dikalikan 100%.

**Rumus Matematis:**

\[
\text{On-Time Graduation Rate} =
\frac{\text{Jumlah Lulusan Tepat Waktu}}
{\text{Jumlah Seluruh Lulusan}}
\times 100\%
\]

**Context (Konteks Analisis)**

- **Dimensi Program Studi:** Untuk membandingkan hasil kelulusan antarprogram studi.
- **Dimensi Angkatan:** Untuk melihat kondisi lulusan berdasarkan tahun masuk.
- **Dimensi Waktu:** Periode atau tanggal kelulusan mahasiswa.

**Caveat (Batasan Penggunaan)**

- Dataset kelulusan yang tersedia hanya mencakup periode Juni 2025 sehingga belum menggambarkan perubahan kelulusan dari beberapa periode.
- Pengukuran hanya mencakup mahasiswa yang sudah tercatat lulus, bukan seluruh mahasiswa aktif dalam suatu angkatan.
- Terdapat 347 baris data kelulusan dengan 345 NIM unik. Dua baris duplikat harus ditangani sebelum perhitungan.
- Seluruh 347 catatan memiliki status `Ya`. Akibatnya, hasil KPI saat ini menunjukkan 100% dan belum dapat membedakan program studi yang memiliki lulusan tepat waktu lebih baik.
- Seluruh lulusan yang tercatat berasal dari angkatan 2021 dengan masa studi 46–47 bulan. Rata-rata masa studi dapat digunakan sebagai ukuran tambahan.
- Perlu dikonfirmasi kepada bagian akademik mengenai definisi resmi kelulusan tepat waktu dan kemungkinan mahasiswa terlambat yang belum tercatat.

### 3. KPI LMS Engagement per Mata Kuliah

**Business Objective (BO04)**

Menilai pemanfaatan aktivitas LMS sebagai informasi tambahan untuk mengevaluasi keterlibatan mahasiswa dalam pembelajaran.

**Decision Requirement (DR04)**

Dosen Pengampu dan Kaprodi perlu menilai apakah intensitas aktivitas LMS dapat digunakan sebagai indikator pendukung risiko akademik berdasarkan hubungannya dengan nilai mahasiswa.

**Analytical Question (AQ04)**

Bagaimana hubungan antara jumlah atau durasi aktivitas LMS dengan nilai mahasiswa pada mata kuliah yang sama?

**KPI Name (Nama Pengukuran)**

> Rata-rata Aktivitas LMS per Mahasiswa pada Setiap Mata Kuliah (*LMS Engagement per Mata Kuliah*).

**Definition (Definisi Bisnis)**

> KPI ini digunakan untuk mengetahui rata-rata jumlah aktivitas pembelajaran digital yang dilakukan mahasiswa pada suatu mata kuliah. Hasil pengukuran dapat digunakan untuk menggambarkan tingkat keterlibatan mahasiswa dalam pembelajaran melalui LMS dan dibandingkan dengan hasil penilaian akademik.

**Formula (Formulasi)**

- **Numerator (Pembilang):** Jumlah `lms_event_id` yang berbeda atau unik pada mata kuliah dan semester yang dianalisis.
- **Denominator (Penyebut):** Jumlah NIM unik yang terdaftar mengambil mata kuliah pada semester tersebut berdasarkan data KRS yang telah dibersihkan.
- **Aggregation (Agregasi):** Jumlah aktivitas LMS unik dibagi jumlah mahasiswa yang terdaftar. Durasi aktivitas dapat dianalisis sebagai ukuran tambahan.

**Rumus Matematis:**

\[
\text{LMS Engagement} =
\frac{\text{COUNT(DISTINCT lms\_event\_id)}}
{\text{COUNT(DISTINCT NIM pada KRS)}}
\]

**Context (Konteks Analisis)**

- **Dimensi Mata Kuliah:** Untuk membandingkan keterlibatan mahasiswa pada mata kuliah berbeda.
- **Dimensi Jenis Aktivitas:** Untuk membedakan aktivitas login, melihat materi, mengumpulkan tugas, mengerjakan kuis, dan forum.
- **Dimensi Waktu:** Untuk mengelompokkan aktivitas berdasarkan semester dan waktu kejadian.
- **Nilai Akademik:** Digunakan sebagai variabel pembanding pada mata kuliah yang sama.

**Caveat (Batasan Penggunaan)**

- Ditemukan 30 aktivitas LMS yang merupakan duplikasi persis sehingga perlu dihapus berdasarkan `lms_event_id`.
- Jumlah mahasiswa sebagai penyebut harus berasal dari KRS agar mahasiswa yang terdaftar tetapi tidak aktif menggunakan LMS tetap diperhitungkan.
- Skor kuis hanya tersedia pada aktivitas `quiz_attempt`, sehingga tidak boleh dianggap tersedia pada semua jenis aktivitas.
- Jumlah aktivitas yang tinggi tidak secara otomatis menunjukkan nilai akademik yang tinggi.
- Hubungan antara aktivitas LMS dan nilai hanya menunjukkan keterkaitan statistik, bukan bukti bahwa aktivitas LMS menjadi penyebab langsung peningkatan nilai.

---

## 8. Data Requirement

Setelah KPI ditentukan, langkah berikutnya adalah mengidentifikasi data yang diperlukan untuk melakukan pengukuran. Kebutuhan data diperoleh dengan melihat ukuran yang akan dihitung, dimensi yang digunakan, periode analisis, serta ketentuan penyaringan data.

### 1. AQ01 dan KPI01

**Analytical Question (AQ01)**

Mata kuliah mana yang mempunyai persentase mahasiswa tidak lulus paling tinggi pada setiap semester?

**KPI:** Course Failure Rate.

Komponen pengukuran yang dibutuhkan meliputi:

1. Jumlah mahasiswa yang tidak lulus.
2. Jumlah peserta mata kuliah yang mempunyai nilai akhir valid.
3. Persentase ketidaklulusan.

Berdasarkan kebutuhan tersebut, data yang harus disiapkan adalah:

- **Measure:** Jumlah mahasiswa, jumlah mahasiswa tidak lulus, dan persentase ketidaklulusan.
- **Context (Dimension):** Mata kuliah dan program studi.
- **Time:** Semester.
- **Filter/Comparison:** Nilai angka valid pada rentang 0–100 serta status kelulusan yang telah tersedia.

Field yang dibutuhkan:

- `nim` dari tabel `nilai`, untuk menghitung mahasiswa secara unik.
- `kode_mk` dari tabel `nilai`, untuk mengelompokkan hasil berdasarkan mata kuliah.
- `semester_id` dari tabel `nilai`, untuk menentukan periode penilaian.
- `nilai_angka` dari tabel `nilai`, untuk memeriksa validitas nilai akhir.
- `status_lulus` dari tabel `nilai`, untuk menentukan mahasiswa yang lulus atau tidak lulus.
- `nilai_huruf` dari tabel `nilai`, untuk membantu pemeriksaan kesesuaian hasil penilaian.

**Catatan:** `status_lulus` digunakan sebagai indikator sementara karena masih terdapat ketidaksesuaian antara nilai angka, nilai huruf, dan status kelulusan.

### 2. AQ02 dan KPI01

**Analytical Question (AQ02)**

Bagaimana perkembangan persentase mahasiswa tidak lulus pada setiap program studi dari 2021 Ganjil sampai 2024 Genap?

**KPI:** Course Failure Rate berdasarkan program studi dan semester.

Komponen data yang diperlukan:

- **Measure:** Jumlah mahasiswa tidak lulus dan persentase ketidaklulusan per program studi.
- **Context (Dimension):** Program studi dan mata kuliah.
- **Time:** Semester 2021 Ganjil sampai 2024 Genap.
- **Filter/Comparison:** Nilai valid, status kelulusan, dan urutan semester.

Field yang dibutuhkan:

- `nim` dari tabel `nilai`, sebagai identitas mahasiswa.
- `kode_mk` dari tabel `nilai`, untuk mengetahui mata kuliah.
- `semester_id` dari tabel `nilai`, untuk mengurutkan periode.
- `status_lulus` dari tabel `nilai`, untuk menghitung ketidaklulusan.
- `kode_prodi_raw` dari tabel `mahasiswa`, sebagai kode program studi awal.
- `kode_prodi` dan `nama_prodi` dari tabel `program_studi`, sebagai referensi program studi.

**Catatan:** Kode program studi dari tabel mahasiswa perlu diseragamkan menggunakan TRIM dan UPPER sebelum dihubungkan dengan tabel referensi program studi.

### 3. AQ03 dan KPI02

**Analytical Question (AQ03)**

Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?

**KPI:** On-Time Graduation Rate.

Komponen data yang dibutuhkan:

- **Measure:** Jumlah lulusan unik, jumlah lulusan tepat waktu, persentase kelulusan tepat waktu, dan rata-rata masa studi.
- **Context (Dimension):** Program studi dan angkatan.
- **Time:** Periode atau tanggal kelulusan.
- **Filter/Comparison:** Satu data kelulusan untuk setiap NIM setelah duplikasi dihilangkan.

Field yang dibutuhkan:

- `nim` dari tabel `kelulusan`, untuk menghitung lulusan secara unik.
- `status_tepat_waktu` dari tabel `kelulusan`, untuk menentukan status kelulusan.
- `masa_studi_bulan` dari tabel `kelulusan`, untuk menghitung lama studi.
- `ipk_final` dari tabel `kelulusan`, untuk melihat capaian akademik akhir.
- `predikat` dari tabel `kelulusan`, untuk mengelompokkan lulusan.
- `tanggal_lulus_raw` dari tabel `kelulusan`, untuk mengetahui periode kelulusan.
- `angkatan` dan `kode_prodi_raw` dari tabel `mahasiswa`, untuk mendapatkan informasi angkatan dan program studi.
- `kode_prodi` dan `nama_prodi` dari tabel `program_studi`, sebagai referensi program studi.

**Catatan:** Seluruh data kelulusan yang tersedia berstatus tepat waktu. Oleh karena itu, perbandingan antara kelompok tepat waktu dan terlambat belum dapat dilakukan.

### 4. AQ04 dan KPI03

**Analytical Question (AQ04)**

Bagaimana hubungan antara jumlah atau durasi aktivitas LMS dengan nilai mahasiswa pada mata kuliah yang sama?

**KPI:** LMS Engagement per Mata Kuliah.

Komponen data yang dibutuhkan:

- **Measure:** Jumlah aktivitas LMS, durasi aktivitas, skor kuis, nilai angka, dan jumlah peserta.
- **Context (Dimension):** Mata kuliah dan jenis aktivitas LMS.
- **Time:** Semester dan waktu aktivitas.
- **Filter/Comparison:** Menggunakan event unik, skor kuis hanya untuk `quiz_attempt`, serta jumlah peserta berdasarkan KRS.

Field yang dibutuhkan:

- `lms_event_id` dari tabel `aktivitas_lms`, untuk menghitung aktivitas secara unik.
- `nim` dari tabel `aktivitas_lms`, untuk menghubungkan aktivitas dengan mahasiswa.
- `kode_mk` dari tabel `aktivitas_lms`, untuk mengetahui mata kuliah.
- `semester_id` dari tabel `aktivitas_lms`, untuk menentukan periode aktivitas.
- `waktu_event` dari tabel `aktivitas_lms`, untuk mengetahui waktu kejadian.
- `tipe_event` dari tabel `aktivitas_lms`, untuk membedakan jenis aktivitas.
- `durasi_menit` dari tabel `aktivitas_lms`, untuk menghitung durasi.
- `skor_kuis` dari tabel `aktivitas_lms`, untuk menganalisis hasil kuis.
- `nilai_angka` dari tabel `nilai`, untuk membandingkan aktivitas dengan hasil akademik.
- `nim`, `kode_mk`, dan `semester_id` dari tabel `krs`, untuk memperoleh jumlah mahasiswa yang terdaftar.

**Catatan:** Penggabungan data dilakukan berdasarkan NIM, kode mata kuliah, dan semester agar aktivitas LMS dibandingkan dengan nilai pada mata kuliah dan periode yang sesuai.

### 5. AQ05 dan Kebutuhan Pengukuran Nilai Semester Awal

**Analytical Question (AQ05)**

Apakah rata-rata nilai mahasiswa pada semester awal berbeda berdasarkan predikat kelulusan?

**KPI:** Rata-rata Nilai Semester Awal Berdasarkan Predikat Kelulusan.

Komponen data yang dibutuhkan:

- **Measure:** Rata-rata nilai angka mahasiswa pada dua semester pertama.
- **Context (Dimension):** Predikat kelulusan.
- **Time:** Dua semester pertama.
- **Filter/Comparison:** Nilai valid 0–100 dan NIM lulusan yang unik.

Field yang dibutuhkan:

- `nim` dari tabel `nilai`, untuk menghubungkan nilai dengan mahasiswa.
- `semester_id` dari tabel `nilai`, untuk memilih semester awal.
- `nilai_angka` dari tabel `nilai`, sebagai ukuran hasil akademik.
- `predikat` dari tabel `kelulusan`, untuk mengelompokkan mahasiswa.
- `ipk_final` dari tabel `kelulusan`, sebagai informasi tambahan hasil akhir.
- `semester_id` dan `urutan_tahun` dari tabel `semester`, untuk menentukan urutan semester.

**Catatan:** Perbandingan mahasiswa tepat waktu dan terlambat belum dapat dilakukan karena seluruh data kelulusan yang tersedia memiliki status tepat waktu.

Seluruh kebutuhan data tersebut dapat diringkas dalam tabel berikut.

| AQ | Measure | Context | Time | Filter/Comparison | Required Data |
|---|---|---|---|---|---|
| AQ01 | Jumlah peserta, jumlah tidak lulus, dan Course Failure Rate | Mata kuliah, program studi | Semester | Nilai angka valid dan status kelulusan | `nim`, `kode_mk`, `semester_id`, `nilai_angka`, `status_lulus`, `nilai_huruf` |
| AQ02 | Persentase ketidaklulusan per program studi | Program studi, mata kuliah | 2021 Ganjil–2024 Genap | Nilai valid dan urutan semester | `nim`, `kode_mk`, `semester_id`, `status_lulus`, `kode_prodi_raw`, `kode_prodi`, `nama_prodi` |
| AQ03 | Jumlah lulusan, lulusan tepat waktu, dan rata-rata masa studi | Program studi, angkatan | Periode kelulusan | Satu catatan per NIM | `nim`, `status_tepat_waktu`, `masa_studi_bulan`, `ipk_final`, `predikat`, `tanggal_lulus_raw`, `angkatan`, `kode_prodi_raw` |
| AQ04 | Jumlah event, durasi, skor kuis, nilai angka, jumlah peserta | Mata kuliah, jenis aktivitas | Semester | Event unik, skor hanya untuk quiz_attempt, peserta dihitung dari KRS | `lms_event_id`, `nim`, `kode_mk`, `semester_id`, `tipe_event`, `durasi_menit`, `skor_kuis`, `nilai_angka`, data KRS |
| AQ05 | Rata-rata nilai angka semester awal | Predikat kelulusan | Dua semester pertama | Nilai 0–100 dan NIM lulusan unik | `nim`, `semester_id`, `nilai_angka`, `predikat`, `ipk_final`, `urutan_tahun` |

---

## 9. Source Mapping

Setelah kebutuhan data diketahui, setiap informasi perlu ditelusuri ke tabel sumber dan kolom yang menyediakannya. Pemetaan ini bertujuan agar jelas data mana yang digunakan sebagai penghubung, ukuran, konteks analisis, maupun komponen KPI.

| Data Requirement | Source | Column | Role |
|---|---|---|---|
| Mahasiswa | `nilai`, `mahasiswa` | `nim` | Integration key |
| Mata kuliah | `nilai`, `mata_kuliah` | `kode_mk` | Course identifier |
| Nama mata kuliah | `mata_kuliah` | `nama_mk` | Analytical context |
| Semester | `nilai`, `semester` | `semester_id` | Time key |
| Nilai mahasiswa | `nilai` | `nilai_angka` | Measure |
| Status lulus/gagal | `nilai` | `status_lulus`, `nilai_huruf` | KPI component |
| Program studi mahasiswa | `mahasiswa`, `program_studi` | `kode_prodi_raw`, `kode_prodi`, `nama_prodi` | Analytical context |
| Angkatan mahasiswa | `mahasiswa` | `angkatan` | Analytical context |
| Status kelulusan tepat waktu | `kelulusan` | `status_tepat_waktu` | KPI component |
| Predikat dan IPK akhir | `kelulusan` | `predikat`, `ipk_final` | Analytical context dan measure |
| Masa studi | `kelulusan` | `masa_studi_bulan` | Measure |
| Aktivitas LMS | `aktivitas_lms` | `lms_event_id` | Measure |
| Peserta mata kuliah | `krs` | `nim`, `kode_mk`, `semester_id` | Denominator KPI LMS |
| Durasi aktivitas LMS | `aktivitas_lms` | `durasi_menit` | Measure |
| Semester aktivitas LMS | `aktivitas_lms` | `semester_id` | Time key |
| Jenis aktivitas LMS | `aktivitas_lms` | `tipe_event` | Analytical context |
| Waktu aktivitas LMS | `aktivitas_lms` | `waktu_event` | Time context |
| Skor kuis LMS | `aktivitas_lms` | `skor_kuis` | Measure |

Keterangan fungsi kolom:

- **Integration Key:** Digunakan untuk menghubungkan data dari tabel yang berbeda.
- **Course Identifier:** Menjadi identitas mata kuliah yang dianalisis.
- **Analytical Context:** Menentukan kelompok atau kategori yang digunakan untuk membaca hasil analisis.
- **Time Key:** Digunakan untuk mengelompokkan data berdasarkan periode.
- **Measure:** Berisi nilai atau jumlah yang akan dihitung.
- **KPI Component:** Menjadi bagian penting dalam formulasi indikator kinerja.

---

## 10. Data Fitness

Pemeriksaan Data Fitness dilakukan untuk melihat apakah data yang tersedia sudah dapat digunakan atau masih memerlukan perbaikan. Penilaian ini mengacu pada hasil Data Profiling Modul 1 Unit 1.2.

| Source | Evidence Unit 1.2 | Fitness | Required Action |
|---|---|---|---|
| `mahasiswa` | Terdapat 15 NIM duplikat persis, sehingga 1.965 baris menjadi 1.950 NIM unik. Ditemukan 30 variasi label program studi untuk 6 program studi, 6 variasi label gender, 208 kode program studi yang bermasalah pada spasi atau huruf kecil, 30 data kota asal kosong, serta 3 format tanggal. | Conditional Ready | Menghilangkan duplikasi berdasarkan NIM, menormalkan `kode_prodi_raw` menggunakan TRIM dan UPPER, menyeragamkan label, serta memperbaiki format tanggal. |
| `program_studi` | Memiliki 6 baris data dengan kode dan nama program studi yang unik serta tidak ditemukan masalah kualitas yang berarti. | Ready | Dapat digunakan sebagai tabel referensi utama untuk pengelompokan program studi. |
| `mata_kuliah` | Kode mata kuliah bersifat unik dan tidak ditemukan data yatim pada KRS, nilai, maupun LMS. Terdapat 63 nama mata kuliah yang berulang pada program studi berbeda, tetapi kondisi tersebut masih dapat diterima. | Ready | Menggunakan `kode_mk` sebagai identitas mata kuliah dan tidak menjadikan nama mata kuliah sebagai kunci utama. |
| `krs` | Ditemukan 25 duplikasi persis, yaitu 57.025 baris menjadi 57.000 data unik. Tidak ditemukan data yatim, tetapi terdapat 3 format tanggal. | Conditional Ready | Melakukan deduplikasi sebelum menghitung jumlah peserta mata kuliah dan menyeragamkan format tanggal. |
| `nilai` | Memiliki 57.000 data dengan kunci unik. Ditemukan 20 nilai kosong, 12 nilai di luar rentang 0–100, 20 ketidaksesuaian nilai angka dan huruf, serta 17 ketidaksesuaian status dan nilai huruf. Tidak ditemukan data yatim. | Conditional Ready | Mengecualikan nilai kosong dan tidak valid, memeriksa konsistensi atribut nilai, serta mengonfirmasi aturan kelulusan yang resmi kepada pemilik data. |
| `aktivitas_lms` | Terdapat 30 aktivitas yang terduplikasi secara persis. Skor kuis hanya tersedia untuk aktivitas `quiz_attempt`. Durasi dan skor berada dalam rentang yang sesuai dan tidak ditemukan data yatim. | Conditional Ready | Menghapus duplikasi berdasarkan `lms_event_id` dan menggunakan skor kuis hanya pada aktivitas yang sesuai. |
| `kelulusan – profile on-time` | Terdapat 347 baris data dengan 345 NIM unik karena ada 2 data duplikat. Tidak ditemukan data yatim, terdapat 1 format tanggal, seluruh status tepat waktu bernilai `Ya`, masa studi 46–47 bulan, dan hanya mencakup angkatan 2021. | Conditional Ready | Menghapus data duplikat berdasarkan NIM, menyeragamkan format tanggal, serta memeriksa masa studi, IPK, dan predikat setelah data dibersihkan. |
| `kelulusan – on-time vs late` | Semua 347 catatan memiliki status tepat waktu `Ya`. Data hanya mencakup angkatan 2021 pada periode Juni 2025 sehingga belum terdapat kelompok mahasiswa yang terlambat lulus. | Not Ready | Meminta konfirmasi kepada bagian akademik mengenai data lulusan terlambat yang belum tersedia. Perbandingan tepat waktu dan terlambat ditunda sampai data pendukung tersedia. |

Berdasarkan hasil pemeriksaan tersebut, sebagian besar tabel masih dapat digunakan setelah dilakukan penanganan kualitas data. Tabel `program_studi`, `mata_kuliah`, dan `semester` mempunyai kondisi yang relatif siap. Sementara itu, tabel mahasiswa, KRS, nilai, aktivitas LMS, dan kelulusan memerlukan pembersihan atau pemeriksaan lanjutan.

Kebutuhan analisis yang belum dapat dipenuhi adalah perbandingan antara mahasiswa yang lulus tepat waktu dan mahasiswa yang terlambat. Hal ini disebabkan seluruh data kelulusan yang tersedia menunjukkan status tepat waktu.

---

## 11. Candidate Model

Pada tahap ini belum dilakukan pembangunan Star Schema final. Hal yang perlu ditentukan adalah kandidat model yang dapat mendukung setiap pertanyaan analitis. Penentuan model dimulai dari candidate grain, yaitu tingkat detail terkecil yang diwakili oleh satu baris data pada suatu fakta.

Urutan penyusunan candidate model adalah:

> Analytical Question → Business Event → Grain → Dimension → Fact → Measure.

Tahapan penentuannya meliputi:

1. Menentukan aktivitas atau kejadian yang menghasilkan data (*Business Event*).
2. Menetapkan arti satu baris data (*Grain*).
3. Menentukan dasar pengelompokan informasi (*Dimension*).
4. Menentukan kejadian yang akan dianalisis (*Fact*).
5. Menentukan nilai atau indikator yang dihitung (*Measure*).

### AQ01

**Analytical Question:**

> Mata kuliah mana yang memiliki persentase ketidaklulusan paling tinggi pada setiap semester?

**Business Event:**

> Mahasiswa menyelesaikan kegiatan perkuliahan dan menerima nilai akhir dari dosen pengampu.

**Candidate Grain:**

> Satu baris data mewakili hasil penilaian akhir seorang mahasiswa pada satu mata kuliah dalam satu semester.

**Candidate Fact:**

> `Fact_Penilaian` atau `Fact_Nilai_Mahasiswa`.

**Candidate Dimensions:**

- Mahasiswa.
- Mata Kuliah.
- Semester.
- Program Studi.

**Candidate Measures:**

- `nilai_angka`.
- `is_lulus`.
- Jumlah catatan nilai.
- Jumlah mahasiswa tidak lulus.
- Course Failure Rate.

### AQ02

**Analytical Question:**

> Bagaimana perubahan persentase mahasiswa tidak lulus pada setiap program studi dari 2021 Ganjil sampai 2024 Genap?

**Business Event:**

> Mahasiswa memperoleh nilai akhir setelah mengikuti mata kuliah pada semester tertentu.

**Candidate Grain:**

> Satu baris mewakili satu hasil penilaian mahasiswa pada satu mata kuliah dan satu semester.

**Candidate Fact:**

> `Fact_Penilaian`.

**Candidate Dimensions:**

- Program Studi.
- Semester.
- Mahasiswa.
- Mata Kuliah.

**Candidate Measures:**

- `is_tidak_lulus`.
- Jumlah mahasiswa peserta.
- Jumlah mahasiswa tidak lulus.
- Persentase ketidaklulusan per program studi.

### AQ03

**Analytical Question:**

> Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?

**Business Event:**

> Mahasiswa menyelesaikan pendidikan dan dicatat sebagai lulusan oleh bagian akademik.

**Candidate Grain:**

> Satu baris data menunjukkan satu catatan kelulusan untuk seorang mahasiswa.

**Candidate Fact:**

> `Fact_Kelulusan`.

**Candidate Dimensions:**

- Mahasiswa.
- Program Studi.
- Angkatan.
- Tanggal Kelulusan.

**Candidate Measures:**

- `is_tepat_waktu`.
- `masa_studi_bulan`.
- `ipk_final`.
- Jumlah lulusan.
- On-Time Graduation Rate.

### AQ04

**Analytical Question:**

> Bagaimana hubungan jumlah atau durasi aktivitas LMS dengan nilai mahasiswa pada mata kuliah yang sama?

**Business Event:**

> Mahasiswa melakukan kegiatan pembelajaran melalui sistem LMS selama proses perkuliahan berlangsung.

**Candidate Grain:**

> Satu baris data mewakili satu aktivitas LMS yang dibedakan berdasarkan `lms_event_id`.

**Candidate Fact:**

> `Fact_Aktivitas_LMS`.

**Candidate Dimensions:**

- Mahasiswa.
- Mata Kuliah.
- Tipe Aktivitas.
- Tanggal atau Waktu.

**Candidate Measures:**

- Jumlah aktivitas LMS.
- `durasi_menit`.
- `skor_kuis`.

**Catatan Model:**

> Untuk menghubungkan aktivitas LMS dengan nilai, aktivitas perlu dirangkum terlebih dahulu berdasarkan mahasiswa dan mata kuliah. Hasil ringkasan kemudian dapat dibandingkan dengan `Fact_Penilaian` melalui dimensi mahasiswa dan mata kuliah. Penggabungan seluruh event LMS langsung dengan detail nilai perlu dihindari karena dapat menghasilkan penggandaan data.

### AQ05

**Analytical Question:**

> Apakah rata-rata nilai mahasiswa pada semester awal berbeda berdasarkan predikat kelulusan?

**Business Event:**

> Mahasiswa mendapatkan nilai selama dua semester pertama dan kemudian memiliki catatan kelulusan yang berisi predikat akhir.

**Candidate Grain:**

> Nilai dari dua semester pertama diringkas menjadi satu catatan per mahasiswa, kemudian dihubungkan dengan satu catatan kelulusan mahasiswa tersebut.

**Candidate Fact:**

- `Fact_Penilaian` yang telah diringkas berdasarkan mahasiswa untuk dua semester pertama.
- `Fact_Kelulusan` dengan satu catatan untuk setiap mahasiswa.

**Candidate Dimensions:**

- Mahasiswa.
- Semester.
- Predikat Kelulusan.

**Candidate Measures:**

- Nilai angka semester awal.
- Rata-rata nilai semester awal.
- `ipk_final`.

**Catatan Model:**

> Analisis dilakukan dengan menghubungkan hasil ringkasan nilai awal mahasiswa dengan predikat kelulusan. Kedua tabel fakta tidak disarankan untuk digabungkan secara langsung pada tingkat detail karena dapat menyebabkan penggandaan baris atau fan-out. Dimensi mahasiswa dapat digunakan sebagai penghubung dalam analisis.

---

## 12. Traceability

Traceability digunakan untuk memastikan setiap bagian analisis mempunyai hubungan yang jelas. Dengan demikian, kebutuhan data dan rancangan model tidak berdiri sendiri, tetapi dapat ditelusuri kembali ke permasalahan bisnis yang menjadi dasar penyusunannya.

Alur traceability:

> Problem → Business Objective → Stakeholder → Decision Requirement → Analytical Question → KPI/Metric → Data Requirement → Source Mapping → Data Fitness → Candidate Model.

Setiap kebutuhan dirangkum dengan menghubungkan permasalahan, tujuan, keputusan, pertanyaan analitis, KPI, data yang dibutuhkan, sumber data, kondisi kualitas data, dan rancangan model.

### 1. TR01 – Course Failure

- **Problem:** Mata kuliah yang mempunyai risiko ketidaklulusan tinggi belum dapat dikenali secara mudah.
- **Stakeholder:** Ketua Program Studi (Kaprodi).
- **Business Objective:** Meningkatkan kemampuan program studi dalam memantau hasil pembelajaran dan menentukan mata kuliah yang perlu dievaluasi.
- **Decision:** Memilih mata kuliah yang harus menjadi prioritas perbaikan.
- **AQ:** Mata kuliah mana yang memiliki persentase ketidaklulusan paling tinggi pada setiap semester?
- **KPI:** Course Failure Rate.
- **Data:** NIM, kode mata kuliah, semester, nilai angka, dan status kelulusan.
- **Source:** `nilai`, `mata_kuliah`, dan `semester`.
- **Fitness:** Tabel nilai berstatus Conditional Ready, sedangkan mata kuliah dan semester berstatus Ready.
- **Candidate Process:** Penilaian.
- **Candidate Grain:** Satu nilai akhir mahasiswa pada satu mata kuliah dalam satu semester.

Karena program studi belum mempunyai gambaran yang cukup mengenai mata kuliah dengan tingkat ketidaklulusan tinggi, Kaprodi membutuhkan informasi yang dapat membantu menentukan mata kuliah prioritas untuk dievaluasi. Kebutuhan tersebut dijawab melalui AQ01 dengan menggunakan KPI Course Failure Rate. Perhitungan membutuhkan data mahasiswa, mata kuliah, semester, nilai angka, dan status kelulusan yang bersumber dari tabel `nilai`, `mata_kuliah`, dan `semester`. Berdasarkan hasil profiling, tabel nilai masih berstatus Conditional Ready karena terdapat beberapa masalah kualitas, sedangkan tabel mata kuliah dan semester sudah Ready. Oleh sebab itu, kandidat model untuk proses penilaian adalah:

- **Grain:** Satu baris menunjukkan nilai akhir seorang mahasiswa pada satu mata kuliah dalam satu semester.
- **Fact:** `Fact_Penilaian` atau `Fact_Nilai_Mahasiswa`.
- **Dimension:** `Dim_Mahasiswa`, `Dim_Mata_Kuliah`, dan `Dim_Semester`.
- **Measure:** `nilai_angka`, `Status_Lulus`, `Jumlah_Peserta`, `Jumlah_Tidak_Lulus`, dan `Course_Failure_Rate`.

### 2. TR02 – On-Time Graduation

- **Problem:** Pola kelulusan tepat waktu berdasarkan program studi dan angkatan belum dapat dievaluasi secara menyeluruh.
- **Stakeholder:** Wakil Rektor Bidang Akademik.
- **Business Objective:** Mengevaluasi keberhasilan mahasiswa dalam menyelesaikan studi.
- **Decision:** Menentukan program studi atau angkatan yang memerlukan penguatan program akademik.
- **AQ:** Bagaimana perbandingan persentase kelulusan tepat waktu dan rata-rata masa studi antarprogram studi?
- **KPI:** On-Time Graduation Rate.
- **Data:** NIM, status tepat waktu, masa studi, angkatan, dan program studi.
- **Source:** `kelulusan`, `mahasiswa`, dan `program_studi`.
- **Fitness:** Tabel kelulusan dan mahasiswa berstatus Conditional Ready, sedangkan program studi berstatus Ready. Perbandingan tepat waktu dan terlambat belum dapat dilakukan karena seluruh data kelulusan berstatus Ya.
- **Candidate Process:** Kelulusan.
- **Candidate Grain:** Satu catatan kelulusan untuk setiap mahasiswa.

Karena universitas belum mempunyai gambaran yang cukup untuk mengevaluasi keberhasilan penyelesaian studi berdasarkan program studi, Wakil Rektor Bidang Akademik membutuhkan informasi mengenai jumlah lulusan dan tingkat kelulusan tepat waktu. Kebutuhan ini dijawab melalui AQ03 dengan KPI On-Time Graduation Rate. Data yang digunakan meliputi NIM, status tepat waktu, masa studi, angkatan, dan program studi yang bersumber dari tabel `kelulusan`, `mahasiswa`, serta `program_studi`. Hasil profiling menunjukkan bahwa data kelulusan dan mahasiswa masih memerlukan deduplikasi serta pemeriksaan atribut, sedangkan tabel program studi siap digunakan. Namun, seluruh data lulusan yang tersedia memiliki status tepat waktu sehingga hasil perbandingan perlu dibatasi. Kandidat modelnya adalah:

- **Grain:** Satu baris mewakili satu mahasiswa yang tercatat lulus.
- **Fact:** `Fact_Kelulusan`.
- **Dimension:** `Dim_Mahasiswa`, `Dim_Prodi`, `Dim_Angkatan`, dan `Dim_Tanggal_Lulus`.
- **Measure:** `is_tepat_waktu`, `masa_studi_bulan`, `ipk_final`, `Jumlah_Lulusan`, dan `On-Time Graduation Rate`.

### 3. TR03 – LMS Engagement

- **Problem:** Belum diketahui apakah keterlibatan mahasiswa pada LMS mempunyai keterkaitan dengan hasil nilai mata kuliah.
- **Stakeholder:** Dosen Pengampu dan Kaprodi.
- **Business Objective:** Menilai aktivitas LMS sebagai informasi tambahan untuk evaluasi pembelajaran.
- **Decision:** Menentukan apakah aktivitas LMS dapat dimanfaatkan sebagai indikator pendukung risiko akademik.
- **AQ:** Bagaimana hubungan jumlah atau durasi aktivitas LMS dengan nilai mahasiswa pada mata kuliah yang sama?
- **KPI:** LMS Engagement per Mata Kuliah.
- **Data:** ID aktivitas, NIM, kode mata kuliah, semester, durasi, skor kuis, dan nilai angka.
- **Source:** `aktivitas_lms`, `nilai`, dan `krs`.
- **Fitness:** Conditional Ready karena terdapat 30 aktivitas duplikat dan beberapa masalah kualitas pada data nilai.
- **Candidate Process:** Aktivitas Pembelajaran LMS.
- **Candidate Grain:** Satu aktivitas LMS berdasarkan `lms_event_id`.

Karena dosen belum mempunyai informasi yang cukup mengenai keterkaitan aktivitas LMS dengan hasil akademik mahasiswa, dosen pengampu dan Kaprodi membutuhkan pengukuran yang dapat membandingkan intensitas aktivitas dengan nilai mata kuliah. Kebutuhan tersebut dijawab melalui AQ04 menggunakan KPI LMS Engagement per Mata Kuliah. Data yang diperlukan meliputi ID aktivitas, NIM, kode mata kuliah, durasi, skor kuis, dan nilai angka dari tabel `aktivitas_lms`, `nilai`, serta KRS sebagai sumber jumlah peserta. Berdasarkan hasil profiling, data aktivitas LMS perlu dibersihkan dari 30 event duplikat dan data nilai masih membutuhkan pemeriksaan. Kandidat modelnya adalah:

- **Grain:** Satu baris menunjukkan satu aktivitas LMS yang memiliki ID event unik.
- **Fact:** `Fact_Aktivitas_LMS`.
- **Dimension:** `Dim_Mahasiswa`, `Dim_Mata_Kuliah`, `Dim_Tipe_Aktivitas`, dan `Dim_Tanggal`.
- **Measure:** `Jumlah_Event`, `durasi_menit`, dan `skor_kuis`.

### 4. TR04 – Identifikasi Risiko Akademik Mahasiswa

- **Problem:** Kelompok mahasiswa yang membutuhkan pendampingan akademik belum mudah dikenali melalui hasil belajar pada semester awal.
- **Stakeholder:** Dosen Pembimbing Akademik dan Bagian Akademik.
- **Business Objective:** Memperkuat proses identifikasi mahasiswa yang berpotensi mengalami kesulitan akademik.
- **Decision:** Menentukan kelompok mahasiswa yang perlu mendapatkan pendampingan lebih awal.
- **AQ:** Apakah rata-rata nilai mahasiswa pada semester awal berbeda berdasarkan predikat kelulusan?
- **KPI:** Rata-rata Nilai Semester Awal Berdasarkan Predikat Kelulusan.
- **Data:** NIM, semester, nilai angka, dan predikat kelulusan.
- **Source:** `nilai`, `kelulusan`, dan `semester`.
- **Fitness:** Tabel nilai dan kelulusan berstatus Conditional Ready, sedangkan semester berstatus Ready.
- **Candidate Process:** Penilaian dan Kelulusan.
- **Candidate Grain:** Nilai dua semester pertama diringkas menjadi satu catatan per mahasiswa dan dihubungkan dengan satu catatan kelulusan.

Karena pihak akademik belum dapat membedakan kelompok mahasiswa yang memerlukan perhatian berdasarkan hasil belajar awal, dosen pembimbing dan bagian akademik membutuhkan informasi mengenai rata-rata nilai semester pertama dan kedua berdasarkan predikat kelulusan. Kebutuhan ini dijawab melalui AQ05 dengan membandingkan rata-rata nilai awal mahasiswa pada kelompok predikat yang berbeda. Data yang diperlukan adalah NIM, semester, nilai angka, dan predikat kelulusan yang bersumber dari tabel `nilai`, `kelulusan`, dan `semester`. Berdasarkan hasil profiling, tabel nilai dan kelulusan masih memerlukan pemeriksaan serta pembersihan, sedangkan tabel semester sudah siap. Kandidat modelnya adalah:

- **Grain:** Nilai dua semester pertama diringkas menjadi satu catatan untuk setiap mahasiswa, kemudian dihubungkan dengan satu catatan kelulusan.
- **Fact:** `Fact_Penilaian` yang diagregasi untuk dua semester pertama dan `Fact_Kelulusan`.
- **Dimension:** `Dim_Mahasiswa`, `Dim_Semester`, dan `Dim_Predikat_Kelulusan`.
- **Measure:** Rata-rata nilai semester awal dan `ipk_final`.

**Catatan:** Penggabungan data penilaian dan kelulusan tidak dilakukan langsung pada tingkat detail karena dapat menyebabkan penggandaan baris. Nilai semester awal perlu diringkas per mahasiswa terlebih dahulu sebelum dihubungkan dengan data kelulusan.
