# Сканирование дисков и обнаружение RAID-массивов
    Давайте проведем полное сканирование всех дисков в системе,
    включая внутренние и внешние,
    а также выявим RAID-массивы и другие надстройки.

## Базовая информация о дисках
* Получим список всех блочных устройств с подробной информацией:
```bash
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT,MODEL
```
* Посмотрим детальную информацию о дисках:
```bash
sudo fdisk -l
```
* Проверка SMART-статуса дисков
  * Установим утилиту smartmontools, если её нет:
```bash
sudo apt-get install smartmontools
```
* Проверим SMART-статус для каждого физического диска (замените sdX на имя вашего диска, например sda, sdb и т.д.):
```bash
sudo smartctl -a /dev/sdX
```

## Обнаружение RAID-массивов
### Программные RAID (mdadm)
* Установим mdadm, если его нет:
```bash
sudo apt-get install mdadm
```
* Проверим наличие активных RAID-массивов:
```bash
cat /proc/mdstat
```
* Получим подробную информацию о RAID-массивах:
```bash
sudo mdadm --detail --scan
```

## Аппаратные RAID
### Установим утилиты для работы с аппаратными RAID-контроллерами:
```bash
sudo apt-get install lshw
```
* Получим информацию о RAID-контроллерах:
```bash
sudo lshw -class disk -class storage
```

### RAID на базе LVM
* Проверим наличие LVM:
```bash
sudo pvs
sudo vgs
sudo lvs
```
* Проверка ZFS - Если есть подозрение на использование ZFS:
```bash
sudo apt-get install zfsutils-linux
sudo zpool status
sudo zpool list
```
* Проверка Btrfs Для файловых систем Btrfs:
```bash
sudo apt-get install btrfs-progs
sudo btrfs filesystem show
```

### Полная информация о дисковой подсистеме
```bash
sudo inxi -Dxx
```
* Если inxi не установлен:
```bash
sudo apt-get install inxi
```

### Проверка NVME дисков Если в системе есть NVME диски:
```bash
sudo apt-get install nvme-cli
sudo nvme list
```

### Проверка SCSI-устройств
```bash
sudo apt-get install lsscsi
sudo lsscsi
```

## Сканирование всех дисков и сохранение результатов scan_disks.sh
### Создадим скрипт для сканирования всех дисков и сохранения результатов:
```bash
#!/bin/bash
echo "Создаем директорию для результатов..."
mkdir -p ~/disk_scan_results
cd ~/disk_scan_results

echo "Базовая информация о дисках..."
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT,MODEL > lsblk_output.txt
sudo fdisk -l > fdisk_output.txt

echo "Проверка SMART-статуса дисков..."
for disk in $(lsblk -d -o NAME | grep -v NAME); do
  sudo smartctl -a /dev/$disk > smart_${disk}.txt 2>&1
done

echo "Проверка RAID-массивов..."
cat /proc/mdstat > mdstat.txt 2>&1
sudo mdadm --detail --scan > mdadm_scan.txt 2>&1

echo "Проверка LVM..."
sudo pvs > pvs.txt 2>&1
sudo vgs > vgs.txt 2>&1
sudo lvs > lvs.txt 2>&1

echo "Проверка аппаратных RAID..."
sudo lshw -class disk -class storage > lshw_storage.txt 2>&1

echo "Проверка ZFS (если установлен)..."
sudo zpool status > zpool_status.txt 2>&1
sudo zpool list > zpool_list.txt 2>&1

echo "Проверка Btrfs (если установлен)..."
sudo btrfs filesystem show > btrfs_show.txt 2>&1

echo "Проверка NVME дисков (если есть)..."
sudo nvme list > nvme_list.txt 2>&1

echo "Проверка SCSI-устройств..."
sudo lsscsi > lsscsi.txt 2>&1

echo "Полная информация о дисковой подсистеме..."
sudo inxi -Dxx > inxi_disk.txt 2>&1

echo "Сканирование завершено. Результаты сохранены в ~/disk_scan_results/"
```

### Send command to Terminal
```bash
chmod +x ~/scan_disks.sh
sudo ./scan_disks.sh
```

    После выполнения скрипта вы получите полную информацию о всех дисках, RAID-массивах и других надстройках в директории ~/disk_scan_results/. Это поможет вам проанализировать состояние дисковой подсистемы и выявить проблемы.
