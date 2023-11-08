---
title: "LinuxMint20.1上安裝docker"
date: 2021-05-19T00:05:03+08:00
draft: false
featured_image: "/docker.png"
tags: ["docker"]
---

### Mint安裝docker會遇上的問題
由於Mint目前還沒有專用版本的docker儲存庫，  
所以我們必須使用Mint的源頭Ubuntu版本的docker儲存庫  
也就是說，你無法按照官方的文件來進行docker安裝。

### 1.更新apt清單，並且確保下載docker儲存庫所需的資源足夠
```bash
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
```
### 2.下載Ubuntu傳輸金鑰
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

### 3.下載儲存庫
```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
```
<br></br>
注意：<span style='color:red'>沒把握的話本段落以下請忽略!</span>  
<span style='color:red'>$(. /etc/os-release; echo "$UBUNTU_CODENAME")</span>
這行的效果會回傳目前的Mint背後的Ubuntu版本  
而<span style='color:red'>/etc/os-release </span>裡頭記載著Mint與上游ubuntu的版本資訊  
<br></br>
也可以手動編輯儲存庫清單，來修改特定Ubuntu版本的docker下載  
檔案位置：
```bash
/etc/apt/sources.list.d/additional-repositories.list
```
打開之後裡頭是這樣
```bash
deb [arch=amd64] https://download.docker.com/linux/ubuntu 版本名稱 stable
```
把版本名稱改成想要的Ubuntu版本即可
<span style='color:red'>但不確定相容與否時別改 </span>
<br></br>

### 4.把剛剛添加的儲存庫清單更新進來
```bash
sudo apt-get update
```

### 5.安裝docker與docker-compose
```bash
sudo apt-get -y  install docker-ce docker-compose
```

### 6.解決權限問題
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
