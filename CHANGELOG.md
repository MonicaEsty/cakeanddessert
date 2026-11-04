# CHANGELOG

## Gate 1 — Fondasi

- **Jadi** — Aplikasi Cake & Dessert Catalog berbasis Flutter sudah memiliki alur utama Home → Katalog → Detail Produk → Pesan via WhatsApp. Aplikasi juga memiliki halaman Promo serta alur Login Admin → Admin Panel. Data produk dan promo masih menggunakan data lokal sementara. Navigasi antarhalaman dapat berjalan tanpa crash dan tampilan sudah diuji pada ponsel portrait, landscape, serta jendela lebar.

- **Macet** — Selama pengembangan, Android Emulator sempat gagal startup dan tidak terdeteksi oleh Flutter. Proses build juga sempat gagal setelah penambahan `url_launcher` karena masalah Kotlin incremental cache. Selain itu, pengujian menggunakan emulator tablet tidak dilanjutkan karena keterbatasan storage dan resource perangkat, sehingga pengujian layar lebar dilakukan melalui jendela Chrome. Kendala emulator dan build berhasil ditangani dengan membersihkan cache, melakukan clean build, serta menjalankan ulang emulator.

- **Keputusan** — Struktur project dipisahkan menjadi `models`, `data`, `screens`, `widgets`, dan `theme` agar tampilan tidak bercampur dengan model dan sumber data. Struktur ini dipilih supaya pengembangan pada Gate 2 lebih mudah ketika data lokal mulai diganti dengan REST API dan penyimpanan lokal. Alternatif menempatkan seluruh kode di `main.dart` tidak digunakan karena akan membuat kode lebih sulit dikelola ketika fitur bertambah.

- **AI** — Saya menggunakan AI untuk membantu menyusun struktur awal project, memperbaiki beberapa bagian kode Flutter, merapikan tampilan responsif, serta membantu ketika terjadi error pada emulator, Gradle, dan testing. Salah satu prompt yang saya gunakan adalah: **"oke yuk lanjutin untuk gate 1 ini"**. Setelah menerima hasilnya, saya menyesuaikan sendiri alur aplikasi, tampilan MILKY Bakery, data produk, login admin, dan navigasi agar sesuai dengan konsep aplikasi dan kebutuhan Gate 1. Saya juga menjalankan serta mengecek kembali hasil implementasinya di emulator untuk memastikan fitur berjalan dan kode yang digunakan dapat saya pahami.

Video Demo: [YouTube Unlisted](https://youtu.be/lJMOfEwzXjk)

Video Demo: [YouTube Unlisted](https://youtu.be/lJMOfEwzXjk)
