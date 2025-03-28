## Туннелирование

#### Для связи localhost машины оператора с localhost удаленной машины
```
ssh -L 8081:localhost:8080 starmark@192.168.88.103
ssh -L 8082:localhost:8080 starmark@192.168.88.104
ssh -L 8083:localhost:8080 starmark@192.168.88.105
ssh -L 8080:localhost:8080 starmark@gitlab.ivl.ua
```

#### Пример такой - Установить Apache и вывести в index.php его настройки_**

**_Проект находится на 192.168.88.105 удаленной VM_**
<br>И состоит из 3-х файлов:
```
#Dockerfile

#Образ с DockerHub, включает Apache и PHP
FROM php:7.2-apache

#Копируем все файлы проекта в контейнер
COPY . /var/www/html

#Сообщаем, какие порты контейнера слушать
EXPOSE 80  
```

```
#docker-compose.yml

starmark@nppt:~/www$ cat do*
version: '3.8'
services:
  app:
    build:
      context: .
    ports:
      - 8080:80
```

``` 
<!-- index.html -->

<h1>Hello from Apache</h1>
<?php phpinfo(); ?>   
```

**_Запуск контейнера из VM или из хоста_**

<запуск проекта на удаленной VM>
```
docker-compose up -d
```

<запуск проекта на удаленной VM>
```
ssh starmark@192.168.88.105 'cd ~/www && docker-compose up -d'
```

#### Как настраивать туннелирование

**_Сначала убедитесь, что ваш Docker контейнер запущен на удаленном сервере_**
<br>Если нет, запустите его (можно удаленно):
```
ssh starmark@192.168.88.105 'cd ~/www && docker-compose up -d'
```

**_Теперь создайте SSH-туннель_**
<br>Выполните следующую команду на вашем локальном компьютере:
```
ssh -L 8081:localhost:8080 starmark@192.168.88.105
```

**_Создаем туннель, который перенаправляет трафик с вашего локального порта 8081 на порт 8080 удаленного сервера
<br>(который, в свою очередь, перенаправляется на порт 80 Docker-контейнера).
<br>Оставьте это SSH-соединение открытым.
<br>Теперь вы можете открыть веб-браузер на вашем локальном компьютере и перейти по адресу:
```
http://localhost:8081
```

**_Вы должны увидеть страницу "Hello from Apache"_**
<br>Которая обслуживается вашим Docker-контейнером на удаленном сервере

**_Важные замечания:_**
<br>Убедитесь, что порт 8080 на удаленном сервере не блокируется файрволом.

<br>Если вы хотите, чтобы туннель работал в фоновом режиме, добавьте флаг -N к SSH-команде:
```
ssh -N -L 8081:localhost:8080 starmark@192.168.88.105
```

**_Если вы часто используете этот туннель, вы можете добавить его конфигурацию в ваш ~/.ssh/config файл для удобства:_**
```
Host mytunnel
    HostName 192.168.88.105
    User starmark
    LocalForward 8081 localhost:8080
```

**_Затем вы сможете создавать туннель простой командой:_**
```
ssh -N mytunnel
```

**_Теперь вы должны иметь возможность просматривать сайт, сгенерированный на удаленном сервере, локально на localhost:8081_**


