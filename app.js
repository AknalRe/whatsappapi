const { Client, LocalAuth, Buttons, List, MessageMedia } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const express = require('express');
require('dotenv').config();
const app = express();
const port = 180;

let nomoradmin = process.env.Nomor_ADMIN || '';
let secret = process.env.SECRET_APP || '';

// Middleware untuk mem-parsa body dari request sebagai JSON
app.use(express.json());

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
  console.log('\x1b[31m%s\x1b[0m', 'Client1 Session WhatsApp Sudah Terhubung.');
});

// Event saat perlu melakukan scan kode QR
client.on('qr', (qrCode) => {
  console.log('Client1 Scan kode QR ini di WhatsApp Anda:');
  qrcode.generate(qrCode, { small: true });
});

// Event saat client siap digunakan
client.on('ready', async () => {
  console.log('\x1b[31m%s\x1b[0m', 'Client1 WhatsApp sudah terhubung.');
  const tujuan = fixNumber(formatKarakter(format62(formatSpasi(nomoradmin))));
  client.sendMessage(`${tujuan}@c.us`, 'Client1 WhatsApp sudah terhubung.');
});

function formatNumber(number) {
  return number.replace(/@c.us/g, '');
}

function formatSpasi(number) {
  return number.replace(/\s+/g, ''); // Menghapus semua spasi dari nomor
}

// Fungsi untuk mengubah '62' di awal menjadi '0'
function format62(number) {
  if (number.startsWith('62')) {
    return '0' + number.substr(2);
  }
  return number;
}

// Fungsi untuk menghapus spasi, karakter '-', dan '+'
function formatKarakter(number) {
  return number.replace(/[\s-+]+/g, '');
}

function fixNumber(nomor){
    if (nomor.startsWith('0')) {
      return '62' + nomor.substr(1);
    }
    return nomor;
};

app.get('/', (req, res) => {
    res.send('Halo')
})

// Endpoint untuk mengirim pesan WhatsApp
app.post('/message', async (req, res) => {
  try {
    const { secretApp, phoneNumber, message } = req.body;
    if (secretApp === secret){
        console.log(`Phone Number : ${phoneNumber}`)
        console.log(`Message : ${message}`)
        // Format nomor telepon jika diperlukan
        const formattedPhoneNumber = fixNumber(formatKarakter(format62(formatSpasi(phoneNumber))));

        // Kirim pesan WhatsApp
        await client.sendMessage(`${formattedPhoneNumber}@c.us`, message);

        res.status(200).json({ success: true, message: 'Pesan terkirim.' });
    } else {
        res.status(500).json({ success: false, message: 'secretApp tidak cocok' });
    }
  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({ success: false, error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server berjalan di port ${port}`);
});

// Inisialisasi client WhatsApp
client.initialize();