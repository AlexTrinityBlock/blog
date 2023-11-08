---
title: "curl遠端執行shell"
date: 2021-05-01T13:29:36+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","curl","shell"]
---
遠端(例如github或網頁)執行shell script的方法，  
此方法需要curl套件。
```
bash < <(curl -s 網址)
```
這種方法執行的shell中不可加入sudo指令，否則會直接中斷  
如果需要sudo 必須採取如下的方式
```
sudo bash < <(curl -s 網址)
```
## 基於安全，你要很清楚知道你執行的shell的內容！