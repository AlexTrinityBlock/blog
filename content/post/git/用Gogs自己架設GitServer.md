---
title: "用Gogs自己架設Git Server"
date: 2022-02-23T00:02:44+08:00
draft: false
featured_image: "/git.png"
tags: ["git","git server"]
---

# Gogs是啥？

由go語言撰寫而成，一個輕量化方便部屬的Git伺服器。

# 需要的部件

Docker: 一個能夠建立容器，快速部屬環境的半虛擬化工具。

Gogs: 輕量化Git伺服器。

# 1.建立儲存卷

在Docker中能夠與外界互相連通得資料夾，稱為Volume，中文翻譯做卷。

我們先建立一個資料夾作為Volume

```bash
sudo mkdir -p /var/gogs
```

# 2.拉取映像檔

Docker中的環境檔案稱為image，也就是映像檔，是可以從Docker Hub網站下載的。

```bash
docker pull gogs/gogs
```

# 3.用映像檔建立運作的容器

可以用以下指令來啟動

**前景執行**

```bash
docker run --name=gogs -p 10022:22 -p 10880:3000 -v /var/gogs:/data gogs/gogs
```

第一次建議前景執行，因為配置錯誤時，會在終端機顯示錯誤原因。

**背景執行**

```bash
docker run -d --name=gogs -p 10022:22 -p 10880:3000 -v /var/gogs:/data gogs/gogs
```

# 4.進行配置

進入本機網址

[http://127.0.0.1:10880/install](http://127.0.0.1:10880/install)

# 5.進行配置

## 雖然SQLite效能不完美，但是單純就配置的容易度來看，是最容易的。

![img](/blog/public/2022-02-23/1.png)

## 網址後頭的port一定要改成我們設置的10880port。

![img](/blog/public/2022-02-23/2.png)

## 然後建議先建立好管理員帳號。

![img](/blog/public/2022-02-23/3.png)

## 最後就可以登入使用了。

![img](/blog/public/2022-02-23/4.png)

# 6.進行SSH配置

## 進入用戶設定

![img](/blog/public/2022-02-23/5.png)

## 管理SSH密鑰

![img](/blog/public/2022-02-23/6.png)

## 新增密鑰並且將自己的公鑰貼上

如果不知道如何生成公私鑰，可以到這篇查看。

[生成SSH公私鑰匙](/blog/public/post/git/github免密碼上傳/)

鑰匙產生之後，記得，我們使用10022port進行SSH連線，所以請按照這一篇，調整我們的SSH連線port。

[調整SSH連線Port](/blog/public/post/git/如何用22port以外連上gitserver/)

![img](/blog/public/2022-02-23/7.png)
