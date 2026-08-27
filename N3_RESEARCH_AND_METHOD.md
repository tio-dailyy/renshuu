# Riset dan Metode Belajar JLPT N3

Terakhir diperbarui: 28 Agustus 2026

## Sasaran aplikasi

Aplikasi `N3 合格ルート` dibuat untuk mengurangi hambatan memulai belajar dan membantu empat hal yang berbeda:

1. memperoleh kosakata, kanji, dan pola tata bahasa;
2. melatih pengambilan jawaban dari ingatan, bukan hanya mengenali materi;
3. meningkatkan kecepatan membaca dan mendengar dalam batas waktu;
4. menemukan kelemahan melalui simulasi dan log kesalahan.

Soal dalam aplikasi adalah soal orisinal yang mengikuti tipe dan tingkat sasaran N3. Soal itu bukan bocoran, salinan soal ujian, atau klaim sebagai soal yang pernah keluar. Contoh resmi tetap dirujuk melalui situs JLPT karena materi resmi dan rekaman listening mempunyai ketentuan hak cipta.

## Format resmi N3

Menurut situs resmi JLPT, N3 memiliki tiga sesi ujian:

| Sesi ujian | Waktu |
|---|---:|
| Pengetahuan bahasa: huruf dan kosakata | 30 menit |
| Pengetahuan bahasa: tata bahasa dan membaca | 70 menit |
| Mendengar | 40 menit |

Bidang nilai resmi berbeda sedikit dari pembagian sesi. Nilai dilaporkan sebagai:

| Bidang nilai | Rentang | Batas minimum |
|---|---:|---:|
| Pengetahuan bahasa: kosakata dan tata bahasa | 0–60 | 19 |
| Membaca | 0–60 | 19 |
| Mendengar | 0–60 | 19 |
| Total | 0–180 | 95 |

Peserta harus mencapai total 95 sekaligus minimal 19 di setiap bidang. Nilai JLPT adalah *scaled score*, bukan konversi langsung jumlah jawaban benar. Nilai aplikasi karena itu hanya estimasi latihan.

Mulai ujian Desember 2025, peserta N3 yang lulus memperoleh referensi CEFR: skor 95–103 ditampilkan sebagai A2 dan skor 104 ke atas sebagai B1. Referensi itu hanya mencakup kemampuan reseptif yang diuji JLPT, bukan berbicara atau menulis.

### Tipe soal yang harus dilatih

- Kosakata: cara baca kanji, ortografi, arti dalam konteks, parafrasa, dan penggunaan.
- Tata bahasa: memilih bentuk, menyusun kalimat, dan memahami hubungan tata bahasa dalam teks.
- Membaca: teks pendek, menengah, panjang, serta pencarian informasi.
- Mendengar: pemahaman tugas, poin penting, gambaran umum, ungkapan lisan, dan respons cepat.

Bank awal aplikasi berisi 50 soal: 16 kosakata, 16 tata bahasa, 8 membaca, dan 10 mendengar. Struktur data dipisahkan di `n3-data.js` agar bank soal dapat ditambah tanpa mengubah mesin aplikasi.

## Dasar metode belajar

### 1. Retrieval practice

Mencoba menjawab sebelum membuka jawaban memperkuat kemampuan memanggil informasi dari ingatan. Karena itu mode latihan meminta jawaban lebih dulu dan baru kemudian menampilkan koreksi. Membaca ulang masih berguna untuk pemahaman awal, tetapi tidak cukup untuk menguji apakah pengetahuan dapat dipanggil saat ujian.

### 2. Spacing dan successive relearning

Materi yang sama diulang setelah ada jeda. Jawaban salah kembali segera, sedangkan jawaban benar berulang mendapat interval lebih panjang. Kombinasi pengambilan aktif dan pengulangan berjeda disebut *successive relearning* dan mempunyai dukungan penelitian kuat untuk retensi jangka panjang, termasuk kosakata bahasa asing.

Jadwal awal aplikasi:

- salah: ulang hari ini;
- benar pertama: satu hari;
- benar kedua berturut-turut: tiga hari;
- berikutnya: interval sebelumnya dikalikan tingkat kemudahan, dengan penyesuaian berdasarkan kesalahan.

