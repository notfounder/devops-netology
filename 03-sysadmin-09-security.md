# 3.9. Элементы безопасности информационных систем

1. Установите плагин Bitwarden для браузера. Зарегестрируйтесь и сохраните несколько паролей.

   <img src="https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_01.jpg?raw=true" alt="03-sysadmin-09-security_01.jpg" style="zoom:50%;" />

1. Установите Google Authenticator на мобильный телефон. Настройте вход в Bitwarden-акаунт через Google Authenticator OTP.

   <img src="https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_02.jpg?raw=true" alt="03-sysadmin-09-security_02.jpg" style="zoom:50%;" />

1. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

   Установка Apache используя инструкцию: "[How To Create a Self-Signed SSL Certificate for Apache in Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-20-04)"

   ```sh
   notfounder@srv-grogu-web:~$ sudo apt update
   notfounder@srv-grogu-web:~$ sudo apt install apache2
   ```

   Открываем порты с помощью утилиты ufw:

   ```sh
   notfounder@srv-grogu-web:~$ sudo ufw allow "Apache Full"
   Rule added
   Rule added (v6)
   notfounder@srv-grogu-web:~$ sudo ufw status verbose
   Status: active
   Logging: on (low)
   Default: deny (incoming), allow (outgoing), disabled (routed)
   New profiles: skip
   
   To                         Action      From
   --                         ------      ----
   22/tcp                     ALLOW IN    Anywhere
   80,443/tcp (Apache Full)   ALLOW IN    Anywhere
   22/tcp (v6)                ALLOW IN    Anywhere (v6)
   80,443/tcp (Apache Full (v6)) ALLOW IN    Anywhere (v6)
   ```

   Подключение модуля mod_ssl для Apache:

   ```sh
   notfounder@srv-grogu-web:~$ sudo a2enmod ssl
   Considering dependency setenvif for ssl:
   Module setenvif already enabled
   Considering dependency mime for ssl:
   Module mime already enabled
   Considering dependency socache_shmcb for ssl:
   Enabling module socache_shmcb.
   Enabling module ssl.
   See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
   To activate the new configuration, you need to run:
     systemctl restart apache2
   notfounder@srv-grogu-web:~$ sudo systemctl restart apache2
   ```

   Создание SSL-сертификата:

   ```sh
   notfounder@srv-grogu-web:~$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
   ....+..+...+......+..........+..+.......+..+..................+.+.....+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+......+....+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+...........+............+................+.........+.....+.+..+.......+..+..........+.....+.+..+...+............+......+....+...+.....+.........+....+......+...+......+..+....+...+........+....+........+.............+........+....+.....+.............+...+..+.......+...+............+..+.........+..........+.....+.+.....+...+......+......+................+.....+...+.+.....+....+..+...+....+......+......+..............+....+...+..+.............+...+......+.........+.....+.+...+...........+....+..+.+........+....+.....+............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   ....+...+....+.....+.......+...+...+...+.........+..+.+............+..+...+.+..+..........+..+.+......+......+...+.....+.......+..+.+............+..+...+...+.+...+......+..+.......+............+...+..+...+...+..........+..+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+.+...+.....+.............................................+.+.........+...+..+.......+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+.......+.....+.......+..+.........+.+....................+...+..........+...+...+..+.........+.+..............+....+..+....+.........+......+........+.+.....+.+.....+...+...+...+....+...............+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -----
   You are about to be asked to enter information that will be incorporated
   into your certificate request.
   What you are about to enter is what is called a Distinguished Name or a DN.
   There are quite a few fields but you can leave some blank
   For some fields there will be a default value,
   If you enter '.', the field will be left blank.
   -----
   Country Name (2 letter code) [AU]:RU
   State or Province Name (full name) [Some-State]:Moscow
   Locality Name (eg, city) []:Moscow
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:Netology
   Organizational Unit Name (eg, section) []:DevOps Dept
   Common Name (e.g. server FQDN or YOUR name) []:192.168.88.28
   Email Address []:admin@netology.local
   ```

   Настройка Apache для использования SSL:

   ```
   notfounder@srv-grogu-web:~$ sudo mcedit /etc/apache2/sites-available/netology_local.conf
   ```

   <img src="https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_03.jpg?raw=true" alt="03-sysadmin-09-security_03.jpg" style="zoom:50%;" />

   Включаем наш файл конфигурации:

   ```sh
   notfounder@srv-grogu-web:/var/www/site1$ sudo a2ensite netology_local.conf
   Enabling site netology_local.
   To activate the new configuration, you need to run:
     systemctl reload apache2
   notfounder@srv-grogu-web:/var/www/site1$ sudo systemctl reload apache2
   ```

   ![03-sysadmin-09-security_04.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_04.jpg?raw=true)

