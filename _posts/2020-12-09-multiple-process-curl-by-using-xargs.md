---
layout: post
title: Use xargs to create multiple process to make curl request
tags: ["bash","curl", "ubuntu","xargs"]
---
Tested on ubuntu 20.04. Create test.sh like that

```bash
#!/usr/bin/env bash
url="http://httpbin.org/ip"
numberProcess=10
numberRequest=100

rm -fr testData.txt response.txt
for i in $(seq 1 1 $numberRequest); do echo $url >> testData.txt; done;

function getUrl() {
     url=$0
     response=`curl --insecure -s $url`
     echo -e "$response\r"
}

export -f getUrl
cat testData.txt | xargs -L1 -P $numberProcess  bash -c 'getUrl "$@"';
```

Then run the test command
```bash
chomd +x ./test.sh
./test.sh
```