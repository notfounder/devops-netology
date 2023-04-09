# 3.8. Компьютерные сети. Лекция 3

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP.

   ```
   telnet route-views.routeviews.org
   Username: rviews
   show ip route x.x.x.x/32
   show bgp x.x.x.x/32
   ```

   ```sh
   vagrant@vagrant:/etc/netplan$ telnet route-views.routeviews.org
   Trying 128.223.51.103...
   Connected to route-views.routeviews.org.
   Escape character is '^]'.
   C
   **********************************************************************
   
                       RouteViews BGP Route Viewer
                       route-views.routeviews.org
   
    route views data is archived on http://archive.routeviews.org
   
    This hardware is part of a grant by the NSF.
    Please contact help@routeviews.org if you have questions, or
    if you wish to contribute your view.
   
    This router has views of full routing tables from several ASes.
    The list of peers is located at http://www.routeviews.org/peers
    in route-views.oregon-ix.net.txt
   
    NOTE: The hardware was upgraded in August 2014.  If you are seeing
    the error message, "no default Kerberos realm", you may want to
    in Mac OS X add "default unset autologin" to your ~/.telnetrc
   
    To login, use the username "rviews".
   
    **********************************************************************
   
   User Access Verification
   
   Username: rviews
   route-views>show ip route 176.111.79.153
   Routing entry for 176.111.72.0/21
     Known via "bgp 6447", distance 20, metric 0
     Tag 6939, type external
     Last update from 64.71.137.241 1w2d ago
     Routing Descriptor Blocks:
     * 64.71.137.241, from 64.71.137.241, 1w2d ago
         Route metric is 0, traffic share count is 1
         AS Hops 4
         Route tag 6939
         MPLS label: none
   ```

   ```sh
   route-views>show bgp 176.111.79.153
   BGP routing table entry for 176.111.72.0/21, version 2784669462
   Paths: (20 available, best #5, table default)
     Not advertised to any peer
     Refresh Epoch 1
     3267 29076 47655 47655 47655 47655 47655 47655 47655 47655 47655 47655
       194.85.40.15 from 194.85.40.15 (185.141.126.1)
         Origin IGP, metric 0, localpref 100, valid, external
         path 7FE133E774E8 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     7018 3356 9002 47655 47655 47655 47655
       12.0.1.63 from 12.0.1.63 (12.0.1.63)
         Origin IGP, localpref 100, valid, external
         Community: 7018:5000 7018:37232
         path 7FE019315628 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     8283 57866 9002 47655 47655 47655 47655
       94.142.247.3 from 94.142.247.3 (94.142.247.3)
         Origin IGP, metric 0, localpref 100, valid, external
         Community: 8283:15 8283:102 9002:0 9002:64667 57866:100 65100:9002 65103:1 65104:31
         unknown transitive attribute: flag 0xE0 type 0x20 length 0x48
           value 0000 205B 0000 0005 0000 0002 0000 205B
                 0000 0006 0000 000F 0000 E20A 0000 0064
                 0000 232A 0000 E20A 0000 0065 0000 0064
                 0000 E20A 0000 0067 0000 0001 0000 E20A
                 0000 0068 0000 001F
         path 7FE18CC38CA8 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     3549 3356 9002 47655 47655 47655 47655
       208.51.134.254 from 208.51.134.254 (67.16.168.191)
         Origin IGP, metric 0, localpref 100, valid, external
         Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:901 3356:2067 3549:2581 3549:30840
         path 7FE12C761588 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     6939 47655 47655 47655
       64.71.137.241 from 64.71.137.241 (216.218.253.53)
         Origin IGP, localpref 100, valid, external, best
         path 7FE0827D8A88 RPKI State valid
         rx pathid: 0, tx pathid: 0x0
     Refresh Epoch 1
     20912 3257 9002 47655 47655 47655 47655
       212.66.96.126 from 212.66.96.126 (212.66.96.126)
         Origin IGP, localpref 100, valid, external
         Community: 3257:8052 3257:50001 3257:54900 3257:54901 20912:65004 65535:65284
         path 7FE0E9D2B738 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     20130 6939 47655 47655 47655
       140.192.8.16 from 140.192.8.16 (140.192.8.16)
         Origin IGP, localpref 100, valid, external
         path 7FE0C569ACB8 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     3356 9002 47655 47655 47655 47655
       4.68.4.46 from 4.68.4.46 (4.69.184.201)
         Origin IGP, metric 0, localpref 100, valid, external
         Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:901 3356:2067
         path 7FE18570D188 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     852 3356 9002 47655 47655 47655 47655
       154.11.12.212 from 154.11.12.212 (96.1.209.43)
         Origin IGP, metric 0, localpref 100, valid, external
         path 7FE0B6C153C0 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     57866 9002 47655 47655 47655 47655
       37.139.139.17 from 37.139.139.17 (37.139.139.17)
         Origin IGP, metric 0, localpref 100, valid, external
         Community: 9002:0 9002:64667 57866:100 65100:9002 65103:1 65104:31
         unknown transitive attribute: flag 0xE0 type 0x20 length 0x30
           value 0000 E20A 0000 0064 0000 232A 0000 E20A
                 0000 0065 0000 0064 0000 E20A 0000 0067
                 0000 0001 0000 E20A 0000 0068 0000 001F
   
         path 7FE082FCBDA8 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     3333 9002 47655 47655 47655 47655
       193.0.0.56 from 193.0.0.56 (193.0.0.56)
         Origin IGP, localpref 100, valid, external
         path 7FE0D5CDAE38 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     49788 12552 9002 47655 47655 47655 47655
       91.218.184.60 from 91.218.184.60 (91.218.184.60)
         Origin IGP, localpref 100, valid, external
         Community: 12552:10000 12552:14000 12552:14100 12552:14101 12552:24000
         Extended Community: 0x43:100:0
         path 7FE13E433690 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     101 3356 9002 47655 47655 47655 47655
       209.124.176.223 from 209.124.176.223 (209.124.176.223)
         Origin IGP, localpref 100, valid, external
         Community: 101:20100 101:20110 101:22100 3356:2 3356:22 3356:100 3356:123 3356:503 3356:901 3356:2067
         Extended Community: RT:101:22100
         path 7FE049667568 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     1351 8359 8359 29076 47655 47655 47655 47655 47655 47655 47655 47655 47655 47655
       132.198.255.253 from 132.198.255.253 (132.198.255.253)
         Origin IGP, localpref 100, valid, external
         path 7FE037B56118 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     19214 3257 9002 47655 47655 47655 47655
       208.74.64.40 from 208.74.64.40 (208.74.64.40)
         Origin IGP, localpref 100, valid, external
         Community: 3257:8791 3257:50001 3257:53100 3257:53101 65535:65284
         path 7FE1772E0908 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     3303 6939 47655 47655 47655
       217.192.89.50 from 217.192.89.50 (138.187.128.158)
         Origin IGP, localpref 100, valid, external
         Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7397 6939:8233 6939:9002
         path 7FE008368950 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     4901 6079 9002 47655 47655 47655 47655
       162.250.137.254 from 162.250.137.254 (162.250.137.254)
         Origin IGP, localpref 100, valid, external
         Community: 65000:10100 65000:10300 65000:10400
         path 7FE0FCCBFB48 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     3257 9002 47655 47655 47655 47655
       89.149.178.10 from 89.149.178.10 (213.200.83.26)
         Origin IGP, metric 10, localpref 100, valid, external
         Community: 3257:8052 3257:50001 3257:54900 3257:54901 65535:65284
         path 7FE01F9ADD60 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 1
     3561 3910 3356 9002 47655 47655 47655 47655
       206.24.210.80 from 206.24.210.80 (206.24.210.80)
         Origin IGP, localpref 100, valid, external
         path 7FE1039777B0 RPKI State valid
         rx pathid: 0, tx pathid: 0
     Refresh Epoch 2
     2497 3356 9002 47655 47655 47655 47655
       202.232.0.2 from 202.232.0.2 (58.138.96.254)
         Origin IGP, localpref 100, valid, external
         path 7FE0D2ADA950 RPKI State valid
         rx pathid: 0, tx pathid: 0
   ```

