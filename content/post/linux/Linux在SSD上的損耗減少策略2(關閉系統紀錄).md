---
title: "Linux在SSD上的損耗減少策略2(關閉系統紀錄)"
date: 2021-03-01T11:24:26+08:00
draft: true
featured_image: "/debian1.jpeg"
tags: ["linux","ssd"]
---
在linux中，為了明確清楚電腦曾經發生過什麼，所以會將一切紀錄記載在以下資料夾  
```
/var/log
```
但是這樣終究會損耗SSD的寫入次數  
而且紀錄檔會越來越大  
如果沒有意圖要紀錄linux中發生的大小事時  
可以這樣操作  

### 關閉紀錄程式

紀錄程式的名稱稱為 rsyslog，以下是關閉的指令：
```
sudo systemctl disable rsyslog
```
systemctl適用於調整開機時自動執行的程式  
disable 關閉 / emable 啟動  
