# 3.6. Компьютерные сети. Лекция 1

1. Работа c HTTP через telnet.

   Подключитесь утилитой telnet к сайту stackoverflow.com:
   `telnet stackoverflow.com 80`

   Отправьте HTTP-запрос:

   ```
   GET /questions HTTP/1.0
   HOST: stackoverflow.com
   [press enter]
   [press enter]
   ```

   Решение:

   ```sh
   notfounder@mb-grogu13 ~ % telnet stackoverflow.com 80
   Trying 151.101.193.69...
   Connected to stackoverflow.com.
   Escape character is '^]'.
   GET /questions HTTP/1.0
   HOST: stackoverflow.com
   
   HTTP/1.1 403 Forbidden
   Connection: close
   Content-Length: 1923
   Server: Varnish
   Retry-After: 0
   Content-Type: text/html
   Accept-Ranges: bytes
   Date: Wed, 05 Apr 2023 18:59:11 GMT
   Via: 1.1 varnish
   X-Served-By: cache-hel1410023-HEL
   X-Cache: MISS
   X-Cache-Hits: 0
   X-Timer: S1680721152.524214,VS0,VE4
   X-DNS-Prefetch-Control: off
   
   <!DOCTYPE html>
   <html>
   <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
       <title>Forbidden - Stack Exchange</title>
       <style type="text/css">
                   body
                   {
                           color: #333;
                           font-family: 'Helvetica Neue', Arial, sans-serif;
                           font-size: 14px;
                           background: #fff url('img/bg-noise.png') repeat left top;
                           line-height: 1.4;
                   }
                   h1
                   {
                           font-size: 170%;
                           line-height: 34px;
                           font-weight: normal;
                   }
                   a { color: #366fb3; }
                   a:visited { color: #12457c; }
                   .wrapper {
                           width:960px;
                           margin: 100px auto;
                           text-align:left;
                   }
                   .msg {
                           float: left;
                           width: 700px;
                           padding-top: 18px;
                           margin-left: 18px;
                   }
       </style>
   </head>
   <body>
       <div class="wrapper">
                   <div style="float: left;">
                           <img src="https://cdn.sstatic.net/stackexchange/img/apple-touch-icon.png" alt="Stack Exchange" />
                   </div>
                   <div class="msg">
                           <h1>Access Denied</h1>
                           <p>This IP address (176.111.79.153) has been blocked from access to our services. If you believe this to be in error, please contact us at <a href="mailto:team@stackexchange.com?Subject=Blocked%20176.111.79.153%20(Request%20ID%3A%203056412389-HEL)">team@stackexchange.com</a>.</p>
                           <p>When contacting us, please include the following information in the email:</p>
                           <p>Method: block</p>
                           <p>XID: 3056412389-HEL</p>
                           <p>IP: 176.111.79.153</p>
                           <p>X-Forwarded-For: </p>
                           <p>User-Agent: </p>
   
                           <p>Time: Wed, 05 Apr 2023 18:59:11 GMT</p>
                           <p>URL: stackoverflow.com/questions</p>
                           <p>Browser Location: <span id="jslocation">(not loaded)</span></p>
                   </div>
           </div>
           <script>document.getElementById('jslocation').innerHTML = window.location.href;</script>
   </body>
   </html>Connection closed by foreign host.
   notfounder@mb-grogu13 ~ %
   ```

   В ответ получил код `403 Forbidden` - это означает, что доступ к запрошенному ресурсу запрещен. Сервер понял запрос, но не выполнит его.

   Посмотрим, что там за ответ у mos.ru

   ```sh
   notfounder@mb-grogu13 ~ % telnet mos.ru 80
   Trying 94.79.51.12...
   Connected to mos.ru.
   Escape character is '^]'.
   GET /questions HTTP/1.0
   HOST: stackoverflow.com
   
   HTTP/1.1 301 Moved Permanently
   Server: nginx
   Date: Wed, 05 Apr 2023 19:09:18 GMT
   Content-Type: text/html
   Content-Length: 162
   Connection: close
   Location: https://stackoverflow.com/questions
   
   <html>
   <head><title>301 Moved Permanently</title></head>
   <body>
   <center><h1>301 Moved Permanently</h1></center>
   <hr><center>nginx</center>
   </body>
   </html>
   Connection closed by foreign host.
   notfounder@mb-grogu13 ~ % 
   ```

   `301 Moved Permanently` - получаемый в ответ от сервера в ситуации, когда запрошенный ресурс был на постоянной основе перемещён в новое месторасположение, и указывающий на то, что текущие ссылки, использующие данный URL, должны быть обновлены. Адрес нового месторасположения ресурса указывается в поле Location получаемого в ответ заголовка пакета протокола HTTP.

