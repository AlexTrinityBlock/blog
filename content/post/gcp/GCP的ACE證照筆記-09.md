---
title: "GCP的ACE證照筆記-09-Cloud function 第二代 (2nd gen)"
date: 2023-11-14T11:20:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# Cloud function - 2nd gen

* 更長的執行時間 60 分鐘。

* 更大的 VM Size，16 GB RAM，4 vCPU。

* Concurrency: 1 個 function 接受同時 1000 個併發。第一代，1 次接受 1 個併發。

* Multiple Function Revisions (多版本)，