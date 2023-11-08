---
title: "MAC位址掩蔽"
date: 2021-07-21T10:00:49+08:00
draft: false
tags: ["secure","資安","mac","MAC"]
featured_image: "/secure.jpg"
---

## 作者

阿維

## 環境

<span style="color:red">Ubuntu 20.04</span>

## 概念

我們的IP位址，除非申請固定IP否則是會變化的，如果你願意也可以用特定軟體來改變或借用別人的IP位址。  
所以既然IP是可以輕鬆變化的，那別人要追蹤到我們是否有別的選擇呢？  

一般而論更好的方法是，追蹤我們的MAC位址。

## 了解MAC位址訊息

有先我們輸入 ifconfig  

列出了下列資訊:  
```
wlp0s20f3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.199.108  netmask 255.255.255.0  broadcast 192.168.199.255
        ether a0:ff:6b:f3:f7:ac  txqueuelen 1000  (Ethernet)
        RX packets 407132  bytes 534433802 (534.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 180425  bytes 22157781 (22.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

我們觀察到<span style="color:red">ether a0:ff:6b:f3:f7:ac</span>這一行這代表我們的MAC位址。  

然後我們看向<span style="color:red">wlp0s20f3</span>這個是我們的網路界面，也就是網路卡。  

MAC位址其實一定程度上可以追溯出網路卡的製造廠商，與一些相關資訊。  

所以暴露出來的風險比較大一點。  

## 不用任何軟體就能暫時修改MAC位址

確實有些軟體可以修改MAC位址，甚至隨機產出MAC位址，但是多數的Linux發行本其實自帶這個功能，所以可能的話不用額外安裝這些軟體。  

基本上修改MAC的指令格式如下:
```
sudo ifconfig <網路界面名稱> down #關閉網路界面
sudo ifconfig <網路界面名稱> hw ether <想改成的MAC位址>
sudo ifconfig <網路界面名稱> up #開啟網路界面
```

以下範例為我將我的MAC改為<span style="color:red">aa:aa:aa:aa:aa:aa</span>
```
sudo ifconfig wlp0s20f3 down
sudo ifconfig wlp0s20f3 hw ether aa:aa:aa:aa:aa:aa
sudo  ifconfig wlp0s20f3 up
```

## 長期修改MAC位址

找到這個檔案
```
/etc/network/interfaces
```
這個檔案會決定網路的一些基本配置  

在末尾加上這一行。  
```
hwaddress ether <想改成的MAC位址>
```
例如:
```
hwaddress ether aa:aa:aa:aa:aa:aa
```
## 偽裝把戲

如果你把MAC位址調整成與WIFI上的某個其他人的電腦一樣。  

這時後會發生兩種可能:

> 1.Switch或WIFI分享器發現錯誤，然後你們兩個都不能用網路  
> 2.你可以收到來自對方的封包，你的上網流量會跟對方的混在一起。  

這是一個可以實驗的事情。  

## 可以變更MAC的軟體

macchanger這個軟體可以幫你變更MAC位址，也可以隨機生成MAC位址。  

不過需要額外的安裝，雖然不多，但仍然是占空間的。  

如果你希望簡單的隨機產生MAC，而不是自己想或手打，可以用用看。  

安裝方式:

```
sudo apt installl macchanger
```
