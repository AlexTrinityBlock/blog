---
title: "GCP的ACE證照筆記-09-Cloud function 第二代"
date: 2023-11-14T09:50:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# Cloud function

可以用在某個事件 (Event) 發生時，產生某個反應。

例如某個 error log 發生時，出現反饋。

* 這項服務是 Serverless 服務，只在運作時算錢。

* 支援語言 Node.js, Python, Go, Java, .NET, and Ruby

* 成本計算方式
    * 呼叫次數
    * 每次運算時間 (預設最多運算一分鐘，可增加至60分鐘)
    * RAM 與 CPU 消耗量

* 目前有第一代跟第二代。

# Cloud function - 概念與名詞解釋

* Event: 上傳 Object 到 Cloud Storage 的動作被稱為事件。

* Trigger: 哪個 function 在某事件觸發時被呼叫 ?

    Trigger 的 來源:

    * Cloud Storage

    * Cloud Pub/Sub

    * HTTP
    
    * Firebase

    * Cloud Firestore

    * Stack driver logging

* Function: 使用 Event 帶來的 Object 資料，做出處理運算或者其他反應。

* 自動水平擴展

* 自動關閉

**範例Cloud function**
```javascript
const escapeHtml = require('escape-html');
/**
* HTTP Cloud Function.
*
* @param {Object} req Cloud Function request context.
* More info: https://expressjs.com/en/api.html#req
* @param {Object} res Cloud Function response context.
* More info: https://expressjs.com/en/api.html#res
*/
exports.helloHttp = (req, res) => {
res.send(`Hello ${escapeHtml(req.query.name || req.body.name || 'World')}!`);
};
```

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