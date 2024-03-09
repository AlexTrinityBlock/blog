---
title: "iptables筆記"
date: 2024-03-09T11:39:25+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","iptables"]
---

# iptables 是什麼?

iptables 是 Linux 內核中的防火牆軟體 netfilter 的管理工具，位於使用者空間，同時也是 netfilter 的一部分。 Netfilter 位於內核空間，不僅有網路地址轉換的功能，也具備資料包內容修改、以及資料包過濾等防火牆功能。

# iptables 可以做什麼?

*建立如 Docker Network 或 K8S 網路等 CIDR 網路

* 限制只允許某些 IP 的主機連入

* 封鎖允許某些 Port

* NAT 轉發

# iptables 有哪些表?

iptables 有四個表，分別是：

* filter：用於過濾資料包。
* nat：用於進行網路地址轉換 (NAT)。
* mangle：用於修改資料包標頭。
* raw：用於處理原始資料包。

每個表都有不同的用途，可以根據需要進行配置。

## filter 表

filter 表是 iptables 中最常用的表，用於過濾資料包。filter 表可以根據以下條件來過濾資料包：

* 來源 IP 位址
* 目標 IP 位址
* 協定
* 埠號
* 資料包標頭中的其他資訊
* filter 表可以允許或拒絕資料包通過。

## nat 表

nat 表用於進行網路地址轉換 (NAT)。NAT 可以將一個 IP 位址轉換為另一個 IP 位址。這可以用於以下目的：

* 將內部網路的 IP 位址轉換為外部網路的 IP 位址
* 將多個 IP 位址轉換為一個 IP 位址
* 隱藏內部網路的 IP 位址

nat 表可以根據以下條件來進行 NAT：

* 來源 IP 位址
* 目標 IP 位址
* 協定
* 埠號
* 資料包標頭中的其他資訊

# mangle 表

mangle 表用於修改資料包標頭。mangle 表可以修改以下標頭：

* IP 標頭
* TCP 標頭
* UDP 標頭
* ICMP 標頭

mangle 表可以用於以下目的：

設定服務品質 (QoS)
進行流量標記
修改資料包的內容

## raw 表

raw 表用於處理原始資料包。raw 表不會對資料包進行任何修改或過濾。raw 表可以用於以下目的：

* 提高效能
* 進行特殊處理

# iptables 列出規則指令

```bash
[root@www ~]# iptables [-t tables] [-L] [-nv]
選項與參數：
-t ：後面接 table ，例如 nat 或 filter ，若省略此項目，則使用預設的 filter
-L ：列出目前的 table 的規則
-n ：不進行 IP 與 HOSTNAME 的反查，顯示訊息的速度會快很多！
-v ：列出更多的資訊，包括通過該規則的封包總位元數、相關的網路介面等
```

列出預設 filter table 的規則:

```bash
iptables -L -n
```

列出 NAT table 的規則:

```bash
iptables -t nat -L -n
```

# 顯示或者持久化保存 iptables

Debian/Ubuntu: 

```bash
iptables-save > /etc/iptables/rules.v4
```

RHEL/CentOS: 

```bash
iptables-save > /etc/sysconfig/iptables
```

# 清理 iptables 自訂規則

```bash
[root@www ~]# iptables [-t tables] [-FXZ]
選項與參數：
-F ：清除所有的已訂定的規則；
-X ：殺掉所有使用者 "自訂" 的 chain (應該說的是 tables ）囉；
-Z ：將所有的 chain 的計數與流量統計都歸零
```

具體指令:

```bash
iptables -F
iptables -X
iptables -Z
```

# 設置 Policy (也就是設置 Table 上的 Chain 上的規則)

```bash
[root@www ~]# iptables [-t nat] -P [INPUT,OUTPUT,FORWARD] [ACCEPT,DROP]
選項與參數：
-P ：定義政策( Policy )
ACCEPT ：封包接受
DROP   ：封包丟棄
```

