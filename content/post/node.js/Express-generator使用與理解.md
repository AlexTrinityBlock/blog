---
title: "Express-generator使用與理解"
date: 2022-02-17T13:00:44+08:00
draft: false
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# 目錄

[1.先備知識](#先備知識)

[2.專案進入點/bin/www](#專案進入點binwww)

[3.理解package.json](#理解packagejson)

[4.理解app.js](#理解appjs)

[5.調整Morgan的log格式](#調整morgan的log格式)

[6.模塊(Module)機制說明](#模塊module機制說明)

[7.HTTP請求](#http請求)

[8.Express中的路由意義](#express中的路由意義)

[9.Express中的路由參數傳遞](#express中的路由參數傳遞)

[10.Express中的回應客戶的方法](#express中的回應客戶的方法)

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
app.use('/', indexRouter);//設定http://127.0.0.1:3000/路徑的路由自製模塊
app.use('/users', usersRouter);//設定http://127.0.0.1:3000/users路徑的路由自製模塊

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

[回到目錄](#目錄)

# 調整Morgan的log格式

## 自訂Mogrgan輸出

到app.js中調整Morgan的一些基本設置，就能夠自訂log輸出格式。

其中有各種類型的log內容，例如顯示用戶輸入的url時可以用這樣
```
:url
```

例如我們改成這樣

```javascript
logger.format('test-log','This is log :method :url :status :response-time');
app.use(logger('test-log'));
```

輸出就會變成這樣

```
This is log GET /stylesheets/style.css 200 3.463
```

以下是各種內容介紹

```
:date[format]
The current date and time in UTC. The available formats are:

clf for the common log format ("10/Oct/2000:13:55:36 +0000")
iso for the common ISO 8601 date time format (2000-10-10T13:55:36.000Z)
web for the common RFC 1123 date time format (Tue, 10 Oct 2000 13:55:36 GMT)
If no format is given, then the default is web.

:http-version
The HTTP version of the request.

:method
The HTTP method of the request.

:referrer
The Referrer header of the request. This will use the standard mis-spelled Referer header if exists, otherwise Referrer.

:remote-addr
The remote address of the request. This will use req.ip, otherwise the standard req.connection.remoteAddress value (socket address).

:remote-user
The user authenticated as part of Basic auth for the request.

:req[header]
The given header of the request. If the header is not present, the value will be displayed as "-" in the log.

:res[header]
The given header of the response. If the header is not present, the value will be displayed as "-" in the log.

:response-time[digits]
The time between the request coming into morgan and when the response headers are written, in milliseconds.

The digits argument is a number that specifies the number of digits to include on the number, defaulting to 3, which provides microsecond precision.

:status
The status code of the response.

If the request/response cycle completes before a response was sent to the client (for example, the TCP socket closed prematurely by a client aborting the request), then the status will be empty (displayed as "-" in the log).

:total-time[digits]
The time between the request coming into morgan and when the response has finished being written out to the connection, in milliseconds.

The digits argument is a number that specifies the number of digits to include on the number, defaulting to 3, which provides microsecond precision.

:url
The URL of the request. This will use req.originalUrl if exists, otherwise req.url.

:user-agent
The contents of the User-Agent header of the request.
```

至於更多細節可以參閱

[https://www.npmjs.com/package/morgan](https://www.npmjs.com/package/morgan)

## Mogrgan預設輸出

到app.js中調整Morgan的一些基本設置，套用幾種預設的輸出格式。

### dev

在終端機裡頭會改變顏色，請求成功是綠色，好看又方便觀察。

等同

```
:method :url :status :response-time ms - :res[content-length]
```

使用時將app.js改為

```javascript
app.use(logger('dev'));
```

### combined　與　common

Apache的標準log格式，方便其他log解讀軟體閱讀，combined多了user-agent比較詳細，十分建議。

```javascript
app.use(logger('combined'));
```

```javascript
app.use(logger('common'));
```

### short 與　tiny

比預設輸出更短。

```javascript
app.use(logger('short'));
```

```javascript
app.use(logger('tiny'));
```

[回到目錄](#目錄)

# 模塊(Module)機制說明

模塊(Module)機制是node.js中的一個關鍵機制，與其他近代語言如同Python一般，可以將類別或函數分別撰寫在不同檔案，最後進行呼叫與代碼重用和組織，以方便管理。

我們此處示範建立一個測試用的模組，其資料夾路徑如下。

```
app/
└── models
        └── test.js
```

## 模塊的內容撰寫
test.js
```javascript
function test(){
    return "This is Test"
}

module.exports = test; //一定要有這一行，才能在使用時引用上頭的test函數或其他物件
```

## 修改在routes中的內容

我們可以在routes目錄下看到index.js，這個資料夾用於，當我們在網頁根路徑/時，引出的對應反應。

```
app/
└── routes
        └── index.js
```

我們將剛剛自製的模塊引入app/routes/index.js

```javascript
var express = require('express');
var test = require('../models/test');

var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: test() });
});

module.exports = router;
```

這時候我們就能引用自己撰寫的test()的內容了。

順代一提，如果沒有名稱重複，強烈建議在routes,自製模組的檔名,函數與類別的名稱，非常建議要一致。否則容易忘記或搞混。

## 複數函數或物件的模塊引用

如果我們的一個檔案裡頭有一個以上的函數或類別，可以用以下方式導出。

test.js
```javascript
function test1(){
    return "This is Test1"
}

function test2(){
    return "This is Test2"
}

module.exports = {
    test1:test1,
    test2:test2
};
```

或者

test.js
```javascript
function test1(){
    return "This is Test1"
}

function test2(){
    return "This is Test2"
}

module.exports = {test1,test2};
```

然後在引用時要這樣

routes/index.js
```javascript
var express = require('express');
var test = require('../models/test');

var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  // res.render('index', { title: 'Express' });
  res.render('index', { title: test.test1()+test.test2() });
});

module.exports = router;
```

[回到目錄](#目錄)

# HTTP請求

## 論HTTP請求中的Header與Body

**GET**

在GET中，請求的內容通通在header中，從另外一個角度來看，請求的內容通通在網址中。

GET沒有body，主要用於取得資料。

例如我們用GET對伺服器發出color為red的請求會長成:

```
網址?color=red
```

**POST**

POST中則是請求的格式細節在header中，而請求內容放在body。
用於新增資料。

**PUT**

用於修改資料。

**DELETE**

用於刪除資料。

[回到目錄](#目錄)

# Express中的路由意義

我們觀察routes/index.js

```javascript
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
```

其中就隱含了node.js中最簡單回應客戶請求的方式，我們可以看到下方的範本:

## GET

```javascript
var router = express.Router();

router.get('/', function(req, res, next) {
  res.send('要回應給客戶的內容');
});
```

## POST

```javascript
var router = express.Router();

router.post('/', function(req, res, next) {
  res.send('要回應給客戶的內容');
});
```

## PUT

```javascript
var router = express.Router();

router.put('/', function(req, res, next) {
  res.send('要回應給客戶的內容');
});
```

## DELETE

```javascript
var router = express.Router();

router.delete('/', function(req, res, next) {
  res.send('要回應給客戶的內容');
});
```

## 設定特定的網頁路徑

例如我們要用

```
網址/home/test
```
來當作我們的路徑，路由可以這樣寫:

```javascript
var router = express.Router();

router.get('/home/test', function(req, res, next) {
  res.send('要回應給客戶的內容');
});
```

[回到目錄](#目錄)

# Express中的路由參數傳遞

## 取得在URL路徑中的參數傳遞

假如我們要買書，並且要買001號書，在一般的get參數傳遞會是這樣:

```
網址?book=001
```

但如果我們希望可以用路徑式的方式來傳遞參數

```
網址/book/001
```

就可以用以下的方式。

我們首先修改routes/index.js

```javascript
var express = require('express');
var router = express.Router();

router.get('/book/:parameter1', function(req, res, next) {
  res.send("你輸入的是"+req.params.parameter1);
});

module.exports = router;

```

其中

```
req.params.parameter1
```

會回傳我們在網址列路徑中輸入的參數

這時候我們存取這個網址

```
http://127.0.0.1:3000/book/001
```

就可以看到

```
你輸入的是001
```

## 取得傳統的GET/POST參數

若要用GET方式傳遞參數，整段程式都不用改，如下即可。

routes/index.js
```javascript
var express = require('express');
var router = express.Router();

router.get('/book/:parameter1', function(req, res, next) {
  res.send("你輸入的是"+req.params.parameter1);
});

module.exports = router;

```

而參數傳遞時則用

```
http://127.0.0.1:3000?book=001
```

而POST亦然，只是請求方式改成POST而已。

## Express中取得參數的幾種方法

| 語法 | 描述 |
| :----: | :----: |
| req.body | POST中主要資訊於body中的內容。 |
| req.query | GET/POST中的參數。 |
| req.params | GET/POST與URL路徑式的參數傳遞的內容。 |

[回到目錄](#目錄)

# Express中的回應客戶的方法

## res.send

這種方法可以回傳字串與陣列

### 字串

routes/index.js
```javascript
var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.send("天氣晴朗");
});

module.exports = router;
```

### 陣列

routes/index.js
```javascript
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.send(["天氣","晴朗"])
});

module.exports = router;
```

## res.json

這種方法用於回應json格式，非常適合在設計API時使用。

routes/index.js
```javascript
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.json({"狗狗":"汪汪","貓咪":"喵喵"})
});

module.exports = router;
```


[回到目錄](#目錄)