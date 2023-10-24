/system script
add dont-require-permissions=yes name=wa_secret owner=Renaldi policy=\
    read,write,policy,test,sensitive source="# SCRIPT BOT WHATSAPP AknalRE\r\
    \n\r\
    \n:global header \"*-----Pesan Otomatis-----*\";\r\
    \n:global footer \"*-----Pesan Otomatis-----*\"\r\
    \n\r\
    \n:global nomoradmin \"6285155431301\";\r\
    \n:global secret \"Contoh123\";\r\
    \n:global interfacewan \"ether1\";\r\
    \n:global nameisp \"INDIHOME\";\r\
    \n:global tnggaltagihan \"5\";\r\
    \n:global tnggalpengingat \"1\";\r\
    \n:global count 0;\r\
    \n:global delaypesan \"10\";\r\
    \n:global outinttoclient \"LAN\";\r\
    \n\r\
    \n:global namaadmin \"Renaldi\";\r\
    \n:global infoadmin \"*\$namaadmin*\\\\nhttps://wa.me/\$nomoradmin\";\r\
    \n\r\
    \n:local url \"http://vpn.aknalre.my.id\";\r\
    \n:local port \":120\";\r\
    \n\r\
    \n:if ([:len \$port] = 0) do={\r\
    \n  :global urlapi (\$url);\r\
    \n} else={\r\
    \n  :global urlapi (\$url . \$port);\r\
    \n}"
add dont-require-permissions=yes name=wa_getupdate owner=Renaldi policy=\
    read,write,policy,test,sensitive source="# SCRIPT BOT WHATSAPP AknalRE\r\
    \n\r\
    \n:global urlapi;\r\
    \n:global nomoradmin;\r\
    \n:global secret;\r\
    \n:global pesanoutbox;\r\
    \n:global uptimemikrotik;\r\
    \n:global count;\r\
    \n\r\
    \n:global pesanenabledisable;\r\
    \n:global pesanblokir;\r\
    \n:global pesanbroadcast;\r\
    \n:global pesanisolir;\r\
    \n:global stringwaktu;\r\
    \n\r\
    \n:local i (\$count + 1);\r\
    \n:local delayreply \"3\";\r\
    \n\r\
    \n:local endpoint \"/logpesan/\$nomoradmin/\$secret\";\r\
    \n:local urlfetch (\$urlapi . \$endpoint);\r\
    \n\r\
    \n:local response [/tool fetch output=user url=\$urlfetch http-method=get \
    as-value];\r\
    \n:local pesan (\$response->\"data\");\r\
    \n\r\
    \n  :if ([:len \$pesan] > 0) do={\r\
    \n    :set stringwaktu [:tostr ([system clock get date] . \"---\" . [syste\
    m clock get time])];\r\
    \n    :log warning \"Menerima Pesan Admin. Isi Pesan : \$pesan\";\r\
    \n    :delay (\$delayreply . \"s\");\r\
    \n    if (\$pesan = \".menu\") do={\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: \$pesan\\\\n\\\\nTelah Di Terima\"\
    );\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :local identityname [system identity get name];\r\
    \n      /system script run wa_uptime\r\
    \n      :delay (\$delayreply . \"s\");\r\
    \n      :set pesanoutbox \"Router Name: *\$identityname*\\\\nUptime : *\$u\
    ptimemikrotik*\\\\n\\\\nDaftar Menu : \\\\n\\\\nNo. *Deskripsi* | Perintah\
    \";\r\
    \n\r\
    \n      :local menuList;\r\
    \n      :local menuCount;\r\
    \n      :set menuCount 1;\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Informasi Mikrotik* | .s\
    tatus\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Kirim Tagihan PPPoE Manu\
    al* | .kirim_tagihan\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Kirim Pengingat Tagihan \
    PPPoE Manual* | .kirim_pengingat\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Kirim Broadcast Ke PPPoE\
    * |\\\\n\\\\tServiceINFO = GANGGUAN / MAINTENANCE / SELESAI / TEKS\\\\n\\\
    \\t\\\\tContoh :\\\\n\\\\t\\\\t- *GANGGUAN* :\\\\n\\\\t\\\\t\\\\t.broadcas\
    t|GANGGUAN|isi_tanggal|isi_waktu\\\\n\\\\t\\\\t- *MAINTENANCE* :\\\\n\\\\t\
    \\\\t\\\\t.broadcast|MAINTENANCE|isi_tanggal|isi_waktu\\\\n\\\\t\\\\t- *SE\
    LESAI* :\\\\n\\\\t\\\\t\\\\t.broadcast|SELESAI|isi_tanggal|isi_waktu\\\\n\
    \\\\t\\\\t- *TEKS*:\\\\n\\\\t\\\\t\\\\t.broadcast|TEKS|isi_pesan yang ingi\
    n di broadcast\\\\n\\\\n\\\\t\\\\t\\\\tCatatan : broadcast *TEKS* usahakan\
    \_teks bersifat general atau umum\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List Secret PPP* | .ac_p\
    pp_secret\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List Active PPP* | .ac_p\
    pp\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List Interface* | .ac_in\
    terface\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List Lease DHCP* | .ac_d\
    hcp\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List User Hotspot* | .ac\
    _user_hotspot\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Enable / Disable* | \\\\\
    n\\\\tService = interface / ppp / userhotspot \\\\n\\\\t\\\\t- *Enable*\\\
    \\n\\\\t\\\\t.enable|service|nama\\\\n\\\\t\\\\t- *Disable*\\\\n\\\\t\\\\t\
    .disable|service|nama\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Blokir Inet User* | .blo\
    kirinet|tambah atau hapus|ipaddress\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Isolir Inet User* | .iso\
    lir|tambah atau hapus|ipaddress\";\r\
    \n\r\
    \n      :while (\$i <= \$menuCount) do={\r\
    \n        :local menuItem (\$menuList->\"menu\$i\");\r\
    \n        :set pesanoutbox (\$pesanoutbox . \"\\\\n\$i. \$menuItem\");\r\
    \n        :set i (\$i + 1);\r\
    \n      }\r\
    \n      /system script run wa_fetch_pesan\r\
    \n    }\r\
    \n    if (\$pesan = \".status\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_status\r\
    \n    }\r\
    \n    if (\$pesan = \".kirim_tagihan\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      :set pesanoutbox (\"Memproses Pengiriman Tagihan PPPoE Secara Manu\
    al\");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_template_tagihan_pppoe\r\
    \n      :set pesanoutbox (\"Proses Pengiriman Sudah Selesai\");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n    }\r\
    \n    if (\$pesan = \".kirim_pengingat\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      :set pesanoutbox (\"Memproses Pengiriman Pengingat Tagihan PPPoE S\
    ecara Manual\");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_template_pengingat_pppoe\r\
    \n      :set pesanoutbox (\"Proses Pengiriman Sudah Selesai\");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n    }\r\
    \n    if (\$pesan~\"^.broadcast\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanbroadcast \$pesan;\r\
    \n      :local sisaPesan1 [:pick \$pesan ([:find \$pesan \"|\"] + 1) [:len\
    \_\$pesan]];\r\
    \n      :local pesan2 [:pick \$sisaPesan1 0 [:find \$sisaPesan1 \"|\"]];\r\
    \n      :local sisaPesan2 [:pick \$sisaPesan1 ([:find \$sisaPesan1 \"|\"] \
    + 1) [:len \$sisaPesan1]];\r\
    \n      :local pesan3 [:pick \$sisaPesan2 0 [:find \$sisaPesan2 \"|\"]];\r\
    \n      :local teksbroadcast [:pick \$sisaPesan1 ([:find \$sisaPesan1 \"|\
    \"] + 1) [:len \$sisaPesan1]];\r\
    \n      :local pesan4 [:pick \$sisaPesan2 ([:find \$sisaPesan2 \"|\"] + 1)\
    \_[:len \$sisaPesan2]];\r\
    \n      :set pesan [:pick \$pesan 0 [:find \$pesan \"|\"]];\r\
    \n      :if (\$pesan2 != \"TEKS\") do={\r\
    \n        :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nINFO Broadcas\
    t: *\$pesan2*\\\\nINFO TANGGAL: *\$pesan3*\\\\nINFO waktu: *\$pesan4*\\\\n\
    \\\\nTelah Di Terima\");\r\
    \n      } else={\r\
    \n        :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nINFO Broadcas\
    t: *\$pesan2*\\\\nPesan broadcast yang dikirimkan :\\\\n*\$teksbroadcast*\
    \\\\n\\\\nTelah Di Terima\");\r\
    \n      }\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      :set pesanoutbox (\"Memproses Pengiriman Broadcast *\$pesan2* Seca\
    ra Manual\");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_template_broadcast_pppoe\r\
    \n      :set pesanoutbox (\"Proses Pengiriman Broadcast *\$pesan2* Sudah S\
    elesai\");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_ppp_secret\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_list_secret_ppp\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_ppp\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_ppp\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_interface\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_interface\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_dhcp\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_dhcp\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_user_hotspot\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_userhotspot\r\
    \n    }\r\
    \n    if ((\$pesan~\"^.enable\") or (\$pesan~\"^.disable\")) do={\r\
    \n      :set pesanenabledisable \$pesan;\r\
    \n      :set pesan [:pick \$pesan 0 [:find \$pesan \"|\"]];\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_set_disable&enable\r\
    \n    }\r\
    \n    if (\$pesan~\"^.blokirinet\") do={\r\
    \n      :set pesanblokir \$pesan;\r\
    \n      :set pesan [:pick \$pesan 0 [:find \$pesan \"|\"]];\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_blokir_inet\r\
    \n    }\r\
    \n    if (\$pesan~\"^.isolir\") do={\r\
    \n      :set pesanisolir \$pesan;\r\
    \n      :set pesan [:pick \$pesan 0 [:find \$pesan \"|\"]];\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \");\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_isolir\r\
    \n    }\r\
    \n    /system script run wa_deleteinbox\r\
    \n} else={\r\
    \n  :put \"Pesan kosong atau tidak mengandung isi.\"\r\
    \n}\r\
    \n"
