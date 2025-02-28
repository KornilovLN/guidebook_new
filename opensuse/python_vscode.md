# Настройка VSCode для работы с Python на openSUSE

### 1. Установка необходимых расширений
* Запустите VSCode и установите следующие расширения:
```
code --install-extension ms-python.python

code --install-extension ms-python.vscode-pylance
```

* **Или установите их через графический интерфейс:**
```
Нажмите Ctrl+Shift+X или иконку расширений на боковой панели
В поиске введите "Python"
Установите расширения "Python" и "Pylance" от Microsoft
``` 

### 2. Выбор интерпретатора Python
* Откройте файл с расширением .py или создайте новый
* Нажмите Ctrl+Shift+P для открытия командной панели
* Введите "Python: Select Interpreter"
* Выберите установленную версию Python 3.12

### 3. Настройка линтера и форматировщика
```
pip install pylint autopep8
```
* **В настройках VSCode (File > Preferences > Settings):**
```
Найдите "Python › Linting: Enabled" и включите
Найдите "Python › Linting: Pylint Enabled" и включите
Найдите "Python › Formatting: Provider" и выберите "autopep8"
```

### 4. Настройка виртуального окружения
```
python -m venv .venv

source .venv/bin/activate
```
* **В VSCode:**
  * Нажмите Ctrl+Shift+P
  * Введите "Python: Select Interpreter"
  * Выберите интерпретатор из виртуального окружения (.venv)

### 5. Настройка отладчика
* Перейдите в раздел "Run and Debug" (Ctrl+Shift+D)
* Нажмите "create a launch.json file"
* Выберите "Python"
* Выберите "Python File"

### 6. Полезные дополнительные расширения
```
code --install-extension njpwerner.autodocstring

code --install-extension kevinrose.vsc-python-indent

code --install-extension ms-python.black-formatter
```

#### Перед внесением изменений в систему рекомендуется создать снапшот:
```
sudo snapper create --description "До настройки VSCode для Python"
```

## 7. Проверка установки
* Создайте простой Python скрипт
* и запустите его, нажав кнопку ▶️ в правом верхнем углу редактора
* или через командную панель (Ctrl+Shift+P)
* командой "Python: Run Python File".