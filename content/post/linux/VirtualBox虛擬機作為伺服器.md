---
title: "VirtualBox虛擬機作為伺服器"
date: 2022-03-14T15:00:36+08:00
draft: true
featured_image: "/debian1.jpeg"
tags: ["linux","VirtualBox","virtualbox"]
---

# 作業系統

本篇文章使用的作業系統是Linux Mint但沒意外的話Ubuntu與Debian也都可以用此種方法操作。

# 安裝VirtualBox

輸入以下指令安裝VirtualBox

```
sudo apt update
sudo apt install virtualbox
```

如果要安裝virtualbox-ext-pack，請記得，這個不能商業使用唷。

不過如果要商業使用的話，或許K8S更合適。

# 開啟VirtualBox

```
virtualbox
```

# 調整虛擬機網路

![img](/blog/public/2022-03-14/)