add dont-require-permissions=yes name=wa_fetch_pesan owner=Renaldi policy=\
    read,write,policy,test,sensitive source="# SCRIPT BOT WHATSAPP AknalRE\r\
    \n\r\
    \n:log warning \"Fetch Send Outbox Mikrotik To Whatsapp Api Berjalan\"\r\
    \n:global urlapi;\r\
    \n:global nomoradmin;\r\
    \n:global secret;\r\
    \n:global pesanoutbox;\r\
    \n:local endpoint \"/message\";\r\
    \n\r\
    \n:local apiwa (\$urlapi . \$endpoint);\r\
    \n\r\
    \n/tool fetch url=(\$apiwa) mode=http \\\r\
    \n     http-method=post \\\r\
    \n     http-header-field=\"Content-Type: application/json\" \\\r\
    \n     http-data=\"{\\\"secretApp\\\":\\\"\$secret\\\",\\\"phoneNumber\\\"\
    :\\\"\$nomoradmin\\\",\\\"message\\\":\\\"\$pesanoutbox\\\"}\" \\\r\
    \n     keep-result=no\r\
    \n\r\
    \n:set pesanoutbox \"\";"
add dont-require-permissions=yes name=wa_uptime owner=Renaldi policy=\
    read,write,policy,test,sensitive source="# Ambil Nilai Uptime Mikrotik\r\
    \n:local uptime [/system resource get uptime];\r\
    \n:local days \"\";\r\
    \n:local time \"\";\r\
    \n\r\
    \n:put (\"Ini Data Uptime Mikrotik: \".\$uptime);\r\
    \n\r\
    \n:if ([:find \$uptime \"d\"] > 0) do={\r\
    \n  :local dpos ([:find \$uptime \"d\"]);\r\
    \n  :set days ([:pick \$uptime 0 \$dpos]);\r\
    \n}\r\
    \n\r\
    \n:local wpos ([:find \$uptime \"w\"]);\r\
    \n:local dpos ([:find \$uptime \"d\"]);\r\
    \n:local tpos ([:find \$uptime \":\"]);\r\
    \n\r\
    \n:if (\$wpos > 0) do={\r\
    \n  :local weeks ([:pick \$uptime 0 \$wpos]);\r\
    \n  :local daysInWeeks (\$weeks * 7);\r\
    \n  :set days \$daysInWeeks;\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$uptime \":\"] > 0) do={\r\
    \n  :local tpos ([:find \$uptime \":\"]);\r\
    \n  :set time ([:pick \$uptime (\$tpos-2) ([:len \$uptime])]);\r\
    \n}\r\
    \n\r\
    \n:put (\"Ini Data Hari Mikrotik: \".\$days);\r\
    \n:put (\"Ini Data Jam Mikrotik: \".\$time);\r\
    \n\r\
    \n:global uptimemikrotik \"\";\r\
    \n\r\
    \n:if (\$days != \"\" && (\$days != \"0\")) do={\r\
    \n  :set uptimemikrotik (\$days . \" Hari \" . \$time);\r\
    \n} else={\r\
    \n  :set uptimemikrotik (\$time . \" Jam\");\r\
    \n}\r\
    \n\r\
    \n:put \$uptimemikrotik;\r\
    \n"
