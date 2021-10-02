---
title: "ventoy在隨身碟上裝多個作業系統"
date: 2021-07-08T10:29:36+08:00
draft: true
featured_image: "/debian1.jpeg"
tags: ["linux","ventoy"]
---
## 傳統隨身碟安裝作業統的方法

傳統上，我們會一個隨身碟安裝一個作業系統安裝程式或Live CD。當然也可以採取用分割區的方式，來在單個隨身碟安裝多個系統，但是這樣每安裝一個作業系統都要用dd指令或者是隨身碟寫入軟體，將映像檔慢慢寫入隨身碟。  

這樣會消耗一些時間，並且不太能靈活的切換新的作業系統。  

## ventoy是什麼？

ventoy是一個開機引導程序，類似Grub，但是有更漂亮的預設選單。  

ventoy寫入隨身碟之後，會產生一個專門裝作業系統映像檔的分割區，只要將ISO映像檔簡單的放入其中即可。  

ventoy的官方網站:  
https://www.ventoy.net/en/index.html  

## ventoy在Linux上頭安裝於隨身碟

下載Linux用的ventoy:  
https://www.ventoy.net/en/download.html  

下載好之後會有個ventoy-版本-linux.tar.gz檔案，這個時候我們將其解壓縮。  

資料夾架構大概像這樣


>ventoy-1.0.46  
>├── boot  
>├── CreatePersistentImg.sh  
>├── ExtendPersistentImg.sh  
>├── log.txt  
>├── plugin  
>├── README  
>├── tool  
>├── ventoy  
>├── Ventoy2Disk.ini  
>├── Ventoy2Disk.sh  
>├── VentoyWebDeepin.sh  
>├── <span style="color:red">VentoyWeb.sh</span>  
>└── WebUI  


解壓縮完畢後，有個VentoyWeb.sh檔案在其中。  
然後用root權限執行:  
```
sudo ./VentoyWeb.sh
```

這個時候打開瀏覽器，網頁的圖形化安裝界面就會出現在  
[http://127.0.0.1:24680](http://127.0.0.1:24680 )   

這個時候，如果隨身碟已經插入，就會顯示在畫面上，按下安裝即可。  

安裝好之後，打開隨身碟，將ISO檔案放入其中，開機的時候就可以看到選單了。  

## 限制

某些作業系統或某些隨身碟，使用ventoy時會意外的失敗，原因不明。  

除此之外，已經知道不可行的其中幾個情況包含:  

1. 映像檔是img檔，而不是iso檔。  
2. 映像檔是專門供應給隨身碟用的，而不支持CDrom(因為ventoy會將映像檔模擬成LiveCD)  
3. 特定檢查比較嚴格的作業系統不保證成功，例如Tail的某些版本，還有Android X86的某些版本。  
