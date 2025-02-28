# Установка Docker в OpenSUSE
### Cписки репозиториев обновить и установить docker
```
sudo zypper refresh
sudo zypper install docker
```

### Запустить и включить автозапуск
```
sudo systemctl enable docker
sudo systemctl start docker
```

### Добавить пользователя в группу docker
```
sudo usermod -aG docker $USER
```

### Установка Docker Compose в OpenSUSE
#### Способ 1: Через zypper
```
sudo zypper install docker-compose
```

#### Способ 2: Через pip
```
sudo zypper install python3-pip
sudo pip3 install docker-compose
```

#### Способ 3: Через бинарный файл
```
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

### Сделать бинарный файл исполняемым
```
sudo chmod +x /usr/local/bin/docker-compose
```

### После установки перезагрузите систему или выйдите и снова войдите в систему, чтобы применить изменения группы docker:
```
newgrp docker
```

### Проверка установки:
```
docker --version
docker-compose --version
```

### Это отличается от метода для Ubuntu/Debian, поскольку OpenSUSE использует менеджер пакетов zypper вместо apt.