1. Проверьте на TLS-уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК и т. п.).

   ![03-sysadmin-09-security_05.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_05.jpg?raw=true)

   ![03-sysadmin-09-security_06.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_06.jpg?raw=true)

   ![03-sysadmin-09-security_07.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_07.jpg?raw=true)

   ![03-sysadmin-09-security_08.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_08.jpg?raw=true)

   ![03-sysadmin-09-security_09.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-09-security_09.jpg?raw=true)

1. Установите на Ubuntu SSH-сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу

   Создаем пару ключей на клиенте:

   ```
   notfounder@srv-grogu13:~$ ssh-keygen
   Generating public/private rsa key pair.
   Enter file in which to save the key (/home/notfounder/.ssh/id_rsa):
   Enter passphrase (empty for no passphrase):
   Enter same passphrase again:
   Your identification has been saved in /home/notfounder/.ssh/id_rsa
   Your public key has been saved in /home/notfounder/.ssh/id_rsa.pub
   The key fingerprint is:
   SHA256:1kg33alZQQ1ctws6owHD3mCiX/Rw2VN0L+qajoJeeZE notfounder@srv-grogu13
   The key's randomart image is:
   +---[RSA 3072]----+
   |            .=+=o|
   |      .   o...oo=|
   |     . O.ooo..=..|
   |    . =.O= .o=...|
   |   .   oE+.++  . |
   |    . .o .o.o    |
   |     oo ..  .    |
   |    .... . o     |
   |   ..  ...+      |
   +----[SHA256]-----+ 
   ```

   Закидываем открытый ключ на сервер к которому планируем подключаться в файл `~/.ssh/authorized_keys`, пережать можно любым способом, с помощью команды `ssh-copy-id` через протокол SFTP или так: 

   ```
   cat ~/.ssh/id_rsa.pub | ssh <USER>@<HOST OR IP> "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"
   ```

   Пробуем:

   ```
   notfounder@srv-grogu13:~$ ssh notfounder@192.168.88.28
   Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.15.0-69-generic aarch64)
   
    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage
   
     System information as of Mon Apr 10 05:49:48 PM UTC 2023
   
     System load:  0.16015625         Processes:               121
     Usage of /:   16.5% of 29.82GB   Users logged in:         1
     Memory usage: 13%                IPv4 address for enp0s5: 192.168.88.28
     Swap usage:   0%
   
    * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
      just raised the bar for easy, resilient and secure K8s cluster deployment.
   
      https://ubuntu.com/engage/secure-kubernetes-at-the-edge
   
    * Introducing Expanded Security Maintenance for Applications.
      Receive updates to over 25,000 software packages with your
      Ubuntu Pro subscription. Free for personal use.
   
        https://ubuntu.com/pro
   
   Expanded Security Maintenance for Applications is not enabled.
   
   28 updates can be applied immediately.
   To see these additional updates run: apt list --upgradable
   
   Enable ESM Apps to receive additional future security updates.
   See https://ubuntu.com/esm or run: sudo pro status
   
   
   Last login: Mon Apr 10 16:56:10 2023 from 192.168.88.15
   notfounder@srv-grogu-web:~$ 
   ```

1. 

   
