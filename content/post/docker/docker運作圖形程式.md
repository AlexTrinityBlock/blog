---
title: "docker運作圖形程式"
date: 2021-06-08T00:05:03+08:00
draft: true
featured_image: "/docker.png"
tags: ["docker"]
---
本篇我們以在docker上頭運作firefox程式為案例。  
但也可應用在其他的軟體。  

## 知識

### 連線檔案
由於在linux上頭連socket連線都是以檔案的形式出現，所以我們要將主機對桌面的連線之檔案複製一份到docker裡頭。這個代表連線的檔案位置如下。  
```
/tmp/.X11-unix 
```

### 連線認證cookie
一開始 X window 圖形界面建立的時候，就考慮到可以透過網路轉發桌面，為了確認是合法的使用者。所以每個使用者連上圖形環境時會取得一個cookie，我們的目標之一就是將cookie複製一份到docker裡頭，讓本機的桌面可以接受來自docker的連線。  

順帶一題，這個認證軟體稱為xauth。

以下為取得認證cookie的方式。(在主機輸入)
```
xauth list
```
由於docker容器不一定會預先裝上xauth提供認證，所以我們可能要手動安裝。  
```
apt install xauth
```

### DISPLAY環境變數
這個變數告訴x window圖形系統，我們的圖形程式該播放在哪個桌面(一個電腦確實可以有多個桌面)  
與一些必要的資訊。  

我們也必須把這個資訊傳入docker

### UTF-8編碼方式
如果沒有採取UTF-8編碼，是無法顯示英文以外的字體的。  
我們進入bash時，bash的設定檔會即時載入設定，我們可以在這個時候將系統字體編碼設置為UTF-8。  

先找到這個bash設定檔
```
/etc/bash.bashrc
```
然後在最後一行加入
```
export LANG=C.UTF-8
```
啟動bash的瞬間環境變數就被改成UTF-8編碼了。  
而我們進入docker容器通常都會用bash

### 安裝中文字體
如果沒裝中文字體，firefox或其他圖形程式直接亂碼給你看  
所以我們要在docker裡頭安裝中文字體

```
apt-get update
apt-get install  ttf-arphic-ukai ttf-arphic-uming ttf-arphic-newsung
```
如果上述不管用也可以裝裝看這個
```
apt-get update
apt-get install ttf-wqy-microhei
```
裝完字體之後，實際測試要重新啟動容器才會生效。  

## 來動手做吧

### 簡單建立一個docker容器
容器名稱:	firefoxforme  
網路:		host(等同主機的網路)  
環境變數:	DISPLAY(將投放的螢幕編號傳入)  
檔案通透:	/tmp/.X11-unix  
作業系統:	ubuntu:20.04  
Shell:		bash  
```
docker run -it  --name firefoxforme --net=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  ubuntu:20.04  bash
```
如果--net不是host的話，X window不會允許以root身份連進圖形，    
這樣就必須在docker裡頭建一個不是root的使用者進行連線。
### 取得主機的圖形界面認證碼
在主機輸入
```
xauth list
```
得到的結果為
```
alex/unix:0  MIT-MAGIC-COOKIE-1  dc9c4ddef8da6bf1e390f48f0dc2a2c5
```
我們將這串複製下來等等放入容器。  
進到容器
```
docker exec -it firefoxforme
```
然後下載xauth認證程式
```
apt install xauth
```
然後加入剛剛的認證碼
```
xauth add alex/unix:0  MIT-MAGIC-COOKIE-1  dc9c4ddef8da6bf1e390f48f0dc2a2c5 
```
### 下載文字編輯器
```
apt install nano
```
### 調整文字編碼
在docker
```
nano /etc/bash.bashrc
```
整段都別更改別刪除，在最後空白處加上  
```
export LANG=C.UTF-8
```

### 安裝中文字體
```
apt-get update
apt-get install ttf-wqy-microhei
```

### 退出容器
```
exit
```
### 重新啟動容器
```
docker firefoxforme  restart 
```

### 進入容器
```
docker exec -it firefoxforme
```

### 打開火狐瀏覽器
```
firefox
```
打開之後，如果你想要可以在setting選項，把字體調整中文字體。  
其他的圖形程式也可以用同樣的方式運作唷～～  


