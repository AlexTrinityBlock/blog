---
title: "NPM安裝"
date: 2022-02-15T12:00:44+08:00
draft: true
featured_image: "/nodejs.jpg"
tags: ["Node.js"]
---

# NPM是啥？
node.js就像是一個登山客，沒有任何裝備時能作到的事情不多，而NPM就如同他的背包，可以讓node.js裝上許多不同的模塊。

# NPM安裝於Ubuntu(儲存庫)

第一種方法是使用Ubuntu儲存庫，裡頭提供穩定版本的node.js，可能會稍微舊一點，但也會穩定一點。

更新apt儲存庫清單
```bash
sudo apt update
```

安裝npm與nodejs
```bash
sudo apt install nodejs npm
```

用顯示nodejs版本，來檢查是否成功安裝。
```bash
nodejs --version
```


# NPM安裝於Ubuntu(NVM管理器)

第二種方法是使用NVM來安裝，NVM是一種node.js版本管理器，好處是可以安裝多個版本，並且也可以安裝新版本的node.js。

從儲存庫下載NVM

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

檢查NVM安裝成功與版本
```bash
nvm --version
```

列出所有Node.js版本
```bash
nvm list-remote
```

安裝最新版本的node.js
```bash
nvm install node
```

安裝完畢後檢查是否安裝成功
```bash
node --version
```

而且，可以同時安裝好多個版本
這裡我們安裝LTS也就是長期支援版與10.9.0版
```bash
nvm install --lts
nvm install 10.9.0
```

列出已經安裝的node.js版本
```bash
nvm ls
```

顯示出來旁邊有箭頭的是正在使用的版本
```bash
>      v10.9.0
       v12.16.3
```

使用特定版本node.js，例如12.16.3
```bash
nvm use 12.16.3
```