add dont-require-permissions=yes name=wa_status owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Status Berjalan\
    \";\r\
    \n\r\
    \n\r\
    \n:global interfacewan;\r\
    \n:global uptimemikrotik;\r\
    \n:global nameisp;\r\
    \n:global interfacewan;\r\
    \n:global pesanoutbox;\r\
    \n\r\
    \n/system script run wa_uptime\r\
    \n:delay 2s;\r\
    \n\r\
    \n:local response [/tool fetch output=user url=\"http://aknalre.my.id:4596\
    1/infoippublic\" http-method=post as-value];\r\
    \n:local ipaddress (\$response->\"data\");\r\
    \n\r\
    \n:local internetwan [/interface monitor-traffic \$interfacewan once as-va\
    lue];\r\
    \n:local txbitspersecond (\$internetwan->\"tx-bits-per-second\");\r\
    \n:local rxbitspersecond (\$internetwan->\"rx-bits-per-second\");\r\
    \n:local txmegabit ((\$txbitspersecond / 1250000).\"Mbps\");\r\
    \n:local rxmegabit ((\$rxbitspersecond / 1250000).\"Mbps\");\r\
    \n\r\
    \n:local identity [/system identity get name];\r\
    \n:local hariini ([/system clock get date] .\" | \" . [system clock get ti\
    me]);\r\
    \n# :local suhu ([system health pr as-value]);:set suhu ((\$suhu ->\"tempe\
    rature\").\"C\");\r\
    \n:local suhu ([/system health get [find name=\"temperature\"] value] . \"\
    C\")\r\
    \n:local freeram ([/system resource get free-memory]/1000000);\r\
    \n:local totalram ([/system resource get total-memory]/1000000);\r\
    \n:local ramterpakai (\$totalram - \$freeram . \"MB\");\r\
    \n:local cpu ([/system resource get cpu-load].\"%\");\r\
    \n:set totalram ([/system resource get total-memory]/1000000 . \"MB\");\r\
    \n\r\
    \n:local count \"20\";\r\
    \n:local dns [/ip dns get servers];\r\
    \n:local statusdns [ping \$dns count=\$count];\r\
    \n:if (\$statusdns = 0) do={\r\
    \n  :set statusdns \"GANGGUAN\";\r\
    \n} else={\r\
    \n  :if (\$statusdns < \$count) do={\r\
    \n    :set statusdns \"Tidak Stabil\";\r\
    \n  } else {\r\
    \n    :set statusdns \"Normal\";\r\
    \n  };\r\
    \n};\r\
    \n\r\
    \n:local download [/interface get [find name=\$interfacewan] rx-byte];\r\
    \n:local upload [/interface get [find name=\$interfacewan] tx-byte];\r\
    \n:local downloadGB [(\$download/1073741824)];\r\
    \n:local uploadGB [(\$upload/1073741824)];\r\
    \n:local TOTAL ([(\$downloadGB + \$uploadGB)].\"GB\");\r\
    \n\r\
    \n# :set pesanoutbox \"*----Informasi MikroTik----*\\\\n\\\\n- Tanggal Sek\
    arang: *\$hariini*\\\\n- Nama Router: *\$identity*\\\\n- Uptime: *\$uptime\
    mikrotik*\\\\n- Penggunaan CPU: *\$cpu*\\\\n- IP Address Publik: *\$ipaddr\
    ess*\\\\n- Suhu MikroTik: *\$suhu*\\\\n- Free RAM: *\$totalram*\\\\n- RAM \
    Terpakai: *\$ramterpakai*\\\\n\\\\n*---Status Koneksi & Kuota---*\\\\n- St\
    atus DNS: *\$statusdns*\\\\n--Penggunaan Internet--\\\\n\\\\t- Download: \
    \$downloadGB GB\\\\n\\\\t- Upload: \$uploadGB GB\\\\n- Total: *\$TOTAL*\\\
    \\n-- Penggunaan Internet (Mbps):\\\\n\\\\t- Download: *\$txmegabit*\\\\n\
    \\\\t- Upload: *\$rxmegabit*\";\r\
    \n\r\
    \n:set pesanoutbox \"*----Informasi MikroTik----*\\\\n\\\\n- Waktu : *\$ha\
    riini*\\\\n- Nama : *\$identity*\\\\n- Uptime: *\$uptimemikrotik*\\\\n- CP\
    U : *\$cpu*\\\\n- IP Publik : *\$ipaddress*\\\\n- Suhu : *\$suhu*\\\\n- Fr\
    ee RAM : *\$totalram*\\\\n- RAM Terpakai : *\$ramterpakai*\\\\n\\\\n*---St\
    atus Koneksi & Kuota---*\\\\n- Status DNS: *\$statusdns*\\\\n--Penggunaan \
    Internet--\\\\n\\\\t\\\\t- Download: \$downloadGB GB\\\\n\\\\t\\\\t- Uploa\
    d: \$uploadGB GB\\\\n\\\\t- Total: *\$TOTAL*\\\\n-- Penggunaan Internet (M\
    bps):\\\\n\\\\t- Download: *\$txmegabit*\\\\n\\\\t- Upload: *\$rxmegabit*\
    \";\r\
    \n\r\
    \n/system script run wa_fetch_pesan;"
add dont-require-permissions=yes name=wa_ac_ppp owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Ac_PPP Berjalan\
    \";\r\
    \n\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:local listppp;\r\
    \n:local pppList [ppp active print as-value];\r\
    \n:local pppCount 1;\r\
    \n\r\
    \n:if ([:len \$pppList] = 0) do={\r\
    \n  :set listppp \"Tidak Ada PPP Aktif\";\r\
    \n} else={\r\
    \n  :foreach pppEntry in=\$pppList do={\r\
    \n    :local pppProps [:toarray \$pppEntry];\r\
    \n\r\
    \n    :local name (\$pppProps->\"name\");\r\
    \n    :local address (\$pppProps->\"address\");\r\
    \n    :local service (\$pppProps->\"service\");\r\
    \n    :local uptime (\$pppProps->\"uptime\");\r\
    \n    :local comment (\$pppProps->\"comment\");\r\
    \n\r\
    \n    :local pppInfo \"\$pppCount. \$name | \$address | \$service | \$upti\
    me\";\r\
    \n\r\
    \n    :if ([:len \$comment] > 0) do={\r\
    \n      :set pppInfo (\$pppInfo . \" | \$comment\");\r\
    \n    }\r\
    \n\r\
    \n    :if ([:len \$listppp] > 0) do={\r\
    \n      :set listppp (\$listppp . \"\\\\n\" . \$pppInfo);\r\
    \n    } else={\r\
    \n      :set listppp \$pppInfo;\r\
    \n    }\r\
    \n    :set pppCount (\$pppCount + 1);\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:set listppp (\$listppp .\"\\\\n\");\r\
    \n\r\
    \n:set pesanoutbox \"*----Informasi PPP Active----*\\\\n\\\\nList\\\\t:\\\
    \\n\\\\nNo. Nama | Address | Service | Uptime | Comment\\\\n\$listppp\"\r\
    \n\r\
    \n/system script run wa_fetch_pesan;"
add dont-require-permissions=yes name=wa_deleteinbox owner=Renaldi policy=\
    read,write,policy,test,sensitive source="# SCRIPT BOT WHATSAPP AknalRE\r\
    \n\r\
    \n:log warning \"Fetch Delete Inbox Mikrotik To Whatsapp Api Berjalan\"\r\
    \n:global urlapi;\r\
    \n:global secret;\r\
    \n:local endpoint \"/hapuspesan/\$secret\";\r\
    \n\r\
    \n:local apiwa (\$urlapi . \$endpoint);\r\
    \n\r\
    \n/tool fetch url=(\$apiwa) mode=http \\\r\
    \n     http-method=post \\\r\
    \n     keep-result=no"
add dont-require-permissions=yes name=wa_fetch_pesan_user owner=Renaldi \
    policy=read,write,policy,test,sensitive source="# SCRIPT BOT WHATSAPP Akna\
    lRE\r\
    \n\r\
    \n:log warning \"Fetch Send Outbox Mikrotik To Whatsapp Api Berjalan\"\r\
    \n:global urlapi;\r\
    \n:global nomoruser;\r\
    \n:global secret;\r\
    \n:global pesanoutboxuser;\r\
    \n:local endpoint \"/message\";\r\
    \n\r\
    \n:local apiwa (\$urlapi . \$endpoint);\r\
    \n\r\
    \n/tool fetch url=(\$apiwa) mode=http \\\r\
    \n     http-method=post \\\r\
    \n     http-header-field=\"Content-Type: application/json\" \\\r\
    \n     http-data=\"{\\\"secretApp\\\":\\\"\$secret\\\",\\\"phoneNumber\\\"\
    :\\\"\$nomoruser\\\",\\\"message\\\":\\\"\$pesanoutboxuser\\\"}\" \\\r\
    \n     keep-result=no\r\
    \n\r\
    \n:set pesanoutboxuser \"\";\r\
    \n:set nomoruser \"\";"
