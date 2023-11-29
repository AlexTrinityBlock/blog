---
title: "GCP的ACE證照筆記-10-Cloud Run"
date: 2023-11-29T16:40:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---
# Cloud Run

* 基於 Knative，一種自動管理 K8S 的工具，幾乎可以做到全自動擴展。

* 不須維護基礎設施。

* 使用時才付費。

# Cloud Run for Anthos

* Cloud Run 是在數秒之內運作一個容器帶來服務。

* 整合以下服務
    * Cloud Code
    * Cloud Build
    * Cloud Monitoring
    * Cloud Logging

* GCP Anthos: 一個可以建立 K8S 於 GCP, 本地與混和雲的一個服務。

* Cloud Run for Anthos: 把 Cloud Run 部署在本地或者 Google Cloud 上。可以用已經存在的 K8S 運作 Cloud Run。

# Gcloud 與  Cloud Run

Docker Image 部署到 Cloud Run

```bash
gcloud run deploy SERVICE_NAME --image IMAGE_URL --revision-suffix v1
```

列出可用版本

```bash
gcloud run revisions list
```

不同版本分流。

```bash
gcloud run services update-traffic myservice --to-revisions=v2=10,v1=90
```

