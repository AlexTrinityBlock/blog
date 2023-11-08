---
title: "Git整合過去Commit"
date: 2022-02-23T00:04:44+08:00
draft: false
featured_image: "/git.png"
tags: ["git","github"]
---
如果說有多條commit要合併成一條

就需要使用 

```
git rebase
```

# 1

首先，在git 中最新的一個commit 稱為 Head

所以git rebase的一個常用指令就是

```
git rebase -i Head~~ 
```

將目前為止的commit進行合併

# 2

這個指令下達之後，會展示一個vim文字編輯器

我們可以在這裡把想合併消失的commit它們的pick改成 squash

最後按 ``` esc ``` + ``` :wq ``` 儲存

# 3

此時會跳出一個編輯視窗
可以直接儲存
也可以刪除舊的commit註解
儲存完後 rebase就完成
舊的commit也就合併了