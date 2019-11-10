## Системные требования
1. PHP не ниже 7.1
1. Операционная система Ubuntu 16.04LTS. Можно любую другую linux систему, но тогда возможно некоторые
из приведенных команд придется скорректировать.

## Подготовка системного окружения
1. Добавляем в систему репозиторий с нужной версией PHP:
    ```bash
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update
    ```
1. Устанавливаем требуемые пакеты:
    ```bash
    sudo apt-get install wget git php7.1 php7.1-cli php7.1-common php7.1-json php7.1-mbstring php7.1-mysql php7.1-odbc
    ```
1. Установка Postgres:
    ```bash
    echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update && sudo apt-get install -y postgresql-11
    ```
    Отредактировать файл (либо убедиться что указанная строка там есть) `/etc/postgresql/11/main/pg_hba.conf` заменив `host all all 127.0.0.1/32 ident` на `host all all 127.0.0.1/32 md5` (т.е. включив вход по паролю для всех клиентов)
1. Создаем базу данных:
    - подсоединяемся к серверу:
        ```bash
        sudo -u postgres psql
        ```
    - создаем пользователя и базу:
        ```postgresql
        CREATE DATABASE vigron;
        CREATE USER vigron WITH PASSWORD 'xa8Ooxay';
        GRANT ALL ON DATABASE vigron TO vigron;
        ```

## Развертывание
1. Клонируем проект в домашную директорию:
    ```bash
    mkdir ~/vigron
    cd ~/vigron
    git clone https://github.com/alekciy/vigron .
    ```
1. Устанавливаем локальный [composer](https://getcomposer.org/download/) и ставим пакеты:
    ```bash
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
   ./composer.phar install
    ```
1. Накатываем базу:
1. Запускам приложение командой: `./composer.phar run-script start`, теперь запросы принимаются на 127.0.0.1 порт 8080
