# Создание user и наделение правами sudo
    Если пользователь vboxuser не находится в файле sudoers и вам нужно предоставить ему права sudo, вам необходимо добавить его в группу sudo или напрямую в файл sudoers.
    Для этого вам понадобятся права администратора (root).

1. Войдите как пользователь с правами sudo или root:
```bash
su - root
```
2. Добавьте пользователя vbocuser в группу sudo (рекомендуемый способ):
```bash
usermod -aG sudo vboxuser
```
3. Или отредактируйте файл sudoers с помощью команды visudo (безопасный способ редактирования):
```bash
visudo
```
4. В открывшемся редакторе добавьте следующую строку:
```
vbocuser ALL=(ALL:ALL) ALL
```
5. Сохраните файл и выйдите из редактора.
    После этих действий пользователь vboxuser получит права sudo и сможет выполнять команды с повышенными привилегиями. Для применения изменений может потребоваться перелогиниться.

6. Примечание: Если у вас нет доступа к учетной записи root или другого пользователя с правами sudo, вам потребуется обратиться к системному администратору для внесения этих изменений.

7. Install the package that contains usermod:
```bash
apt-get update && apt-get install -y passwd
```
* Or on Red Hat/CentOS/Fedora systems:
```bash
yum install -y shadow-utils
```
* Use the full path to the command (if it exists but isn't in your PATH):
```bash
/usr/sbin/usermod -aG sudo vboxuser
```

## Alternative approaches if you can't install packages:
a) Edit the sudoers file directly (be very careful with this):
```bash
pkexec visudo
```
* Or:
```bash
su -c "visudo"
```

b) If you have access to the /etc/group file, you can manually add the user to the sudo group:
```bash
su -c "echo 'vboxuser:x:27:vboxuser' >> /etc/group"
```

c) If you're in a container or minimal environment, you might need to install the necessary packages first or use a different approach based on your specific environment. Remember that you need root or sudo privileges to modify user permissions in any of these ways.

## Для создания пользователя anna с паролем !18anna28 и предоставления ей прав администратора (sudo):
* Сначала войдите в систему как vboxuser с паролем changeme
* Затем используйте sudo для создания нового пользователя:
```bash
sudo useradd -m anna
```
* Установите пароль для пользователя anna:
```bash
sudo passwd anna
```
* Когда система запросит пароль, введите !18anna28
  * Добавьте пользователя anna в группу sudo:
```bash
sudo usermod -aG sudo anna
```

## Если команда usermod недоступна, можно использовать альтернативный способ:
```bash
sudo adduser anna sudo
```
* Проверьте, что пользователь anna успешно добавлен в группу sudo:
```bash
groups anna
```
* В выводе должна присутствовать группа sudo.

### Теперь пользователь anna создан с паролем !18anna28 и имеет права администратора через sudo. Вы можете переключиться на этого пользователя командой:
```bash
su - anna
```
* И проверить права sudo:
```bash
sudo whoami
```
* Результат должен быть "root", что подтверждает работу sudo.

    Вы пытаетесь создать пользователя anna с правами sudo
    Но пользователь vboxuser, под которым вы работаете, сам не имеет прав sudo
    Поэтому вы не можете использовать команды с sudo для создания нового пользователя с правами администратора
* В этой ситуации вам нужно:
  * Войти в систему как root (если у вас есть пароль root):
```bash
su -
```

    Если ни один из этих вариантов невозможен, вам может потребоваться перезагрузить систему в режиме восстановления (recovery mode) или использовать Live CD/USB для редактирования файлов /etc/passwd, /etc/shadow и /etc/group, чтобы добавить пользователя с правами администратора.

    Если вы работаете в виртуальной машине VirtualBox (на что указывает имя пользователя vboxuser), возможно, проще будет пересоздать виртуальную машину с правильными настройками пользователей.

#### Странно. Если я делаю из-под vboxuser команду su - то у меня запрашивают пароль для vboxuser и я его ввожу так changeme и я оказываюсь в root@vbox:~# что свидетельствует о возможностях рута. Но по выходу из рута в пользователя vboxuser я теряю возможности sudo???? 

* Вот что происходит:

    Когда вы выполняете команду su - и вводите пароль changeme, вы успешно переключаетесь на пользователя root. Это означает, что changeme - это пароль пользователя root, а не пароль пользователя vboxuser.

    После выхода из сессии root (командой exit или Ctrl+D) вы возвращаетесь к пользователю vboxuser, который не имеет прав sudo.

    Это стандартное поведение в Linux-системах. Пользователь vboxuser не имеет прав sudo, но вы знаете пароль root, что позволяет вам получить полный административный доступ через команду su -.

* Чтобы решить вашу задачу, вы можете:

### Будучи под root (после su -)
```bash
useradd -m anna
passwd anna  # Установите пароль !18anna28
usermod -aG sudo anna  # Добавьте в группу sudo
```
* Если хотите также дать права sudo пользователю vboxuser:
```bash
usermod -aG sudo vboxuser
```