2. Повторите задание 1 в браузере, используя консоль разработчика F12

     Полученный HTTP-код:

     ![03-sysadmin-06-net_0.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-06-net_0.jpg?raw=true)

     Определите, какой запрос обрабатывался дольше всего:

     ![03-sysadmin-06-net_1.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-06-net_1.jpg?raw=true)

3. Какой IP-адрес у вас в интернете?

     ```sh
     notfounder@mb-grogu13 ~ % dig ANY +short @ns1-1.akamaitech.net ANY whoami.akamai.net
     ;; Warning, extra type option
     176.111.79.155
     notfounder@mb-grogu13 ~ % curl icanhazip.com
     176.111.79.155
     ```

4. Какому провайдеру принадлежит ваш IP-адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

     ```sh
     notfounder@mb-grogu13 ~ % whois 176.111.79.155
     % IANA WHOIS server
     % for more information on IANA, visit http://www.iana.org
     % This query returned 1 object
     
     refer:        whois.ripe.net
     
     inetnum:      176.0.0.0 - 176.255.255.255
     organisation: RIPE NCC
     status:       ALLOCATED
     
     whois:        whois.ripe.net
     
     changed:      2010-05
     source:       IANA
     
     # whois.ripe.net
     
     inetnum:        176.111.72.0 - 176.111.79.255
     netname:        LINKINTEL-NET
     country:        RU
     org:            ORG-Ll47-RIPE
     admin-c:        DM10269-RIPE
     tech-c:         DM10269-RIPE
     status:         ASSIGNED PI
     mnt-by:         RIPE-NCC-END-MNT
     mnt-by:         MNT-LINKINTEL
     mnt-routes:     MNT-LINKINTEL
     mnt-domains:    MNT-LINKINTEL
     created:        2012-03-07T13:43:38Z
     last-modified:  2016-04-14T10:23:36Z
     source:         RIPE
     sponsoring-org: ORG-NGs2-RIPE
     
     organisation:   ORG-Ll47-RIPE
     org-name:       LINKINTEL ltd.
     country:        RU
     org-type:       OTHER
     address:        141730, Moscow reg., Lobnya, Krupskoy st., 24
     abuse-c:        AR25370-RIPE
     mnt-ref:        MNT-LINKINTEL
     mnt-by:         MNT-LINKINTEL
     created:        2008-05-12T06:45:22Z
     last-modified:  2022-12-01T16:35:35Z
     source:         RIPE # Filtered
     
     person:         Denis Milovanov
     address:        141730, Moscow reg., Lobnya, Krupskoy st., 24
     phone:          +7 498 7057333
     nic-hdl:        DM10269-RIPE
     mnt-by:         MNT-LINKINTEL
     created:        2012-03-06T09:36:50Z
     last-modified:  2018-08-27T07:30:07Z
     source:         RIPE
     
     % Information related to '176.111.72.0/21AS47655'
     
     route:          176.111.72.0/21
     descr:          route object
     origin:         AS47655
     mnt-by:         MNT-LINKINTEL
     created:        2012-05-04T15:08:38Z
     last-modified:  2012-05-04T15:08:38Z
     source:         RIPE
     
     % This query was served by the RIPE Database Query Service version 1.106 (SHETLAND)
     ```

     Провайдер: `LINKINTEL ltd`. Автономная система - `AS47655`

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute

     ```
     notfounder@srv-grogu13:~$ traceroute -An 8.8.8.8
     traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
      1  192.168.88.1 [*]  2.733 ms  4.087 ms  4.063 ms
      2  192.168.251.200 [*]  7.502 ms  7.470 ms  7.434 ms
      3  194.152.34.6 [AS47655]  7.405 ms  9.568 ms  12.068 ms
      4  72.14.209.210 [AS15169]  12.029 ms  11.999 ms  11.959 ms
      5  * * *
      6  108.170.250.129 [AS15169]  16.670 ms  8.799 ms 172.253.69.162 [AS15169]  11.226 ms
      7  108.170.250.99 [AS15169]  11.108 ms 108.170.250.146 [AS15169]  11.082 ms  11.072 ms
      8  172.253.66.116 [AS15169]  27.051 ms 142.250.239.64 [AS15169]  27.032 ms 72.14.234.20 [AS15169]  27.007 ms
      9  142.251.237.142 [AS15169]  27.790 ms 72.14.235.69 [AS15169]  31.090 ms 172.253.65.82 [AS15169]  27.686 ms
     10  216.239.62.9 [AS15169]  30.031 ms 142.250.56.221 [AS15169]  36.176 ms 142.250.56.131 [AS15169]  34.375 ms
     11  * * *
     12  * * *
     13  * * *
     14  * * *
     15  * * *
     16  * * *
     17  8.8.8.8 [AS15169/AS263411]  26.561 ms * *
     ```

     Начиная с 3-й строчки `194.152.34.6 [AS47655]` пакет попадает на автономную систему моего провайдера. Далее пакету сразу улетают в США `72.14.209.210 [AS15169]` уже к первой точки на стороне Google LLC к автономной системе которая находиться в Калифорнии, город - Mountain View.

