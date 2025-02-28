# Установка Python и окружения для разработки на openSUSE
### 1. Установка Python
* **Для установки последней версии Python на openSUSE:**
```
sudo zypper refresh

sudo zypper install python312 python312-devel
```
* **Примечание: Номер версии (311) следует заменить на актуальную версию (например, python312 для Python 3.12).**

### 2. Установка pip
```
sudo zypper install python312-pip
```
### 3. Установка виртуального окружения
```
sudo zypper install python312-virtualenv
```

### 4. Другие необходимые инструменты для разработки
```
sudo zypper install git

sudo zypper install gcc gcc-c++ make

sudo zypper install python312-setuptools
```

### 5. Установка дополнительных библиотек для Data Science (опционально)
* Если вы планируете работать с Data Science, на основе информации из docker/docker-python.md, установите:
```
pip3 install numpy scipy pandas matplotlib seaborn scikit-learn jupyter
```

### 6. Создание виртуального окружения для проекта (рекомендуется)
```
python3.12 -m venv myproject_env

source myproject_env/bin/activate
```

### 7. Проверка установленных компонентов
```
python --version

pip --version
```

### Рекомендуется перед установкой создать снапшот системы с помощью Snapper, как показано в файле opensuse/snapshot.md:
```
sudo snapper create --description "До установки Python и окружения"
```
* **Это позволит вернуться к предыдущему состоянию системы в случае проблем с установкой.**

### 8 Рекомендуется устанавливать SciPy в виртуальном окружении, чтобы избежать конфликтов зависимостей между разными проектами:
```
python3.12 -m venv scipy_env
source scipy_env/bin/activate
pip install scipy
```