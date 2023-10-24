const { Client, LocalAuth, Buttons, List, MessageMedia, MessageTypes } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const bodyParser = require('body-parser'); 
const express = require('express');
const http = require('http');
require('dotenv').config();
const app = express();
const path = require('path');


let nomoradmin = process.env.Nomor_ADMIN || '';
let secret = process.env.SECRET_APP || '';
let port = parseInt(process.env.PORT || 180);
let isadmin;
let nameisadmin;
let pesanadmin = '';
 
// Middleware untuk mem-parsa body dari request sebagai JSON
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// Membuat instance dari client WhatsApp
const client = new Client({
  authStrategy: new LocalAuth({
    clientId: 'client1'
  }),
  puppeteer: {
    platform: 'linux',
    headless: true,
    ignoreHTTPSErrors: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-extensions",
      '--disable-gpu',
      "--disable-accelerated-2d-canvas",
      "--no-first-run",
      "--no-zygote",
      '--disable-dev-shm-usage'
    ],
  },
});

// Event saat berhasil terautentikasi
client.on('authenticated', (session) => {
  console.log('\x1b[31m%s\x1b[0m', 'Session WhatsApp Sudah Terhubung.');
});

// Event saat perlu melakukan scan kode QR
client.on('qr', (qrCode) => {
  console.log('Scan kode QR ini di WhatsApp Anda:');
  qrcode.generate(qrCode, { small: true });
});

// Fungsi untuk memformat nomor telepon
function formatPhoneNumber(number) {
  number = number.replace(/@c.us/g, '');
  number = number.replace(/\s+/g, ''); // Menghapus semua spasi
  // Memeriksa apakah awalan adalah '0' atau '62', jika bukan, ubah menjadi '62'
  if (!number.startsWith('0') && !number.startsWith('62')) {
    number = '62' + number;
  }
  if (number.startsWith('62')) {
    number = '0' + number.substr(2);
  }
  number = number.replace(/[\s-+]+/g, ''); // Menghapus spasi, '-', dan '+'
  if (number.startsWith('0')) {
    number = '62' + number.substr(1);
  }
  return number;
}

function formatmessagefrom(number) {
  // Gunakan metode .replace() dengan ekspresi reguler untuk menghapus @c.us
  return number.replace(/@c\.us$/, '');
}

// Fungsi untuk menghapus pesanadmin
function clearPesanAdmin() {
  pesanadmin = ''; // Mengosongkan pesanadmin
  console.log('Pesan Admin telah dihapus.');
}

function gantiTanda(message) {
  message = message.replace(/{silang}/g, '❌');
  message = message.replace(/{centang}/g, '✅');
  return message;
}

// setInterval(clearPesanAdmin, 15000);

// Event saat client siap digunakan
client.on('ready', async () => {
  console.log('\x1b[31m%s\x1b[0m', 'WhatsApp sudah terhubung.');
  const tujuan = formatPhoneNumber(nomoradmin);
  client.sendMessage(`${tujuan}@c.us`, 'WhatsApp sudah terhubung.');
});

client.on('message', async message => {
//   console.log(message);
  // isadmin = (message.from || message_data.from).replace(/@c\.us$/, '');
  isadmin = formatmessagefrom(message.from || message._data.from);
  console.log(`Nomor WA ADMIN : ${isadmin}`)
  if (isadmin === formatPhoneNumber(nomoradmin) && message.from.length < 19) {
    nameisadmin = message._data.notifyName || message.author;
    pesanadmin = message.body || message._data.body;
    console.log(`Nama WA ADMIN : ${nameisadmin}`);
    console.log(`Isi Pesan : ${pesanadmin}`);
  } else {
    console.log(`Pesan Bukan Dari Nomor Admin`);
  }
})

app.get(`/logpesan/${formatPhoneNumber(nomoradmin)}/:secretApp`, async (req, res) => {
  try {
    const secretApp = req.params.secretApp;
    if (secretApp === secret) {
      res.send(`${pesanadmin}`);
    } else {
      res.send(`secret kode tidak sama`);
    }
  } catch {
    res.send('ERROR')
  }
})

app.get('/image', (req, res) => {
  const folderPath = path.join(__dirname, 'public/image'); // Ganti dengan path folder Anda
  res.sendFile(folderPath);
});

