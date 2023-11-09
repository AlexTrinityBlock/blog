---
title: "GCP的ACE證照筆記-04-Cloud Load Balancing"
date: 2022-11-09T09:00:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# Cloud Load Balancing

負載平衡，可以單 region 或者 multiple regions。

增加服務的 Resiliency (彈性)，Auto Scaling，High Availability。

**重要的服務:**

* Health check

* Auto Scaling

* Global load balancing with single anycast IP，anycast IP 指一個  IP 指向多個裝置，流量會自動導向最近的裝置。

# 網路分層

談及 high performance (高效能) 時，很多時候關連到 Transport Layer。

* Application Layer (Layer7): HTTP, HTTPS, SMTP, FTP。

* Transport Layer (Layer4): TCP, TLS, UDP。

* Network Layer (Layer3): IP，傳遞 bits or bytes。

# Terminology (術語)

* Backend，如在 Cloud Load Balancing 後方接收流量的 VM 或者 K8S 群集。

* Frontend，特定的 IP, Port, Protocol 用於接收客戶請求。

* Host and path rules，定義的規則，將請求轉送到不同後端，可以基於網址的路徑如:`example.com/api` 或 `example.com/web`，基於主機網址: `.a.example.com` 或 `b.example.com`，或者基於 HTTP headers: GET, POST 導向不同後端服務。

# SSL/TLS Termination/Offffloading

* Load Balancer 到 VM instance 透過 Google ，這種情況下  HTTP 也是安全的，但仍建議 HTTPS。

# 如何選擇 Load Balancing 示意圖

[https://cloud.google.com/load-balancing/images/choose-lb.svg](https://cloud.google.com/load-balancing/images/choose-lb.svg)

# Features

## 採用 Proxy

採用 80, 8080, 443 port。

* External HTTP(S) : Global, External, HTTP or HTTPS。

* Internal HTTP(S) : Regional, Internal, HTTP or HTTPS。

TCP 的常用服務  port。

* SSL Proxy: Global, External, TCP with SSL offload。

* TCP Proxy: Global, External, TCP without SSL offload。

## 採用 Pass-through

任意 port。

* External Network TCP/UDP: Regional, External, TCP or UDP。

* Internal TCP/UDP: Regional, Internal, TCP or UDP。

# 情境問答

```
Q: 希望健康的 instances 接收流量。
A: health check。

Q: 希望高可用性。
A: Multiple MIGs 在 multiple regions。

Q: 希望路由一些不同 requests 到多個 microservices，用同一個 load balancer。
A: 建立每個 microservice 於獨立的MIG，建立 Host and path rules 將流量導向不同 microservice 。

Q: 你想要 load balance Global external HTTPS 導向不同 backend，並跨越多個 regions。
A: 採用 Choose External HTTP(S) Load Balancer。

Q: 你想加上 SSL termination 到非 HTTPS 服務上。
A: 採用 SSL Proxy Load Balancer。
```