---
title: "Express-generator使用與理解"
date: 2022-02-17T13:00:44+08:00
draft: true
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# 目錄

[1.先備知識](#先備知識)

[2.專案進入點/bin/www](#專案進入點binwww)

[3.理解package.json](#理解packagejson)

[4.理解app.js](#理解appjs)

# 先備知識

[學會安裝NPM](/blog/public/post/node.js/npm安裝/)

[用Express-generator建立專案](/blog/public/post/node.js/用express-generator建立專案/)

[回到目錄](#目錄)

# 專案進入點/bin/www

當我們輸入

```
npm start
```

就會第一個觸發該js程式，我們可以看看裡頭的檔案配置。

```javascript
#!/usr/bin/env node

/**
 * 引入必要模塊
 */

var app = require('../app');//引入我們自己寫的app.js
var debug = require('debug')('app:server');
var http = require('http');

/**
 * 把port傳入app裡頭，沒有預設環境變數時，預設3000port，可以手動修改成別的。
 */

var port = normalizePort(process.env.PORT || '3000');
app.set('port', port);

/**
 * 建立node.js HTTP 伺服器
 */

var server = http.createServer(app);

/**
 * HTTP 伺服器　偵聽特定port並且在出錯時啟用我們自製的錯誤處理函數
 */

server.listen(port);
server.on('error', onError);
server.on('listening', onListening);

...

```

[回到目錄](#目錄)

# 理解package.json

```json
{
  "name": "app",//npm專案名稱
  "version": "0.0.0",//版本
  "private": true,//私有專案
  "scripts": {
    "start": "node ./bin/www"　//輸入NPM start時，會執行node ./bin/www，用js執行 www啟動腳本
  },
  "dependencies": { //專案依賴套件
    "cookie-parser": "~1.4.4",//Cookie解析模塊
    "debug": "~2.6.9",
    "express": "~4.16.1",//Express網頁模塊
    "http-errors": "~1.6.3",//HTTP錯誤處理模塊
    "jade": "~1.11.0",//前端模板引擎
    "morgan": "~1.9.1"//log紀錄檔模塊
  }
}
```
順代一提，如果要新增package.json裡頭npm模塊，需要使用這個指令:

```
npm install <模塊名稱>
```

不過在低版本的npm5.0以前，如果沒有加入如下的--save參數，是不會紀錄到package.json中的。

因此，需要用以下指令:

```
npm install <模塊名稱> --save
```

刪除則是

```
npm uninstall <模塊名稱>
```

如果為了快速移動專案資料夾，可以刪除掉node_modules

移動到新的環境時，用以下指令安裝所有需要的模塊

```
npm install
```
[回到目錄](#目錄)

# 理解app.js

app.js
```javascript
var createError = require('http-errors');//建立錯誤頁面物件
var express = require('express');//導入主要express物件
var path = require('path');//路徑物件
var cookieParser = require('cookie-parser');//cookie檢視物件
var logger = require('morgan');//紀錄log物件，我們在終端機上看到的GET / 200 6.923 ms - 170等存取紀錄就是來自這個模塊。如果要的話，可以寫入某個特定文件。

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