Jadwal ini bersifat adaptif dan sederhana, bukan klaim sebagai algoritme optimal universal.

### 3. Interleaving

Sesi harian mencampur bidang soal agar pengguna belajar memilih strategi yang tepat, bukan hanya mengulang pola sama dalam satu blok panjang. Latihan terarah per bidang tetap tersedia ketika evaluasi menunjukkan kelemahan khusus.

### 4. Feedback yang berbeda menurut tujuan

- Latihan: koreksi dan penjelasan langsung untuk mencegah kesalahan menetap.
- Simulasi: tidak ada koreksi, kamus klik, atau nilai sampai seluruh tes dikumpulkan.
- Evaluasi: skor per bidang, batas minimum, dan daftar soal yang pernah salah.

### 5. Metakognisi

Rasa “sudah hafal” sering terlalu optimistis setelah membaca ulang. Dashboard menampilkan perilaku yang terukur—soal pernah dikerjakan, jawaban salah, materi jatuh tempo, dan penguasaan per bidang—agar keputusan belajar berdasarkan performa, bukan rasa familier.

## Rencana penggunaan yang disarankan

### Hari kerja: 15–30 menit

1. Kerjakan antrean “Ulang yang hampir lupa”.
2. Lanjutkan sesi harian campuran sampai 15 soal.
3. Jika satu bidang di bawah bidang lain, tambah 5–10 soal terarah.
4. Klik kanji/kotoba sulit hanya setelah mencoba memahami kalimat.

### Satu kali per minggu

1. Jalankan simulasi ringkas tanpa bantuan.
2. Buka Evaluasi dan pilih bidang terendah.
3. Latih ulang log kesalahan, lalu buat satu contoh kalimat sendiri untuk pola yang masih membingungkan.

### Empat sampai enam minggu sebelum ujian

- Tambahkan simulasi penuh 140 menit secara berkala.
- Latih duduk dan fokus sesuai urutan sesi resmi.
- Gunakan Official Practice Workbook untuk kalibrasi terakhir terhadap materi resmi.
- Jangan menilai kesiapan hanya dari skor total; setiap bidang harus aman di atas batas bagian.

## Penyimpanan dan instalasi

- Progres otomatis disimpan ke IndexedDB di perangkat setelah jawaban atau perpindahan sesi.
- Sesi yang ditutup di tengah jalan muncul lagi sebagai “Lanjutkan”.
- Timer simulasi disimpan sebagai waktu akhir; menutup browser tidak menghentikan waktu ujian.
- Tombol “Unduh backup progres” membuat berkas JSON lokal.
- Service worker menyimpan aset inti sehingga aplikasi dapat dibuka kembali secara offline setelah kunjungan pertama.
- Progres saat ini bersifat per perangkat dan tidak disinkronkan ke server. Ini menghindari kebutuhan akun belajar tambahan, tetapi progres HP dan desktop akan berbeda.

## Sumber primer dan resmi

- [JLPT — Composition of Test Sections and Items](https://www.jlpt.jp/e/guideline/testsections.html)
- [JLPT — Scoring Sections, Pass or Fail, Score Report](https://www.jlpt.jp/e/guideline/results.html)
- [JLPT — Official Practice Workbook](https://www.jlpt.jp/e/samples/sampleindex.html)
- [JLPT — N1–N5 Level Summary](https://www.jlpt.jp/e/about/levelsummary.html)
- [JLPT — CEFR reference indication](https://www.jlpt.jp/e/about/cefr_reference.html)
- Carpenter, S. K., Pan, S. C., & Butler, A. C. (2022). [The science of effective learning with spacing and retrieval practice](https://www.nature.com/articles/s44159-022-00089-1). *Nature Reviews Psychology, 1*, 496–511.

## Pengembangan berikutnya yang paling bernilai

1. memperbesar bank menjadi beberapa ratus soal orisinal dengan review penutur Jepang;
2. menambahkan rekaman suara manusia untuk listening, bukan hanya TTS perangkat;
3. menambahkan impor backup agar progres dapat dipindah manual antarperangkat;
4. menambahkan profil akun dan sinkronisasi lintas perangkat hanya jika benar-benar diperlukan;
5. membuat beberapa paket simulasi tetap agar skor antarminggu dapat dibandingkan secara adil.
