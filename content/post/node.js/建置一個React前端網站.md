---
title: "建置一個React前端網站"
date: 2022-08-12T09:30:44+08:00
draft: false
featured_image: "/nodejs.jpg"
tags: ["Node.js","React"]
---

# 更新Node.js

這段請隨著Node.js的版本更新調整。

本文章撰寫的時候，我希望安裝Node.js 16 版，因為此時需要如此才能順利建置React APP。

### 安裝NVM

NVM用於安裝多個版本的Node.js這是在非主流Linux上必要的措施。

```
sudo apt install curl
cd ~
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
```

啟動NVM

```
source ~/.profile 
```

安裝Node.js 16

```
 nvm install 16
```

啟動Node.js 16

```
nvm use 16
```

檢查版本

```
node -v
npm -v
```

# 建立React專案

建立一個空資料夾

```
mkdir my-react
cd my-react
```

在資料夾中安裝React建置工具

```
npm install create-react-app
```

建立React App資料夾，並且初始化：

```
npx create-react-app my-react-app
```

# 啟動React專案

進入專案資料夾

```
cd my-react-app
``` 

啟動React專案

```
npm start
```

啟動後就會自動在預設瀏覽器開啟整個專案了。

# 把專案打包成 HTML, CSS, JS

有個已經設置好的建置指令:

```
npm run build
```

接著會生成出一個build資料夾，裡頭就有編譯好的 HTML, CSS, JS 了。

# 建立伺服器來檢查打包的專案是否能正確執行

安裝伺服器軟體。

```
npm install -g serve
```

將剛剛建置好的build資料夾當作靜態網頁根目錄執行。

```
serve -s build
```

# 參考資料

https://tecadmin.net/install-latest-nodejs-npm-on-linux-mint/

https://ithelp.ithome.com.tw/articles/10266770