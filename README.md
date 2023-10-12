# Aplikasi Simpel Whatsapp Api
Repositori ini berisi kode untuk menghubungkan aplikasi Anda ke WhatsApp melalui API. Dengan menggunakan repositori ini, Anda dapat mengirim pesan WhatsApp dari aplikasi Anda dengan cara yang mudah dan terotomatisasi.

Repositori ini menggunakan whatsapp-web.js untuk berinteraksi dengan WhatsApp, express sebagai server, dan qrcode-terminal untuk menampilkan kode QR yang diperlukan untuk mengautentikasi dengan WhatsApp.

## Penggunaan

1. Instal Node.js
Node.js adalah lingkungan runtime JavaScript yang diperlukan untuk menjalankan aplikasi Node.js. Anda dapat mengunduh installer Node.js dari situs resmi Node.js di https://nodejs.org/ dan ikuti panduan instalasi yang sesuai dengan sistem operasi Anda (Windows, macOS, atau Linux).

2. Unduh Kode Sumber Aplikasi
Unduh atau klon kode sumber aplikasi Anda ke komputer Anda. Pastikan Anda memiliki salinan kode sumber aplikasi yang telah Anda sebutkan dalam pertanyaan Anda.

3. Konfigurasi File .env
Di dalam direktori kode sumber aplikasi Anda, pastikan Anda memiliki file .env. Anda perlu mengisi variabel-variabel yang diperlukan, yaitu Nomor_ADMIN, SECRET_APP DAN PORT. Gantilah "nomor_admin_anda", "kode_rahasia_anda" dan "port_yang_ingin_digunakan" dengan nilai sesuai dengan konfigurasi yang diperlukan. Contoh isi dari file .env mungkin seperti ini:
```bash
Nomor_ADMIN=nomor_admin_anda
SECRET_APP=kode_rahasia_anda
PORT=port_yang_ingin_digunakan
```

4. Buka Command Prompt (CMD)
Buka Command Prompt (CMD) di sistem Anda. Anda dapat melakukan ini dengan mencari "CMD" di menu Start (Windows) atau menggunakan terminal (Linux/macOS).

5. Navigasi ke Direktori Aplikasi
Gunakan perintah cd untuk menavigasi ke direktori di mana Anda menyimpan kode sumber aplikasi.Pastikan Anda sudah berada di direktori yang berisi file app.js dan file lain yang dibutuhkan. Misalnya:

```bash
cd /path/ke/direktori/aplikasi-anda
```

6.  Instal Dependensi
Gunakan perintah npm install untuk menginstal semua dependensi yang diperlukan oleh aplikasi Anda. Pastikan Anda memiliki koneksi internet yang aktif saat menjalankan perintah ini karena npm akan mengunduh dependensi dari registry npm.

```
npm install
```
7. Menjalankan Aplikasi
Setelah Anda menginstal dependensi, Anda dapat menjalankan aplikasi dengan perintah node app.js atau dengan mengklik file start.bat yang tersedia di dalam folder.

```
node app.js
```
8. Jika semuanya dikonfigurasi dengan benar dan tidak ada kesalahan, aplikasi Anda seharusnya akan mulai berjalan. Anda dapat mengaksesnya melalui peramban web Anda dengan membuka alamat secara default jika port tidak di atur akan berjalan di  http://localhost:180 jika sudah anda atur maka aplikasi akan berjalan sesuai dengan port yang anda atur. Pastikan untuk memeriksa konsol (Command Prompt) di mana Anda menjalankan aplikasi untuk melihat log dan pesan yang dihasilkan oleh aplikasi Anda.

Dengan mengikuti langkah-langkah di atas, Aplikasi akan mulai berjalan dan siap digunakan. Anda dapat mengirim permintaan POST ke /message dengan body JSON yang berisi secretApp, phoneNumber, dan message untuk mengirim pesan WhatsApp.

## API Endpoint
- POST /message
Mengirim pesan WhatsApp ke nomor yang ditentukan.

- Permintaan
Body JSON:
secretApp (String): Kode rahasia untuk otorisasi.
phoneNumber (String): Nomor telepon tujuan.
message (String): Pesan yang akan dikirim.

- Respon
Status 200: Pesan berhasil terkirim.
Status 500: Kesalahan dalam proses pengiriman pesan atau kode rahasia tidak cocok.

### Command Prompt Windows (Curl)
Anda dapat menggunakan perintah curl di Command Prompt Windows untuk mengirim permintaan POST ke endpoint /message. Pastikan Anda telah menginstal curl di sistem Anda sebelum melanjutkan. Berikut adalah contoh penggunaannya:
Buka Command Prompt Windows.
Gunakan perintah berikut untuk mengirim permintaan POST:
```
curl -X POST http://localhost:180/message -H "Content-Type: application/json" -d "{\"secretApp\":\"isi dengan secret\",\"phoneNumber\":\"isi dengan nomor\",\"message\":\"isi pesan\"}"
```

Pastikan untuk menggantikan "isi dengan secret," "isi dengan nomor," dan "isi pesan" dengan nilai yang sesuai.

### MikroTik
Anda dapat menggunakan MikroTik Script untuk mengirim permintaan POST ke endpoint /message. Pastikan Anda telah menggantikan "isi dengan secret," "isi dengan nomor," dan "isi pesan" dengan nilai yang sesuai. Berikut adalah contoh penggunaannya:

```
:local apiwa "http://localhost:180/message"
:local secret "isi dengan secret"
:local nomor "isi dengan nomor"
:local pesan "isi pesan"

/tool fetch url=($apiwa) mode=http \
     http-method=post \
     http-header-field="Content-Type: application/json" \
     http-data="{\"secretApp\":\"$secret\",\"phoneNumber\":\"$nomor\",\"message\":\"$pesan\"}" \
     keep-result=no
```
Dengan perintah ini, Anda dapat mengirim permintaan POST ke endpoint WhatsApp API yang telah Anda atur.

Pastikan Anda telah menggantikan semua nilai yang sesuai dengan konfigurasi Anda sebelum menjalankan perintah. Juga, pastikan bahwa MikroTik Anda memiliki akses internet dan dapat mencapapai endpoint WhatsApp API yang telah Anda atur.