2. Создайте dummy-интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

   Загружаем модуль `dummy`, опцию `numdummies=2` позволяет сразу создать  два dymmy интерфейса: `dummy0` и `dummy1`

   ```sh
   vagrant@vagrant:~$ sudo modprobe -v dummy numdummies=2
   insmod /lib/modules/5.4.0-137-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2
   vagrant@vagrant:~$ lsmod | grep dummy
   dummy                  16384  0
   vagrant@vagrant:~$ ip a
   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
       inet 127.0.0.1/8 scope host lo
          valid_lft forever preferred_lft forever
       inet6 ::1/128 scope host
          valid_lft forever preferred_lft forever
   2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
       link/ether 00:1c:42:b0:31:f8 brd ff:ff:ff:ff:ff:ff
       inet 10.211.55.3/24 brd 10.211.55.255 scope global dynamic eth0
          valid_lft 1340sec preferred_lft 1340sec
       inet6 fdb2:2c26:f4e4:0:21c:42ff:feb0:31f8/64 scope global dynamic mngtmpaddr noprefixroute
          valid_lft 2591636sec preferred_lft 604436sec
       inet6 fe80::21c:42ff:feb0:31f8/64 scope link
          valid_lft forever preferred_lft forever
   3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
       link/ether 3a:fa:3c:a0:e6:a6 brd ff:ff:ff:ff:ff:ff
   4: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
       link/ether 96:e5:1d:d0:ee:0f brd ff:ff:ff:ff:ff:ff
   ```

   Добавляем IP адреса и переводим в UP dummy интерфейсы:

   ```sh
   vagrant@vagrant:~$ sudo ip addr add 192.168.1.150/24 dev dummy0
   vagrant@vagrant:~$ sudo ip addr add 192.168.100.150/24 dev dummy1
   vagrant@vagrant:~$ sudo ip link set dummy0 up
   vagrant@vagrant:~$ sudo ip link set dummy1 up
   vagrant@vagrant:~$ ip a
   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
       inet 127.0.0.1/8 scope host lo
          valid_lft forever preferred_lft forever
       inet6 ::1/128 scope host
          valid_lft forever preferred_lft forever
   2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
       link/ether 00:1c:42:49:22:1d brd ff:ff:ff:ff:ff:ff
       inet 10.211.55.3/24 brd 10.211.55.255 scope global dynamic eth0
          valid_lft 1173sec preferred_lft 1173sec
       inet6 fdb2:2c26:f4e4:0:21c:42ff:fe49:221d/64 scope global dynamic mngtmpaddr noprefixroute
          valid_lft 2591968sec preferred_lft 604768sec
       inet6 fe80::21c:42ff:fe49:221d/64 scope link
          valid_lft forever preferred_lft forever
   3: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
       link/ether f6:78:36:fd:3a:ec brd ff:ff:ff:ff:ff:ff
       inet 192.168.1.150/24 scope global dummy0
          valid_lft forever preferred_lft forever
       inet6 fe80::f478:36ff:fefd:3aec/64 scope link
          valid_lft forever preferred_lft forever
   4: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
       link/ether e6:3c:e0:44:b8:cd brd ff:ff:ff:ff:ff:ff
       inet 192.168.100.150/24 scope global dummy1
          valid_lft forever preferred_lft forever
       inet6 fe80::e43c:e0ff:fe44:b8cd/64 scope link
          valid_lft forever preferred_lft forever
   ```

   Текущие маршруты:

   ```sh
   vagrant@vagrant:~$ ip route
   default via 10.211.55.1 dev eth0 proto dhcp src 10.211.55.3 metric 100
   10.211.55.0/24 dev eth0 proto kernel scope link src 10.211.55.3
   10.211.55.1 dev eth0 proto dhcp scope link src 10.211.55.3 metric 100
   192.168.1.0/24 dev dummy0 proto kernel scope link src 192.168.1.150
   192.168.100.0/24 dev dummy1 proto kernel scope link src 192.168.100.150
   ```

   Добавляем несколько статических маршрутов:

   ```sh
   vagrant@vagrant:~$ sudo ip route add 8.8.8.8 via 192.168.1.150
   vagrant@vagrant:~$ sudo ip route add 10.10.1.0/24 dev dummy0
   vagrant@vagrant:~$ ip route
   default via 10.211.55.1 dev eth0 proto dhcp src 10.211.55.3 metric 100
   8.8.8.8 via 192.168.1.150 dev dummy0
   10.10.1.0/24 dev dummy0 scope link
   10.211.55.0/24 dev eth0 proto kernel scope link src 10.211.55.3
   10.211.55.1 dev eth0 proto dhcp scope link src 10.211.55.3 metric 100
   192.168.1.0/24 dev dummy0 proto kernel scope link src 192.168.1.150
   192.168.100.0/24 dev dummy1 proto kernel scope link src 192.168.100.150 
   ```

   ![03-sysadmin-08-net_01.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-08-net_01.jpg?raw=true)

