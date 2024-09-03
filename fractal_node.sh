#!/bin/bash
tput reset
tput civis

# Put your logo here if necessary

echo -e "\e[33m"
echo -e '----------_____--------------------_____----------------_____----------'
echo -e '---------/\----\------------------/\----\--------------/\----\---------'
echo -e '--------/::\____\----------------/::\----\------------/::\----\--------'
echo -e '-------/:::/----/---------------/::::\----\-----------\:::\----\-------'
echo -e '------/:::/----/---------------/::::::\----\-----------\:::\----\------'
echo -e '-----/:::/----/---------------/:::/\:::\----\-----------\:::\----\-----'
echo -e '----/:::/____/---------------/:::/__\:::\----\-----------\:::\----\----'
echo -e '----|::|----|---------------/::::\---\:::\----\----------/::::\----\---'
echo -e '----|::|----|-----_____----/::::::\---\:::\----\--------/::::::\----\--'
echo -e '----|::|----|----/\----\--/:::/\:::\---\:::\----\------/:::/\:::\----\-'
echo -e '----|::|----|---/::\____\/:::/--\:::\---\:::\____\----/:::/--\:::\____\'
echo -e '----|::|----|--/:::/----/\::/----\:::\--/:::/----/---/:::/----\::/----/'
echo -e '----|::|----|-/:::/----/--\/____/-\:::\/:::/----/---/:::/----/-\/____/-'
echo -e '----|::|____|/:::/----/------------\::::::/----/---/:::/----/----------'
echo -e '----|:::::::::::/----/--------------\::::/----/---/:::/----/-----------'
echo -e '----\::::::::::/____/---------------/:::/----/----\::/----/------------'
echo -e '-----~~~~~~~~~~--------------------/:::/----/------\/____/-------------'
echo -e '----------------------------------/:::/----/---------------------------'
echo -e '---------------------------------/:::/----/----------------------------'
echo -e '---------------------------------\::/----/-----------------------------'
echo -e '----------------------------------\/____/------------------------------'
echo -e '-----------------------------------------------------------------------'
echo -e '\e[0m'

echo -e "\n \e[33mПодпишись на мой канал\e[0m Beloglazov invest, \n чтобы быть в курсе самых актуальных нод и активностей \n \e[33mhttps://t.me/beloglazovinvest \e[0m \n"

sleep 2

