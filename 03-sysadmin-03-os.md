# 3.3. Операционные системы, лекция 1

1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd.
    Ответ: `chdir("/tmp")`

  <img src="https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_13.png?raw=true" alt="03-sysadmin-01-terminal_13.png"  />

2. Попробуйте использовать команду `file` на объекты разных типов на файловой системе. Например:

   ```
   vagrant@netology1:~$ file /dev/tty
   /dev/tty: character special (5/0)
   vagrant@netology1:~$ file /dev/sda
   /dev/sda: block special (8/0)
   vagrant@netology1:~$ file /bin/bash
   /bin/bash: ELF 64-bit LSB shared object, x86-64
   ```

   Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.

   Ответ:

   ![03-sysadmin-01-terminal_14.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_14.png?raw=true)

   ![03-sysadmin-01-terminal_15.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_15.png?raw=true)

3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

   Ответ:

   Воссоздадим ситуацию описанную выше:

   ![03-sysadmin-01-terminal_16.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_16.png?raw=true)

   ![03-sysadmin-01-terminal_17.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_17.png?raw=true)

   А теперь самое решение задачи:

   ![03-sysadmin-01-terminal_18.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_18.png?raw=true)

4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

   Ответ: Нет зомби-процессы не занимают ресурсы ОС, но занимают запись в таблице процессов.

5. В iovisor BCC есть утилита `opensnoop`:

   ```
   root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
   /usr/sbin/opensnoop-bpfcc
   ```

   На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04.

   Ответ: 

6. 
