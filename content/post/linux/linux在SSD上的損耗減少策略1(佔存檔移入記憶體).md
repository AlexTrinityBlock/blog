---
title: "linux在SSD上的損耗減少策略1(佔存檔移入記憶體)"
date: 2021-03-01T01:04:15+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","ssd"]
---

### 概述

固態硬碟SSD存在著寫入次數限制  
而linux上頭各應用程式  
暫時存在的檔案通常會放在 
```
/tmp
```
目錄之中  
我們該如何減少/tmp 中頻繁的擦寫帶來的損耗呢？  

### linux mint 中的解決方案
tmpfs是個可以將資料暫存到記憶體  
也就是Ram中的程式  
雖然可以直接操控，但是為求簡便linux mint中預設某個可用的服務，可以直接達成此目標  
打開終端機  
```
sudo cp /usr/share/systemd/tmp.mount /etc/systemd/system/tmp.mount
```
將沒被啟用的服務檔案tmp.mount複製到正在使用的服務檔案資料夾  
```
sudo systemctl enable tmp.mount
```
啟用服務，完成！
