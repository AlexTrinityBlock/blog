---
title: "用Express-generator建立專案"
date: 2022-02-16T14:00:44+08:00
draft: false
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

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

# Express-generator使用

## 建立一個資料夾稱為web

```
mkdir web1
```

## 進入資料夾

```
cd web1
```

## 安裝

```
npm install express-generator
```

## 執行express-generator

執行express-generator並且建立名為app的專案

```
./node_modules/.bin/express app
```

## 了解專案目錄

```
app/                                     
├── app.js                               #網站主要的進入點js
├── bin                                  #裡頭有個可執行腳本www
│   └── www                              
├── package.json                         #npm需要安裝的清單與各種專案設定
├── package-lock.json                    #npm各個套件的版本
├── public                               #放置圖片與css,js等靜態檔案
│   ├── images                           
│   ├── javascripts                      
│   └── stylesheets                      
│       └── style.css                    
├── routes                               #路由路徑資料夾
│   ├── index.js                         
│   └── users.js                         
└── views                                #jade模板引擎
    ├── error.jade                       
    ├── index.jade                       
    └── layout.jade  
```

## 進入app資料夾

```
cd app
```

## 安裝索需要的套件

```
npm install
```

## 執行專案

```
npm start
```

## 以瀏覽器檢視網站

[http://127.0.0.1:3000/](http://127.0.0.1:3000/)