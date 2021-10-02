---
title: "讓firefox跑在docker-compose裡頭的正確腳本"
date: 2021-07-17T10:05:03+08:00
draft: true
featured_image: "/docker.png"
tags: ["docker","firefox"]
---

## 資料夾結構
```
firefox
├── docker-compose.yml
├── Dockerfile
└── run
```

##  docker-compose.yml
```yaml
#docker-compose版本
version: "3.4"
#服務，不過這裡唯一的服務就是firefox瀏覽器
services:
  #服務名稱，如果我們要登入容器是要輸入服務名稱的，隨意取名即可
  firefox00:
    #這個是我們的映像檔名稱，可以自己選擇，當映像檔建立時就會是firefox00版本0.0
    image: firefox00:0.0
    #用在這個資料夾下的Dockerfile建立映像檔
    build: .
    #網路模式和主機相同，也就是說如果容器開放80port，那主機也會開放80port，這個主要是為了更簡單的讓x window傳送firefox的畫面到主機上
    network_mode: host
    #要啟動這個，才能在關閉瀏覽器後仍然繼續運作容器
    tty: true

```

##  Dockerfile
```Dockerfile
#基底作業系統
FROM ubuntu:20.04
#檔案通透，聯繫到x windows傳輸socket
VOLUME /tmp/.X11-unix:/tmp/.X11-unix
#設置環境變數
ENV DISPLAY=":0"
#設定輸入法
ENV XMODIFIERS="@im=ibus"
ENV QT_IM_MODULE="ibus"
ENV GTK_IM_MODULE="ibus"
#編碼為C.UTF-8避免中文亂碼
ENV LANG="C.UTF-8"
#安裝需要的內容
RUN apt-get update &&\
    #x window的認證程式
	apt-get install xauth -y&&\
	apt-get install nano -y &&\
    #安裝中文輸入法
    apt-get install ttf-wqy-microhei -y &&\
    apt-get install firefox -y &&\
    apt-get install ffmpeg -y
#啟動觸發腳本
CMD ["/bin/bash"]
```

##  run腳本

啟動firefox時運作這個腳本，它可以將x cookie傳入容器裡頭，當容器取得x cookie就能在本機的x window server獲得正確認證，然後開啟圖形界面。  

```
#!/bin/bash
docker-compose up -d
TEMP_VAR=$(xauth list)
docker-compose exec firefox00 xauth add $TEMP_VAR
docker-compose exec  firefox00 firefox
```