3. Проверьте открытые TCP-порты в Ubuntu. Какие протоколы и приложения используют эти порты? Приведите несколько примеров.

   ```
   vagrant@vagrant:~$ sudo ss -tlpn
   State      Recv-Q     Send-Q         Local Address:Port         Peer Address:Port     Process
   LISTEN     0          4096           127.0.0.53%lo:53                0.0.0.0:*         users:(("systemd-resolve",pid=690,fd=13))
   LISTEN     0          128                  0.0.0.0:22                0.0.0.0:*         users:(("sshd",pid=1601,fd=3))
   LISTEN     0          128                     [::]:22                   [::]:*         users:(("sshd",pid=1601,fd=4))
   ```

4. Проверьте используемые UDP-сокеты в Ubuntu. Какие протоколы и приложения используют эти порты?

   ```
   vagrant@vagrant:~$ sudo ss -lupn
   State     Recv-Q     Send-Q            Local Address:Port         Peer Address:Port    Process
   UNCONN    0          0                 127.0.0.53%lo:53                0.0.0.0:*        users:(("systemd-resolve",pid=690,fd=12))
   UNCONN    0          0              10.211.55.3%eth0:68                0.0.0.0:*        users:(("systemd-network",pid=688,fd=15))
   ```

   53 - DNS, 22 - SSH порт

5. Используя diagrams.net, создайте L3-диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

   ![03-sysadmin-08-net_02.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-08-net_02.jpg?raw=true)

   
