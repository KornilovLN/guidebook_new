## XFCE setup in Debian
**_https://linuxthebest.net/yak-vstanoviti-xfce-na-debian-12-11-10/_**

<br>
#### Установка

- 1. ```sudo apt update && sudo apt upgrade```

- 2. ```sudo apt install task-xfce-desktop```

<br>Установка XFCE обычно происходит быстрее, чем его аналогов, благодаря его легковесности.
<br>Во время этого процесса вы столкнетесь с экраном конфигурации для менеджера дисплеев LightDM.
<br>XFCE разработан для эффективной работы с LightDM.
<br>Если XFCE будет вашей средой рабочего стола по умолчанию, выберите LightDM на этом шаге.
<br>Используйте клавишу TAB для навигации по интерфейсу и выберите <Ok>, затем нажмите клавишу ENTER для подтверждения выбора.

- 3. ```sudo reboot```

<br>
#### Вход в систему

- 1. Прежде чем приступить к входу в систему, необходимо подтвердить,
     <br>какое окружение рабочего стола будет загружено в вашей системе.
     <br>Можно нажать на значок в правом верхнем углу экрана входа в систему.

- 2. Выбор сеанса XFCE
     <br>Из списка сессий выберите «Xfce Session» вместо «Default Xsession».     

#### Советы по началу работы с Xfce в Debian Linux

    * Используйте сочетания клавиш: Используйте возможности сочетаний клавиш для повышения производительности. Вы можете установить свои собственные сочетания клавиш в Настройки > Клавиатура > Ярлыки приложений.

    * Изучите настройки панели: Панель Xfce очень легко настраивается. Посетите Настройки > Панель, чтобы настроить ее свойства по своему вкусу.

    * Используйте рабочие пространства: Xfce поддерживает несколько рабочих пространств. Вы можете переключаться между ними с помощью Ctrl + F1 для первого рабочего пространства, Ctrl + F2 для второго и так далее.

    * Управление настройками питания: Настройте параметры управления питанием в соответствии с вашими потребностями. Доступ к ним можно получить в меню Настройки > Диспетчер питания.

<br>
#### Настройки

    <br>Xfce славится своей настраиваемостью. Вот несколько способов:

    * Изменение тем: Вы можете изменить внешний вид рабочего стола, изменив тему. Перейдите в Настройки > Внешний вид > Стиль, чтобы выбрать новую тему.

    * Изменить наборы значков: Настройте наборы значков в разделе Настройки > Внешний вид > Значки.

    * Настроить панель: Вы можете добавлять, удалять и изменять расположение элементов на панели. Щелкните правой кнопкой мыши на панели и выберите Панель > Добавить новые элементы или Панель > Параметры панели.

    * Настройка параметров диспетчера окон: Вы можете настроить поведение окон в Настройки > Диспетчер окон.

<br>
#### Продвинутые советы

    * Используйте терминал: Хотя Xfce известен своим графическим пользовательским интерфейсом, не забывайте о возможностях командной строки. Вы можете запустить терминал, используя Ctrl + Alt + T.

    * Установите плагины: Xfce имеет ряд плагинов, расширяющих его функциональность. Вы можете найти их в программном центре или установить через командную строку с помощью команды sudo apt install PLUGIN_NAME.

    * Настройка приложений при запуске: Управление приложениями, запускаемыми при запуске, осуществляется в разделе Настройки > Сеанс и запуск > Автозапуск приложений.

<br>
#### Обновление пакетов рабочего стола XFCE

```sudo apt update && sudo apt upgrade```

<br>
#### Переключение менеджеров отображения по умолчанию

```sudo dpkg-reconfigure lightdm```
<br>Не забудьте перезагрузить систему при переключении между окружениями рабочего стола, чтобы изменения вступили в силу.

<br>
#### Удаление XFCE из Debian Linux

```sudo apt autoremove '^xfce' task-xfce-desktop --purge```

<br>
#### Если вы хотите переустановить среду рабочего стола GNOME после удаления

```
sudo apt update
sudo apt install gnome gdm3 task-gnome-desktop --reinstall
```

<br>Перед перезагрузкой системы убедитесь, что GDM включен.
<br>Если вы забудете это сделать, вы можете загрузиться в терминал или сервер.
<br>Если это произойдет, вы можете вернуть вход в рабочий стол GNOME:
```
sudo systemctl enable gdm --now
sudo reboot
```




