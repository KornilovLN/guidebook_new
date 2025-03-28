#!/bin/bash

echo "--- Installing Docker --------------------------------------------------------------"
sudo apt update
echo "------------------------------------------------------------------------------------"

echo "--- Installing utils --------------------------------------------------------------"
sudo apt install apt-transport-https ca-certificates curl software-properties-common
echo "------------------------------------------------------------------------------------"

echo "--- Добавьте ключ GPG для официального репозитория Docker в систему ----------------"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "------------------------------------------------------------------------------------"

echo "--- Добавьте репозиторий Docker в источники APT ------------------------------------"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
echo "------------------------------------------------------------------------------------"

echo "--- Обновите БД пакетов и добавьте Docker из недавно добавленного репозитория ------"
sudo apt update
echo "------------------------------------------------------------------------------------"

echo "--- Убедитесь, что установка будет выполняться из репозитория Docker ---------------"
apt-cache policy docker-ce
echo "------------------------------------------------------------------------------------"

echo "--- Установить Docker --------------------------------------------------------------"
sudo apt install docker-ce
echo "------------------------------------------------------------------------------------"

echo "--- Docker установлен, демон запущен, активирован запуск при загрузке --------------"
sudo systemctl status docker
echo "------------------------------------------------------------------------------------"

echo "--- Без sudo при запуске docker, добавьте свое имя пользователя в группу docker ----"
sudo usermod -aG docker ${USER}
echo "------------------------------------------------------------------------------------"

echo "--- Чтобы примен. добавление нового члена группы, выйд. и войдите на сервер или ----"
su - ${USER}
echo "------------------------------------------------------------------------------------"

echo "--- Проверьте, что ваш пользователь добавлен в группу docker, введя следующее ------"
id -nG
echo "------------------------------------------------------------------------------------"

echo "--- Если нужно доб. польз. в группу docker, объявите имя пользователя явно ---------"
sudo usermod -aG docker username
echo "------------------------------------------------------------------------------------"

echo "--- Установка Docker Compose -------------------------------------------------------"
sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose  
echo "------------------------------------------------------------------------------------"

echo "--- Версия Docker Compose ----------------------------------------------------------"
docker-compose --version
echo "------------------------------------------------------------------------------------"  




