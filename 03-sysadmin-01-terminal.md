# 3.1. Работа в терминале, лекция 1

1. Установите средство виртуализации Oracle VirtualBox.
  готово

2. Установите средство автоматизации Hashicorp Vagrant.
  готово

3. В вашем основном окружении подготовьте удобный для дальнейшей работы терминал.
  Имеется SecureCRT и Терминал Windows

4. С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant
  готово

5. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?
  RAM: 1024mb
  CPU: 2 cpu
  HDD: 64gb
  Video: 4mb

6. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
    Добавлением команд в файл Vagrantfile
    v.memory = 1024 
    v.cpus = 2
    или командами:
    ```shell
    config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    end
    ```

7. Команда vagrant ssh из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.

    Готово:

    ```
    C:\Users\vnena\devops-netology\Vagrant>vagrant ssh
    Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/advantage
    
     System information as of Thu 26 May 2022 05:26:20 AM UTC
    
     System load:  0.03               Processes:             118
     Usage of /:   12.2% of 30.88GB   Users logged in:       0
     Memory usage: 26%                IPv4 address for eth0: 10.0.2.15
     Swap usage:   0%
    
    This system is built by the Bento project by Chef Software
    More information can be found at https://github.com/chef/bento
    Last login: Tue May 24 13:49:03 2022 from 10.0.2.2
    vagrant@vagrant:~$
    ```


8. Ознакомиться с разделами man bash, почитать о настройках самого bash

   какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?

   Переменной HISTSIZE описана в мане на 945 строке. Дословное описание:

   ```
   HISTSIZE
   The  number of commands to remember in the command history (see HISTORY below).  If the value is 0, commands are not saved in the history list.  Numeric values less than  zero result in every command being saved on the history list (there is no limit).  The shell sets the default value to 500 after reading any startup files.
   ```

   что делает директива ignoreboth в bash?

   Ответ: директива ignoreboth включает в себя действие двух директив
   ignorespace (не записывать в history строки, начинающиеся с пробела) и
   ignoredups (не записывать в history повторяющиеся строки)

9. В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?

   Описано на 256 строчке.

   ```
   { list; }
                 list is simply executed in the current shell environment.  list must be terminated with  a  newline  or semicolon.  This is known as a group command.  The return status is the exit status of list.  Note that unlike the metacharacters ( and ), { and } are reserved words and must occur where a reserved  word  is permitted  to be recognized.  Since they do not cause a word break, they must be separated from list by whitespace or another shell metacharacter.
   ```

10. С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

    Ответ:

    ```
    vagrant@vagrant:~$ mkdir test_dz
    vagrant@vagrant:~$ cd test_dz/
    vagrant@vagrant:~/test_dz$ touch {1..100000}.txt
    ```

    ```
    vagrant@vagrant:~$ cd test_dz2
    vagrant@vagrant:~/test_dz2$ ls
    vagrant@vagrant:~/test_dz2$
    vagrant@vagrant:~/test_dz2$
    vagrant@vagrant:~/test_dz2$ touch {1..300000}.txt
    -bash: /usr/bin/touch: Argument list too long
    ```

    не получилось создать 300000 файлов

11. В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]

    ```
    [[ expression ]]
                  Return a status of 0 or 1 depending on the evaluation of the conditional  expression  expression.   Ex‐pressions  are composed of the primaries described below under CONDITIONAL EXPRESSIONS.  Word splitting and pathname expansion are not performed on the words between the [[ and ]]; tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, process substitution, and quote re‐moval are performed.  Conditional operators such as -f must be unquoted to be recognized as primaries.
    ```

    Ответ: конструкция [[ -d /tmp ]] проверяет наличие каталога tmp

12. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:

    bash is /tmp/new_path_directory/bash
    bash is /usr/local/bin/bash
    bash is /bin/bash

    Ответ: 

    ```
    vagrant@vagrant:~$ type -a bash
    bash is /usr/bin/bash
    bash is /bin/bash
    vagrant@vagrant:~$ mkdir /tmp/new_path_directory/
    vagrant@vagrant:~$ cp /bin/bash /tmp/new_path_directory/
    vagrant@vagrant:~$ cd /tmp/new_path_directory/
    vagrant@vagrant:~$ PATH=/tmp/new_path_directory/:$PATH
    vagrant@vagrant:~$ type -a bash
    bash is /tmp/new_path_directory/bash
    bash is /usr/bin/bash
    bash is /bin/bash
    vagrant@vagrant:~$
    ```

13. Чем отличается планирование команд с помощью batch и at?

    Ответ: команда **at** используется для назначения одноразового задания на заданное время, а команда **batch** - для назначения одноразовых задач, которые должны выполняться, когда загрузка системы становится меньше 1,5 (т.е. в периоды наименьшей нагрузки)

14. Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.

    ```
    vagrant@vagrant:~$ logout
    Connection to 127.0.0.1 closed.
    
    C:\Users\vnena\devops-netology\Vagrant>vagrant halt
    ==> default: Attempting graceful shutdown of VM...
    
    C:\Users\vnena\devops-netology\Vagrant>
    ```

    
