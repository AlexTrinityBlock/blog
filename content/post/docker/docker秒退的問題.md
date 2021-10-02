---
title: "docker.sock錯誤處理"
date: 2021-05-01T23:05:03+08:00
draft: true
featured_image: "/docker.png"
tags: ["docker"]
---

### docker.sock的錯誤
剛裝好docker時常常會跳出此種錯誤
```
Got permission denied while trying to connect 
to the Docker daemon socket at 
unix:///var/run/docker.sock: 
Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: 
dial unix /var/run/docker.sock: connect: permission denied
```

### docker.sock的功能
簡單來說就是連通容器與外部主機

### 解決
建立docker權限群組
```bash
sudo groupadd docker
```
將使用者加入權限群組
```bash
sudo usermod -aG docker $USER
```
切換到docker權限群組
```bash
newgrp docker 
```
這樣就不會跳出錯誤了