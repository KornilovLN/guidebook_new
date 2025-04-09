#!/bin/bash
echo "Создаем директорию для результатов..."
mkdir -p disk_scan_results
cd disk_scan_results

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
