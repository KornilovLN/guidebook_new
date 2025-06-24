# Volume создаётся на удалённой VM (srvGit), где работает Docker.

    Именно там хранятся данные Forgejo.

* **Где именно на VM:**
```bash
# Выполнить ЭТО на VM (srvGit):
sudo mkdir -p /mnt/forgejo/data
sudo chown -R 1000:1000 /mnt/forgejo  # Права для Docker

В docker-compose.yml (который на VM) пропишите:
```yaml

    volumes:
      - /mnt/forgejo/data:/data  # Это ВСЁ что нужно

    Ваш хост (локальный компьютер) не участвует в хранении данных.
    Вы будете подключаться к Forgejo по сети через:

        Веб: http://IP_VM:3000

        Git: git clone ssh://git@IP_VM:2222/ваш-проект.git
```

### Итог:

    Папка /mnt/forgejo/data создаётся на VM

    Docker контейнер смонтирует её внутрь себя как /data

    Ваши репозитории будут физически лежать на диске VM в /mnt/forgejo/data