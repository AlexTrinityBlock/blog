---
title: "Linux網路基本指令1"
date: 2024-02-08T22:00:44+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","apt"]
---

# ip 類網路指令

以下指令僅在重新啟動前生效，如果要長期保存，需要根據各 Linux 發行版不同實踐調整設定檔案。

```bash
# 列出介面
ip link

# 查詢個別網卡的資訊
ip addr show eth0
ip addr list eth0
ip addr show dev eth0

# 給網卡定義 IP 地址
sudo ip addr add 10.20.0.15/24 dev eth1

# 啟動網卡
sudo ip link set dev eth1 up

# 停用網卡
sudo ip link set dev eth1 down

# 顯示 Routing Table
ip route
ip route show
ip route list

# add 新增 / del 刪除 / src 來源IP(本機IP) / via 透過...(網關或路由器) / dev 經由哪個網卡
ip route add 1.1.1.0/24 src 3.3.3.3 via 3.3.3.254 dev eth1
```

# IP 轉發指令

持久設置 IP 轉發:

```bash
# 關閉 IP 轉發
echo 0 > /proc/sys/net/ipv4/ip_forward

# 開啟 IP 轉發
echo 1 > /proc/sys/net/ipv4/ip_forward
```

IP 轉發的用途是把 Linux 作為一個類似 Router 的角色，可以做到從 eth0 收到封包，轉送到 eth1。

預設是關閉的，因為假定 eth0 是內部網路， eth1 是外部網路 ， 預設避免互通轉送可以確保一定的安全性。

# DNS 有關

本機 DNS 解析路徑:

```
/etc/hosts
```

外部 DNS 主機紀錄:

```
/etc/resolv.conf 
```

# 從 URL 找到對應 IP 與 DNS 供應商

```bash
nslookup www.google.com
dig www.google.com
```

# 一個容易配置的 DNS Server - CoreDNS

可以用二進制檔案，或者是容器啟動。

啟動後會 Listen Port 53 。

如果將 DNS 配置清單設置為 /etc/host ， 就可以對於寫在該配置檔案中的 DNS 查詢進行回應。

[https://coredns.io/](https://coredns.io/)