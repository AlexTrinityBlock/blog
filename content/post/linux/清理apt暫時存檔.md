---
title: "清理apt暫時存檔"
date: 2021-06-02T13:29:36+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","apt"]
---
## 下載套件的暫存路徑清除
當apt套件管理工具在安裝套件時，會先對套件進行下載。  
下載完畢尚未安裝的套件會被儲存在以下路徑:  
```
/var/cache/apt/archives
```
當這個目錄裡頭的東西過多時，可以用指令刪除暫存檔案：  
```bash
sudo apt-get autoclean
sudo apt-get clean
```

## 不用的相依賴套件刪除
當我們下載某個套件時，這個套件可能會因為依賴其他套件，而裝了許多套件。  
這種時刻，我們可以刪除不用的依賴套件:
```bash
sudo apt-get autoremove
```

