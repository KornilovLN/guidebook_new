# Запуск Flask-приложения на удаленном сервере
    доступ к нему из браузера хостовой машины
    нужно отредактировать Dockerfile и скрипты запуска.

## 1. Редактирование Dockerfile
Ваш Dockerfile уже настроен правильно, но давайте убедимся, что он корректно работает с путями на удаленном сервере:
```
### Обновляем список пакетов и устанавливаем необходимые пакеты
FROM python:3.12-slim

### Обновляем список пакетов и устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y nginx docker.io git mc && \
    rm -rf /var/lib/apt/lists/*

### Копируем файл requirements.txt
COPY requirements.txt /app/requirements.txt

### Обновляем pip, setuptools и wheel
RUN pip install --upgrade pip setuptools wheel

### Устанавливаем зависимости Python через pip
RUN pip install -r /app/requirements.txt

### Устанавливаем рабочую директорию
WORKDIR /app

### Копируем конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

### Открываем порт для Nginx
EXPOSE 80

### Запускаем Nginx и Flask приложение при старте контейнера
CMD ["sh", "-c", "nginx && gunicorn -b 0.0.0.0:5000 app:app"]
```

## 2. Редактирование start_cont.sh
```
#!/bin/bash

IMAGENAME="my-flask-img:latest"
CONTAINERNAME="my-flask-cont"
VOLUMENAME="ekatra_flask_data"

# Путь к проекту на удаленном сервере
VOLUMEPATH="/home/starmark/work/poligon_ekatra/flask"
APPPATH="/app"
DATAPATH="/data"

# Порт, который будет доступен извне
PORTHOST=8086
PORTDOCK=80

# Если был запущен, то надо остановить перед перегрузкой
docker stop $CONTAINERNAME 2>/dev/null || true

sleep 2

# Создаем том для контекста, создаваемого приложением
docker volume create $VOLUMENAME

# После останова самоуничтожится
docker run  --rm \
            --name $CONTAINERNAME \
            -p $PORTHOST:$PORTDOCK \
            -v $VOLUMEPATH:$APPPATH \
            -v $VOLUMENAME:$DATAPATH \
            -d \
            $IMAGENAME
            
echo "Контейнер запущен. Приложение доступно по адресу http://$(hostname -I | awk '{print $1}'):$PORTHOST"
```

## 3. Редактирование run_cont.sh
```
#!/bin/bash

IMAGENAME="my-flask-img:latest"
CONTAINERNAME="my-flask-cont"

# Имя тома для данных
VOLUMENAME="ekatra_flask_data"

# Путь к проекту на удаленном сервере
VOLUMEPATH="/home/starmark/work/poligon_ekatra/flask"

# Порт на хосте и Порт в контейнере    
PORTHOST=8089
PORTDOCK=80

# Остановка существующего контейнера
docker stop $CONTAINERNAME 2>/dev/null || true

# Пауза, чтобы контейнер успел остановиться
sleep 2

# Создание тома для данных
docker volume create $VOLUMENAME

# Запуск контейнера
docker run  --rm \
            --name $CONTAINERNAME \
            -p $PORTHOST:$PORTDOCK \
            -v $VOLUMEPATH:/app \
            -v $VOLUMENAME:/data \
            -d \
            $IMAGENAME

echo "Контейнер запущен. Приложение доступно по адресу http://$(hostname -I | awk '{print $1}'):$PORTHOST"
```

## 4. Инструкция по запуску на удаленном сервере
### Подключитесь к удаленному серверу по SSH:
```
ssh gitsrv
```

### Перейдите в каталог с проектом:
```
cd /home/starmark/work/poligon_ekatra/flask
```

### Соберите Docker-образ:
```
docker build -t my-flask-img .
```

### Запустите контейнер с помощью одного из скриптов:
```
bash start_cont.sh
```
* или
```
bash run_cont.sh
```

### После запуска вы увидите сообщение с IP-адресом и портом, по которому доступно приложение.

### Откройте браузер на хостовой машине и введите адрес:
```
http://IP_АДРЕС_СЕРВЕРА:8086
```
* или
```
http://IP_АДРЕС_СЕРВЕРА:8089
```

## Важные замечания:
* флаг -d в команды docker run - контейнер запускается в фоновом режиме.
* Добавлен вывод информации о том, по какому адресу доступно приложение.
* порты 8086 или 8089 должны быть открыты в брандмауэре сервера.
* Если вы хотите, чтобы приложение было доступно по имени домена, вам потребуется настроить DNS и, возможно, обратный прокси-сервер на удаленном сервере.