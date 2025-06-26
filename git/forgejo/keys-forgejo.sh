#!/bin/bash
# keys-forgejo.sh

FORGEJO_HOST="localhost"
FORGEJO_PORT="2222"
EMAIL="ln.starmark@gmail.com"

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
