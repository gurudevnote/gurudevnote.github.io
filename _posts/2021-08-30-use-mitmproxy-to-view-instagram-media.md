---
layout: post
title: Use mitmproxy to set cross-origin-resource-policy header to cross-origin
tags: ["mitmproxy","cross-site","cross-origin-resource-policy"]
---
It will be helpful when we want to show some image from some website those don't give permission to other website to show their image. 

- Start mitmproxy to change cross-origin-resource-policy header to cross-site
```bash
sudo docker run --net=host --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 127.0.0.1:8081:8081 mitmproxy/mitmproxy mitmproxy \
--ssl-insecure \
-H "/cross-origin-resource-policy/cross-origin"
```

