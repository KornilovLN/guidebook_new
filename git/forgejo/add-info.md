# Вопросы:

1. Где создать том (volume) для данных: можно ли изменить `./forgejo` на `/mnt/forgejo/data`?

2. Важны ли значения USER_UID и USER_GID (1000) или их можно оставить?

3. Достаточно ли этого конфига для начала?

## По пунктам:

1. **Том (volume) для данных**:

- Часто нужно изменить путь на хосте.

- Вместо `./forgejo` (относительный путь, создастся в текущей директории) можно указать `/mnt/forgejo/data`.

- Это даже лучше, если есть отдельный раздел /mnt для данных.

- Пример: `- /mnt/forgejo/data:/data`

2. **USER_UID и USER_GID**:

- Эти переменные важны, чтобы внутри контейнера пользователь Forgejo (по умолчанию `git`) имел правильные права на файлы в томе.

- Значения 1000:1000 обычно соответствуют первому обычному пользователю на Linux-хосте (проверьте командой `id -u` и `id -g`).

- Если на хосте пользователь, от которого запускается Docker, имеет UID/GID отличные от 1000, то нужно указать его UID/GID.

- Как проверить:

```bash

echo "UID: $(id -u), GID: $(id -g)"

```

- Если результат, например, 1001:1001, то в конфиге укажите:

```yaml

environment:

- USER_UID=1001

- USER_GID=1001

```

3. **Полнота конфига**:

- Предоставленный конфиг почти полный, но есть нюанс: в нем используется сеть `forgejo`, которая объявлена как `external: false`. Это означает, что Docker Compose создаст сеть с именем `<имя_папки>_forgejo` (если вы запускаете из папки, например, `myforgejo`, то сеть будет `myforgejo_forgejo`).

- Для простоты можно оставить как есть, но если вы хотите, чтобы контейнер был доступен по имени `server` (или `forgejo`) из других контейнеров в этой же сети, то это полезно.

- Однако, если вы не планируете подключать другие контейнеры (например, базу данных), то сеть не критична. Forgejo будет доступен по портам на хосте.

- **Важное замечание по порту SSH**: в примере с сайта указан порт `222:22`, но это может вызвать проблему, потому что на хосте порт 222 может требовать прав root. Обычно используют порт выше 1024, например `2222:22` (как в предыдущем примере). Если вы хотите использовать порт 222, убедитесь, что на хосте он свободен и вы имеете права его биндить.

- **Рекомендуемый конфиг** (с учетом ваших пожеланий и корректировок):

```yaml

version: '3'

networks:

forgejo:

external: false

services:

server:

image: codeberg.org/forgejo/forgejo:11

container_name: forgejo

environment:

- USER_UID=1000      # Замените на ваш UID, если не 1000

- USER_GID=1000      # Замените на ваш GID, если не 1000

restart: always

networks:

- forgejo

volumes:

- /mnt/forgejo/data:/data   # Тут ваша директория на хосте

- /etc/timezone:/etc/timezone:ro

- /etc/localtime:/etc/localtime:ro

ports:

- '3000:3000'   # HTTP веб-интерфейс

- '2222:22'     # SSH для Git (рекомендую изменить порт хоста на 2222, чтобы не конфликтовать с системным sshd)

```

4. **Дополнительные советы**:

- Создайте директорию для данных: `sudo mkdir -p /mnt/forgejo/data` и установите права. Если ваш UID/GID 1000:1000, то:

```bash

sudo chown -R 1000:1000 /mnt/forgejo/data

```

Если вы указали другие UID/GID в конфиге, то используйте их.

- Если вы планируете использовать Forgejo в production, рассмотрите:

- Использование reverse proxy (Nginx, Caddy) с HTTPS.

- Отдельную базу данных (PostgreSQL, MySQL) вместо SQLite.

- Для запуска:

- Сохраните конфиг в `docker-compose.yml`.

- Выполните: `docker-compose up -d`

- После запуска откройте `http://ваш_хост:3000` и выполните первоначальную настройку.

- Если вы хотите использовать доменное имя, в настройках Forgejo укажите:

- `SSH_DOMAIN`: ваш домен (если SSH доступ через домен) или IP.

- `DOMAIN`: ваш домен (или IP) для HTTP.

- Для доступа по SSH для Git: `git clone ssh://git@ваш_хост:2222/username/repo.git`

