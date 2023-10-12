<!DOCTYPE html>
<html>
<head>
    <title>Panduan Integrasi WhatsApp API</title>
</head>
<body>
    <h1>Panduan Integrasi WhatsApp API</h1>
    <p>Repositori ini berisi kode untuk menghubungkan aplikasi Anda ke WhatsApp melalui API. Dengan menggunakan repositori ini, Anda dapat mengirim pesan WhatsApp dari aplikasi Anda dengan cara yang mudah dan terotomatisasi.</p>

    <h2>Repositori Ini Menggunakan:</h2>
    <ul>
        <li>whatsapp-web.js untuk berinteraksi dengan WhatsApp.</li>
        <li>express sebagai server.</li>
        <li>qrcode-terminal untuk menampilkan kode QR yang diperlukan untuk mengautentikasi dengan WhatsApp.</li>
    </ul>

    <h2>Cara Menggunakan:</h2>
    <ol>
        <li><strong>Instal Node.js</strong></li>
        <p>Node.js adalah lingkungan runtime JavaScript yang diperlukan untuk menjalankan aplikasi Node.js. Anda dapat mengunduh installer Node.js dari situs resmi Node.js di <a href="https://nodejs.org/" target="_blank">https://nodejs.org/</a> dan ikuti panduan instalasi yang sesuai dengan sistem operasi Anda (Windows, macOS, atau Linux).</p>
        
        <li><strong>Unduh Kode Sumber Aplikasi</strong></li>
        <p>Unduh atau klon kode sumber aplikasi Anda ke komputer Anda. Pastikan Anda memiliki salinan kode sumber aplikasi yang telah Anda sebutkan dalam pertanyaan Anda.</p>
        
        <li><strong>Konfigurasi .env File</strong></li>
        <p>Di dalam direktori kode sumber aplikasi Anda, pastikan Anda memiliki file .env. Anda perlu mengisi variabel-variabel yang diperlukan, yaitu Nomor_ADMIN dan SECRET_APP. Contoh isi dari file .env mungkin seperti ini:</p>
        <pre>
Nomor_ADMIN=nomor_admin_anda
SECRET_APP=kode_rahasia_anda
        </pre>
        <p>Gantilah "nomor_admin_anda" dan "kode_rahasia_anda" dengan nilai sesuai dengan konfigurasi yang diperlukan.</p>
        
        <li><strong>Buka Command Prompt (CMD)</strong></li>
        <p>Buka Command Prompt (CMD) di sistem Anda. Anda dapat melakukan ini dengan mencari "CMD" di menu Start (Windows) atau menggunakan terminal (Linux/macOS).</p>
        
        <li><strong>Navigasi ke Direktori Aplikasi</strong></li>
        <p>Gunakan perintah cd untuk menavigasi ke direktori di mana Anda menyimpan kode sumber aplikasi. Misalnya:</p>
        <pre>
cd /path/ke/direktori/aplikasi-anda
        </pre>
        <p>Pastikan Anda sudah berada di direktori yang berisi file app.js dan file lain yang dibutuhkan.</p>
        
        <li><strong>Instal Dependensi</strong></li>
        <p>Gunakan perintah npm install untuk menginstal semua dependensi yang diperlukan oleh aplikasi Anda. Pastikan Anda memiliki koneksi internet yang aktif saat menjalankan perintah ini karena npm akan mengunduh dependensi dari registry npm.</p>
        <pre>
npm install
        </pre>
        <li><strong>Menjalankan Aplikasi</strong></li>
        <p>Setelah Anda menginstal dependensi, Anda dapat menjalankan aplikasi dengan perintah node app.js atau dengan mengklik file start.bat jika Anda memiliki file batch yang telah diatur.</p>
        <pre>
