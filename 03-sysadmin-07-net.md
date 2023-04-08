# 3.7. Компьютерные сети. Лекция 2

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

   Linux: `ip a`, `ip link show`, `ifconfig`

   ```
   notfounder@srv-grogu13:~$ ip a
   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
       inet 127.0.0.1/8 scope host lo
          valid_lft forever preferred_lft forever
       inet6 ::1/128 scope host
          valid_lft forever preferred_lft forever
   2: enp0s5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
       link/ether 00:1c:42:5c:42:81 brd ff:ff:ff:ff:ff:ff
       inet 192.168.88.26/24 metric 100 brd 192.168.88.255 scope global dynamic enp0s5
          valid_lft 578sec preferred_lft 578sec
       inet6 fe80::21c:42ff:fe5c:4281/64 scope link
          valid_lft forever preferred_lft forever
   ```

   ```
   notfounder@srv-grogu13:~$ ip link show
   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
   2: enp0s5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
       link/ether 00:1c:42:5c:42:81 brd ff:ff:ff:ff:ff:ff
   ```

   ```
   notfounder@srv-grogu13:~$ ifconfig
   enp0s5: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
           inet 192.168.88.26  netmask 255.255.255.0  broadcast 192.168.88.255
           inet6 fe80::21c:42ff:fe5c:4281  prefixlen 64  scopeid 0x20<link>
           ether 00:1c:42:5c:42:81  txqueuelen 1000  (Ethernet)
           RX packets 34955  bytes 33549318 (33.5 MB)
           RX errors 0  dropped 66  overruns 0  frame 0
           TX packets 9378  bytes 950872 (950.8 KB)
           TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
   
   lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
           inet 127.0.0.1  netmask 255.0.0.0
           inet6 ::1  prefixlen 128  scopeid 0x10<host>
           loop  txqueuelen 1000  (Local Loopback)
           RX packets 254  bytes 29347 (29.3 KB)
           RX errors 0  dropped 0  overruns 0  frame 0
           TX packets 254  bytes 29347 (29.3 KB)
           TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
   ```

   Windows: `ipconfig /all`

2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

   **Ответ:** Для распознавания соседа по сетевому интерфейсу в Linux используется протокол LLDP. Пакет `lldpd`, команда `lldpctl`

   Протоколы других вендоров:

   LLDP (Link Layer Discovery Protocol)
   CDP (Cisco Discovery Protocol)
   FDP (Foundry Discovery Protocol)
   NDP (Nortel Discovery Protocol)
   EDP (Extreme Discovery Protocol)
   LLTD (Link Layer Topology Discovery)

3. Какая технология используется для разделения L2-коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

   Для разделения L2 коммутатора на несколько виртуальных сетей используется технология VLAN (Virtual Local Area Network).

   Пакет для управления VLAN: `vlan`, `iproute2`, `NetworkManager`, `vconfig`

   ```
   network:
     version: 2
     renderer: networkd
     ethernets:
       eth0:
         optional: yes
         addresses: 
           - 192.168.0.2/24
     vlans:
       vlan13:
         id: 13
         link: eth0 
         addresses:
           - 192.168.1.2/24
   ```

