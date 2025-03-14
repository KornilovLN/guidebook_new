#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# fix_encoding.py
# usage: python fix_encoding.py <путь_к_директории> [расширения_файлов]
#        Пример: python fix_encoding.py /path/to/directory txt docx
#        Пример: python fix_encoding.py /path/to/directory txt

import os
import re

# Словарь замен для некорректных символов
replacements = {
    '╤': 'И',
    '╕': 'і',
    '╖': 'ѣ',  # если встречается
    '╗': 'ъ',  # если встречается
    # Добавьте другие замены по необходимости
}

def fix_text(text):
    """Исправляет некорректные символы в тексте"""
    for old, new in replacements.items():
        text = text.replace(old, new)
    return text

def process_file(file_path):
    """Обрабатывает один файл"""
    try:
        # Определяем кодировку файла (можно изменить если известна)
        encodings = ['utf-8', 'cp1251', 'koi8-r', 'iso-8859-5']
        
        for encoding in encodings:
            try:
                with open(file_path, 'r', encoding=encoding) as file:
                    content = file.read()
                    break
            except UnicodeDecodeError:
                continue
        else:
            print(f"Не удалось определить кодировку файла {file_path}")
            return
        
        # Исправляем текст
        fixed_content = fix_text(content)
        
        # Записываем исправленный текст
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(fixed_content)
        
        print(f"Обработан файл: {file_path}")
    except Exception as e:
        print(f"Ошибка при обработке файла {file_path}: {e}")

def process_directory(directory_path, extensions=['.txt']):
    """Обрабатывает все файлы в директории с указанными расширениями"""
    for root, _, files in os.walk(directory_path):
        for file in files:
            if any(file.lower().endswith(ext) for ext in extensions):
                file_path = os.path.join(root, file)
                process_file(file_path)

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Использование: python fix_encoding.py <путь_к_директории> [расширения_файлов]")
        print("Пример: python fix_encoding.py ./books txt,doc")
        sys.exit(1)
    
    directory = sys.argv[1]
    
    extensions = ['.txt']  # По умолчанию только текстовые файлы
    if len(sys.argv) > 2:
        extensions = ['.' + ext if not ext.startswith('.') else ext for ext in sys.argv[2].split(',')]
    
    print(f"Начинаю обработку файлов с расширениями {extensions} в директории {directory}")
    process_directory(directory, extensions)
    print("Обработка завершена")