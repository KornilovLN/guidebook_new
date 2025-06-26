# Установка Forgejo сервер контроля версий (СКВ) на srvGit(192.168.88.107)

## Подготовка на VM srvGit папок, переход по ssh и установка forgejo
* **0. Убедится, что установлены git и docker, docker-compose на VM**
  * Установить при их отсутствии 
  * Клонировать Forgejo
```bash
docker pull codeberg.org/forgejo/forgejo:11
```
 
* **1. Создать папки для томов контейнера forgejo**
```bash
#!

# Выяснить свой uid и gid для записи в yml (например 1000:1000):
# - USER_UID=1000
# - USER_GID=1000
echo "UID: $(id -u), GID: $(id -g)"

# Выяснить, куда устанавливать тома: ZB:  /mnt/v720/
# перейти в корень home на VM
cd ~/
sudo mkdir -p /mnt/v720/forgejo/data         # Создать место для volume
sudo chown -R 1000:1000 /mnt/v720/forgejo    # Права для Docker

# После запуска docker-compose.yml  (см. далее)
# Папка ~/forgejo/data создаётся на VM
# Docker контейнер смонтирует её внутрь себя как /data
# репозитории будут физически лежать на диске VM в ~/forgejo/data
```

* **2. Подготовить docker-compose.yml в корне ~/**
```yml
version: '3'

networks:
  forgejo:
    driver: bridge

services:
  server:
    image: codeberg.org/forgejo/forgejo:11
    container_name: forgejo
    environment:
      - USER_UID=1000
      - USER_GID=1000
    restart: unless-stopped
    networks:
      - forgejo
    volumes:
      - /mnt/v720/forgejo/data:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"   # Веб-интерфейс
      - "2222:22"     # SSH для Git

# Запуск
# docker-compose up -d
# Веб-интерфейс: http://srvGit:3000
# SSH для Git: ssh://git@сервер:2222/starmark/new-project.git 
# Проверка сети
# docker network ls
# docker inspect forgejo
```

* **3. Запуск контейнера и проверка результата**
```bash
docker ps | grep forgejo
```
  * Ожидаемый вывод:
```text
CONTAINER ID  IMAGE                          STATUS        PORTS
abcdef123456  codeberg.org/forgejo/forgejo:11  Up 5 minutes  0.0.0.0:3000->3000/tcp, 0.0.0.0:2222->22/tcp
```

* **Вход и настройки через WEB интерфейс на порту 3000**


