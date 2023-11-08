---
title: "VirtualBox虛擬機作為伺服器"
date: 2022-03-14T15:00:36+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","VirtualBox","virtualbox"]
---

如果我們今天想要架設一個小小的服務，或者網頁，甚至只是想在一個乾淨的環境開發網站，不希望開發完畢後電腦裡頭還留下一大堆網頁開發的程式，這個時候我們就可以用虛擬機作為我們架設網頁伺服器的地方。

從安全的角度來看，虛擬機一般而言對於黑客是難以突破的，所以在上頭架設網站也是更加安全的。

但有個小問題，如果同事，或者服務的使用者要透過外網連入我們的虛擬機，要如何做到呢？

**在KVM上頭的設置是相對困難的**，不過呢，在VirtualBox上則容易許多。

因此，我們目前先在VirtualBox上頭進行。

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

1.點擊設定

![img](/blog/public/2022-03-14/1.png)

2.設置網路

選擇網路>附加到NAT>介面卡類型:半虛擬化網路

![img](/blog/public/2022-03-14/2.png)

然後點擊"連接埠轉送"

我們在下圖進行設置。

這樣的意思是，不指定特別的IP，然後真實電腦的8080 port會對應到虛擬機的80 port。

<span style="color:red">注意!在Ubuntu上頭真實電腦的防火牆UFW可能會預設鎖住80 port，所以我在耗費無數的失敗時間後，認為如果可以的話，調整防火牆設置，或者直接在真實電腦上改開動8080 port。</span>

![img](/blog/public/2022-03-14/3.png)