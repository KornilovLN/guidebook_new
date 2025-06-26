Отлично, вот пошаговая инструкция для запуска и проверки Forgejo на основе вашего docker-compose.yml:
1. Запуск контейнера
bash

# Перейдите в директорию с docker-compose.yml
cd /path/to/your/directory

# Запустите контейнер в фоновом режиме
docker-compose up -d

2. Проверка запущенных контейнеров
bash

docker ps | grep forgejo

Ожидаемый вывод:
text

CONTAINER ID  IMAGE                          STATUS        PORTS
abcdef123456  codeberg.org/forgejo/forgejo:11  Up 5 minutes  0.0.0.0:3000->3000/tcp, 0.0.0.0:2222->22/tcp

3. Доступ к веб-интерфейсу

Откройте в браузере:
http://srvGit:3000

Первая настройка:

    Выберите SQLite3 (для начала)

    Укажите настройки:

        Имя сервера: srvGit:3000

        Порт SSH: 2222

        Базовый URL: http://srvGit:3000

    Создайте аккаунт администратора (ваши данные)

4. Работа с Git через SSH

Добавление SSH-ключа:

    На локальной машине (если нет ключа):
    bash

    ssh-keygen -t ed25519 -C "your_email@example.com"

    В Forgejo:

        Профиль → Настройки → SSH-ключи

        Добавить ключ → Вставить содержимое ~/.ssh/id_ed25519.pub

Пример работы с репозиторием:
bash

# Создайте новый проект в веб-интерфейсе (например new-project)

# Клонирование
git clone ssh://git@srvGit:2222/starter/new-project.git

# Первый коммит
cd new-project
echo "# My Project" > README.md
git add .
git commit -m "Initial commit"
git push origin main

5. Проверка сети Docker
bash

# Список сетей
docker network ls

# Должна быть сеть с именем вида:
# <директория>_forgejo

# Информация о сети
docker network inspect <директория>_forgejo

6. Важные команды для мониторинга
bash

# Просмотр логов
docker logs forgejo

# Проверка состояния
docker-compose ps

# Остановка
docker-compose down

# Перезапуск
docker-compose restart

Если возникнут проблемы

    SSH подключение:
    bash

# Проверка подключения
ssh -T -p 2222 git@srvGit
# Ожидаемый ответ: Hi there! You've successfully authenticated...

Проверка портов:
bash

netstat -tuln | grep -E '3000|2222'

Проверка прав доступа:
bash

ls -ld /home/starter/forgejo/data
# Должно быть: drwxr-xr-x ... starter starter

Если не работает имя srvGit:

    Замените в URL на IP-адрес VM

    Или добавьте в /etc/hosts на локальной машине:
    text

        <IP_VM> srvGit

Ваша конфигурация полностью готова к работе! После начальной настройки в веб-интерфейсе вы сможете создавать репозитории и работать с ними через Git.
New chat

## Отправка
```bash
git remote add origin http://localhost:3000/starmark/pi-calc.git
git push -u origin main
```
