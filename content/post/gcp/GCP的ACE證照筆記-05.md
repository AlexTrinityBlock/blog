---
title: "GCP的ACE證照筆記-05-Managed Services"
date: 2023-11-09T15:55:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# IAAS (Infrastructure as a Service)

供應商管理硬體，其他可以自訂。

例如 : VM。

需自己更新 OS, APP, APP runtime, Auto scaling, Availability, Load balancing。

# PAAS (Platform as a Service)

供應商管理硬體, OS, 網路, APP runtime, Load balancing, Auto scaling。

用戶寫 Code 即可。

例如 : Cloud Run, App Engine, Firebase, Cloud Functions, Cloud Build, Cloud Code。

* Varieties (變體):
    * CAAS (Container as a Service): 容器即服務。
    * FAAS (Function as a Service): 函數即服務。
    * Databases: 資料庫服務，如 Amazon RDS, Google Cloud SQL, Azure SQL Database。

* Cloud Run

    Cloud Run 是完全託管的無伺服器平台，可讓您快速輕鬆地部署和執行容器化應用程式。Cloud Run 無需管理伺服器或基礎架構，只需將您的容器映像上傳到 Cloud Run，即可立即開始使用。Cloud Run 可用於任何容器化應用程式，包括 Web 應用程式、API、批次處理工作和資料處理工作。

* App Engine

    App Engine 是託管的完整 Web 應用程式平台，可讓您快速輕鬆地部署和執行 Web 應用程式。App Engine 提供彈性的可擴充性和高可用性，可滿足各種 Web 應用程式的需求。App Engine 支援多種程式語言和框架，包括 Java、Python、Go、Node.js 和 PHP。

# Container Orchestration (容器編排)

設置各種容器的需求。

* Auto Scaling

* Service Discovery，讓微服務發現彼此

* Load Balancer

* Self Healing

* Zero Downtime Deployment

# Serverless

* 無須管理 OS。

* 部分是隨著使用才進行計費，例如有 request 才算錢，十分節省開銷。

* Serverless 的重要特色

    1. 不用擔心基礎設施，可用性與自動擴展。

    2. 沒被使用，就不會花錢。

    3. 依照呼叫的量體付費

* Google App Engine 與 AWS Fargate: 1 + 2

* Google Functions, AWS Lambda, Azure Functions: 1 + 2 + 3

