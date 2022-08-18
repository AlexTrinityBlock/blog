---
title: "EJS-一個Javascript模板引擎"
date: 2022-08-18T09:00:44+08:00
draft: true
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# EJS-一個Javascript模板引擎

EJS是個可以像是PHP或者ASP般，在HTML中嵌入後端變數的模板引擎。

使用的語法是這樣的，我們傳入JS的變數kindOfDay後，就可以把ejs檔案裡頭的`<%= %>`標籤進行渲染了。

```ejs
<h1>It is <%= kindOfDay %>  </h1>
```

首先我們先建立一個目錄，

```bash
mkdir today
cd today
```

然後npm初始化資料夾

```
npm init

```

npm安裝需要的套件

```
npm install express body-parser ejs
```

建立裝置ejs檔案的資料夾views
這個資料夾一定要叫views～！

```
mkdir views
```

建立程式進入點

```
touch app.js
```

建立EJS模板

```
touch ./views/list.ejs
```

完成後後目錄如下：

```
today
├── app.js
├── node_modules
├── package.json
├── package-lock.json
└── views
        └── list.ejs
```

然後我們就可以快速建立一個判斷今天是否是週末的前後端程式了


`app.js`

```javascript
const express = require('express');
const bodyParser = require('body-parser');

const app = express();

app.set('view engine', 'ejs');

app.get('/', function (req, res) {

    let today = new Date();
    let currentDate = today.getDay();    
    let day = "";

    if (currentDate === 6 || currentDate === 0) {
        day = "Weekend";
    } else {
        day = "Weekday";
    }

    res.render("list.ejs",{"kindOfDay":day});
});

app.listen(3000, function () {
    console.log('Node Server Start');
});

```

`list.ejs`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>To Do List</title>
</head>
<body>
    <h1>It is <%= kindOfDay %>  </h1>
</body>
</html>
```