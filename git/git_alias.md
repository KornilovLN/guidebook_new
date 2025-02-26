## Alias для git команд

1. Выполнить в системе команды в оболочке dash:
```
alias Gad='git add'
alias Gbr='git branch'
alias Gco='git checkout'
alias Gcm='git commit -m'
alias Gst='git status'
alias Gpl='git pull'
alias Gps='git push'
alias Gdf='git diff'
alias Glg='git log'
```

2. Затем зафиксировать в .bashrc или в .zsh:
```
source ~/.bashrc
```
```
source ~/.zshrc
```

3. Теперь можно использовать короткие команды:
```
Gad .                 - добавить все файлы
Gbr                   - посмотреть ветки
Gco main              - переключиться на ветку main
Gcm "commit message"  - создать коммит с сообщением
Gst                   - проверить статус
Gpl                   - получить изменения
Gps                   - отправить изменения
```

4. А можно создать скрипт:
<br>gitaliases.sh
```
#!/bin/bash

echo "Создание коротких команд для работы с git"

# Массив с алиасами для проверки
aliases=(
    "alias Gad='git add'"
    "alias Gbr='git branch'"
    "alias Gco='git checkout'"
    "alias Gcm='git commit -m'"
    "alias Gst='git status'"
    "alias Gpl='git pull'"
    "alias Gps='git push'"
    "alias Gdf='git diff'"
    "alias Glg='git log'"
)

# Проверяем каждый алиас отдельно
for alias_cmd in "${aliases[@]}"; do
    if ! grep -q "$alias_cmd" ~/.bashrc; then
        echo "$alias_cmd" >> ~/.bashrc
    fi
done

source ~/.bashrc

echo "Git aliases успешно установлены!"

```
