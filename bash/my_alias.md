# Создание и сохранение алиасов в Linux

## Временное создание алиаса (до перезагрузки)
* **Создать алиас shutdown**
```bash
alias shutdown='sudo shutdown -h now'
```

* **Чтобы применить изменения без перезагрузки, выполните следующую команду:**
```
source ~/.bashrc
``` 

* **Применить алиас**
```
shutdown
```

* **Сохранить многие алиасы в файле .bashrc**
  * Откройте файл .bashrc в домашней директории
    ```
    nano ~/.bashrc
    ``` 
  * Прокрутите вниз до конца файла и добавьте ваши алиасы:   
    ```bash
    # Пользовательские алиасы
    alias shutdown='sudo shutdown -h now'
    alias update='sudo apt update && sudo apt upgrade -y'
    alias diskspace='df -h'
    alias folders='du -h --max-depth=1'
    alias ll='ls -la'
    ```

## Полезные алиасы для Raspberry Pi

### Выключение и перезагрузка
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias sdshutdown='sudo shutdown -h now'

### Обновление системы
alias update='sudo apt update && sudo apt upgrade -y'
alias upgrade='sudo apt update && sudo apt full-upgrade -y'

### Информация о системе
alias temp='vcgencmd measure_temp'
alias cpuinfo='cat /proc/cpuinfo'
alias meminfo='free -h'

### Работа с дисками
alias diskspace='df -h'
alias usage='du -h --max-depth=1 | sort -hr'
alias bigfiles='find / -type f -size +100M -exec ls -lh {} \; 2>/dev/null | sort -rh | head -10'

### Сеть
alias myip='hostname -I'
alias ports='netstat -tulanp'

### Навигация и файлы
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'


## Просмотр существующих алиасов
```bash
alias
```

## Удаление алиаса
* **Чтобы временно удалить алиас в текущей сессии:**
```bash
unalias shutdown
```

* **Для постоянного удаления, отредактируйте файл ~/.bashrc и удалите соответствующую строку.**

## Использование параметров в алиасах
#### Если вам нужно передавать параметры в алиас, лучше использовать функции:

* **Добавьте в ~/.bashrc**
``` 
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
```
* **Сохраните файл и перезагрузите .bashrc**
* Теперь вы можете использовать extract archive.tar.gz для распаковки любого архива.