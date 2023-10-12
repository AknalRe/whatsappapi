# whatsappapi
Deskripsi
Repositori ini berisi kode untuk menghubungkan aplikasi Anda ke WhatsApp melalui API. Dengan menggunakan repositori ini, Anda dapat mengirim pesan WhatsApp dari aplikasi Anda dengan cara yang mudah dan terotomatisasi.

Repositori ini menggunakan whatsapp-web.js untuk berinteraksi dengan WhatsApp, express sebagai server, dan qrcode-terminal untuk menampilkan kode QR yang diperlukan untuk mengautentikasi dengan WhatsApp.

Penggunaan
Untuk menggunakan repositori ini, Anda perlu melakukan beberapa langkah berikut:

Pastikan Anda telah mengatur file .env dengan variabel-variabel berikut:

Nomor_ADMIN: Nomor admin yang akan menerima pesan.
SECRET_APP: Kode rahasia yang digunakan untuk mengamankan akses ke API ini.
Instal dependensi dengan menjalankan npm install atau yarn install.

Jalankan server dengan menjalankan npm start atau yarn start.

Aplikasi akan mulai berjalan dan siap digunakan. Anda dapat mengirim permintaan POST ke /message dengan body JSON yang berisi secretApp, phoneNumber, dan message untuk mengirim pesan WhatsApp.

API Endpoint
POST /message
Mengirim pesan WhatsApp ke nomor yang ditentukan.

Permintaan
Body JSON:
secretApp (String): Kode rahasia untuk otorisasi.
phoneNumber (String): Nomor telepon tujuan.
message (String): Pesan yang akan dikirim.
Respon
Status 200: Pesan berhasil terkirim.
Status 500: Kesalahan dalam proses pengiriman pesan atau kode rahasia tidak cocok.
Kontribusi
Anda sangat diundang untuk berkontribusi pada repositori ini dengan melaporkan masalah atau mengirimkan permintaan tarik. Kami selalu menghargai kontribusi dari komunitas.

Lisensi
Lisensi: MIT License
