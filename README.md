## My Guidebook {linux, bash, git, docker, chatgpt, python, ...}

### All sections appeared spontaneously and have a simple look but provide useful information.

### In the course of work in various fields of activity this reference material will be supplemented.

### It is possible to use a more stylish design. 
**_But this is for later :)_** 

Перешел на local

Push прошел успешно через SSH.

Теперь ваш репозиторий настроен правильно и будет пушить в локальный сервер.

Давайте проверим текущую конфигурацию:

git remote -v

git status



Теперь у вас настроено:

    Remote URL: ssh://git@localhost:2222/starmark/guidebook_new.git
    SSH аутентификация работает корректно
    Upstream branch настроен (master отслеживает origin/master)

Полезные команды для дальнейшей работы:

```bash
#Для обычного push в будущем:

git push

#Для pull изменений:

git pull
```

Проверить статус:
```bash
git status
```

Почему SSH сработал, а HTTP нет:

    SSH использует ключи аутентификации (более безопасно)
    HTTP требовал правильной настройки credentials или токенов
    Ваш Gitea сервер настроен на SSH порту 2222

    Теперь вы можете спокойно работать с вашим локальным репозиторием guidebook_new!
    Все изменения будут пушиться в:
    http://localhost:3000/starmark/guidebook_new.git
    через SSH соединение.

```
$ git remote set-url origin ssh://git@localhost:2222/starmark/guidebook_new.git
$ git config --list | grep credential
credential.helper=store
credential.helper=store

$ git config --global --list | grep user
user.email=ln.KornilovStar@gmail.com
user.name=KornilovLN

$ git push -u origin master
Перечисление объектов: 23, готово.
Подсчет объектов: 100% (23/23), готово.
При сжатии изменений используется до 4 потоков
Сжатие объектов: 100% (17/17), готово.
Запись объектов: 100% (17/17), 7.00 КиБ | 3.50 МиБ/с, готово.
Всего 17 (изменения 9), повторно использовано 0 (изменения 0)
To ssh://localhost:2222/starmark/guidebook_new.git
   18dee40..20921be  master -> master
Ветка «master» отслеживает внешнюю ветку «master» из «origin».

$ git remote -v
origin  ssh://git@localhost:2222/starmark/guidebook_new.git (fetch)
origin  ssh://git@localhost:2222/starmark/guidebook_new.git (push)

$ git status
Текущая ветка: master
Эта ветка соответствует «origin/master».
нечего коммитить, нет изменений в рабочем каталоге
```