add dont-require-permissions=yes name=wa_ac_interface owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Ac_Interface Be\
    rjalan\";\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:local listint;\r\
    \n:local intCount 1;\r\
    \n\r\
    \n:foreach interface in=[/interface find] do={\r\
    \n    :local status;\r\
    \n    :local interfaceName [/interface get \$interface name];\r\
    \n    :local Comment [/interface get \$interface comment];\r\
    \n    :local isDisabled [/interface get \$interface disabled];\r\
    \n    :local typeint [/interface get \$interface type];\r\
    \n    :local download [/interface get \$interface rx-byte];\r\
    \n    :local upload [/interface get \$interface tx-byte];\r\
    \n    :local downloadGB [(\$download/1073741824)];\r\
    \n    :local uploadGB [(\$upload/1073741824)];\r\
    \n    :local TOTALGB [(\$downloadGB + \$uploadGB)];\r\
    \n    \r\
    \n    :if (\$isDisabled = true) do={\r\
    \n        :set status \"{silang}\";\r\
    \n    } else={\r\
    \n        :set status \"{centang}\";\r\
    \n    }\r\
    \n    \r\
    \n    :set downloadGB (\$downloadGB . \" GB\");\r\
    \n    :set uploadGB (\$uploadGB . \" GB\");\r\
    \n    :set TOTALGB (\$TOTALGB . \" GB\");\r\
    \n\r\
    \n    :if ([:len \$Comment] > 0) do={\r\
    \n      :set listint (\$listint . \"\$intCount. *\$interfaceName* | \$type\
    int | \$status | \$TOTALGB | \$Comment\\\\n\");\r\
    \n    } else={\r\
    \n      :set listint (\$listint . \"\$intCount. *\$interfaceName* | \$type\
    int | \$status | \$TOTALGB | \\\\n\");\r\
    \n    }\r\
    \n    :set intCount (\$intCount + 1);\r\
    \n}\r\
    \n\r\
    \n# :set listint (\$listint .\"\\\\n\");\r\
    \n\r\
    \n:set pesanoutbox \"*----Informasi List Interface----*\\\\n\\\\nList\\\\t\
    :\\\\n\\\\nNo. Nama | Type | Status | Total GB | Comment\\\\n\$listint\";\
    \r\
    \n\r\
    \n/system script run wa_fetch_pesan;\r\
    \n"
add dont-require-permissions=yes name=wa_ac_dhcp owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Ac_Dhcp Berjala\
    n\";\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:local leaseInfo;\r\
    \n:local Count 1;\r\
    \n\r\
    \n:foreach lease in=[/ip dhcp-server lease find where status=\"bound\"] do\
    ={\r\
    \n    :local ipAddress [/ip dhcp-server lease get \$lease address];\r\
    \n    :local comment [/ip dhcp-server lease get \$lease comment];\r\
    \n    :local macAddress [/ip dhcp-server lease get \$lease mac-address];\r\
    \n    :local hostName [/ip dhcp-server lease get \$lease host-name];\r\
    \n    :local leaseTime [/ip dhcp-server lease get \$lease expires-after];\
    \r\
    \n\r\
    \n    :if ([:len \$Comment] > 0) do={\r\
    \n      :set leaseInfo (\$leaseInfo . \"\$Count. \$hostName | \$ipAddress \
    | \$leaseTime | \$comment\\\\n\");\r\
    \n    } else={\r\
    \n      :set leaseInfo (\$leaseInfo . \"\$Count. \$hostName | \$ipAddress \
    | \$leaseTime | \\\\n\");\r\
    \n    }\r\
    \n\r\
    \n    :set Count (\$Count + 1);\r\
    \n}\r\
    \n\r\
    \n:set pesanoutbox \"*----List DHCP-SERVER LEASE Bound----*\\\\n\\\\nList\
    \\\\t:\\\\n\\\\nNo. Hostname | IP Address | Lease Time | Comment\\\\n\$lea\
    seInfo\";\r\
    \n\r\
    \n/system script run wa_fetch_pesan;"
add dont-require-permissions=yes name=wa_template_tagihan_pppoe owner=Renaldi \
    policy=read,write,policy,test,sensitive source=":log warning \"Wa_Kirim_Ta\
    gihan_Berjalan\";\r\
    \n\r\
    \n:global header;\r\
    \n:global footer;\r\
    \n:global infoadmin;\r\
    \n:global delaypesan;\r\
    \n\r\
    \n:global nomoruser;\r\
    \n:global pesanoutboxuser;\r\
    \n:global pesanoutbox;\r\
    \n:global tnggaltagihan;\r\
    \n:local tanggal \$tnggaltagihan;\r\
    \n\r\
    \n:foreach pppSecretId in=[/ppp secret find profile=\"PPPoE\"] do={\r\
    \n  :local comment [/ppp secret get \$pppSecretId comment];\r\
    \n  :if ([:len \$comment] > 0) do={\r\
    \n    :local delimiter ([:find \$comment \"|\"]);\r\
    \n    :local number [:pick \$comment 0 \$delimiter];\r\
    \n    :local remaining [:pick \$comment (\$delimiter + 1) [:len \$comment]\
    ];\r\
    \n    :local name ([:pick \$remaining 0 ([:find \$remaining \"|\"])]);\r\
    \n    \r\
    \n    :local remaining2 [:pick \$remaining ([:find \$remaining \"|\"] + 1)\
    \_[:len \$remaining]];\r\
    \n    :local tagihan ([:pick \$remaining2 0 ([:find \$remaining2 \"|\"])])\
    ;\r\
    \n    :local paket ([:pick \$remaining2 ([:find \$remaining2 \"|\"] + 1) [\
    :len \$remaining2]]);\r\
    \n\r\
    \n    :local templatetagihan \"\$header\\\\n\\\\nHalo *\$name*,\\\\n\\\\nK\
    ami ingin mengingatkan Anda tentang tagihan berikut:\\\\n\\\\n-\\\\tNama: \
    *\$name*\\\\n-\\\\tTagihan: *Rp\$tagihan*\\\\n-\\\\tPaket: *\$paket*\\\\n-\
    \\\\tBatas Pembayaran: Tanggal *\$tanggal*\\\\n\\\\nPastikan untuk segera \
    melakukan pembayaran sebelum tanggal *\$tanggal*. Jika Anda telah membayar\
    , silakan abaikan pesan ini.\\\\n\\\\nTerima kasih atas kerjasamanya.\\\\n\
    \\\\n\$infoadmin\\\\n\$footer\";\r\
    \n    \r\
    \n    :set pesanoutboxuser \$templatetagihan;\r\
    \n    :set nomoruser \$number;\r\
    \n\r\
    \n    :delay (\$delaypesan . \"s\");\r\
    \n    \r\
    \n    /system script run wa_fetch_pesan_user;\r\
    \n\r\
    \n    :set pesanoutbox \"Pesan tagihan ke *\$name* sudah dikirimkan\"\r\
    \n    /system script run wa_fetch_pesan\r\
    \n  }\r\
    \n}\r\
    \n"
