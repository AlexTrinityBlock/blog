---
title: "Jenkins的docker容器"
date: 2022-02-23T00:00:44+08:00
draft: true
featured_image: "/cicd.png"
tags: ["CICD"]
---

# 建立Jenkins容器

建立一個可以跟jenkins容器內部互通資料夾，我們稱為jenkins_volume

```bash
mkdir jenkins_volume
```

下載jenkins的docker映像檔

```bash
docker pull jenkins/jenkins
```

運作docker容器

```bash
docker run -p 8080:8080 -p 50000:50000 -v /home/alex/桌面/jenkins_volume:/jenkins_volume jenkins/jenkins
```

# 取得Jenkins密碼

檢查容器id

```bash
 docker ps
```

結果

```
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS                                                                                      NAMES
038da061a3dd   jenkins/jenkins   "/sbin/tini -- /usr/…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   nifty_liskov
```

我們可以知道容器的id是038da061a3dd，所以我們用以下指令登入容器。

```bash
docker exec -it 038da061a3dd bash
```

**後頭的bash是指，使用bash shell來接收我們的輸入**

然後查看裝有密碼的檔案

```bash
 cat /var/jenkins_home/secrets/initialAdminPassword
```

結果

```
bb3bbd515be0428a9114128faa04dedd
```

然後我們就可以打開

[http://127.0.0.1:8080/](http://127.0.0.1:8080/)

用上頭的密碼登入jenkins了。