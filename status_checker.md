Скачайте https://raw.githubusercontent.com/rxitech/k6clean/master/status_checker.sh

```
curl https://raw.githubusercontent.com/rxitech/k6clean/master/status_checker.sh > status_checker.sh
```
Змініть мод
```
chmod +x status_checker.sh
```

Запустіть
```
./status_checker.sh example.com google.com ....
```

для файла
```
less hosts_to_check.txt | xargs ./status_checker.sh
```

где `hosts_to_check.txt`:

```
example.com
google.com
...
```