node app.js
        </pre>
        <p>Jika semuanya dikonfigurasi dengan benar dan tidak ada kesalahan, aplikasi Anda seharusnya akan mulai berjalan. Anda dapat mengaksesnya melalui peramban web Anda dengan membuka alamat <a href="http://localhost:180" target="_blank">http://localhost:180</a> jika Anda telah mengatur server untuk mendengarkan pada port 180.</p>
        
        <p>Pastikan untuk memeriksa konsol (Command Prompt) di mana Anda menjalankan aplikasi untuk melihat log dan pesan yang dihasilkan oleh aplikasi Anda.</p>
    </ol>
    
    <h2>Untuk Menggunakan Repositori Ini:</h2>
    <p>Anda perlu melakukan beberapa langkah berikut:</p>
    <ol>
        <li>Pastikan Anda telah mengatur file .env dengan variabel-variabel berikut:</li>
        <ul>
            <li><strong>Nomor_ADMIN:</strong> Nomor admin yang akan menerima pesan.</li>
            <li><strong>SECRET_APP:</strong> Kode rahasia yang digunakan untuk mengamankan akses ke API ini.</li>
        </ul>
        <li>Instal dependensi dengan menjalankan <code>npm install</code> atau <code>yarn install</code>.</li>
        <li>Jalankan server dengan menjalankan <code>npm start</code> atau <code>yarn start</code>.</li>
    </ol>
    
    <p>Aplikasi akan mulai berjalan dan siap digunakan. Anda dapat mengirim permintaan POST ke <code>/message</code> dengan body JSON yang berisi <code>secretApp</code>, <code>phoneNumber</code>, dan <code>message</code> untuk mengirim pesan WhatsApp.</p>
    
    <h2>API Endpoint</h2>
    <p><strong>POST /message</strong></p>
    <p>Mengirim pesan WhatsApp ke nomor yang ditentukan.</p>
    
    <h3>Permintaan</h3>
    <p>Body JSON:</p>
    <pre>
{
    "secretApp": "KodeRahasiaAnda",
    "phoneNumber": "NomorTujuan",
    "message": "PesanAnda"
}
    </pre>
    
    <h3>Respon</h3>
    <p>Status 200: Pesan berhasil terkirim.</p>
    <p>Status 500: Kesalahan dalam proses pengiriman pesan atau kode rahasia tidak cocok.</p>
    
    <h2>Command Prompt Windows (Curl)</h2>
    <p>Anda dapat menggunakan perintah curl di Command Prompt Windows untuk mengirim permintaan POST ke endpoint <code>/message</code>. Pastikan Anda telah menginstal curl di sistem Anda sebelum melanjutkan. Berikut adalah contoh penggunaannya:</p
    <ol>
        <li>Buka Command Prompt Windows.</li>
        <li>Gunakan perintah berikut untuk mengirim permintaan POST:</li>
        <pre>
curl -X POST http://localhost:180/message -H "Content-Type: application/json" -d "{\"secretApp\":\"IsiDenganSecret\",\"phoneNumber\":\"IsiDenganNomor\",\"message\":\"IsiPesan\"}"
        </pre>
        <p>Pastikan untuk menggantikan "IsiDenganSecret," "IsiDenganNomor," dan "IsiPesan" dengan nilai yang sesuai.</p>
    </ol>
    
    <h2>MikroTik</h2>
    <p>Anda dapat menggunakan MikroTik Script untuk mengirim permintaan POST ke endpoint <code>/message</code>. Pastikan Anda telah menggantikan "IsiDenganSecret," "IsiDenganNomor," dan "IsiPesan" dengan nilai yang sesuai. Berikut adalah contoh penggunaannya:</p>
    <pre>
:local apiwa "http://localhost:180/message"
:local secret "IsiDenganSecret"
:local nomor "IsiDenganNomor"
:local pesan "IsiPesan"

/tool fetch url=($apiwa) mode=http \
     http-method=post \
     http-header-field="Content-Type: application/json" \
     http-data="{\"secretApp\":\"$secret\",\"phoneNumber\":\"$nomor\",\"message\":\"$pesan\"}" \
     keep-result=no
    </pre>
    
    <p>Dengan perintah ini, Anda dapat mengirim permintaan POST ke endpoint WhatsApp API yang telah Anda atur.</p>
    
    <p>Pastikan Anda telah menggantikan semua nilai yang sesuai dengan konfigurasi Anda sebelum menjalankan perintah. Juga, pastikan bahwa MikroTik Anda memiliki akses internet dan dapat mencapai endpoint WhatsApp API yang telah Anda atur.</p>
    
    <h2>Kontribusi</h2>
    <p>Anda sangat diundang untuk berkontribusi pada repositori ini dengan melaporkan masalah atau mengirimkan permintaan tarik. Kami selalu menghargai kontribusi dari komunitas.</p>
    
    <h2>Lisensi</h2>
    <p>Lisensi: MIT License</p>
</body>
</html>
