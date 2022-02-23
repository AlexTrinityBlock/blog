---
title: "Jenkins的docker容器"
date: 2022-02-23T00:00:44+08:00
draft: true
featured_image: "/cicd.png"
tags: ["CICD"]
---

# 一次性快速使用Jenkins

```bash
docker run \
  --rm \
  -u root \
  -p 8080:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME":/home \
  jenkinsci/blueocean
```

趁密碼出現時，從終端機上頭複製下來

用複製到的密碼解鎖

[http://127.0.0.1:8080/](http://127.0.0.1:8080/)

# 長期保存的Jenkins

## 建立Jenkins容器

運作docker容器

```bash
docker run \
  -u root \
  -p 8080:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME":/home \
  jenkinsci/blueocean
```

## 取得Jenkins密碼

檢查容器id

```bash
 docker ps
```

結果

```
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS                                                                                      NAMES
038da061a3dd   jenkins/jenkins   "/sbin/tini -- /usr/…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp.....
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

我們接著就可以安裝，並且以設定帳號密碼，本教學都將用admin來當作一切帳號密碼。