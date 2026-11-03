# CHANGELOG

## Gate 1 — Fondasi

- **Jadi** — Aplikasi Cake & Dessert Catalog berbasis Flutter sudah memiliki alur utama Home → Katalog → Detail Produk → Pesan via WhatsApp. Aplikasi juga memiliki halaman Promo serta alur Login Admin → Admin Panel. Data produk dan promo masih menggunakan data lokal sementara. Tampilan aplikasi sudah dibuat responsif dan navigasi antarhalaman dapat berjalan tanpa crash pada penggunaan normal.

- **Macet** — Pengujian pada konfigurasi layar besar belum dilakukan menggunakan emulator tablet karena keterbatasan kapasitas penyimpanan perangkat. Pengujian sementara dilakukan dengan mengubah ukuran layar emulator yang sama. Kendala utamanya adalah penggunaan storage dan resource yang cukup besar jika harus menambahkan emulator tablet baru.

- **Keputusan** — Struktur project dipisahkan menjadi `models`, `data`, `screens`, `widgets`, dan `theme` agar tampilan tidak bercampur dengan model dan sumber data. Struktur ini dipilih supaya pengembangan pada Gate 2 lebih mudah ketika data lokal mulai diganti dengan REST API dan penyimpanan lokal. Alternatif menempatkan seluruh kode di `main.dart` tidak digunakan karena akan membuat kode lebih sulit dikelola ketika fitur bertambah.

- **AI** — Saya menggunakan AI terutama untuk membantu menyusun struktur awal project, memperbaiki beberapa bagian kode Flutter, membuat tampilan lebih rapi dan responsif, serta membantu ketika terjadi error pada emulator, Gradle, dan testing. Salah satu prompt yang saya gunakan adalah: **"oke yuk lanjutin untuk gate 1 ini"**. Setelah itu saya tetap menyesuaikan sendiri alur aplikasi, tampilan MILKY Bakery, data produk, login admin, dan beberapa bagian navigasi agar sesuai dengan konsep aplikasi yang saya buat. Saya juga menjalankan dan mengecek kembali hasilnya di emulator supaya kode yang digunakan benar-benar berjalan dan saya pahami.

Video Demo: [tautan YouTube Unlisted ditambahkan sebelum Gate 1 dikumpulkan]