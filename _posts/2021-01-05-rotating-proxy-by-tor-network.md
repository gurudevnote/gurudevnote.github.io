---
layout: post
title: Create rotating proxy by using tor network
tags: ["tor","proxy", "rotating"]
---
- See more detail at the git repository [https://github.com/mattes/rotating-proxy]()

- Start rotating proxy   

````bash
# ... or pull docker container
docker pull mattes/rotating-proxy:latest

# start docker container
docker run -d -p 5566:5566 -p 4444:4444 --env tors=25 mattes/rotating-proxy

# test with ...
curl --proxy 127.0.0.1:5566 http://httpbin.org/ip
curl --proxy 127.0.0.1:5566 http://header.jsontest.com

# monitor
http://127.0.0.1:4444/haproxy?stats
````