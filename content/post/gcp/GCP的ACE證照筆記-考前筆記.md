---
title: "GCP的ACE證照筆記-考前筆記"
date: 2023-12-26T01:00:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# GCP ACE 考前模擬題目的小筆記

以下紀錄著模擬考題裏頭的各種超綱題。

## 儲存秘密

GCP Secret Manager 與 Environment variables 的抉擇，兩個都可行，該選哪個?

GCP Secret Manager 提供版本控制和日誌記錄功能，可以很容易調查哪個 APP 進行存取，相對好點。

## GCP 的定時運作腳本

GCP Batch 可以透過定時啟動一個 Spot VM 來執行預先撰寫好的 Script。

[https://cloud.google.com/batch/docs/get-started](https://cloud.google.com/batch/docs/get-started)

## 用 GCP 管理 Active Directory

Cloud Identity 上可以創建與管理員工的帳號，並且跟 Active Directory 同步。

Google Cloud Directory Sync (GCDS) 也可以把 Google 帳戶跟 Microsoft Active Directory 或 LDAP 伺服器的資料保持同步。

順帶一提常用的 LDAP 工具是 OpenLDAP 。

## HRMS 人資管理系統

這個詞只是出現在模擬題目中，以下說明定義。

HRMS software 是 Human Resource Management Systems 的縮寫，中文意思是人力資源管理系統。它是一種軟體平台，可以整合、管理和自動化組織中的許多常規人力資源流程。它可以執行多種功能，例如組織和管理員工的詳細資料和組織資訊、提供員工自助服務、處理薪資和福利、追蹤員工的出勤、請假、績效、獎勵等，以及提供數據分析和報告等。

## 在本地模擬 GCP Cloud Datastore

Cloud Datastore 是個 NoSQL，使用 Key Value 儲存內容， Datastore Emulator 可在本地對其進行模擬。

Google 提供 Datastore Emulator，模擬遠端的 GCP 資料儲存。

[https://cloud.google.com/datastore/docs/tools/datastore-emulator](https://cloud.google.com/datastore/docs/tools/datastore-emulator)

## 可視化帳單變化

1. 把 Billing Data export 到 Big Query
2. 用 Looker Studio 來進行圖表可視化。

## 檢查誰是這個 Project 的 Owner 

一行指令檢查所有 IAM 

```
gcloud projects get iam policy
```

## 設置群組權限

IAM Group 可以一次將某個 Role 賦予到一整群用戶上。

## Active Directory Federation Service 是什麼?

是一種可以讓特定 Active Directory（AD）加入的服務。一旦任何的 AD 加入了這個同盟組織，ADFS 伺服器可以立刻的知道。ADFS 的目的是為了解決不同網域的使用者一再輸入認證資料的問題，讓使用者只需通過一次身份驗證後，就可以自由存取網路上其他網域的系統服務而不必再重複身份驗證步驟。ADFS 使用 Windows Identity Foundation（WIF）的架構來建立身分識別，並且提供了一些範本用來建置簡單的 ASP.NET STS，而開發人員可以擴充這些 STS 並且實作適合自己需求的實際 STS。

## SAML 是什麼?

什麼是安全斷言標記語言 （SAML）？

SAML 是安全性聲明標記語言 (Security Assertion Markup Language) 的縮寫，是一種用於在身分識別提供者 (IdP) 和服務提供者 (SP) 之間交換驗證和授權資料的開放標準。SAML 是一種 XML 型標記語言，用於傳遞安全性判斷提示，也就是服務提供者用來進行存取控制決策的陳述式。

SAML 的一個主要用途是實現單一登入 (SSO) 的技術，讓使用者只需一次驗證，就可以存取多個應用程式和服務。使用 SSO 時，使用者不需要向他們使用的每項服務確認他們的身分，而是透過 SAML 宣告來授予他們存取權限。

## Cassandra 資料庫

首先 GCP 的 Cloud Bigtable 與 Cassandra 相容!

Cassandra 是一種開源的分散式 NoSQL 資料庫系統，它最初由 Facebook 開發，用於儲存簡單格式的資料，例如收件箱。Cassandra 的資料模型參考了 Google 的 BigTable，採用了寬欄儲存模型 (Wide Column Stores)，可以儲存大量的非結構化或半結構化的資料，並支援動態的欄位變化。Cassandra 的分散式架構參考了 Amazon 的 Dynamo，採用了一致性雜湊 (Consistent Hashing) 的方式，將資料分散在多個節點上，並提供高可用性和高延展性的特性。

以下範例:

```
CREATE TYPE address (
  street text,
  city text,
  state text,
  zip_code int
);

CREATE TABLE user (
  id int PRIMARY KEY,
  name text,
  email text,
  home_address address,
  work_address address
);

```

一句話不準確地說，就是一個表裏頭，還可以藏著幾個表。

## GCP Deployment manager 用 YAML 部屬資源

GCP Deployment manager 是一種基於雲端的服務，可以讓您使用 YAML 檔案來宣告和自動化 Google Cloud 平台 (GCP) 的資源管理。您可以使用範本和設定檔來定義您想要部署的資源，例如 Cloud Storage, Compute Engine, 和 Cloud SQL，並讓它們協同運作。您也可以使用 Deployment manager 來更新或刪除已部署的資源。

Deployment manager 的優點是可以提供一致性、可重複性、和可維護性的部署方案，而不需要手動操作每個資源。您也可以使用 Python 或 Jinja2 來撰寫更彈性和強大的範本。

## Cloud Source Repositories

GCP 版 Github。

## GCP snapshot schedule

可以給定排程，自動 Snapshot。

## ETL transformations

將非結構化數據擷取 (extract)、轉換 (transform) 和載入 (load) ，然後放入單一資料庫。

## Cloud Dataflow

無伺服器、快速且具成本效益的整合式串流與批次資料處理服務。

可以事先寫好 "要如何處理資料" 然後，放在 Dataflow 上執行。


## Dataproc 

可執行 Apache Hadoop、Apache Spark、Apache Flink、Presto 和 30 多種開放原始碼工具和架構。

## Ops Agent

可以將 VM 裏頭的 logs 自動回傳到 Cloud logs。

以下主機自帶:

* App Engin
* App Engine flexible
* Dataflow
* Dataproc
* Google Kubernetes Engine node
* Cloud Run

## 如何擴充 GKE 主機?

新 Node pool 可以允許新的主機型號加入，選更高配置的即可。

## 如何同時查詢 Cloud Storage 與 Cloud Bigtable ?

在 Cloud Storage 跟 Cloud Bigtable 上建立 BigQuery external tables。

然後用 BigQuery join 後查詢。

## GKE IP 不夠用解法

擴展 CIDR range。

## 安裝 google-cloud-sdk-datastore-emulator

在 Ubuntu 或者 Debian 上需要用 apt-get 安裝，而非 gcloud。

## 需要一個僅能檢視資料夾階層的 Role

roles/browser role 僅能檢視 Folder，但不能檢視具體 Bucket 裏頭的內容。

## 如果要外接如微軟等第三方的 Active Directory 該怎麼做?

Cloud Identity 設置 third-party identity。

## 同時要看多個 Project 的 CPU 用量該怎麼做?

可以將數個 Project 放入同個 Workspaces。

來監看 CPU, memory, and disk。

## 如果一個 Project 裏頭有多個執行的網站，如何檢查單一個網站花掉的 egress 網關花費

首先，Billing Alert 只能用在單一的一個 Project 的花費總和。

這時候只能把 billing data export 到 BigQuery 進行分析，然後寫個 Cloud function 來寄信通知費用超標。

## 自動配置 GKE 指定資源，並且自動調度如 GPU, CPU 等

GKE 有個 node auto-provisioning 功能，可以用 yaml 定義單個 Node 最大最小的 CPU, RAM, GPU。

並且可以自動擴展，或者收縮，根據使用量。

## 對於已經自帶 HTTPS 的應用程式進行 Reverse Proxy 轉發

由於應用程式已經自帶 HTTPS 了，這個時候進行 SSL Proxy Load Balancer。

## BigQuery 的定價方式

* 儲存定價: 存多少資料算錢。
* 分析定價: 以讀取的資料量作為結果(?)

## 將公鑰加入自己的 GCP 帳戶

用以下指令添加公鑰到 GCP 帳戶，就可以順利的登入 VM 了。 只要同時有 IAM 權限。

[](https://cloud.google.com/compute/docs/connect/add-ssh-keys)

```
gcloud compute os-login
```

## 將同個組織下的 Project 統一管帳

建立一個 billing account，所有的 Project 連結到那個 Billing account。

## Cloud SQL 的 binary logging

Cloud SQL (MySQL) with the enable binary logging 是一種在Cloud SQL上啟用二進制日誌（binary log）的功能。二進制日誌是一種記錄MySQL數據庫中所有更改的文件，可以用於數據恢復和複製。啟用二進制日誌可以讓您創建Cloud SQL的讀取副本（read replica），以分擔主實例（primary instance）的讀取負載或分析流量。啟用二進制日誌也可以讓您使用Cloud SQL Proxy來連接Cloud SQL，以提高安全性和可靠性。

## 讓 App Engine 快速響應的方法

設置 min_idle_instances。

保留固定數量空閒的 VM ，可以即時應付巔峰流量。

## Cloud Storage 的計時刪除

這種稱為 lifecycle management。

如果要 90 天移動到 Coldline ，365天刪除，就直接設置即可。

別試圖用 365 - 90 = 275 ，來設置刪除時間，這樣會導致提早刪除。

## 合適的儲存時序資料

用 Bigtable 

## 如何檢查哪個用戶讀寫過 Bucket 

GCP Audit log 可以看到。

## 跨地區連通 VPC 內網

1. 建立一個新的VPC
2. 分別把兩個Sub-net 建立在不同區域

## 如何改 App Engine 的地理位置

首先一個專案只能有一個 App Engine。

設置後無法修改位置，只能刪除專案，重新建立一個不同位置的新專案。

## 將 projects 移動到不同 organization 

這是可以的。

是為了公司併購而考量的。

## 觀察啟動失敗的 Pod

```
kubectl describe pod <pod-name>
```

## moderately-severe bug 

在軟體開發中，moderately-severe bug 是指會導致一些功能缺失或效能下降的錯誤。 這種錯誤不會導致系統崩潰或資料遺失，但會影響使用者的正常使用。

## 跨 Project 對接 VPC

不同組織  => 對接時只能用 VPC Network Peering 來實現。

同組織下 => 可以用 Share VPC 來實現。

## 便宜划算的 Redis

Memorystore 提供根據使用容量的 Cache 服務，相對運作一個 VM ，有時候更便宜。


## 連續讀寫熱點

如果 Cloud Spanner 的 Primary Key 是連續的話，很容易造成某個區域被頻繁讀寫，性能下降。

不同於 MySQL 資料庫，Cloud Spanner 的 Primary Key 用 UUID 效率更高。

使用單調遞增的整數作為主鍵（primary keys）的缺點不只存在於 Google Cloud Spanner，也存在於其他的分散式資料庫系統（distributed database systems），例如 Cassandra、HBase、MongoDB 等。這是因為這種主鍵設計會導致資料的熱點（hotspots），也就是資料的分片（shards）或節點（nodes）不均勻，造成某些分片或節點承受過多的讀寫負載，而影響資料庫的效能和可用性。

為了避免熱點的產生，建議使用隨機或散列（hash）的主鍵，或者在主鍵中加入一些隨機或散列的元素，以使資料分佈更加均勻。例如，您可以使用 UUID（Universally Unique Identifier，通用唯一識別碼）作為主鍵，或者在主鍵中加入一個隨機的字首或尾碼。

##  Avro 檔案

由 Apache Avro 開發的資料序列化格式，常用於 Apache Hadoop 等大數據處理系統中。它可以將資料以一種緊湊的二進位格式儲存和傳輸，並且在 JSON 格式中定義資料的結構和類型。

## Cloud VPN 與混和雲

Cloud VPN 適合用在將本地端跟遠端 VPC 整合。

* HA VPN: 2 external IP， BGP 路由。
* Classic VPN: 1 external IP，靜態路由與BGP 路由。

## Cloud Interconnect 物理上的快速聯網

相對 VPN 定價高很多，但也快。

* Dedicated Interconnect - 10 Gbps or 100 Gpbs configurations

* Partner Interconnect - 50 Mbps to 10 Gbps configurations

## Cloud Monitoring 監控雲端基礎設施

* visualizations: 可以產生圖表與主控台
* Configure Alerts: 自訂條件跳出警告

Default metrics monitored 涵蓋以下內容:
* CPU utilization
* disk traffic metrics
* Network traffic
* Uptime information

## Cloud Monitoring - Workspace 跨 Project 監控

先在一個 Project 建立 Workspace，然後可以將另外一個 Project 加入。

## Cloud Logging

可以搜尋與儲存，分析 Logs，Serverless。

有以下功能:

* Logs Explorer - Search, sort & analyze using flexible queries
* Logs Dashboard - Rich visualization
* Logs Metrics - Capture metrics from logs (using queries/matching strings)
* Logs Router - Route different log entries to different destinations

## 會自動保存 Cloud Logging 的服務

* GKE
* App Engine
* Cloud Run

## 如何取得 GCE VM 的 Log ?

安裝 Logging Agent 。

## 本地主機如何接到 Cloud Loggin

用 BindPlane tool ，加上 Cloud Logging API。

## 稽核與安全用的 Logs

* Access Transparency Log: 資料開給 Google 內部人員存取時， Google 人員的存取紀錄。 需要 Gold support level 才又。

Cloud Audit Logs (誰?在哪?存取了啥?): 

* Admin activity Logs: API 呼叫或修改資源配置或元資料的其他操作，使用者何時建立 VM 實例或變更身分和存取管理權限。始終寫入管理活動審核日誌；您無法配置、排除或停用它們。即使您停用 Cloud Logging API，仍會產生管理活動審核日誌 (預設啟用)。
* Data Access Logs: 資料存取 (不會預設啟用)。
* System Event Audit Logs: 系統事件(預設啟用)。 
* Policy Denied Audit Logs: 當 Google Cloud 服務因違反安全政策而拒絕存取使用者或服務帳號時，會記錄政策拒絕審核日誌 (預設啟用)。

## Logs 到哪去了?

Cloud Logg ->  Log Router -> 強制啟用的 Log 進入 Required Logs buckets(Admin activity, System Events & Access Transparency) 保留 400 天 / 非強制啟用的進入 Default Logs buckets 自動保留 30 天

* 需要替 Default Logs buckets 付錢，而且無法刪除。

* 不用替 Required Logs buckets 同時也不用付錢，也無法刪除。

同時，也可以自己把 Logs 放入:

* Cloud Storage
* BigQuery
* Pub/Sub

這需要手動在 Log Router 設置，這個動作稱為 export sinks。

也可以用 Google Look Studio 來視覺化。

## 如何追蹤各種服務的運作時間 ? Cloud Trace

可以查看:
* Compute Engine
* GKE
* App Engine
的消耗時間。

可以調用以下語言的函數庫來追蹤耗時: C#, Go, Java, Node.js, PHP, Python & Ruby。

可以看到單次消耗的時間，平均耗時，與耗時趨勢。

## 效能瓶頸檢查工具 Cloud Profiler

可以追蹤某段時間內的 CPU 與 RAM 用量，找到效能瓶頸。

* Profiling agent: 蒐集效能瓶頸訊息。
* Profiler interface: 視覺化。
* 支援 Go, Java, Node.js, Python
* 支援 GCE, GKE, App Engine, 甚至本地端主機

可以整合到雲端運作的各種語言程式碼中，例如: 可以看到 go 語言中，哪個函數跑得比較慢。

## 及時發現運作程式中的錯誤 Error Reporting

* 支持 Go, Java, .NET, Node.js, PHP, Python, and Ruby。

* 集中檢查崩潰訊息

* 可以寄到 Cloud Logging 或者 Reporting API

* 即時監測，當機，錯誤等等。

支持:
* Compute Engine
* App Engine
* Kubernetes Engine
* Cloud Functions
* Cloud Run

## 組織結構

Organization > Folder > Project > Resources

* projects: 區分環境

* folders: 區分部門

## 帳單帳號 Billing Accounts

任何 Project 都強制綁定帳單帳號。

帳單帳號可以綁定多 Project。

一個 Organization 可以有多個 billing accounts。

## 設置 Cloud Billing Budget 防止價格超過預期

Cloud Billing Budget 設置 Configure Alerts，還有到達 thresholds 前的 Alerts 與  Email。

* Billing admins 與 Billing Account users 會在 Email 收到警告。

## 將帳單匯出用來分析

帳單可以匯出到:

* Big Query
* Cloud Storage (一般用於存檔)

## 定期檢查

常常看 Cloud Audit Logs ，看看 IAM 變化與 Service Account keys 的存取。

## 盡量用  IAM Groups

省時省力。

## 最小權限原則

## 關鍵的事情最好將權限切割給至少兩個人

## 聯邦式(Federate)權限控管

Cloud Identity 與 Google Workspace 可以把登入的動作移交給企業所有的認證伺服器，這稱為 external identity provider (IdP) 外部認證提供者。

例如:  Active Directory or Azure Active Directory, LDAP 等。

## 允許 Single Sign On

Single Sign On 是單點登入的意思，可以用企業的帳號密碼或者認證，直接登入 Google Workspace。

當使用者被授權，SAML assertion 會傳送到 Google Sign-In。

企業的  Active Directory 伺服器可以透過 Cloud Identity by using Google Cloud Directory Sync (GCDS) and Active Directory Federation Services (AD FS) 來聯合認證。

## IAM 中的角色

* Google Account (個人Email)
* Service account (應用程式的帳號，也可附加到某個使用者的個人Email上)
* Google group: 有個獨立的電子郵件。
* Google & Service Accounts 的集合
* Google Workspace domain: 企業用  Gmail, Calendar, Meet, Chat, Drive, Docs 的集合。
* Cloud Identity domain: 一個認證服務，Identity as a Service (IDaaS) 。

## Organization 中的最高管理員

Organization Administrator

## 財務小組需要的 Role

* Billing Account Creator: 建立新的 billing accounts。
* Billing Account Administrator: 管理 billing accounts。

## 財務稽查員

* Billing Account Viewer

## 如何 SSH 到 Linux VM

要 SSH 到 Compute Engine Linux VMs 有兩種方法:

1. 手動在 Metadata 裏頭放入使用者 SSH Public Key。

2. 此種方法 Linux 使用者綁定 Google identity。首先設置 metadata 中的 enable-oslogin 為 true。然後使用者擁有這個 Role 就可以登入了，roles/compute.osLogin 或者 roles/compute.osAdminLogin。

上述完成後，可以直接用

```
gcloud compute ssh
```

以上指令連入 VM 。

或在有權限的情況下加入自己的 Key。

```
gcloud compute os-login ssh-keys add
```

## Windows VM 登入

在 console 或者命令行產生帳號密碼。

```
gcloud compute reset-windows-password
```

## YAML 定義 GCP 服務

Google Cloud Deployment Manager 可以用  YAML 來調整服務配置。

非常建議用這個來管理一切資源。

類似 K8S 的 Deployment.yaml。

## Cloud Marketplace

提供很多付費或者免費的其他人提供的軟體 Stack。

如 LAMP, Jenkins ... 等都有。

Datasets, Developer tools, OS ... 等都有。

## Cloud DNS

租網址，Email轉址 ... 等。

Public/private DNS。

甚至可以在 VPC 裏頭建立 Internal DNS。

## Cloud Dataflow

可以對於流動資料進行處理，支持多個語言(Java, Python, Go ...)，使用 Apache Beam 。

Serverless 服務。

## Cloud Dataproc

GCP 託管的分散式運算平台，內含:

* Spark
* PySpark
* SparkR
* Hive
* SparkSQL
* Pig
* Hadoop

有分為 Single Node / Standard/ High Availability (3 masters)

可以用 regular/preemptible VMs。