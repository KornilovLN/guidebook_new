# Настройка Python 3.12 в качестве версии по умолчанию в openSUSE

## Вот несколько способов сделать Python 3.12 версией по умолчанию:

### Способ 1: Использование символических ссылок
```
sudo ln -sf /usr/bin/python3.12 /usr/bin/python

sudo ln -sf /usr/bin/pip3.12 /usr/bin/pip
```

### Способ 2: Использование системы alternatives (рекомендуется)
```
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.12 2

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1

sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.12 2

sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.6 1
```

#### Затем выберите Python 3.12 в качестве версии по умолчанию:
```
sudo update-alternatives --config python
```

#### И для pip:
```
sudo update-alternatives --config pip
```

### Способ 3: Использование файла ~/.bashrc

#### Добавьте в конец вашего ~/.bashrc:
```
echo 'alias python=/usr/bin/python3.12' >> ~/.bashrc

echo 'alias pip=/usr/bin/pip3.12' >> ~/.bashrc
```

#### Затем примените изменения:
```
source ~/.bashrc
```

### Предостережение:
```
* Перед изменением системного Python по умолчанию, рекомендуется создать снапшот:
```
sudo snapper create --description "До изменения Python по умолчанию"
```

### Важно:
* Многие системные утилиты могут зависеть от Python 3.6.
* Изменение системной версии Python потенциально может вызвать проблемы.
* Поэтому для разработки рекомендуется использовать виртуальные окружения вместо изменения системного Python.