---
title: "Serverless真的省錢嗎"
date: 2023-11-14T09:08:44+08:00
draft: false
featured_image: "/code.jpg"
tags: ["daily"]
---

# 不一定! 可能更貴。

根據文章 `Scaling up the Prime Video audio/video monitoring service and reducing costs by 90%` 的研究顯示，某個影像音訊監控服務，在採用各種 AWS Lambda 函數互相交互的時候，花費了大量的資金。

[https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90](https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90)

減少成本的方法也很簡單，將微服務，或者說每個功能組件移動到同一台 EC2 虛擬機上，就可以減少大量的開銷。

## 分析

由於 AWS Lambda 這類服務，可以簡單地將程式部署，並且在呼叫時才運作。

每個 AWS Lambda 之間也都存在著通訊與啟動的開銷。

所以更好的方式如下:

* 將可以整合的組件寫進同一個 AWS Lambda，減少非必要開銷。

* 將所有組件，做成 Container 放入 EC2 這樣就僅需要支付一個 EC2 虛擬機的成本，無論進行多少存取次數。

## 真正適合 AWS Lambda 或 Cloud function 的服務

* 偶爾才被呼叫一次。

* 簡單的運算與資料存取。

## 真正適合 EC2 或 GCE 的服務

* 頻繁與長時間的運算。

* 持續產生資料或者 Log。