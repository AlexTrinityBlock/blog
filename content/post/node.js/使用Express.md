---
title: "使用Express"
date: 2022-02-16T13:00:44+08:00
draft: true
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# 原生的安裝方式

## 建立一個資料夾稱為web
```
mkdir web
```

## 進入資料夾
```
cd web
```

## 安裝express

### 完整語法

```
npm install express --save
```
也可以安裝為開發者模式
```
npm install express --save-dev
```

### 簡化語法

一般模式
```
npm i express
```
也可以安裝為開發者模式
```
npm i express -D
```

## 一個簡單的javascript的程式

檔案名稱: main.js

```javascript
//引入模塊express
var express = require('express');
//實例化express
var app = express();
 
//在網站的根目錄回應Hello
app.get('/', function (req, res) {
   res.send('Hello!!!');
})

//偵聽8080
var server = app.listen(8080, function () {

    //取得目前伺服器的偵聽ip
    var host = server.address().address
    //取得目前伺服器的偵聽port
    var port = server.address().port
    //在終端顯示偵聽的ip與port。
    console.log("位址與port", host, port)
 
})
```

## 直接執行

```bash
node main.js
```
