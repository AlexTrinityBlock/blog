---
title: "ngrok使用"
date: 2021-04-24T14:43:44+08:00
draft: false
featured_image: "/network.jpg"
tags: ["ngrok","手機網路","伺服器","network"]
---


## 人不可能一帆風順，人生低潮的時候，還是需要能遠端展示網頁的工具
### 當手邊沒太多錢訂購vps或者是固定ip網路時...就靠ngrok架站吧～！

## 1.關於架設一個網站需要的條件

(1)伺服器（你的筆電，桌上型電腦，樹莓派...甚至手機，能裝上linux的裝置）  

(2)一個ip位址，固定ip不能是由NAT隨機轉發，所以一般情況下，手機網路是不能的，除非業者提供相關服務。

## 2.沒有固定ip的克服方式

### 申請帳號與登錄金鑰

以後不知道，但是在此時此刻，ngrok提供一個免費的ip轉發  
先到下列網站申請帳號  
[ngrok](https://ngrok.com/)  

然後下載ngrok檔案  
![img](/blog/public/2021-04-27/ngrok1.png)  

解壓縮，並且將金鑰登入
![img](/blog/public/2021-04-27/ngrok2.png)  

### 啟動ip轉發 

啟動應用程式  

``` bash
./ngrok http 80
```

假如你寫了一個網站，在80 port  
此時終端機就會產生一組網誌連入你電腦的80 port  

