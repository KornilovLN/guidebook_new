# Установка Visual Studio Code на openSUSE
## Способ 1: Установка через репозиторий Microsoft
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'

sudo zypper refresh

sudo zypper install code
```

## Способ 2: Установка через Snap (если установлен snapd)
```
sudo zypper install snapd

sudo systemctl enable --now snapd

sudo snap install code --classic
```

## Способ 3: Установка из .rpm файла
* **Скачайте последнюю версию .rpm файла с официального сайта VS Code**
```
sudo zypper install ./путь_к_скачанному_файлу.rpm
```
* После установки VS Code можно запустить из меню приложений или через терминал командой code.
* Рекомендуется также создать снапшот перед установкой, используя команду:
```
sudo snapper create --description "До установки VS Code"
```
* Это позволит вам вернуться к предыдущему состоянию системы в случае проблем с установкой.