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

允許 localhost 進入的任何內容:

```bash
iptables -A INPUT -i lo -j ACCEPTs
```

# 參考資料

[https://linux.vbird.org/linux_server/centos6/0250simple_firewall.php](https://linux.vbird.org/linux_server/centos6/0250simple_firewall.php)