#!/usr/bin/env bash
##############################
#Project: Homework Netology
#Version 1.0
#(c) 2023 Notfounder
##############################

ip_address=("192.168.0.1" "173.194.222.113" "87.250.250.242")
port=80

for ip_check in ${ip_address[@]}; do #перебираем массив ip адресов

    for ((count = 1; count < 6; count++)); do #перебираем каждое значение из массива 5 раз
        date=$(date "+%d.%m.%Y %H:%M:%S")
        nc -w 1 -z $ip_check $port 2>/dev/null #проверяем доступность IP адреса по порту

        if (($? == 0)); then

            result="$date available IP:$ip_check:$port"

        else

            result="$date NOT AVAILABLE IP:$ip_check:$port"
            echo $result >>available_error.log #записываем в error log результат
            exit 0                             #завершаем работу скрипта
        fi

        echo $result >>available.log #записываем результат

    done

done