比較類似預設規則，假如設置 DROP，則會發生 "如果 INPUT 規則都不符合則 DROP"。


例如以下規則:

```bash
iptables -P INPUT   DROP
iptables -P OUTPUT  ACCEPT
iptables -P FORWARD ACCEPT
```

# 增加 iptables 規則

```bash
[root@www ~]# iptables [-AI 鏈名] [-io 網路介面] [-p 協定] \
> [-s 來源IP/網域] [-d 目標IP/網域] -j [ACCEPT|DROP|REJECT|LOG]
選項與參數：
-AI 鏈名：在某個鏈上 "插入" 或 "新增" 規則
    -A ：在鏈的末端新增規則。例如，原本有四條規則，使用 -A 就會加上第五條規則。
    -I ：在鏈的開頭或指定位置插入規則。例如，原本有四條規則，使用 -I 就會把新規則放在第一條，而原本的規則就會往後移。
    鏈 ：有 INPUT, OUTPUT, FORWARD 等，分別對應不同的封包方向，與 -io 有關，請看下面。

-io 網路介面：設定封包的進出介面
    -i ：封包的來源介面，例如 eth0, lo 等。要與 INPUT 鏈搭配使用。
    -o ：封包的目的介面，要與 OUTPUT 鏈搭配使用。

-p 協定：設定規則適用的封包類型
   常見的封包類型有： tcp, udp, icmp 及 all 。

-s 來源 IP/網域：設定封包的來源 IP 或網域，例如：
   IP  ：192.168.0.100
   網域：192.168.0.0/24 或 192.168.0.0/255.255.255.0 都可以。
   如果要設定『不允許』的來源，就加上 ! ，例如：
   -s ! 192.168.100.0/24 表示不允許 192.168.100.0/24 的封包來源。

-d 目標 IP/網域：同 -s ，只是設定封包的目的 IP 或網域。

-j ：後面接動作，常用的動作有接受(ACCEPT)、丟棄(DROP)、拒絕(REJECT)及記錄(LOG)
```

允許 localhost 進入的任何內容:

```bash
iptables -A INPUT -i lo -j ACCEPTs
```

# 允許主機主動發起的連線

如果由我們主動發起通信，由遠方回應我們時，該如何放行呢?

```bash
[root@www ~]# iptables -A INPUT [-m state] [--state 狀態]
選項與參數：
-m state ：使用狀態模組來過濾封包的連線狀態
--state 狀態：指定要過濾的封包的連線狀態，可以是以下之一：
     INVALID    ：無效的封包，例如資料破損或不符合協定的封包
     ESTABLISHED：已經建立連線的封包，例如 TCP 的三方交握後的封包
     NEW        ：新建立連線的封包，例如 TCP 的 SYN 封包
     RELATED    ：與已建立連線的封包有關的封包，例如 FTP 的資料傳輸封包

範例：允許已建立或相關的封包通過，並丟棄無效的封包
[root@www ~]# iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
[root@www ~]# iptables -A INPUT -m state --state INVALID -j DROP
```

# 鳥哥的拒絕 Ping 但允許其他 ICMP 的腳本

```bash
#!/bin/bash
icmp_type="0 3 4 11 12 14 16 18"
for typeicmp in $icmp_type
do
   iptables -A INPUT -i eth0 -p icmp --icmp-type $typeicmp -j ACCEPT
done
```

# 鳥哥的防火牆範例

```bash
#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin; export PATH

# 1. 清除規則
iptables -F
iptables -X
iptables -Z

# 2. 設定政策
iptables -P   INPUT DROP
iptables -P  OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# 3~5. 制訂各項規則
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A INPUT -i eth0 -s 192.168.1.0/24 -j ACCEPT

# 6. 寫入防火牆規則設定檔
/etc/init.d/iptables save
```

# 參考資料

[https://linux.vbird.org/linux_server/centos6/0250simple_firewall.php](https://linux.vbird.org/linux_server/centos6/0250simple_firewall.php)