app.get('/image/:imageName', (req, res) => {
  const imageName = req.params.imageName;
  const imagePath = path.join(__dirname, 'public/image', imageName); // Ganti dengan path folder dan gambar Anda
  res.sendFile(imagePath);
});

app.get('/error', (req, res) => {
  const html = `
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: auto;
}
</style>

</head>

<img src="http://vpn.aknalre.my.id:120/image/expired.png" alt="isolir belum bayar tagihan" class="center" width=450px height=310px>
<br>
<div class="center">
<center>
<h2>Internet Dinonaktifkan Sementara</h2>
          <p>
              Pelanggan yang terhormat,<br><br>
              Kami informasikan bahwa layanan internet Anda saat ini <b>terisolir (dimatikan sementara)</b>.<br><br>
              Dimohon untuk <b>melakukan pembayaran tagihan</b>, supaya internet <b>kembali normal</b>.<br><br>
              Guna menghindari ketidaknyamanan ini,<br>
              dimohon untuk melakukan pembayaran sebelum tanggal jatuh tempo.<br><br>
              Terimakasih
          </p></center>
</div>
</body></html>
`;

  res.send(html); // Mengirimkan HTML sebagai respons
});

// Endpoint GET untuk mengirim pesan WhatsApp
app.get('/message', async (req,res) => {
  try {
    const { secretApp, phoneNumber, message } = req.query;
    if (secretApp === secret) {
      const formattedPhoneNumber = formatPhoneNumber(phoneNumber);
      await client.sendMessage(`${formattedPhoneNumber}@c.us`, message);

      res.status(200).json({ success: true, message: 'Pesan terkirim.' });
    } else {
      res.status(500).json({ success: false, message: 'secretApp tidak cocok' });
    }
  } catch {
    console.error('Error:', error.message);
    res.status(500).json({ success: false, error: error.message });
  }
})

app.post('/hapuspesan/:secretApp', async (req, res) => {
  const secretApp = req.params.secretApp;
  if (secretApp === secret) {
    clearPesanAdmin()
    res.status(200).json({ success: true, message: 'Pesan Admin Berhasil Di Hapus' })
  }
})

// Endpoint POST untuk mengirim pesan WhatsApp
app.post('/message', async (req, res) => {
  try {
    const { secretApp, phoneNumber, message } = req.body;
    if (secretApp === secret){
        console.log(`Phone Number : ${phoneNumber}`)
        console.log(`Message : ${message.replace(/(\n|\t|\r)/g, (match) => {
          if (match === '\n') return '\\n';
          if (match === '\t') return '\\t';
          if (match === '\r') return '\\r';
        })}`)
        // Format nomor telepon jika diperlukan
        const formattedPhoneNumber = formatPhoneNumber(phoneNumber);

        // Kirim pesan WhatsApp
        await client.sendMessage(`${formattedPhoneNumber}@c.us`, gantiTanda(message));

        res.status(200).json({ success: true, message: 'Pesan terkirim.' });
    } else {
        res.status(500).json({ success: false, message: 'secretApp tidak cocok' });
    }
  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({ success: false, error: error.message });
  }
});

// Definisikan fungsi untuk mencoba port yang berbeda jika port sudah digunakan
function startServer(port) {
  const server = http.createServer(app);

  server.on('error', (error) => {
    if (error.code === 'EADDRINUSE') {
      // Port sudah digunakan, coba port yang berbeda secara acak
      console.log('\x1b[31m%s\x1b[0m', `Port ${port} sudah digunakan. Mencoba port lain...`);
      // Fungsi untuk mendapatkan angka acak antara 1024 dan 65535 (rentang port yang valid)
      function getRandomPort() {
        return Math.floor(Math.random() * (65535 - 1024 + 1)) + 1024;
      }

      // Menggunakan angka acak untuk menambahkan port
      let randomPort = getRandomPort();
      startServer(port + randomPort); // Mencoba port berikutnya
    } else {
      console.error('Kesalahan lain:', error);
    }
  });

  server.on('listening', () => {
    console.log(`Server berjalan di port ${server.address().port}`);
  });

  server.listen(port);
}

// Inisialisasi Server
startServer(port);
// Inisialisasi client WhatsApp
client.initialize();
