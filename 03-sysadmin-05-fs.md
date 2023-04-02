# 3.5. Файловые системы

1. Что такое разрежённый файл ([sparse-файлах](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB))?

   **Разрежённый файл** (англ. sparse file) — файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях (список дыр).

   **Дыра** (англ. hole) — последовательность нулевых байт внутри файла, не записанная на диск. Информация о дырах (смещение от начала файла в байтах и количество байт) хранится в метаданных файловой системы.

   Типы ФС поддерживающие разрежённые файлы: BTRFS, NILFS, ZFS, NTFS[2], ext2, ext3, ext4, XFS, JFS, ReiserFS, Reiser4, UFS, Rock Ridge, UDF, ReFS, APFS, F2FS.

2. Могут ли файлы, являющиеся жёсткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

     Нет не могут, т.к. жесткая ссылка имеет тот же inode что и оригинальный файл.

3. 

4. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

     поместите его в автозагрузку,
     предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
     удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

     **Решение:**

     Установка node_exporter:

     ![03-sysadmin-01-terminal_22.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_22.png?raw=true)

     Создал unit-файл и предусмотрел возможность добавления опций к запускаемому процессу через внешний файл:

     ![03-sysadmin-01-terminal_23.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_23.png?raw=true)

     ```
     vagrant@vagrant:~$ systemctl daemon-reload
     ==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ===
     Authentication is required to reload the systemd state.
     Authenticating as: vagrant
     Password:
     ==== AUTHENTICATION COMPLETE ===
     vagrant@vagrant:~$ sudo systemctl enable node_exporter
     ```

     Стартовали:

     ![03-sysadmin-01-terminal_24.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_24.png?raw=true)

     Небольшой тюнинг конфигурации vagrantfile открыл порт:

     ![03-sysadmin-01-terminal_25.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_25.png?raw=true)

     Готово:

     ![03-sysadmin-01-terminal_26.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_26.png?raw=true)

     В процессе развертывания несколько раз делал vagrant reload все поднимается и стартует автоматический.

5. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

   **Ответ:** 

   CPU:

   ```
   node_cpu_seconds_total{cpu="0",mode="idle"} 413.53
   node_cpu_seconds_total{cpu="0",mode="iowait"} 2.91
   node_cpu_seconds_total{cpu="0",mode="irq"} 0
   node_cpu_seconds_total{cpu="0",mode="nice"} 0
   node_cpu_seconds_total{cpu="0",mode="softirq"} 0.24
   node_cpu_seconds_total{cpu="0",mode="steal"} 0
   node_cpu_seconds_total{cpu="0",mode="system"} 3.16
   node_cpu_seconds_total{cpu="0",mode="user"} 1.88
   node_cpu_seconds_total{cpu="1",mode="idle"} 406.16
   node_cpu_seconds_total{cpu="1",mode="iowait"} 2.23
   node_cpu_seconds_total{cpu="1",mode="irq"} 0
   node_cpu_seconds_total{cpu="1",mode="nice"} 0
   node_cpu_seconds_total{cpu="1",mode="softirq"} 0.02
   node_cpu_seconds_total{cpu="1",mode="steal"} 0
   node_cpu_seconds_total{cpu="1",mode="system"} 3.6
   node_cpu_seconds_total{cpu="1",mode="user"} 2.3
   process_cpu_seconds_total 311933.19
   ```

   Memory:

   ```
   node_memory_MemTotal_bytes 1.028685824e+09
   node_memory_MemAvailable_bytes 7.30718208e+08
   node_memory_SwapFree_bytes 2.057302016e+09
   ```

   Disk:

   ```
   node_disk_io_time_seconds_total{device="dm-0"} 17.78
   node_disk_io_time_seconds_total{device="sda"} 17.976
   node_disk_read_bytes_total{device="dm-0"} 4.58556416e+08
   node_disk_read_bytes_total{device="sda"} 4.67933184e+08
   node_disk_write_time_seconds_total{device="dm-0"} 15.56
   node_disk_write_time_seconds_total{device="sda"} 6.405
   ```

   Network:

   ```
   node_network_receive_errs_total{device="eth0"} 0
   node_network_receive_bytes_total{device="eth0"} 57192
   node_network_transmit_bytes_total{device="eth0"} 64532
   node_network_transmit_errs_total{device="eth0"} 0
   ```

6. Результат установки и первичной настройки Netdata:

     ![03-sysadmin-01-terminal_27.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_27.png?raw=true)

7. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

     Ответ: Да

     ```
     vagrant@vagrant:~$ dmesg |grep virt
     [    0.005607] CPU MTRRs all blank - virtualized system.
     [    0.040774] Booting paravirtualized kernel on KVM
     [   12.133478] systemd[1]: Detected virtualization oracle.
     ```

8. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?

     Ответ: Переменная `fs.nr_open` обозначает максимальное количество файловых дескрипторов, которые может выделить процесс. Значение по умолчанию - 1024*1024 (1048576) определено в коде ядра, чего должно быть достаточно для большинства машин. Значение «Максимальное количество открытых файлов» ( `ulimit -n`) ограничено `fs.nr_open` значением.

     Из справки:

     -n        the maximum number of open file descriptors

     ```
     vagrant@vagrant:~$ /sbin/sysctl -n fs.nr_open
     1048576
     vagrant@vagrant:~$ ulimit -n
     1024
     vagrant@vagrant:~$
     ```

     ```
     vagrant@vagrant:~$ ulimit -n
     1024
     vagrant@vagrant:~$
     ```

9. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.

     Ответ:

     ![03-sysadmin-01-terminal_28.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_28.png?raw=true)

     ![03-sysadmin-01-terminal_29.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_29.png?raw=true)

10. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

     Ответ:

     ![03-sysadmin-01-terminal_30.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_30.png?raw=true)

     ![03-sysadmin-01-terminal_31.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_31.png?raw=true)

     Это fork bomb, за счет системного вызова `fork()`

     Используя команду `ulimit -u 30` можно ограничить количество запущенных процессов для пользователя.
