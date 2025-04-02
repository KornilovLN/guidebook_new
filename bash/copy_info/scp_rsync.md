# Копирование с хоста на удаленный сервер каталогов

    Для копирования всего каталога с локального хоста на удаленный сервер через SSH, можно использовать команду scp (secure copy) или rsync.
    rsync обычно предпочтительнее для больших каталогов, поскольку он может возобновлять прерванные передачи и копировать только измененные файлы.

## Вариант 1: Использование scp
```
scp -r /mnt/poligon/poligon_ekatra_flask/ gitsrv:/home/starmark/work/
```

## Вариант 2: Использование rsync (рекомендуется)
```
rsync -avz /mnt/poligon/poligon_ekatra_flask/ gitsrv:/home/starmark/work/poligon_ekatra_flask/
```

### Опции rsync:
* -a сохраняет атрибуты файлов
* -v выводит подробную информацию о процессе
* -z сжимает данные при передаче
* Если настроен нестандартный порт SSH, добавить опцию:
  * -P для scp 
  * -e "ssh -p PORT" для rsync:
    ```
    scp -r -P 7722 /mnt/poligon/poligon_ekatra_flask/ gitsrv:/home/starmark/work/

    rsync -avz -e "ssh -p 7722" /mnt/poligon/poligon_ekatra_flask/ gitsrv:/home/starmark/work/poligon_ekatra_flask/
    ```
* Если используется другое имя пользователя на удаленном сервере - указать его перед именем хоста:
    ```
    rsync -avz /mnt/poligon/poligon_ekatra_flask/ username@gitsrv:/home/starmark/work/poligon_ekatra_flask/
    ```