# Создание нового диска sdd и в нем раздела sdd1

## Проверка созданного раздела
```bash
lsblk -f

sudo blkid /dev/sdd1

df -h

## Монтирование диска
1. Создание точки монтирования
```bash
sudo mkdir -p /mnt/addata
```

2. Временное монтирование для проверки
```bash
sudo mount /dev/sdd1 /mnt/addata
```

3. Проверка монтирования
```bash
df -h | grep addata

ls -la /mnt/addata
```

## Постоянное монтирование
1. Получение UUID
```bash
sudo blkid /dev/sdd1 | grep -o 'UUID="[^"]*"'
```
```
UUID="97251518-a0e8-41c5-b36c-496e26185c41"
UUID="5ee12dff-01"
```

2. Добавление в /etc/fstab
```bash
sudo cp /etc/fstab /etc/fstab.backup

echo 'UUID="97251518-a0e8-41c5-b36c-496e26185c41" /mnt/addata ext4 defaults,noatime 0 2' | sudo tee -a /etc/fstab
```

3. Проверка fstab
```bash
sudo mount -a

df -h | grep addata
```

### Настройка прав доступа
```bash
sudo chown $USER:$USER /mnt/addata

chmod 755 /mnt/addata
```

### Тестирование диска
```bash
sudo touch /mnt/addata/test_file

echo "Test data" | sudo tee /mnt/addata/test_file

cat /mnt/addata/test_file

sudo rm /mnt/addata/test_file
```

### Мониторинг состояния
```bash
sudo smartctl -a /dev/sdd

sudo tune2fs -l /dev/sdd1 | grep -E "(Block count|Free blocks|Block size)"
```

## Оптимизация для данных
### Отключение журналирования времени доступа (уже в fstab с noatime)
```bash
sudo tune2fs -o noatime /dev/sdd1
```

### Проверка файловой системы
```bash
sudo fsck.ext4 -f /dev/sdd1
```

## Ваша разметка оптимальна:

    ✅ Оставлено достаточно свободного места (5.2%)
    ✅ Использована надежная файловая система ext4
    ✅ Создан UUID для стабильного монтирования
    ✅ Метка "addata" для удобной идентификации

Диск готов к использованию для хранения данных!


