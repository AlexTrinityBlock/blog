---
title: "Docker基本指令"
date: 2022-07-06T09:00:03+08:00
draft: true
featured_image: "/docker.png"
tags: ["docker"]
---

## Docker概念

* 半虛擬化

* 比一般虛擬機快

* 檔案大小很小

* 不用完全模擬到硬體層級

## 實用只指令

### 1.運作一個nginx網頁伺服器

* run: 下載映像檔同時執行。

* -d: 第一次建立容器時就採取背景執行，防止中止執行時刪除容器。

* -p: 容器的80 port對應到實體主機的8080 port。

* nginx: 下載與執行Nginx網頁伺服器容器。

```
 docker run -d -p 8080:80 nginx
```

### 2.顯示所有啟動或者關閉的容器

* ps: 展示目前執行中的容器。

* -a: 也一併展示關閉的容器。

```
docker ps -a
```

### 3.下載Ubuntu的docker映像檔

* pull: 下載映像檔

* 版本: ***ubuntu:20.04*** 代表要下載的映像檔是Ubuntu20.04版本的映像檔。

```
docker pull ubuntu:20.04
```

### 4.容器停止運作之後清除容器

單次使用的應用程式非常適合該指令，因為在結束運作之後，不會留下殘餘檔案。

* --rm: 該容器停止運作之後，直接刪除容器檔案。

```
docker run --rm ubuntu:20.04
```

### 5.容器停止後總是重新啟動

* --restart: 容器停止後是否重新啟動的選項。

* mysql: 資料庫。

```
docker run --restart=always mysql
```

### 6.使用Ubuntu並且限制只能使用0~1號CPU

* --cpuset-cpus: 設定可以使用的CPU核心，0-2代表0,1,2三個CPU核心都可以使用。

* -m: 給單一容器的記憶體大小，300M代表300MB的空間。

```
docker run -it  -m 300M --cpuset-cpus="0-2" ubuntu:20.04 /bin/bash
```

### 7.建立Docker可以使用的硬碟空間Volume

暫存於Ram的空間。

* type=tmpfs: 建立臨時檔案系統。

* device=tmpfs: 路徑位於/tmpfs。

* o=size=100m: 最大容量100MB。

* uid=1000: 使用者為一般使用者。

```
docker volume create --driver local \
    --opt type=tmpfs \
    --opt device=/tmpfs \
    --opt o=size=100m,uid=1000 \
    foo
```