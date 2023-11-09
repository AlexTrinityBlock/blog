---
title: "GCP的ACE證照筆記-06-App Engine"
date: 2023-11-09T16:20:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# App Engine

一個可以簡單部屬可以自動縮放的應用程式。

* 預設運作環境: Go, Java, .NET, Node.js, PHP, Python, Ruby ，這些語言都有提供運作環境。

* 客製化作環境: 可採用任何語言。

* 一個 Project 只能有一個 APP Engine，但可以建立多個 Service 彌補。

* 可以連接 Google Cloud 資料庫與檔案儲存服務，如 Cloud SQL。

* 僅需要為使用的資源付費，但有可能容器持續運作，被持續扣錢。

* 全自動高可用性服務:
    * Automatic load balancing
    * Auto scaling
    * Application versioning (自動版控)
    * Traffic splitting 自動分流

* PaaS 平台即服務

* Serverless

* Lower Flexbility

(p.94)

# App Engine environments

* Standard

    APP 運作在特定語言的 sandboxes 裏頭。

    完全隔離的 OS/Disk/Other Apps。

    * V1: Java, Python, PHP, Go (舊版本)

    * V2: Java, Python, PHP, Node.js, Ruby, Go (新版本)

* Flexible

    APP 運作在使用者自訂的 Docker containers ，支持任意 runtime 。

    可以存取 containers 的背景 processes 與 local disks。

# Application Component Hierarchy (應用程式部件階層)

* Application: 每個 Project 一個 App。

* Service: Application 下有多個 Services ，每個 Service 也可以視為 microservice 。

* Versions: 可以建立多個版本的 code 跟 config。

# Comparison (比較)

* Standard

    * Pricing Factors(費率計算): Instance hours 運作的時間。

    * Scaling: Manual(手動), Basic(基本), Automatic, 自動擴展。

    * Scaling to zero: Yes，也就是沒有被呼叫，有可能不用錢。

    * startup time (啟動時間): 以秒來算。

    * Rapid Scaling (快速擴展): 可以。

    * Max request timeout: 1 ~ 10 分鐘。

    * Local disk: 除了 Python 與 PHP 都可以，並且要寫到 /tmp。

    * SSH: 無法。

* Flexible

    * Pricing Factors(費率計算): vCPU, Memory, Persistent Disks。

    * Scaling: Manual(手動), Automatic。

    * Scaling to zero: No，任何時刻都需要消耗某些成本，就算沒有用戶呼叫。

    * startup time (啟動時間): 以分鐘來算。

    * Rapid Scaling (快速擴展): 無法。

    * Max request timeout: 60 分鐘。

    * Local disk: Yes，但是暫時的，每次啟動都會刷新硬碟內容。

    * SSH: 可以。

# Scaling Instances

* Automatic: 根據運作負荷，自動擴展。推薦用於長期持續工作負載。

    * Target CPU Utilization (CPU 應用率)

    * Target Throughput Utilizatio (吞吐量)

    * Max Concurrent Requests (最大併發請求數)

    * Max Instances and Min Instances (最大和最小的 Instances 數量)

* Basic: 當 requests 被接收時 Instances 被啟動，推薦用於 Adhoc (短期臨時) 工作負載。

    * 當沒有人發送 requests 時，可以維持低成本，但延遲較高。

    * 不支持 App Engine Flexible。

    * 可以設置 Configure Max Instances 與 Idle Timeout。

* Manual: 手動設置特定數量的 instances 持續運作。

# 啟動一個 APP Engine

這個 APP Engine 是個基於 Flask 的APP

**app.yaml**
```yaml
runtime: python39
service: my-first-service
```

**main.py**
```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'My Default Service - V1'
```

**requirements.txt**
```
Flask==3.0.0
```

將上述檔案放到一個資料夾中後，並且啟動專案中的 APP Engine 的權限後，輸入以下指令:

```bash
cd <資料夾>
gcloud config set project <專案ID>
gcloud app deploy
```

#  APP Engine 實用技能

**列出services**
```bash
gcloud app services list
```

**列出可用regions**
```bash
gcloud app regions list
```

**列出版本**
```bash
gcloud app versions list
```

**列出執行實體**
```bash
gcloud app instances list
```

**刪除實體**
```bash
 gcloud app instances delete <實體ID> --version=<實體版本> --service=default
```

**刪除服務**
```bash
gcloud app services delete <服務名稱>
```

**瀏覽器開啟特定版本APP**
```bash
gcloud app deploy --version=<版本號>
```

**啟動APP的網頁Console介面**
```bash
gcloud app open-console --version=<版本號>
```

**分割不同流量到不同版本APP進行測試**

以下例子為，版本號3分配50%，版本號2分配50%。

```bash
gcloud app services set-traffic splits=v3=.5,v2=.5
```