add dont-require-permissions=yes name=wa_template_pengingat_pppoe owner=\
    Renaldi policy=read,write,policy,test,sensitive source=":log warning \"Wa_\
    Kirim_Pengingat_Tagihan_Berjalan\";\r\
    \n\r\
    \n:global header;\r\
    \n:global footer;\r\
    \n:global infoadmin;\r\
    \n:global delaypesan;\r\
    \n\r\
    \n:global nomoruser;\r\
    \n:global pesanoutboxuser;\r\
    \n:global pesanoutbox;\r\
    \n:global tnggaltagihan;\r\
    \n:local tanggal \$tnggaltagihan;\r\
    \n\r\
    \n:foreach pppSecretId in=[/ppp secret find profile=\"PPPoE\"] do={\r\
    \n  :local comment [/ppp secret get \$pppSecretId comment];\r\
    \n  :if ([:len \$comment] > 0) do={\r\
    \n    :local delimiter ([:find \$comment \"|\"]);\r\
    \n    :local number [:pick \$comment 0 \$delimiter];\r\
    \n    :local remaining [:pick \$comment (\$delimiter + 1) [:len \$comment]\
    ];\r\
    \n    :local name ([:pick \$remaining 0 ([:find \$remaining \"|\"])]);\r\
    \n    \r\
    \n    :local remaining2 [:pick \$remaining ([:find \$remaining \"|\"] + 1)\
    \_[:len \$remaining]];\r\
    \n    :local tagihan ([:pick \$remaining2 0 ([:find \$remaining2 \"|\"])])\
    ;\r\
    \n    :local paket ([:pick \$remaining2 ([:find \$remaining2 \"|\"] + 1) [\
    :len \$remaining2]]);\r\
    \n\r\
    \n    :local templatepengingat \"\$header\\\\n\\\\n*\$name* Harap segera l\
    akukan pembayaran sebelum tanggal *\$tanggal* untuk menghindari keterlamba\
    tan.\\\\n\\\\nJangan khawatir jika Anda sudah melakukan pembayaran sebelum\
    nya.\\\\n\\\\n\$infoadmin\\\\n\$footer\";\r\
    \n    :set pesanoutboxuser \$templatepengingat;\r\
    \n    :set nomoruser \$number;\r\
    \n    :delay (\$delaypesan . \"s\");\r\
    \n    /system script run wa_fetch_pesan_user\r\
    \n\r\
    \n    :set pesanoutbox \"Pesan pengingat tagihan ke *\$name* sudah dikirim\
    kan\"\r\
    \n    /system script run wa_fetch_pesan\r\
    \n  }\r\
    \n}"
add dont-require-permissions=yes name=wa_getnumber&name&tagihan owner=Renaldi \
    policy=read,write,policy,test,sensitive source=":local comments;\r\
    \n:foreach pppSecretId in=[/ppp secret find profile=\"PPPoE\"] do={\r\
    \n  :local comment [/ppp secret get \$pppSecretId comment];\r\
    \n  :if ([:len \$comment] > 0) do={\r\
    \n    :local delimiter ([:find \$comment \"|\"]);\r\
    \n    :local number [:pick \$comment 0 \$delimiter];\r\
    \n    :local remaining [:pick \$comment (\$delimiter + 1) [:len \$comment]\
    ];\r\
    \n    :local name ([:pick \$remaining 0 ([:find \$remaining \"|\"])]);\r\
    \n    \r\
    \n    :local remaining2 [:pick \$remaining ([:find \$remaining \"|\"] + 1)\
    \_[:len \$remaining]];\r\
    \n    :local tagihan ([:pick \$remaining2 0 ([:find \$remaining2 \"|\"])])\
    ;\r\
    \n    :local paket ([:pick \$remaining2 ([:find \$remaining2 \"|\"] + 1) [\
    :len \$remaining2]]);\r\
    \n    :set comments (\$comments . \"Nomor: \" . \$number . \", Nama: \" . \
    \$name . \", Tagihan: \" . \$tagihan . \", Paket: \" . \$paket . \"\\n\");\
    \r\
    \n  }\r\
    \n}\r\
    \n:put \$comments\r\
    \n"
add dont-require-permissions=yes name=test owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":global pesanoutbox;\r\
    \n:global header;\r\
    \n:global footer;\r\
    \n\r\
    \n:local nama \$user;\r\
    \n:local ip \$address;\r\
    \n:local prf \$profile;\r\
    \n:local mac \$\"mac-address\";\r\
    \n:local tanggal [/system clock get date];\r\
    \n:local waktu [/system clock get time];\r\
    \n:local stringtanggal \"\$tanggal / \$waktu\"\r\
    \n:local useraktif [/ip hotspot active print count-only];\r\
    \n:local lby [/ip hotspot active get [find user=\"\$nama\"] login-by];\r\
    \n:local host [/ip dhcp-server lease get [find address=\"\$ip\"] host-name\
    ];\r\
    \n\r\
    \n\r\
    \n:local namaprf [:pick \$prf 0 [:find \$prf \"|\"]];\r\
    \n:local timeprf [:pick \$prf ([:find \$prf \"|\"] + 1) [:len \$prf]];\r\
    \n\r\
    \n:local namasch \"User \$nama | HAPUS USER HOTSPOT\";\r\
    \n\r\
    \n:log warning \$pesanoutbox;\r\
    \n:log warning \$header;\r\
    \n:log warning \$footer;\r\
    \n\r\
    \n:log warning \$nama;\r\
    \n:log warning \$ip;\r\
    \n:log warning \$prf;\r\
    \n:log warning \$mac;\r\
    \n:log warning \$tanggal;\r\
    \n:log warning \$waktu;\r\
    \n:log warning \$stringtanggal;\r\
    \n:log warning \$useraktif;\r\
    \n:log warning \$lby;\r\
    \n:log warning \$host;\r\
    \n:log warning \$namaprf;\r\
    \n:log warning \$timeprf;\r\
    \n:log warning \$namasch;\r\
    \n\r\
    \n/ip hotspot user set [find name=\$nama] comment=\"BERHASIL LOGIN\"\r\
    \n\r\
    \n\r\
    \n:if ([/ip hotspot user get [find name=\$nama] comment]=\"BERHASIL LOGIN\
    \") do={\r\
    \n  /ip hotspot user set [find name=\$nama] comment=\"Login : \$stringtang\
    gal\";\r\
    \n  /ip hotspot user set \$nama mac=\$mac;\r\
    \n  :log info \"User \$nama sudah berhasil login dan sudah di bindingkan d\
    engan mac \$mac\";\r\
    \n\r\
    \n  :local emot \"{centang}\";\r\
    \n  :set pesanoutbox \"\$header\\\\n\\\\n\$emot \$nama berhasil login hots\
    pot\\\\nWaktu Login\\\\t: \$stringtanggal\\\\nIP Address\\\\t: \$ip\\\\nPr\
    ofile\\\\t: \$prf\\\\n\\\\nTotal User Hotspot Active : \$useraktif\\\\n\\\
    \\n\$footer\";\r\
    \n  /system script run wa_fetch_pesan\r\
    \n} else={\r\
    \n  :log warning \"User \$nama berhasil melakukan login ulang.\";\r\
    \n}\r\
    \n\r\
    \n:if (:len [/system scheduler find name=\$namasch] = 0) do={\r\
    \n  /system scheduler add name=\$namasch start-date=\$tanggal start-time=\
    \$waktu interval=\$timeprf on-event=\":global pesanoutbox;\\r\\n/ip hotspo\
    t active remove [find user=\$nama]\\r\\n/ip hotspot user remove [find name\
    =\$nama]\\r\\n:if ([:len [/ip hotspot user find name=\$nama]] = 0 && [:len\
    \_[/ip hotspot active find user=\$nama]] = 0) do={\\r\\n  /system schedule\
    r remove [find name=\$namasch]\\r\\n  :set pesanoutbox \\\"User \$nama dan\
    \_scheduler \$namasch\\\\n{centang} Berhasil Dihapus\\\";\\r\\n  /system s\
    cript run wa_fetch_pesan;\\r\\n}\\r\\n\";\r\
    \n};"
