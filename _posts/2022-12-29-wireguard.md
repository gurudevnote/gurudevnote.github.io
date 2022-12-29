---
layout: post
title: Use mitmproxy to start wireguard and setup wireguard client
tags: ["ubuntu","wireguard","mitmproxy"]
---

# install wireguard tools
```bash
sudo apt install wireguard-tools resolvconf
```

# Start wireguard server by mitmproxy
```bash
sudo docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy --net=howt mitmproxy/mitmproxy mitmweb --mode wireguard --web-host 0.0.0.0
```

# Open website to see wirdguard client config
- [http://0.0.0.0:8081/](http://0.0.0.0:8081/)

# Edit client configuration by modify the file `/etc/wireguard/wg0.conf` , add the content like below content
```text
[Interface]
PrivateKey = yJn4Kk4mNfpXa2lHWkuKvqxmAqqagGfpnUEmx3Ws1HI=
Address = 10.0.0.1/32
DNS = 10.0.0.53

[Peer]
PublicKey = zblj0+QdSUI5B8AKP+LRVuN9HynZn5h1tXH+T//6HkQ=
AllowedIPs = 0.0.0.0/0
Endpoint = 192.168.1.44:51820
```

# start wireguard
```bash
wg-quick up wg0
```

# stop wireguard
```bash
wg-quick down wg0
```

# References:
- [https://www.wireguard.com/](https://www.wireguard.com/)
- [https://www.server-world.info/en/note?os=Ubuntu_22.04&p=wireguard&f=2](https://www.server-world.info/en/note?os=Ubuntu_22.04&p=wireguard&f=2)