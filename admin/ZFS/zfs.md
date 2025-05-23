# Установка ZFS и команды zpool на Linux
    Для использования команды zpool вам необходимо установить ZFS (Z File System) на вашу Linux-систему.
    Вот инструкции для разных дистрибутивов:

## Установка ZFS на Debian/Ubuntu
* Добавьте репозиторий ZFS и установите пакеты:
```bash
sudo apt update
sudo apt install zfsutils-linux
```

## Проверка установки
* После установки вы можете проверить, что ZFS и команда zpool работают:
```bash
sudo modprobe zfs
zpool --version
```
* После установки вы можете использовать команду zpool для управления пулами ZFS:
* Создание пула:
```bash
sudo zpool create mypool /dev/sdX
```
* Проверка статуса:
```bash
sudo zpool status
* Список пулов:
```bash
sudo zpool list
```
## Важные замечания
* ZFS требует значительного объема оперативной памяти для оптимальной работы (рекомендуется минимум 8 ГБ).
* В некоторых дистрибутивах может потребоваться перезагрузка после установки ZFS.
* Использование ZFS может быть ограничено лицензионными соображениями в некоторых коммерческих дистрибутивах из-за лицензии CDDL.
* Перед созданием пулов ZFS рекомендуется ознакомиться с документацией, так как неправильная настройка может привести к потере данных.