add dont-require-permissions=yes name=wa_userhotspot owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Ac_User_Hotspot\
    \_Berjalan\";\r\
    \n\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:global count;\r\
    \n:local localcount (\$count + 1);\r\
    \n:local listuserhotspot;\r\
    \n\r\
    \n:local userhotspotList [/ip hotspot user print detail  as-value];\r\
    \n\r\
    \n:if ([:len \$userhotspotList] = 0) do={\r\
    \n    :set listuserhotspot \"Tidak Ada User Hotspot\";\r\
    \n} else={\r\
    \n    :foreach userhotspotEntry in=\$userhotspotList do={\r\
    \n        :local status;\r\
    \n        :local userhotspotProps [:toarray \$userhotspotEntry];\r\
    \n\r\
    \n        :local user (\$userhotspotProps->\"name\");\r\
    \n        :local password (\$userhotspotProps->\"password\");\r\
    \n        :local profile (\$userhotspotProps->\"profile\");\r\
    \n        :local uptime (\$userhotspotProps->\"uptime\");\r\
    \n\r\
    \n        :local disabled [/ip hotspot user get \$user disabled];\r\
    \n        :if (\$disabled = true) do={\r\
    \n            :local emot \"{silang}\";\r\
    \n            :set status \$emot;\r\
    \n        } else={\r\
    \n            :local emot \"{centang}\";\r\
    \n            :set status \$emot;\r\
    \n        }\r\
    \n\r\
    \n        :if (\$uptime != \"00:00:00\") do={\r\
    \n            :set listuserhotspot (\$listuserhotspot .\"\$localcount. \$s\
    tatus | \$user | \$password | \$profile | \$uptime \\\\n\")\r\
    \n        } else={\r\
    \n            :set listuserhotspot (\$listuserhotspot . \"\$localcount. \$\
    status | \$user | \$password | \$profile | {silang} \\\\n\")\r\
    \n        }\r\
    \n        :set localcount (\$localcount +1);\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:set pesanoutbox \"*----Informasi User Hotspot----*\\\\n\\\\nList User :\
    \\\\n\\\\nNo. Status | User | Password | Profile | Uptime\\\\n\$listuserho\
    tspot\";\r\
    \n\r\
    \n/system script run wa_fetch_pesan;\r\
    \n"
add dont-require-permissions=yes name=wa_set_disable&enable owner=Renaldi \
    policy=read,write,policy,test,sensitive source=":log warning \"Wa_Service_\
    Enable&Disable Berjalan\";\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:global pesanenabledisable;\r\
    \n\r\
    \n:local setstatus [:pick \$pesanenabledisable 0 [:find \$pesanenabledisab\
    le \"|\"]];\r\
    \n:local sisaPesan [:pick \$pesanenabledisable ([:find \$pesanenabledisabl\
    e \"|\"] + 1) [:len \$pesanenabledisable]];\r\
    \n:local service [:pick \$sisaPesan 0 [:find \$sisaPesan \"|\"]];\r\
    \n:local nama [:pick \$sisaPesan ([:find \$sisaPesan \"|\"] + 1) [:len \$s\
    isaPesan]];\r\
    \n\r\
    \n:put \$setstatus;\r\
    \n\r\
    \n:if (\$setstatus = \".enable\") do={\r\
    \n    :put \$service;\r\
    \n    :put \$nama;\r\
    \n    :local status \"no\";\r\
    \n    :local stringstatus \"\";\r\
    \n\r\
    \n    :if (\$status = \"no\") do={\r\
    \n        :set stringstatus \"{centang} *Diaktifkan*\";\r\
    \n    }\r\
    \n\r\
    \n    :if (\$service = \"interface\") do={\r\
    \n        /interface set \$nama disabled=\$status;\r\
    \n        :delay 3s;\r\
    \n        :set pesanoutbox \"Interface Nama : *\$nama*\\\\n\\\\nBerhasil \
    \$stringstatus\"\r\
    \n    }\r\
    \n    :if (\$service = \"ppp\") do={\r\
    \n        /ppp secret set \$nama disabled=\$status;\r\
    \n        :delay 3s;\r\
    \n        :set pesanoutbox \"PPP Secret Nama : *\$nama*\\\\n\\\\nBerhasil \
    \$stringstatus\"\r\
    \n    }\r\
    \n    :if (\$service = \"userhotspot\") do={\r\
    \n        /ip hotspot user set \$nama disabled=\$status;\r\
    \n        :delay 3s;\r\
    \n        :set pesanoutbox \"Hotspot User Nama : *\$nama*\\\\n\\\\nBerhasi\
    l \$stringstatus\"\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:if (\$setstatus = \".disable\") do={\r\
    \n    :put \$service;\r\
    \n    :put \$nama;\r\
    \n    :local status \"yes\";\r\
    \n    :local stringstatus \"\";\r\
    \n\r\
    \n    :if (\$status = \"yes\") do={\r\
    \n        :set stringstatus \"{silang} *Dinonaktifkan*\";\r\
    \n    }\r\
    \n\r\
    \n    :if (\$service = \"interface\") do={\r\
    \n        /interface set \$nama disabled=\$status;\r\
    \n        :delay 3s;\r\
    \n        :set pesanoutbox \"Interface Nama : *\$nama*\\\\n\\\\nBerhasil \
    \$stringstatus\"\r\
    \n    }\r\
    \n    :if (\$service = \"ppp\") do={\r\
    \n        /ppp secret set \$nama disabled=\$status;\r\
    \n        :delay 3s;\r\
    \n        :set pesanoutbox \"PPP Secret Nama : *\$nama*\\\\n\\\\nBerhasil \
    \$stringstatus\"\r\
    \n    }\r\
    \n    :if (\$service = \"userhotspot\") do={\r\
    \n        /ip hotspot user set \$nama disabled=\$status;\r\
    \n        :delay 3s;\r\
    \n        :set pesanoutbox \"Hotspot User Nama : *\$nama*\\\\n\\\\nBerhasi\
    l \$stringstatus\"\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:set pesanenabledisable \"\";\r\
    \n/system script run wa_fetch_pesan;\r\
    \n"
add dont-require-permissions=yes name=wa_list_secret_ppp owner=Renaldi \
    policy=read,write,policy,test,sensitive source=":log warning \"Wa_List_Sec\
    ret_secretppp Berjalan\";\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:local listsecretppp;\r\
    \n:local secretpppList [ppp secret print detail as-value];\r\
    \n:local secretpppCount 1;\r\
    \n\r\
    \n:if ([:len \$secretpppList] = 0) do={\r\
    \n  :set listsecretppp \"Tidak Ada secretppp Aktif\";\r\
    \n} else={\r\
    \n  :foreach secretpppEntry in=\$secretpppList do={\r\
    \n    :local secretpppProps [:toarray \$secretpppEntry];\r\
    \n\r\
    \n    :local name (\$secretpppProps->\"name\");\r\
    \n    :local password (\$secretpppProps->\"password\");\r\
    \n    :local address (\$secretpppProps->\"remote-address\");\r\
    \n    :local service (\$secretpppProps->\"service\");\r\
    \n    :local status (\$secretpppProps->\"last-disconnect-reason\");\r\
    \n    :local comment (\$secretpppProps->\"comment\");\r\
    \n\r\
    \n    :local statusppp [/ppp secret get \$name disabled ];\r\
    \n\r\
    \n    :if (\$statusppp = true) do={\r\
    \n        :local emot \"{silang}\";\r\
    \n        :set statusppp \$emot;\r\
    \n    } else={\r\
    \n        :local emot \"{centang}\";\r\
    \n        :set statusppp \$emot;\r\
    \n    }\r\
    \n\r\
    \n    :local secretpppInfo \"\$secretpppCount. \$statusppp *\$name* | \$pa\
    ssword | \$address | \$service | \$status\";\r\
    \n\r\
    \n    :if ([:len \$comment] > 0) do={\r\
    \n      :set secretpppInfo (\$secretpppInfo . \" | *\$comment*\");\r\
    \n    }\r\
    \n\r\
    \n    :if ([:len \$listsecretppp] > 0) do={\r\
    \n      :set listsecretppp (\$listsecretppp . \"\\\\n\" . \$secretpppInfo)\
    ;\r\
    \n    } else={\r\
    \n      :set listsecretppp \$secretpppInfo;\r\
    \n    }\r\
    \n    :set secretpppCount (\$secretpppCount + 1);\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n# :set listsecretppp (\$listsecretppp .\"\\\\n\");\r\
    \n\r\
    \n:set pesanoutbox \"*----Informasi Secret PPP----*\\\\n\\\\nList Secret\\\
    \\t:\\\\n\\\\nNo. Nama | Password | Remote-Address | Service | Status Serv\
    ice | Comment\\\\n\$listsecretppp\"\r\
    \n\r\
    \n/system script run wa_fetch_pesan;"
