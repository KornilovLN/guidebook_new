#!/bin/bash
# check-smart-disk.sh
# Скрипт для проверки состояния диска с помощью SMART

while true; do
  status=$(sudo smartctl -c /dev/sdd | grep "Self-test execution status")
  if [[ $status != *"in progress"* ]]; then
    echo "SMART test completed!"
    notify-send "SMART test completed!" "The long SMART test on /dev/sdd has finished."
    break
  fi
  echo "Test still running... $(date)"
  sleep 300  # Проверка каждые 5 минут
done
