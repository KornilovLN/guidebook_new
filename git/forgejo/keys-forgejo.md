# Пошаговая инструкция по настройке SSH ключей для работы с Forgejo:

## Шаг 1: Создание SSH ключей
```bash
# Создать новый SSH ключ (если у вас его еще нет)
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/forgejo_key

# Или использовать RSA (если ed25519 не поддерживается)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/forgejo_key

# Запустить ssh-agent
eval "$(ssh-agent -s)"

# Добавить ключ в ssh-agent
ssh-add ~/.ssh/forgejo_key
```

## Шаг 2: Добавление публичного ключа в Forgejo
```bash
# Скопировать публичный ключ в буфер обмена
cat ~/.ssh/forgejo_key.pub
```

## В веб-интерфейсе Forgejo:
* **Войдите в http://localhost:3000**
* **Перейдите в Настройки → SSH / GPG ключи**
* **Нажмите Добавить ключ**
* **Вставьте содержимое ~/.ssh/forgejo_key.pub**
* **Дайте ключу имя (например, "My Development Key")**
* **Нажмите Добавить ключ**
 
## Шаг 3: Настройка SSH конфигурации
### Создать или отредактировать файл конфигурации SSH (config)
```bash
nano ~/.ssh/config
```

### Добавить в файл:
```
# Forgejo SSH Configuration
Host forgejo
    HostName localhost
    Port 2222
    User git
    IdentityFile ~/.ssh/forgejo_key
    IdentitiesOnly yes

# Альтернативный вариант для localhost
Host localhost
    Port 2222
    User git
    IdentityFile ~/.ssh/forgejo_key
    IdentitiesOnly yes
```

### Установить правильные права на конфигурационный файл
```bash
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/forgejo_key
chmod 644 ~/.ssh/forgejo_key.pub
```

## Шаг 4: Тестирование SSH подключения
```bash
# Тест подключения к Forgejo
ssh -T git@localhost -p 2222

# Или используя алиас из конфига
ssh -T forgejo
```

### Ожидаемый ответ:
```
Hi starmark! You've successfully authenticated, but Forgejo does not provide shell access.
```

## Шаг 5: Настройка существующего репозитория
```bash
# Перейти в ваш проект
cd /mnt/poligon/pi-calc

# Изменить URL удаленного репозитория на SSH
git remote set-url origin ssh://git@localhost:2222/starmark/pi-calc.git

# Или используя алиас
git remote set-url origin forgejo:starmark/pi-calc.git

# Проверить изменения
git remote -v
```

## Шаг 6: Тестирование push/pull
```bash
# Проверить статус
git status

# Если есть изменения, закоммитить
git add .
git commit -m "Test SSH connection"

# Пушить через SSH
git push -u origin master

# Или если используете main
git push -u origin main
```

## Скрипт автоматической настройки SSH для Forgejo
```bash
#!/bin/bash
# setup_forgejo_ssh.sh

FORGEJO_HOST="localhost"
FORGEJO_PORT="2222"
FORGEJO_USER="starmark"
EMAIL="your_email@example.com"

echo "=== Настройка SSH для Forgejo ==="

# Шаг 1: Создание SSH ключа
echo "1. Создание SSH ключа..."
if [ ! -f ~/.ssh/forgejo_key ]; then
    ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/forgejo_key -N ""
    echo "✓ SSH ключ создан"
else
    echo "✓ SSH ключ уже существует"
fi

# Шаг 2: Настройка прав доступа
echo "2. Настройка прав доступа..."
chmod 600 ~/.ssh/forgejo_key
chmod 644 ~/.ssh/forgejo_key.pub
echo "✓ Права настроены"

# Шаг 3: Добавление в ssh-agent
echo "3. Добавление ключа в ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/forgejo_key
echo "✓ Ключ добавлен в ssh-agent"

# Шаг 4: Создание SSH конфигурации
echo "4. Создание SSH конфигурации..."
SSH_CONFIG="$HOME/.ssh/config"

# Создать резервную копию если файл существует
if [ -f "$SSH_CONFIG" ]; then
    cp "$SSH_CONFIG" "$SSH_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Добавить конфигурацию Forgejo
cat >> "$SSH_CONFIG" << EOF

# Forgejo SSH Configuration
Host forgejo
    HostName $FORGEJO_HOST
    Port $FORGEJO_PORT
    User git
    IdentityFile ~/.ssh/forgejo_key
    IdentitiesOnly yes

Host $FORGEJO_HOST
    Port $FORGEJO_PORT
    User git
    IdentityFile ~/.ssh/forgejo_key
    IdentitiesOnly yes
EOF

chmod 600 "$SSH_CONFIG"
echo "✓ SSH конфигурация создана"

# Шаг 5: Показать публичный ключ
echo "5. Публичный ключ для добавления в Forgejo:"
echo "================================================"
cat ~/.ssh/forgejo_key.pub
echo "================================================"

echo ""
echo "Следующие шаги:"
echo "1. Скопируйте публичный ключ выше"
echo "2. Перейдите в http://$FORGEJO_HOST:3000"
echo "3. Настройки → SSH/GPG ключи → Добавить ключ"
echo "4. Вставьте ключ и сохраните"
echo "5. Протестируйте: ssh -T git@$FORGEJO_HOST -p $FORGEJO_PORT"

# Шаг 6: Автоматическое тестирование (после добавления ключа)
echo ""
read -p "После добавления ключа в Forgejo нажмите Enter для тестирования..."

echo "6. Тестирование SSH подключения..."
if ssh -T git@$FORGEJO_HOST -p $FORGEJO_PORT 2>&1 | grep -q "successfully authenticated"; then
    echo "✓ SSH подключение работает!"
else
    echo "⚠ SSH подключение не работает. Проверьте:"
    echo "  - Добавлен ли ключ в Forgejo"
    echo "  - Запущен ли Forgejo на порту $FORGEJO_PORT"
    echo "  - Правильно ли настроен SSH ключ"
fi

echo ""
echo "=== Настройка завершена ==="
```

## Использование SSH с существующими репозиториями
```bash
# Для вашего проекта pi-calc
cd /mnt/poligon/pi-calc

# Изменить remote на SSH
git remote set-url origin ssh://git@localhost:2222/starmark/pi-calc.git

# Проверить
git remote -v

# Теперь можно пушить через SSH
git push origin master
```

## Отладка проблем SSH
```bash
# Подробный вывод SSH для отладки
ssh -vvv -T git@localhost -p 2222

# Проверить SSH ключи
ssh-add -l

# Проверить SSH конфигурацию
cat ~/.ssh/config

# Проверить права на файлы
ls -la ~/.ssh/
```

### Запустите скрипт настройки:
```bash
chmod +x setup_forgejo_ssh.sh
./setup_forgejo_ssh.sh
```

#### После этого можно работать с Forgejo через SSH без ввода паролей!


