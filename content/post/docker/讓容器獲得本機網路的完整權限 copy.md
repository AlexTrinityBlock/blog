---
title: "讓容器獲得本機網路的完整權限"
date: 2021-06-12T00:05:03+08:00
draft: false
featured_image: "/docker.png"
tags: ["docker"]
---

## docker run指令的對外網開放端口選項

我們如果想讓容器與本機使用同一個網路，並且能建立像是網頁伺服器一類的對外開放端口，  
可以將網路設置為host。

```
docker run -it -p 80:80 --net=host ubuntu:20.04 bash
```

## docker-compose的對外開放端口選項
docker-compose中也可以這樣來設置，這樣就可以對外開放80port了。  
網路一樣設置根本機相同的host。  
```yaml
version: "3.4"
services:
  ubuntu-server:
    ports:
      -80:80
    image: ubuntu:20.04
    network_mode: host
    tty: true
```

## docker-compose添加網路嗅探與更多操作網卡的功能
雖然網路設置為host可以開啟了用docker當成伺服器的功能，但是像是網路嗅探與其他進階網卡的操作，權限上還是被禁止的。  

所以這個時候要用更進一步的解決方案。  

在linux裡頭有一種權限稱為capability(能力)，也就是某個process能夠操作電腦硬體到什麼程度。  

雖然docker的process沒特別設置下，預設為root權限的process，但為了安全起見所以並沒有太多的capability，像是網路嗅探就需要完整的"使用網路的capability"。  

### wireshark在capability的能力配置範例
這是個wireshark的映像檔，其中有調整了capability參數，來取得網路嗅探的能力。
```yaml
version: "2.1"
services:
  wireshark:
    image: ghcr.io/linuxserver/wireshark
    container_name: wireshark
    cap_add:
      - NET_ADMIN
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - ./config:/config
    ports:
      - 3000:3000 #optional
    restart: unless-stopped
```
我們注意到下列一段，它取得了網路管理員的身份。  
```yaml
    cap_add:
      - NET_ADMIN
```
並且不讓這個容器取得root權限，而是取得使用者編號1000的權限。  
```yaml
    environment:
      - PUID=1000
      - PGID=1000
```
要了解capability的意義可以查看man文檔
```
man 7 capability
```
