# Как создать новый репозиторий из существующего
## и исправить ошибки в файлах при этом.

### 1. Создайте новую директорию
```
mkdir ~/virt/guidebook_new
cd ~/virt/guidebook_new
```
### 2. Инициализируйте новый репозиторий
```
git init
```
### 3. Скопируйте файлы из существующего репозитория (кроме .git)
```
cp -r ~/virt/guidebook/* ~/virt/guidebook_new/
rm -rf ~/virt/guidebook_new/.git
```
### 4. Отредактируйте файл chatgpt/OpenAI.md, удалив секретный ключ

### 5. Добавьте файлы и создайте коммит
```
git init
git add .
git commit -m "Initial commit with clean files"
```
### 6. Добавьте удаленный репозиторий
```
git remote add origin https://github.com/KornilovLN/Guidebook.git
```
### 7. Отправьте в новую ветку
```
git push -u origin main --force
```