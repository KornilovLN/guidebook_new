#!/bin/bash
# gitaliases.sh

echo "Создание коротких команд для работы с git"

# Массив с алиасами для проверки
aliases=(
    "alias Gin='git init'"
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
