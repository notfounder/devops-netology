# 3.2. Работа в терминале, лекция 2

1. Какого типа команда `cd`? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.

  Ответ: cd это встроенная команда оболочки, команда являются частью оболочки и реализована как часть исходного кода оболочки, скомпилирована в исполняемые файлы оболочки. Теоретически ничто не мешает разработчику оболочки реализовать ее как внешнюю команду. Но никто так не делает, потому что в этом нет смысла. Оболочка распознает, что команда, которую ей было предложено выполнить, была одной из ее встроенных функций, и выполняет это действие самостоятельно, не обращаясь к отдельному исполняемому файлу.

<img src="https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_1.png?raw=true" alt="03-sysadmin-01-terminal_1.png"  />

2. Какая альтернатива без pipe команде `grep <some_string> <some_file> | wc -l`? `man grep` поможет в ответе на этот вопрос. Ознакомьтесь с [документом](http://www.smallo.ruhr.de/award.html) о других подобных некорректных вариантах использования pipe.

   Ответ: 

   ![03-sysadmin-01-terminal_2.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_2.png?raw=true)

3. Какой процесс с PID `1` является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?

   Ответ:

   ![03-sysadmin-01-terminal_3.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_3.png?raw=true)

4. Как будет выглядеть команда, которая перенаправит вывод stderr `ls` на другую сессию терминала?

   Ответ: 

   ![03-sysadmin-01-terminal_4.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_4.png?raw=true)

   ![03-sysadmin-01-terminal_5.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_5.png?raw=true)

5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.

   Ответ:

   ![03-sysadmin-01-terminal_6.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_6.png?raw=true)

6. Получится ли находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?

   Ответ: 

   ![03-sysadmin-01-terminal_7.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_7.png?raw=true)

7. Выполните команду `bash 5>&1`. К чему она приведет? Что будет, если вы выполните `echo netology > /proc/$$/fd/5`? Почему так происходит?

   Ответ: Первая команда создала новый дескриптор 5 и перенаправила его в stdout, вторая команда отправила в него слово netology, которую мы получили в stdout на терминале.

   ![03-sysadmin-01-terminal_8.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_8.png?raw=true)

8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от `|` на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.

   Ответ: Получиться, с использованием промежуточного дескриптора.

   7>&2 -  новый дескриптор перенаправили в stderr
   2>&1 - stderr перенаправили в stdout 
   1>&7 - stdout - перенаправили в в новый дескриптор замкнули

   ![03-sysadmin-01-terminal_9.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_9.png?raw=true)

9. Что выведет команда `cat /proc/$$/environ`? Как еще можно получить аналогичный по содержанию вывод?

   Ответ: Команда `cat /proc/$$/environ` выведет нам переменные окружения, аналогичные результат можно получить с помощью команд `env` или `printenv`, только в последнем случае с разделением по строкам переменных.


10. Используя `man`, опишите что доступно по адресам `/proc/<PID>/cmdline`, `/proc/<PID>/exe`.

    Ответ: `/proc/<PID>/cmdline` - полный путь до исполняемого файла процесса.

    `/proc/<PID>/exe` - содержит ссылку до файла запущенного для процесса [PID], выполнение этого файла,  запустит еще одну копию самого файла.

    ![03-sysadmin-01-terminal_10.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_10.png?raw=true)

    ![03-sysadmin-01-terminal_11.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_11.png?raw=true)

11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью `/proc/cpuinfo`.

    Ответ: 4.1

    ![03-sysadmin-01-terminal_12.png](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-01-terminal_12.png?raw=true)

12. При открытии нового окна терминала и `vagrant ssh` создается новая сессия и выделяется pty. Это можно подтвердить командой `tty`, которая упоминалась в лекции 3.2. Однако:

```
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
```

Почитайте, почему так происходит, и как изменить поведение.

Ответ: При выполнении команды ssh localhost 'tty' не выделяется TTY. Поможет ключ -t, который выделит псевдотерминал для команды.

13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись `reptyr`. Например, так можно перенести в `screen` процесс, который вы запустили по ошибке в обычной SSH-сессии.

    Ответ: Получилось согласно этой инструкции https://github.com/nelhage/reptyr#typical-usage-pattern

14. `sudo echo string > /root/new_file` не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без `sudo` под вашим пользователем. Для решения данной проблемы можно использовать конструкцию `echo string | sudo tee /root/new_file`. Узнайте что делает команда `tee` и почему в отличие от `sudo echo` команда с `sudo tee` будет работать.

    Ответ: Будет работать т.к. в данном случае запись в файл будет осуществляться командой tee запущенной от root имеет все права для записи.
