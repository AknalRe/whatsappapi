/system scheduler
add interval=5s name=wa_getupdate on-event="/system script run wa_getupdate" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=oct/14/2023 start-time=14:20:06
/system script
add dont-require-permissions=yes name=wa_secret owner=Renaldi policy=\
    read,write,policy,test,sensitive source="# SCRIPT BOT WHATSAPP AknalRE\r\
    \n\r\
    \n:global header \"*-----Pesan Otomatis-----*\";\r\
    \n:global footer \"*-----Pesan Otomatis-----*\"\r\
    \n\r\
    \n:global nomoradmin \"Ganti Dengan Nomor Anda\";\r\
    \n:global secret \"Ganti Dengan Secret Anda\";\r\
    \n:global interfacewan \"Ganti Dengan Input Internet Anda\";\r\
    \n:global nameisp \"Ganti Dengan Nama ISP Anda\";\r\
    \n:global tnggaltagihan \"Ganti Dengan Tanggal Tagihan yang anda inginkan\";\r\
    \n:global count 0;\r\
    \n\r\
    \n:global namaadmin \"Ganti Nama Anda\";\r\
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
    \n:local i (\$count + 1)\r\
    \n\r\
    \n:local endpoint \"/logpesan/\$nomoradmin/\$secret\";\r\
    \n:local urlfetch (\$urlapi . \$endpoint);\r\
    \n\r\
    \n:local response [/tool fetch output=user url=\$urlfetch http-method=get \
    as-value];\r\
    \n:local pesan (\$response->\"data\");\r\
    \n\r\
    \n:if ([:len \$pesan] > 0) do={\r\
    \n    :log info \"Menerima Pesan Admin. Isi Pesan : \$pesan\"\r\
    \n    :delay 2s;\r\
    \n    if (\$pesan = \".menu\") do={\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: \$pesan\\\\n\\\\nTelah Di Terima\"\
    )\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :local identityname [system identity get name]\r\
    \n      /system script run wa_uptime\r\
    \n      :delay 2s\r\
    \n      :set pesanoutbox \"Router Name: *\$identityname*\\\\nUptime : *\$u\
    ptimemikrotik*\\\\n\\\\nDaftar Menu : \\\\n\\\\nNo. *Deskripsi* | Perintah\
    \"\r\
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
    \n      :set (\$menuList->\"menu\$menuCount\") \"*Active PPP* | .ac_ppp\";\
    \r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List Interface* | .ac_in\
    terface\";\r\
    \n      :set menuCount (\$menuCount + 1);\r\
    \n\r\
    \n      :set (\$menuList->\"menu\$menuCount\") \"*List Lease DHCP* | .ac_d\
    hcp\";\r\
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
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_status\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_ppp\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_ppp\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_interface\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_interface\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_dhcp\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_dhcp\r\
    \n    }\r\
    \n    if (\$pesan = \".kirim_tagihan\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      :set pesanoutbox (\"Memproses Pengiriman Tagihan PPPoE Secara Manu\
    al\")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_template_tagihan_pppoe\r\
    \n      :set pesanoutbox (\"Proses Pengiriman Sudah Selesai\")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n    }\r\
    \n    if (\$pesan = \".kirim_pengingat\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      :set pesanoutbox (\"Memproses Pengiriman Pengingat Tagihan PPPoE S\
    ecara Manual\")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_template_pengingat_pppoe\r\
    \n      :set pesanoutbox (\"Proses Pengiriman Sudah Selesai\")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n    }\r\
    \n    if (\$pesan = \".ac_dhcp_lease\") do={\r\
    \n      /system script run wa_deleteinbox\r\
    \n      :set pesanoutbox (\"Pesan\\\\t: *\$pesan*\\\\n\\\\nTelah Di Terima\
    \")\r\
    \n      /system script run wa_fetch_pesan\r\
    \n      /system script run wa_ac_ppp\r\
    \n    }\r\
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
    \n        :set status \"NONAKTIF\";\r\
    \n    } else={\r\
    \n        :set status \"AKTIF\";\r\
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
    \n    :delay 7s;\r\
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
    \n    :delay 7s;\r\
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
    \n    :local tagihan ([:pick \$remaining ([:find \$remaining \"|\"] + 1) [\
    :len \$remaining]]);\r\
    \n    :set comments (\$comments . \"Nomor: \" . \$number . \", Nama: \" . \
    \$name . \", Tagihan: \" . \$tagihan . \"\\n\");\r\
    \n  }\r\
    \n}\r\
    \n:put \$comments\r\
    \n"
