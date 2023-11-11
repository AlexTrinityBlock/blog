---
title: "GCP的ACE證照筆記-06-App Engine"
date: 2023-11-11T00:20:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# App Engine

一個可以簡單部屬可以自動縮放的應用程式。

* 預設運作環境: Go, Java, .NET, Node.js, PHP, Python, Ruby ，這些語言都有提供運作環境。

* 客製化作環境: 可採用任何語言。

* App Engine 是 Regional，可以橫跨數個 Zone，但不能改 Region。

* 採用結合 resident instances (常駐型實例) 與 dynamic instances (動態實例)

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

* 需要預先在 default 建立一個 service 才可建立其他的。

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

**部署新版本，但仍將流量導入舊版本**
```bash
gcloud app deploy --no-promote
```

**分割不同流量到不同版本APP進行測試**

以下例子為，版本號3分配50%，版本號2分配50%。

但是每個IP該服務會盡量提供同一個版本的 App 提供存取。

```bash
gcloud app services set-traffic splits=v3=.5,v2=.5
```

若要隨機切換新舊版本，可以採用以下指令。

```bash
gcloud app services set-traffic splits=v3=.5,v2=.5 --splitby=random
```

也可以用 Cookie 來進行切換

```bash
gcloud app services set-traffic splits=v3=.5,v2=.5 --splitby=cookie
```

**部署Docker image**

假定我們做了一個Image上傳到 GCP 的 gcr.ip，名為 `hello-world-rest-api:0.0.1.RELEASE` 我們就可以採用以下方式使用  App Engine 執行。

(對自訂容器會持續扣錢，無法再不使用時，完全關閉)

```bash
gcloud app deploy --image-url gcr.io/PROJECT-ID/hello-world-rest-api:0.0.1.RELEASE
```

### 三種流量拆分方式

* random

* cookie

* IP

# 問答-關於 Gcloud 操作 APP engine

```
Q: 如果我要直接將 APP 版本更新，我該如何做
A: 直接輸入 gcloud app deploy

Q: 如果我希望測試完善後，再從v1遷移到v2，目前暫不遷移，我該怎麼做?
A: gcloud app deploy --no-promote

Q: 如果接著要手動v1遷移到v2，該怎麼做?
A: gcloud app services set-traffic s1 --splits V2=1

Q: 如何將部分用戶遷移?
A: gcloud app services set-traffic splits=v3=.5,v2=.5

Q: 如何 gradually migration 漸進式遷移到 v2
A: 加上 --migrate
```

# Playing with App Engine

**取得某個服務某版本的網址**

這裡取得 myService 的版本 v1 網址。

```bash
gcloud app browse --service="myService" --version="v1"
```

**取得某個服務控制台視窗**

```bash
gcloud app open-console --service="myService" --version="v1"
```

**取得某個服務控制台log**

```bash
gcloud app open-console --logs
```

**命令行上追蹤某個APP Log**

```bash
gcloud app logs tail
```

# App Engine 背後的 Instances

**列出存在的Instances**

```bash
gcloud app instances list
```

**SSH到特定 Instance**

注意，標準的 Standard 更省錢，但不提供 SSH 功能。

```bash
gcloud app instances ssh <實例ID> --service=default --version=v1
```

# App Engine 的 Service

**列出Service**

```bash
gcloud app services list
```

**描述Service**

```bash
gcloud app services describe <Service名稱>
```

# App Engine 的 Version

**列出版本**
```bash
gcloud app version list
```

**啟動與關閉版本**
```bash
gcloud app versions start/stop v1
```

# App Engine 的 Cron Job 定時任務

可以每隔一段時間呼叫某個API。

可以用於自動呼叫某API，寄送郵件。

建議用 HTTP GET 的 API 。

**cron.yaml**

```yaml
cron:
- description: "daily summary job"
url: /tasks/summary
schedule: every 24 hours
```

呼叫方式

```
gcloud app deploy cron.yaml
```

# 分派不同路徑到不同 Service

這個記得同時修改微服務本身代碼，如 Flask 的路徑，才可完成路由。

**dispatch.yaml**

```yaml
dispatch:
- url: "*/mobile/*"
service: mobile-frontend
- url: "*/work/*"
service: static-backend
```

# 建立Queue任務

**queue.yaml**

```yaml
queue:
- name: fooqueue
rate: 1/s
retry_parameters:
task_retry_limit: 7
task_age_limit: 2d
```

# 問答-一般問題

```
Q: 我希望在同 project 建立兩個 APP。
A: 不行，但可以建立多個 Service。

Q: 我希望建立兩個 Service，在同個 APP 裡頭。
A: 可以。

Q: 我希望跨越幾個洲建立同個 APP。
A: 不能，Region 一開始就選好了。你只能在不同洲建立不同 project 。

Q: 希望做一個測試版本跟正式版本 APP。
A: gcloud app deploy --nopromote ，然後測試完畢後，再緩緩上線。
```

