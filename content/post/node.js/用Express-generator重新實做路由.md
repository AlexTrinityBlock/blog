---
title: "用Express-generator重新實做路由"
date: 2022-02-18T10:00:44+08:00
draft: true
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# 目錄

[1.先備知識](#先備知識)

[2.新增路由檔案](#新增路由檔案)

[3.修改app.js](#修改appjs)

# 先備知識

[學會安裝NPM](/blog/public/post/node.js/npm安裝/)

[用Express-generator建立專案](/blog/public/post/node.js/用express-generator建立專案/)

[Express-generator使用與理解](/blog/public/post/node.js/express-generator使用與理解/)

[回到目錄](#目錄)

# 新增路由檔案

首先在routes底下新增我們自己的路由檔案news.js。

```
app/
└── routes
     └── news.js
```

然後撰寫news.js的內容。

```javascript
var express = require('express');
var router = express.Router();

router.get('/news', function(req, res, next) {
  res.send('新聞:天氣晴');
});

module.exports = router;

```

[回到目錄](#目錄)

# 修改app.js

增加新的路由檔案之後，要放入app.js使其在主程式執行時被啟用。

```
app/
└── app.js
```

app.js改成這樣:

```javascript
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var newsRouter = require('./routes/news.js');//增加這行，引入路由

var app = express();


app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/info', newsRouter);//增加這行，這樣我們要存取news的網址為http://localhost:3000/info/news


app.use(function(req, res, next) {
  next(createError(404));
});


app.use(function(err, req, res, next) {

  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};


  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
```

這樣我們就能順利在

```
http://localhost:3000/info/news
```

存取到網站了。

[回到目錄](#目錄)