while true; do
    echo "1. Подготовка к установке Fractal (Preparation)"
    echo "2. Установка Fractal (Install)"
    echo "3. Создать кошелек (Create wallet)"
    echo "4. Запустить или перезапустить ноду (Start or restart node)"
    echo "5. Посмотреть private key (Check private key)"
    echo "6. Проверить логи (Check logs)"
    echo "7. Удалить ноду (Delete Node)"
    echo "8. Выход (Exit)"
    echo ""
    read -p "Выберите опцию (Select option): " option

    case $option in
        1)
            # System preparation
            echo -e "\e[33mНачинаем подготовку (Starting preparation)...\e[0m"
            sleep 1
            echo -e "\e[33mОбновляем пакеты (Updating packages)...\e[0m"
            if sudo apt update & sudo apt upgrade -y && sudo apt install ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev curl git wget make jq build-essential pkg-config lsb-release libssl-dev libreadline-dev libffi-dev gcc screen unzip lz4 -y; then
                sleep 1
                echo -e "Обновление пакетов (Updating packages): \e[32mУспешно (Success)\e[0m"
                echo ""
            else
                echo -e "Обновление пакетов (Updating packages): \e[31mОшибка (Error)\e[0m"
                echo ""
                exit 1
            fi
            echo -e "\e[33m--- ПОДГОТОВКА ЗАВЕРШЕНА. PREPARATION COMPLETED ---\e[0m"
            echo ""
            ;;
        2)
            # Download tar
            echo -e "\e[33mУстанавливаем Fractal (Installing Fractal)...\e[0m"
            sleep 1

            echo -e "\e[33mСкачиваем (Downloading)...\e[0m"
            if wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v0.1.7/fractald-0.1.7-x86_64-linux-gnu.tar.gz; then
                sleep 1
                echo -e "Download (Скачивание): \e[32mSuccess\e[0m"
                echo ""
            else
                echo -e "Download (Скачивание): \e[31mError\e[0m"
                echo ""
                exit 1
            fi

            # Unpack tar
            echo -e "\e[33mРаспаковка (Unpacking)...\e[0m"
            if tar -zxvf fractald-0.1.7-x86_64-linux-gnu.tar.gz; then
                sleep 1
                echo -e "Распаковка (Unpacking): \e[32mSuccess\e[0m"
                echo ""
            else
                echo -e "Распаковка (Unpacking): \e[31mError\e[0m"
                echo ""
                exit 1
            fi

            # Change dir
            echo -e "\e[33mСоздаем путь (Creating dir)...\e[0m"
            if cd fractald-0.1.7-x86_64-linux-gnu/ && mkdir data && cp ./bitcoin.conf ./data; then
                sleep 1
                echo -e "Создан (Created): \e[32mSuccess\e[0m"
                echo ""
            else
                echo -e "Создан (Created): \e[31mError\e[0m"
                echo ""
                exit 1
            fi

            # Create service file
            echo -e "\e[33mСоздаем сервис (Creating service)...\e[0m"
            sleep 1

            if sudo bash -c 'cat << EOF > /etc/systemd/system/fractald.service
                [Unit]
                Description=Fractal Node
                After=network-online.target

                [Service]
                User=$USER
                ExecStart=/root/fractald-0.1.7-x86_64-linux-gnu/bin/bitcoind -datadir=/root/fractald-0.1.7-x86_64-linux-gnu/data/ -maxtipage=504576000
                Restart=always
                RestartSec=5
                LimitNOFILE=infinity

                [Install]
                WantedBy=multi-user.target
                EOF'; then
                sleep 1
                echo -e "Сервис фаил создан (Service file created): \e[32mУспешно (Success)\e[0m"
                echo ""
            else
                echo -e "Создан сервис (Service created): \e[31mОшибка (Error)\e[0m"
                echo ""
                exit 1
            fi
            echo -e "\e[33m--- УСТАНОВКА ЗАВЕРШЕНА. INSTALLATION COMPLETED ---\e[0m"
            echo ""
            ;;
        3)
            # Creating bitcoin wallet
            echo -e "\e[33mСоздаем кошелек (Creating wallet)...\e[0m"
            cd bin
            ./bitcoin-wallet -wallet=wallet -legacy create
            cd /root/fractald-0.1.7-x86_64-linux-gnu/bin
            ./bitcoin-wallet -wallet=/root/.bitcoin/wallets/wallet/wallet.dat -dumpfile=/root/.bitcoin/wallets/wallet/MyPK.dat dump

            if [ $? -eq 0 ]; then
                sleep 1
                echo -e "Кошелек создан (Wallet created): \e[32mУспешно (Success)\e[0m"
                echo ""
            else
                echo -e "Кошелек создан (Wallet created): \e[31mОшибка (Error)\e[0m"
                echo ""
                exit 1
            fi

            echo -e "\e[34mИщем private key (Looking for privat key)...\e[0m"
            sleep 2
            cd && awk -F 'checksum,' '/checksum/ {print "Wallet Private Key:" $2}' .bitcoin/wallets/wallet/MyPK.dat
            echo ""
            ;;
        4)
            # Starting or restarting node
            if [ -f "/etc/systemd/system/fractald.service" ]; then
                echo -e "\e[33mРестарт ноды (Restarting node)...\e[0m"
                sleep 1
                    if sudo systemctl restart fractald; then
                        sleep 1
                        echo -e "Рестарт выполнен (Restart completed): \e[32mУспешно (Success)\e[0m"
                        echo ""
                    else
                        echo -e "Рестарт выполнен (Restart completed): \e[31mОшибка (Error)\e[0m"
                        echo ""
                    fi
            else
                echo -e "\e[33mЗапуск ноды (Starting node)...\e[0m"
                if sudo systemctl daemon-reload && sudo systemctl enable fractald && sudo systemctl start fractald; then
                    sleep 1
                    echo -e "Запущена (Started): \e[32mУспешно (Success)\e[0m"
                    echo ""
                else
                    echo -e "Запущена (Started): \e[31mОшибка (Error)\e[0m"
                    echo ""
                fi
            fi
            echo ""
            ;;
        5)
            # Print priv key
            echo -e "\e[34mИщем private key (Looking for privat key)...\e[0m"
            sleep 2
            cd && awk -F 'checksum,' '/checksum/ {print "Wallet Private Key:" $2}' .bitcoin/wallets/wallet/MyPK.dat
            echo ""
            ;;
        6)
            # Check logs
            sudo journalctl -u fractald -f --no-hostname -o cat
            ;;
        7)
            # Delete node
            echo -e "\e[33mУдаление ноды (Deletting Node)...\e[0m"
            sleep 1

            echo -e "\e[33mОстановка ноды (Stopping node)...\e[0m"
            if sudo systemctl stop fractald; then
                sleep 1
                echo -e "Остановлена (Stopped): \e[32mУспешно (Success)\e[0m"
                echo ""
            else
                echo -e "\e[34mНода не запущена (Node isn't running)\e[0m"
                echo ""
            fi

            echo -e "\e[33mУдаление сервиса (Deleting service)...\e[0m"
            if sudo rm -rf /etc/systemd/system/fractald.service; then
                sleep 1
                echo -e "Удален (Deleted): \e[32mУспешно (Success)\e[0m"
                echo ""
            else
                echo -e "\e[34mСервис не найден (Service not Found)\e[0m"
                echo ""
            fi

            echo -e "\e[33mУдаление ноды (Deleting node)...\e[0m"
            if sudo rm -rf /root/fractald-0.1.7-x86_64-linux-gnu/; then
                sleep 1
                echo -e "Удалена (Deleted): \e[32mУспешно (Success)\e[0m"
                echo ""
            else
                echo -e "\e[34mДиректория не найдена (Dir not Found)\e[0m"
                echo ""
            fi

            echo -e "\e[33m--- УДАЛЕНИЕ ЗАВЕРШЕНО. DELETING COMPLETED ---\e[0m"
            echo ""
            ;;
        8)
            # Stop script and exit
            echo -e "\e[31mСкрипт остановлен (Script stopped)\e[0m"
            echo ""
            exit 0
            ;;
    esac
done