add dont-require-permissions=yes name=wa_template_broadcast_pppoe owner=\
    Renaldi policy=read,write,policy,test,sensitive source=":log warning \"Wa_\
    Kirim_Broadcast_Berjalan\";\r\
    \n\r\
    \n:global header;\r\
    \n:global footer;\r\
    \n:global infoadmin;\r\
    \n:global pesanbroadcast;\r\
    \n:global delaypesan;\r\
    \n\r\
    \n:global nomoruser;\r\
    \n:global pesanoutboxuser;\r\
    \n:global pesanoutbox;\r\
    \n\r\
    \n:foreach pppSecretId in=[/ppp secret find profile=\"PPPoE\"] do={\r\
    \n  :local comment [/ppp secret get \$pppSecretId comment];\r\
    \n  :if ([:len \$comment] > 0) do={\r\
    \n    :local delimiter ([:find \$comment \"|\"]);\r\
    \n    :local number [:pick \$comment 0 \$delimiter];\r\
    \n    :local remaining [:pick \$comment (\$delimiter + 1) [:len \$comment]\
    ];\r\
    \n    :local name ([:pick \$remaining 0 ([:find \$remaining \"|\"])]);\r\
    \n\r\
    \n    :local sisaPesan1 [:pick \$pesanbroadcast ([:find \$pesanbroadcast \
    \"|\"] + 1) [:len \$pesanbroadcast]];\r\
    \n    :local infobroadcast [:pick \$sisaPesan1 0 [:find \$sisaPesan1 \"|\"\
    ]];\r\
    \n    :local sisaPesan2 [:pick \$sisaPesan1 ([:find \$sisaPesan1 \"|\"] + \
    1) [:len \$sisaPesan1]];\r\
    \n    :local infotanggal [:pick \$sisaPesan2 0 [:find \$sisaPesan2 \"|\"]]\
    ;\r\
    \n    :local teksbroadcast [:pick \$sisaPesan1 ([:find \$sisaPesan1 \"|\"]\
    \_+ 1) [:len \$sisaPesan1]];\r\
    \n    :local infowaktu [:pick \$sisaPesan2 ([:find \$sisaPesan2 \"|\"] + 1\
    ) [:len \$sisaPesan2]];\r\
    \n    :local template;\r\
    \n\r\
    \n    :if (\$infobroadcast = \"GANGGUAN\") do={\r\
    \n      :set template \"\$header\\\\n\\\\nHalo \$name,\\\\n\\\\nKami ingin\
    \_memberitahu Anda bahwa saat ini terdapat gangguan jaringan. Gangguan ini\
    \_terjadi pada tanggal \$infotanggal mulai pukul \$infowaktu. Tim teknis k\
    ami sedang bekerja keras untuk mengatasi masalah ini dan memulihkan layana\
    n sesegera mungkin. Kami meminta maaf atas ketidaknyamanan ini dan berteri\
    ma kasih atas kesabaran Anda. Kami akan memberikan pembaruan segera.\\\\n\
    \\\\nTerima kasih atas pengertian Anda.\\\\n\\\\nSalam,\\\\n\$infoadmin\\\
    \\n\\\\n\$footer\";\r\
    \n    } else={\r\
    \n      :if (\$infobroadcast = \"MAINTENANCE\") do={\r\
    \n        :set template \"\$header\\\\n\\\\nHalo \$name,\\\\n\\\\nPada tan\
    ggal \$infotanggal, kami akan melaksanakan maintenance pada pukul \$infowa\
    ktu. Selama periode ini, layanan kami mungkin tidak tersedia. Tujuannya ad\
    alah untuk meningkatkan kualitas layanan kami. Terima kasih atas pengertia\
    n Anda dan mohon maaf atas ketidaknyamanan yang mungkin terjadi. Kami akan\
    \_berusaha sebaik mungkin untuk menyelesaikan maintenance ini dengan cepat\
    .\\\\n\\\\nTerima kasih atas dukungan Anda.\\\\n\\\\nSalam,\\\\n\$infoadmi\
    n\\\\n\\\\n\$footer\";\r\
    \n      } else={\r\
    \n        :if (\$infobroadcast = \"SELESAI\") do={\r\
    \n          :set template \"\$header\\\\n\\\\nHalo \$name,\\\\n\\\\nKami s\
    enang memberitahu Anda bahwa maintenance telah selesai pada tanggal \$info\
    tanggal dan gangguan jaringan telah diatasi. Layanan kami kini telah pulih\
    \_sepenuhnya mulai pukul \$infowaktu. Terima kasih atas kesabaran Anda sel\
    ama periode ini.\\\\n\\\\nJika Anda masih mengalami masalah atau memiliki \
    pertanyaan, jangan ragu untuk menghubungi tim dukungan kami. Terima kasih \
    atas dukungan Anda.\\\\n\\\\nSalam,\\\\n\$infoadmin\\\\n\\\\n\$footer\";\r\
    \n        } else={\r\
    \n          :if (\$infobroadcast = \"TEKS\") do={\r\
    \n            :set template \"\$header\\\\n\\\\n\$teksbroadcast\\\\n\\\\n\
    \$footer\";\r\
    \n          }\r\
    \n        }\r\
    \n      }\r\
    \n    }\r\
    \n\r\
    \n    :set pesanoutboxuser \$template;\r\
    \n    :set nomoruser \$number;\r\
    \n    :delay (\$delaypesan . \"s\");\r\
    \n    /system script run wa_fetch_pesan_user\r\
    \n\r\
    \n    :set pesanoutbox \"Pesan Broadcast *\$infobroadcast* ke *\$name* sud\
    ah dikirimkan\"\r\
    \n    /system script run wa_fetch_pesan\r\
    \n  }\r\
    \n}"
