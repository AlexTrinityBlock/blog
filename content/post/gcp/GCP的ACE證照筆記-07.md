---
title: "GCP的ACE證照筆記-07-Google Kubernetes Engine"
date: 2023-11-11T11:20:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# GKE 簡述

Google 提供的 K8S 服務。

跟典型的 K8S 服務一樣有以下特色:

* Auto Scaling

* Service Discovery

* Load Balancer

* Self-Healing

* Zero Downtime Deployment

* Auto-repair

* Pod and Cluster Autoscaling

* 可用 Cloud Logging 與 Cloud Monitoring 監控

* 由 Google 提供的 Container-Optimized OS

* 提供 Persistent disks 與  Local SSD。

# 啟動一個 GKE

### 1.啟動一個 default node pool

```bash
gcloud container clusters create
```