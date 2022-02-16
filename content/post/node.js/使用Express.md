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
├── bin                                  #裡頭有個www二進位檔
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

## 程式進入點app.js

app.js
```javascript
var createError = require('http-errors');//建立錯誤頁面物件
var express = require('express');//導入主要express物件
var path = require('path');//路徑物件
var cookieParser = require('cookie-parser');//cookie檢視物件
var logger = require('morgan');//紀錄log物件

//取得路由物件
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

//app物件由express建構子回傳
var app = express();

// 設定前端使用jade模板引擎
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

//導入各項功能
app.use(logger('dev'));//log紀錄
app.use(express.json());//json
app.use(express.urlencoded({ extended: false }));//URL 編碼
app.use(cookieParser());//Cookie 解析器
app.use(express.static(path.join(__dirname, 'public')));//靜態檔案資料夾

//將路由物件對應到不同網頁路徑，例如http://127.0.0.1:3000/users
app.use('/', indexRouter);//設定http://127.0.0.1:3000/路徑的陸由檔案
app.use('/users', usersRouter);//設定http://127.0.0.1:3000/users路徑的陸由檔案

//設置頁面不存在時的檔案
app.use(function(req, res, next) {
  next(createError(404));
});

//當網頁程式有誤時展示錯誤頁面
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  //如果是development開發狀態時，回應錯誤訊息
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  //渲染錯誤頁面，並且回應500
  res.status(err.status || 500);
  res.render('error');
});

//當別的模塊require這個檔案時，導出我們建構好的app物件
module.exports = app;
```