6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка — delay?

     ```
     notfounder@srv-grogu13:~$ mtr -zn --report  8.8.8.8
     Start: 2023-04-07T21:48:12+0000
     HOST: srv-grogu13                 Loss%   Snt   Last   Avg  Best  Wrst StDev
       1. AS???    192.168.88.1         0.0%    10    3.2   3.7   2.7   5.5   0.9
       2. AS???    192.168.251.200      0.0%    10    7.5   7.7   6.2   9.6   0.9
       3. AS47655  194.152.34.6         0.0%    10    5.1   7.1   4.5  10.1   2.1
       4. AS15169  72.14.209.210        0.0%    10    6.8   8.7   5.8  13.3   2.3
       5. AS15169  108.170.250.33       0.0%    10   11.1   9.6   7.2  11.1   1.4
       6. AS15169  108.170.250.34       0.0%    10   11.1   9.1   6.8  11.1   1.5
       7. AS15169  172.253.66.116       0.0%    10   27.3  37.6  24.9 114.7  27.7
       8. AS15169  72.14.235.69         0.0%    10   27.3  28.6  25.4  39.6   4.1
       9. AS15169  216.239.57.5         0.0%    10   22.0  23.2  20.8  24.8   1.4
      10. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      11. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      12. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      13. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      14. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      15. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      16. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      17. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      18. AS15169  8.8.8.8              0.0%    10   26.3  25.8  23.0  28.3   1.7
     ```

     Наибольшая задержка на 7 и 8 хопе

7. Какие DNS-сервера отвечают за доменное имя dns.google? Какие A-записи? Воспользуйтесь утилитой dig

     Смотрим NS сервера:

     ```
     notfounder@srv-grogu13:~$ dig NS dns.google
     
     ; <<>> DiG 9.18.1-1ubuntu1.3-Ubuntu <<>> NS dns.google
     ;; global options: +cmd
     ;; Got answer:
     ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 53943
     ;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1
     
     ;; OPT PSEUDOSECTION:
     ; EDNS: version: 0, flags:; udp: 65494
     ;; QUESTION SECTION:
     ;dns.google.                    IN      NS
     
     ;; ANSWER SECTION:
     dns.google.             21600   IN      NS      ns3.zdns.google.
     dns.google.             21600   IN      NS      ns4.zdns.google.
     dns.google.             21600   IN      NS      ns1.zdns.google.
     dns.google.             21600   IN      NS      ns2.zdns.google.
     
     ;; Query time: 35 msec
     ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
     ;; WHEN: Fri Apr 07 21:54:02 UTC 2023
     ;; MSG SIZE  rcvd: 116
     ```

     Смотрим А-записи:

     ```
     notfounder@srv-grogu13:~$ dig dns.google
     
     ; <<>> DiG 9.18.1-1ubuntu1.3-Ubuntu <<>> dns.google
     ;; global options: +cmd
     ;; Got answer:
     ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2870
     ;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 4, ADDITIONAL: 5
     
     ;; OPT PSEUDOSECTION:
     ; EDNS: version: 0, flags:; udp: 65494
     ;; QUESTION SECTION:
     ;dns.google.                    IN      A
     
     ;; ANSWER SECTION:
     dns.google.             292     IN      A       8.8.4.4
     dns.google.             292     IN      A       8.8.8.8
     
     ;; AUTHORITY SECTION:
     dns.google.             21536   IN      NS      ns1.zdns.google.
     dns.google.             21536   IN      NS      ns2.zdns.google.
     dns.google.             21536   IN      NS      ns3.zdns.google.
     dns.google.             21536   IN      NS      ns4.zdns.google.
     
     ;; ADDITIONAL SECTION:
     ns1.zdns.google.        84473   IN      A       216.239.32.114
     ns2.zdns.google.        86393   IN      A       216.239.34.114
     ns3.zdns.google.        84843   IN      A       216.239.36.114
     ns4.zdns.google.        86393   IN      A       216.239.38.114
     
     ;; Query time: 15 msec
     ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
     ;; WHEN: Fri Apr 07 21:55:07 UTC 2023
     ;; MSG SIZE  rcvd: 212
     ```

8. Проверьте PTR записи для IP-адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой dig

     ```
     notfounder@srv-grogu13:~$ dig -x 8.8.4.4  +noall +answer
     4.4.8.8.in-addr.arpa.   11827   IN      PTR     dns.google.
     notfounder@srv-grogu13:~$ dig -x 8.8.8.8  +noall +answer
     8.8.8.8.in-addr.arpa.   55381   IN      PTR     dns.google.
     ```

     
