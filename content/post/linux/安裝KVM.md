---
title: "安裝KVM"
date: 2021-05-28T13:29:36+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","kvm"]
---
本篇討論在linux mint上頭安裝kvm虛擬機的方法。  
## 檢查CPU相容性
cpu檢查工具
```
sudo apt install cpu-checker
```
檢查
```
sudo kvm-ok
```

## apt 套件安裝
```
 sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager ovmf
```

## 啟動虛擬化守護進程
```
 sudo systemctl enable --now libvirtd
```

剛安裝完畢時可能會無法連接qemu server，重新啟動或登出登入即可  
