---
title: "建置一個React前端網站"
date: 2022-08-12T09:30:44+08:00
draft: true
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

# 建立一個空資料夾

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