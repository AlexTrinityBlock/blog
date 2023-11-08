---
title: "用UFW在ping下隱藏自己"
date: 2021-07-13T16:00:49+08:00
draft: false
tags: ["secure","防火牆","資安","firewall"]
featured_image: "/secure.jpg"
---

## 作者

阿維

## 概念

通常入侵與攻擊的第一步驟，是藉由ICMP(例如ping)或其他開放端口服務發掘主機所在的IP位址。  

我們可以嘗試先在ICMP的角度上頭隱藏好自己，至少對方沒有明確目標時，可能會忽略對我們的攻擊。  

當我們使用Linux的時候，我們有個很不錯的防火牆iptables，但是由於直接config時需要更多的經驗，才能確保連線順利。  
所以Ubuntu提供了一個簡便的軟體替我們代為調整iptables也就是UFW(Uncomplicated Firewall)(不複雜的防火牆)  

## 1.UFW的預設配置

我們可以在以下路徑找到UFW設定檔:
```
/etc/ufw/before.rules
```

UFW的預設配值如下
```
#
# rules.before
#
# Rules that should be run before the ufw command line added rules. Custom
# rules should be added to one of these chains:
#   ufw-before-input
#   ufw-before-output
#   ufw-before-forward
#

# Don't delete these required lines, otherwise there will be errors
*filter
:ufw-before-input - [0:0]
:ufw-before-output - [0:0]
:ufw-before-forward - [0:0]
:ufw-not-local - [0:0]
# End required lines


# allow all on loopback
-A ufw-before-input -i lo -j ACCEPT
-A ufw-before-output -o lo -j ACCEPT

# quickly process packets for which we already have a connection
-A ufw-before-input -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A ufw-before-output -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A ufw-before-forward -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# drop INVALID packets (logs these in loglevel medium and higher)
-A ufw-before-input -m conntrack --ctstate INVALID -j ufw-logging-deny
-A ufw-before-input -m conntrack --ctstate INVALID -j DROP

# ok icmp codes for INPUT
-A ufw-before-input -p icmp --icmp-type destination-unreachable -j ACCEPT
-A ufw-before-input -p icmp --icmp-type time-exceeded -j ACCEPT
-A ufw-before-input -p icmp --icmp-type parameter-problem -j ACCEPT
-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT

# ok icmp code for FORWARD
-A ufw-before-forward -p icmp --icmp-type destination-unreachable -j ACCEPT
-A ufw-before-forward -p icmp --icmp-type time-exceeded -j ACCEPT
-A ufw-before-forward -p icmp --icmp-type parameter-problem -j ACCEPT
-A ufw-before-forward -p icmp --icmp-type echo-request -j ACCEPT

# allow dhcp client to work
-A ufw-before-input -p udp --sport 67 --dport 68 -j ACCEPT

#
# ufw-not-local
#
-A ufw-before-input -j ufw-not-local

# if LOCAL, RETURN
-A ufw-not-local -m addrtype --dst-type LOCAL -j RETURN

# if MULTICAST, RETURN
-A ufw-not-local -m addrtype --dst-type MULTICAST -j RETURN

# if BROADCAST, RETURN
-A ufw-not-local -m addrtype --dst-type BROADCAST -j RETURN

# all other non-local packets are dropped
-A ufw-not-local -m limit --limit 3/min --limit-burst 10 -j ufw-logging-deny
-A ufw-not-local -j DROP

# allow MULTICAST mDNS for service discovery (be sure the MULTICAST line above
# is uncommented)
-A ufw-before-input -p udp -d 224.0.0.251 --dport 5353 -j ACCEPT

# allow MULTICAST UPnP for service discovery (be sure the MULTICAST line above
# is uncommented)
-A ufw-before-input -p udp -d 239.255.255.250 --dport 1900 -j ACCEPT

# don't delete the 'COMMIT' line or these rules won't be processed
COMMIT
```

要達成本篇文章的目的我們只要注意到兩個關鍵字
```
ACCEPT 與 DROP
```
DROP代表符合描述時丟棄封包，ACCEPT則代表接受。  


## 2.丟棄ICMP封包

我們先找到，同意接受外部ICMP，例如Ping的項目:  
```
# ok icmp codes for INPUT
-A ufw-before-input -p icmp --icmp-type destination-unreachable -j ACCEPT
-A ufw-before-input -p icmp --icmp-type time-exceeded -j ACCEPT
-A ufw-before-input -p icmp --icmp-type parameter-problem -j ACCEPT
-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT
```
我們注意到，裡頭有許多的ACCEPT  
這代表同意各式的ICMP，而ping也在其中。  

然後將所有ICMP都丟棄，改成以下這一段:  
```
# ok icmp codes for INPUT
-A ufw-before-input -p icmp --icmp-type destination-unreachable -j DROP
-A ufw-before-input -p icmp --icmp-type time-exceeded -j DROP
-A ufw-before-input -p icmp --icmp-type parameter-problem -j DROP
-A ufw-before-input -p icmp --icmp-type echo-request -j DROP
```

## 3.重新載入UFW
```
sudo ufw reload
```

## 補充閱讀

https://bobcares.com/blog/ufw-block-ping/  
https://linuxconfig.org/how-to-deny-icmp-ping-requests-on-ubuntu-18-04-bionic-beaver-linux  
