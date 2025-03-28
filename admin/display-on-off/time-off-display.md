# Настройка времени отключения дисплея и отключение запроса пароля

## Для GNOME (Ubuntu, Fedora, и т.д.)

    Настройка времени отключения дисплея через командную строку:
    gsettings set org.gnome.desktop.session idle-delay 900

* Это установит время отключения дисплея на 900 секунд (15 минут). 
* Измените значение по вашему желанию.

## Отключение запроса пароля после пробуждения:
```
gsettings set org.gnome.desktop.screensaver lock-enabled false
```

## Отключение автоматической блокировки экрана:
```
gsettings set org.gnome.desktop.screensaver lock-delay 0
```
## Для KDE Plasma
### Через командную строку:

* Настройка времени отключения дисплея:
```
kwriteconfig5 --file powermanagementprofilesrc --group AC --group DimDisplay --key idleTime 900000
```
* Значение указывается в миллисекундах (900000 = 15 минут).
* Отключение запроса пароля:
```
kwriteconfig5 --file kscreenlockerrc --group Daemon --key Autolock false
```
* После внесения изменений перезапустите службу:
```
qdbus org.kde.screensaver /ScreenSaver configure
```

## Для Xfce

* Настройка времени отключения дисплея:
```
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 15
```
* Это установит время отключения на 15 минут.
* Отключение запроса пароля:
```
xfconf-query -c xfce4-session -p /general/LockCommand -s ""
```

## Для i3, Sway и других оконных менеджеров
* Если вы используете легковесный оконный менеджер, вы можете настроить xset:
```
xset s 900 900
xset dpms 900 900 900
```
* Для отключения блокировки экрана, вам нужно настроить или отключить используемый вами экранный блокировщик (например, i3lock, swaylock, xscreensaver).

## Системные настройки через файл конфигурации
* Вы также можете отредактировать файл /etc/systemd/logind.conf:
```
sudo nano /etc/systemd/logind.conf
```
* Найдите и измените (или добавьте) следующие строки:
```
IdleAction=ignore
IdleActionSec=900
```
* После сохранения изменений перезапустите службу:
```
sudo systemctl restart systemd-logind
```

## Выберите метод, который соответствует вашей среде рабочего стола. Если вы не уверены, какую среду рабочего стола вы используете, выполните:
```
echo $XDG_CURRENT_DESKTOP
```