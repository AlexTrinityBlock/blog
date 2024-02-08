---
title: "關於Docker的Image閒談1"
date: 2024-02-08T14:10:44+08:00
draft: false
featured_image: "/docker.png"
tags: ["docker"]
---

# Docker 的 Volume 與 Image 的具體儲存位置

實際上 Volume 與 Image 在 Linux 上儲存在以下目錄:

```
/var/lib/docker/
/var/lib/docker/containers
/var/lib/docker/image
/var/lib/docker/volumes
```

雖然不建議，但純手動來複製 Image 也是可能的。

# Docker 或者其他容器技術的 Layer 結構

以下是個 Dockerfile:

```Dockerfile
FROM python:3.8

WORKDIR /app

RUN pip install flask

COPY . /app

EXPOSE 5000

CMD ["python", "app.py"]

```

如果我們加一個 `RUN pip install requests` 在 `RUN pip install flask`  下時:

```Dockerfile
FROM python:3.8

WORKDIR /app

RUN pip install flask
```

上方這段進行的操作是不會改變的， Docker Image 也只會增加或修改第三行以後的變更。

屬於增量儲存。

# Copy-on-write

Docker 的 Copy-on-write 特性主要體現在容器和鏡像的分層結構上。容器最上面是一個可寫的容器層，以及若干只讀的鏡像層組成，容器的數據就存放在這些層中。當在容器中進行數據修改時（比如修改 /etc/hello.conf 文件），Docker 會從上至下依次在各個鏡像層中查找此文件，一旦找到該文件，會立即將其複製到容器層，然後再進行修改操作，其他的操作也是一樣（如添加、讀取、刪除等操作）。

# 是誰負責讀寫新增 Docker 的每個 Layer ?

由 Storage drivers 驅動，可以如下:

* AUFS
* ZFS
* BTRFS
* Device Mapper
* Overlay
* Overlay2

# Docker 的 Volume 是誰來負責的? 能否直接寫入遠端檔案系統?

可以，要使用不同的 Volume Driver。

可以使用的 Volume Driver 有:

* Local
* Azure File Storage
* Convoy
* DigitalOcean Block Storage
* Flocker
* GCE-Docker
* GlusterFS
* NetAPP
* RexRay
* Portworx
* VMware vSphere Storage