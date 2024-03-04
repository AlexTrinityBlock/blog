---
title: "Jenkins的docker-compose容器"
date: 2024-03-04T18:00:44+08:00
draft: false
featured_image: "/cicd.png"
tags: ["CICD"]
---

# Jenkins 的參考 YAML

以下 Docker compose 應對到 80 port。

*docker-compose.yaml*

```yaml
version: '3.3'
services:
  jenkins:
    image: jenkins/jenkins:lts
    restart: unless-stopped
    privileged: true
    user: root
    ports:
    - 80:8080
    container_name: jenkins
    volumes:
    - ./jenkins/data:/var/jenkins_home
    - /var/run/docker.sock:/var/run/docker.sock
    - /usr/local/bin/docker:/usr/local/bin/docker
```

# 連入容器的方法

```bash
docker exec jenkins bash
```