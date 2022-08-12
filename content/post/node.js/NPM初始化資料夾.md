---
title: "NPM初始化資料夾"
date: 2022-08-12T09:00:44+08:00
draft: true
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# NPM初始化空資料夾

建立一個空資料夾，並且進入資料夾。

```bash
mkdir npm-test
cd npm-test
```

輸入npm初始化指令

```npm
npm init
```

然後輸入下列內容:

* package name: 專案名稱
* version: 專案版本
* description: 專案介紹
* entry point: 進入點，有點類似C語言里頭的main.c，程式開始的地方，預設為indexl.js。
* author: 作者。
* license: 授權。
* test command: 測試指令（在建立完整測試程序後可以再補上）。

## 建立出 package.json

接著就會建立出一個`package.json`檔案，檔案記載著你剛剛輸入的資訊，與未來添加套件的套件名稱與版本。

`package.json`

```json
{
  "name": "npm-test",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
```

## 安裝某個套件

我們來安裝React建置工具，用`npm install` 來進行。

```npm 
npm install create-react-app
```

## 建立出 node_modules 與 package-lock.json

* package-lock.json:
       由於一個create-react-app套件中，有許多的依賴套件，所以在這個檔案中，會列出所有正確版本的依賴套件，以便下次能正確還原。

* node_modules:
       這個檔案裡頭裝載著所有模組的實際檔案，通常這個檔案會很大。