4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

   В Linux есть две технологии агрегации (LAG): `bonding` и `teaming`.

   `Bonding` – это объединение сетевых интерфейсов по определенному типу агрегации, Служит для увеличения пропускной способности и/или отказоустойчивость сети.

   Типы агрегации интерфейсов в Linux:

   `Mode-0(balance-rr)` – Данный режим используется по умолчанию. Balance-rr обеспечивается балансировку нагрузки и отказоустойчивость. В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему. Если выходят из строя интерфейсы, пакеты отправляются на остальные оставшиеся. Дополнительной настройки коммутатора не требуется при нахождении портов в одном коммутаторе. При разностных коммутаторах требуется дополнительная настройка.

   `Mode-1(active-backup)` – Один из интерфейсов работает в активном режиме, остальные в ожидающем. При обнаружении проблемы на активном интерфейсе производится переключение на ожидающий интерфейс. Не требуется поддержки от коммутатора.

   `Mode-2(balance-xor)` – Передача пакетов распределяется по типу входящего и исходящего трафика по формуле ((MAC src) XOR (MAC dest)) % число интерфейсов. Режим дает балансировку нагрузки и отказоустойчивость. Не требуется дополнительной настройки коммутатора/коммутаторов.

   `Mode-3(broadcast)` – Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость. Рекомендуется только для использования MULTICAST трафика.

   `Mode-4(802.3ad)` – динамическое объединение одинаковых портов. В данном режиме можно значительно увеличить пропускную способность входящего так и исходящего трафика. Для данного режима необходима поддержка и настройка коммутатора/коммутаторов.

   `Mode-5(balance-tlb)` – Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

   `Mode-6(balance-alb)` – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

   Для настройки объединения интерфейсов необходимо отредактировать файл `/etc/network/interfaces` конфигурации сети

   ```sh
   # The loopback network interface
   auto lo
   iface lo inet loopback
   
   # The primary network interface
   auto bond0 eth0 eth1
   # настроим параметры бонд-интерфейса
   iface bond0 inet static
   # адрес, маска, шлюз. (можно еще что-нибудь по вкусу)
           address 10.0.0.11
           netmask 255.255.255.0
           gateway 10.0.0.254
           # определяем подчиненные (объединяемые) интерфейсы
           bond-slaves eth0 eth1
           # задаем тип бондинга
           bond-mode balance-alb
           # интервал проверки линии в миллисекундах
   bond-miimon 100
           # Задержка перед установкой соединения в миллисекундах
   bond-downdelay 200
   # Задержка перед обрывом соединения в миллисекундах
           bond-updelay 200
   ```

5. Сколько IP-адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

   ![03-sysadmin-07-net_1.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-07-net_1.jpg?raw=true)

   В сети c маской /29 имеются 6 IP адресов.

   Разобьем сеть 10.10.10.0/24 на подсети /29 с помощью команды sipcalc:

   ![03-sysadmin-07-net_02.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-07-net_02.jpg?raw=true)

   и подсчитаем количество сетей /29 в сети /24:

   ```sh
   vagrant@vagrant:/etc/netplan$ sipcalc 10.10.10.0/24  -s 29 | grep Network | wc
        32     160    1363
   ```

6. Задача: вас попросили организовать стык между двумя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP-адреса? Маску выберите из расчёта — максимум 40–50 хостов внутри подсети.

   **Ответ:** Существует всего 4 диапазона, которые определены для частных сетей 3 из них заняты, нам остался диапазон 100.64.0.0 - 100.127.255.255 с маской /10
   10.64.0.0/26 - на 64 адреса

7. Как проверить ARP-таблицу в Linux, Windows? Как очистить ARP-кеш полностью? Как из ARP-таблицы удалить только один нужный IP?

   Посмотреть в Linux: `arp` или `ip neigh` в Windows: `arp -a`

   ```sh
   vagrant@vagrant:/etc/netplan$ arp
   Address                  HWtype  HWaddress           Flags Mask            Iface
   prl-local-ns-server.sha  ether   00:1c:42:00:00:18   C                     eth0
   10.211.55.2              ether   ae:c9:06:00:1e:64   C                     eth0
   
   vagrant@vagrant:/etc/netplan$ ip neigh
   10.211.55.1 dev eth0 lladdr 00:1c:42:00:00:18 STALE
   10.211.55.2 dev eth0 lladdr ae:c9:06:00:1e:64 REACHABLE
   fe80::21c:42ff:fe00:18 dev eth0 lladdr 00:1c:42:00:00:18 router STALE
   ```

   Очистить ARP-кеш полностью в Linunx: `ip neigh flush all` в Windows: `arp -d `

   Удалить один `IP в Linux: ip neigh delete <IP> dev <INTERFACE>`, `arp -d <IP>` в Windows: `arp -d <IP>`

   
