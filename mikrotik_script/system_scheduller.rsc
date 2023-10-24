/system scheduler
add interval=7s name=wa_getupdate on-event="/system script run wa_getupdate" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=oct/14/2023 start-time=14:20:06
add interval=1d10s name=wa_tagihan on-event=":local hariini [/system clock get\
    \_date];\r\
    \n:local timeini [/system clock get time];\r\
    \n\r\
    \n:local timestamp (\"\$hariini / \$timeini\");\r\
    \n:put \$timestamp;\r\
    \n\r\
    \n:global tnggaltagihan;\r\
    \n:global tnggalpengingat;\r\
    \n:global pesanoutbox;\r\
    \n\r\
    \n\r\
    \n:if (\$hariini~\"/\$tnggaltagihan/\") do={\r\
    \n  :log warning \"Data tanggal sekarang \$hariini sama dengan data tangga\
    l tagihan \$tnggaltagihan. Memproses pengiriman tagihan.\";\r\
    \n  :set pesanoutbox \"Waktu Sekarang \$timestamp\\\\n\\\\nTanggal sesuai \
    dengan ketentuan tanggal tagihan yaitu \$tnggaltagihan. Memproses pengirim\
    an tagihan.\";\r\
    \n  /system script run wa_fetch_pesan;\r\
    \n  /system script run wa_template_tagihan_pppoe;\r\
    \n} else={\r\
    \n  :set \$hariini \"Bukan Tanggal \$tnggaltagihan\";\r\
    \n  :put \$hariini;\r\
    \n\r\
    \n  :if (\$hariini~\"/\$tnggalpengingat/\") do={\r\
    \n    :log warning \"Data tanggal sekarang \$hariini sama dengan data tang\
    gal penggingat tagihan \$tnggalpengingat. Memproses pengiriman penggingat \
    tagihan.\";\r\
    \n    :set pesanoutbox \"Waktu Sekarang \$timestamp\\\\n\\\\nTanggal sesua\
    i dengan ketentuan tanggal pengingat tagihan yaitu \$tnggalpengingat. Memp\
    roses pengiriman penginggat tagihan.\";\r\
    \n    /system script run wa_fetch_pesan;\r\
    \n    /system script run wa_template_penginggat_pppoe;\r\
    \n  } else={\r\
    \n    :set \$hariini \"Bukan Tanggal \$tnggalpengingat\";\r\
    \n    :put \$hariini;\r\
    \n  };\r\
    \n};" policy=read,write,policy,test,sensitive start-date=jun/01/2023 \
    start-time=00:00:00