Теперь у вас есть рабочий экземпляр Forgejo с данными, хранящимися в `/mnt/forgejo/data`.

Отличный вопрос! Давайте разберём ваш docker-compose.yml по пунктам:
1. Путь для volumes (ваш главный вопрос)

Можно и нужно менять! Рекомендую использовать /mnt/forgejo/data:
yaml

volumes:
  - /mnt/forgejo/data:/data  # Вот так будет правильно

Почему лучше /mnt?

    Данные будут храниться на отдельном разделе/диске

    Проще делать бэкапы

    Не потеряется при переустановке системы

    Повышает производительность (если /mnt на SSD)

Как подготовить:
bash

sudo mkdir -p /mnt/forgejo/data
sudo chown -R 1000:1000 /mnt/forgejo/data  # Важно для прав доступа!

2. USER_UID и USER_GID (1000)

Это критически важно! Вот что нужно сделать:

    Проверьте ваш UID/GID на хостовой машине:
    bash

id -u  # Ваш UID
id -g  # Ваш GID

Варианты настройки:

    Если ваш UID/GID = 1000: оставляем как есть

    Если другой (например 1001):
    yaml

environment:
  - USER_UID=1001
  - USER_GID=1001

Если не уверены - оставьте 1000, но тогда:
bash

        sudo chown -R 1000:1000 /mnt/forgejo/data

3. Полнота конфигурации

Ваш конфиг почти готов, но нужно добавить 2 важные вещи:
yaml

version: '3'

services:
  server:
    image: codeberg.org/forgejo/forgejo:11
    container_name: forgejo
    environment:
      - USER_UID=1000          # Поменяйте если нужно!
      - USER_GID=1000          # Поменяйте если нужно!
      - FORGEJO__security__INSTALL_LOCK=true  # Критично для безопасности!
    restart: always
    networks:
      - forgejo
    volumes:
      - /mnt/forgejo/data:/data  # Рекомендуемый путь
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - '3000:3000'  # Веб-интерфейс
      - '2222:22'    # SSH (поменял 222 на 2222 - см. пояснение ниже)
    # Добавьте это для безопасности:
    security_opt:
      - no-new-privileges:true

networks:
  forgejo:
    driver: bridge

Почему я изменил порт 222 → 2222?

    Порт 222 часто используется другими службами

    Порт 222 требует прав root для биндинга

    2222 - стандартная альтернатива для SSH-сервисов

Первый запуск и настройка

    Создайте docker-compose.yml с настройками выше

    Запустите:
    bash

docker-compose up -d

Инициализация (через браузер):
Откройте http://ваш-сервер:3000 и:

    Создайте администратора

    Выберите SQLite3 (достаточно для начала)

    Укажите:
    text

        SSH-сервер: ваш-сервер:2222
        HTTP-сервер: ваш-сервер:3000

Как подключиться с хоста

    Создайте SSH-ключ (если нет):
    bash

ssh-keygen -t ed25519 -C "forgejo@$(hostname)"

Добавьте публичный ключ в Forgejo:

    Профиль → Настройки → SSH-ключи

    Вставьте содержимое ~/.ssh/id_ed25519.pub

Настройте ~/.ssh/config:
config

Host forgejo-vm
  HostName ваш-сервер
  Port 2222
  User git
  IdentityFile ~/.ssh/id_ed25519

Тестируем:
bash

    ssh -T forgejo-vm
    # Должны увидеть: Hi there! You've successfully authenticated...

Пример работы с репозиторием
bash

git clone forgejo-vm:ваш-пользователь/ваш-репозиторий.git
cd ваш-репозиторий
touch README.md
git add .
git commit -m "First commit"
git push -u origin main

Важные примечания

    Если будете менять порты:

        В Forgejo: app.ini → [server] → SSH_PORT и HTTP_PORT

        В docker-compose.yml → ports

    Для миграции с GitHub:

        В Forgejo есть "Мигратор" в интерфейсе

        Нужен GitHub Personal Access Token

    Бэкапы:
    bash

    docker exec forgejo forgejo dump -c /data/forgejo/conf/app.ini
    # Бэкап появится в /mnt/forgejo/data/forgejo-dump

Ваша конфигурация теперь готова к работе! При таком подходе ваши данные будут надежно храниться в /mnt/forgejo/data, а доступ по SSH будет через порт 2222 с правильными правами.