add dont-require-permissions=yes name=wa_blokir_inet owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Blokir_Inet Ber\
    jalan\";\r\
    \n\r\
    \n:global pesanoutbox;\r\
    \n:global outinttoclient;\r\
    \n:global pesanblokir;\r\
    \n:global stringwaktu;\r\
    \n\r\
    \n\r\
    \n:local listblokir \"BLOKIR-INET\";\r\
    \n\r\
    \n:local pemisah1 [:pick \$pesanblokir ([:find \$pesanblokir \"|\"] + 1) [\
    :len \$pesanblokir]];\r\
    \n:local fungsi [:pick \$pemisah1 0 [:find \$pemisah1 \"|\"]];\r\
    \n:local iptarget [:pick \$pemisah1 ([:find \$pemisah1 \"|\"] + 1) [:len \
    \$pemisah1]];\r\
    \n\r\
    \n:if (([:len [/ip firewall address-list find list=\$listblokir]] = 0) && \
    ([:len [/ip firewall filter find comment=\$listblokir]] = 0)) do={\r\
    \n#   /ip firewall address-list add list=\$listblokir address=\$iptarget;\
    \r\
    \n#   /ip firewall address-list add list=\$listblokir;\r\
    \n  /ip firewall filter add action=drop chain=forward src-address-list=\$l\
    istblokir in-interface=\$outinttoclient comment=\$listblokir;\r\
    \n}\r\
    \n\r\
    \n:if (\$fungsi = \"tambah\") do={\r\
    \n    :local checkExists [ /ip firewall address-list find list=\$listbloki\
    r address=\$iptarget ];\r\
    \n\r\
    \n    :if ( [:len \$checkExists] = 0 ) do={\r\
    \n        :local commentlist [:tostr \"\$stringwaktu\"];\r\
    \n        :put \$commentlist\r\
    \n        :local command \"/ip firewall address-list add list=\$listblokir\
    \_address=\$iptarget comment=\$commentlist\";\r\
    \n        :execute \$command;\r\
    \n        :set pesanoutbox \"IP *\$iptarget* Berhasil di tambahkan ke list\
    \_*'\$listblokir'*.\";\r\
    \n    } else={\r\
    \n        :set pesanoutbox \"IP *\$iptarget* sudah ada dalam daftar list *\
    '\$listblokir'*.\";\r\
    \n    }\r\
    \n} else={\r\
    \n    :if (\$fungsi = \"hapus\") do={\r\
    \n        :local checkExists [ /ip firewall address-list find list=\$listb\
    lokir address=\$iptarget ];\r\
    \n\r\
    \n        :if ( [:len \$checkExists] = 1 ) do={\r\
    \n            :local command \"/ip firewall address-list remove [find list\
    =\$listblokir address=\$iptarget]\";\r\
    \n            :execute \$command;\r\
    \n            :set pesanoutbox \"IP *\$iptarget* Berhasil di hapus dari li\
    st *'\$listblokir'*.\";\r\
    \n        } else={\r\
    \n            :set pesanoutbox \"IP *\$iptarget* tidak ada dalam daftar li\
    st *'\$listblokir'*.\";\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n/system script run wa_fetch_pesan;"
add dont-require-permissions=yes name=wa_isolir owner=Renaldi policy=\
    read,write,policy,test,sensitive source=":log warning \"Wa_Isolir Berjalan\
    \";\r\
    \n\r\
    \n:global urlapi;\r\
    \n:global pesanisolir;\r\
    \n:global pesanoutbox;\r\
    \n:global stringwaktu;\r\
    \n:global pesanblokir;\r\
    \n:global domain;\r\
    \n:global urlapi;\r\
    \n:set pesanblokir \$pesanisolir;\r\
    \n\r\
    \n:local endurl \"\$urlapi/error5\";\r\
    \n:local endurldata \"\$urlapi/error\";\r\
    \n:local filename;\r\
    \n:local type \".html file\";\r\
    \n:local commentnat \"ISOLIR-INET\";\r\
    \n:local portproxy;\r\
    \n\r\
    \n:if ([:len [file find type=\"disk\" name=\"flash\"]]=1) do={\r\
    \n    :put \"Ada Disk 'flash'\";\r\
    \n    :set filename \"flash/webproxy/error.html\";\r\
    \n    :if ([ip proxy get enabled]=false) do={\r\
    \n        /ip proxy set enabled=yes\r\
    \n        :set portproxy [/ip proxy get port]\r\
    \n    }\r\
    \n#    /tool fetch url=\$endurl  mode=http dst-path=\$filename\r\
    \n} else={\r\
    \n    :set filename \"webproxy/error.html\";\r\
    \n    :if ([ip proxy get enabled]=false) do={\r\
    \n        /ip proxy set enabled=yes\r\
    \n        :set portproxy [/ip proxy get port]\r\
    \n    }\r\
    \n#    /tool fetch url=\$endurl  mode=http dst-path=\$filename\r\
    \n}\r\
    \n\r\
    \n# :if ([:len [file find name=\"web-isolir/error-isolir.html\" type=\".ht\
    ml file\"]]=0) do={\r\
    \n#     /tool fetch url=\$endurl  mode=http dst-path=\$filename\r\
    \n# }\r\
    \n\r\
    \n# :if ([ip proxy get enabled]=false) do={\r\
    \n#     /ip proxy set enabled=yes\r\
    \n# }\r\
    \n\r\
    \n:if ([:len [/ip firewall nat find comment=\"ISOLIR-INET\"]]=0) do={\r\
    \n    /ip firewall nat add chain=dstnat action=redirect to-ports=\$portpro\
    xy src-address-list=BLOKIR-INET protocol=tcp dst-port=80,443 comment=\$com\
    mentnat\r\
    \n}\r\
    \n\r\
    \n:local pemisah1 [:pick \$pesanisolir ([:find \$pesanisolir \"|\"] + 1) [\
    :len \$pesanisolir]];\r\
    \n:local fungsi [:pick \$pemisah1 0 [:find \$pemisah1 \"|\"]];\r\
    \n:local iptarget [:pick \$pemisah1 ([:find \$pemisah1 \"|\"] + 1) [:len \
    \$pemisah1]];\r\
    \n:put \$fungsi;\r\
    \n:put \$iptarget;\r\
    \n\r\
    \n:if (\$fungsi = \"tambah\") do={\r\
    \n    :local checkExists [ /ip proxy access find src-address=\$iptarget ];\
    \r\
    \n    /system script run wa_blokir_inet\r\
    \n\r\
    \n    :if ( [:len \$checkExists] = 0 ) do={\r\
    \n        :local commentlist \"\$stringwaktu\";\r\
    \n        :put \$commentlist\r\
    \n        :local command \"/ip proxy access add src-address=\$iptarget dst\
    -host=!\$domain action=redirect action-data=\$endurldata comment=\$comment\
    list\";\r\
    \n        :execute \$command;\r\
    \n        :set pesanoutbox \"IP *\$iptarget* Berhasil di tambahkan ke acce\
    ss web proxy *'\$commentnat'*.\";\r\
    \n    } else={\r\
    \n        :set pesanoutbox \"IP *\$iptarget* sudah ada dalam access web pr\
    oxy *'\$commentnat'*.\";\r\
    \n    }\r\
    \n} else={\r\
    \n    :if (\$fungsi = \"hapus\") do={\r\
    \n        :local checkExists [ /ip proxy access find src-address=\$iptarge\
    t];\r\
    \n        /system script run wa_blokir_inet\r\
    \n\r\
    \n        :if ( [:len \$checkExists] = 1 ) do={\r\
    \n            /ip proxy access remove [find src-address=\$iptarget];\r\
    \n            :set pesanoutbox \"IP *\$iptarget* Berhasil di hapus dari ac\
    cess web proxy *'\$commentnat'*.\";\r\
    \n        } else={\r\
    \n            :set pesanoutbox \"IP *\$iptarget* tidak ada dalam access we\
    b proxy *'\$commentnat'*.\";\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n/system script run wa_fetch_pesan;"
