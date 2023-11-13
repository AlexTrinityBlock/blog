---
title: "GCP的ACE證照筆記-07-Google Kubernetes Engine"
date: 2023-11-11T11:20:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# GKE 簡述

(p.111)

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

建立一個名為 `my-cluster` 的 Cluster，位置在 `us-central1-a ` 。

由於一般用戶SSD硬碟大小未申請僅有 250 GB ，但 GKE 預設需求 300 GB。要解決可以設置硬碟為`pd-ssd`，大小為80 GB 預設 3 個節點，這樣就只會消耗 240 GB 硬碟空間。

```bash
gcloud container clusters create my-cluster --zone  us-central1-a --disk-size 80 --disk-type pd-ssd 
```

刪除時採用以下指令

```bash
gcloud container clusters delete create my-cluster --zone  us-central1-a 
```

### 2.連入 Cluster

首先取得 credentials 可以視為取得操作 K8S 的憑證。

這之後就能用 kubectl 設定  Cluster 了。

```bash
gcloud container clusters get-credentials my-cluster --zone  us-central1-a 
```

### 3.建立一個服務

建立一個服務

```bash
kubectl create deployment hello-world-rest-api --image=in28min/hello-world-rest-api:0.0.1.RELEASE
```

將服務暴露在 8080 port

```bash
kubectl expose deployment hello-world-rest-api --type=LoadBalancer --port=8080
```

接著可以在 GKE 的 Services & Ingress 查看具體暴露在哪個 IP/port。

### 4.建立多個容器複製

首先，這是在所有 Node 主機，上增加多個 pod。但  Node 主機不會增加。

首先查看 GKE 的 Workloads，可以發現 pod 預設只有一個。

```bash
kubectl scale deployment hello-world-rest-api --replicas=2
```

接著發現變成兩個。

### 5.修改 Node 數量

可以視為開啟更多 VM，增加可以服務的主機。

不過首先要檢查 Node pool 名稱，可以在 Cluster，點進  Nodes 查看。

```bash
gcloud container clusters resize my-cluster --node-pool default-pool --num-nodes 1 --zone  us-central1-a 
```

### 6.設置 microservice 容器 auto scaling 

當 CPU 單核運作到 70% 時自動擴展新容器，最大容器數量設置為10。

```bash
kubectl autoscale deployment hello-world-rest-api --max=10 --cpu-percent=70
```

### 7.設置 cluster 主機 auto scaling 

設置最少主機數跟最大主機數。

```bash
gcloud container clusters update my-cluster --enable-autoscaling --min-nodes=1 --max-nodes=2 --zone  us-central1-a 
```
### 8.對微服務設置 application configuration

Config Map 可以將環境變數傳入容器中，在手動設置後。

下方的範例中 `RDS_DB_NAME:todos` 這個 Key Value 被傳入容器。

```bash
kubectl create configmap todo-web-application-config --from-literal=RDS_DB_NAME=todos
```

接著進行檢查

```bash
kubectl get configmap todo-web-application-config
```

檢查 configmap 細節。

```bash
kubectl describe configmap todo-web-application-config
```

結果如下:

```
q123717111@cloudshell:~ (idyllic-kiln-405005)$ kubectl describe configmap todo-web-application-config
Name:         todo-web-application-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
RDS_DB_NAME:
----
todos

BinaryData
====

Events:  <none>
```

可以看到 configmap 已經被建立。

### 9.對微服務設置 Secret 來存放敏感資料

Secret 可以存放容器需要的敏感資料，如資料庫密碼。

下方的範例中 `RDS_PASSWORD:dummytodos` 這個 Key Value 被傳入容器。

```bash
kubectl create secret generic todo-web-application-secrets-1 --from-literal=RDS_PASSWORD=dummytodos
```

檢查是否成功創建

```bash
kubectl get secret todo-web-application-secrets-1
```

檢查 secret 細節。

```bash
kubectl describe secret todo-web-application-secrets-1
```

結果如下，不會直接在畫面上顯示

```
q123717111@cloudshell:~ (idyllic-kiln-405005)$ kubectl describe secret todo-web-application-secrets-1
Name:         todo-web-application-secrets-1
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
RDS_PASSWORD:  10 bytes
```

### 10.檢查當前有哪些 Deployment

檢查當前有哪些 Deployment，也就是當前有哪些容器。

```bash
kubectl get deployment
```

### 11.檢查當前有哪些 Service

容器 pod 也是種服務，而暴露 IP/Port 的 LoadBalancer 也是種服務。

```bash
kubectl get services
```

此案例中，輸入上述指令得到的結果如下。

```
q123717111@cloudshell:~ (idyllic-kiln-405005)$ kubectl get services
NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
hello-world-rest-api   LoadBalancer   10.104.1.45   34.67.8.30    8080:32183/TCP   23m
kubernetes             ClusterIP      10.104.0.1    <none>        443/TCP          25m
```

### 12. 取得 Cluster 發生的事件

```bash
kubectl get events
```

結果如下

```
q123717111@cloudshell:~ (idyllic-kiln-405005)$ kubectl get events
LAST SEEN   TYPE      REASON                                   OBJECT                                           MESSAGE
43m         Normal    Starting                                 node/gke-my-cluster-default-pool-1e13b58c-8rlc   Starting kubelet.
...
19m         Normal    UpdatedLoadBalancer                      service/hello-world-rest-api                     Updated load balancer with new hosts
```

### 13. Service 跟 Ingress 的差別

Service 是一連串 pods 與 Load blancer ，而 Ingress 是外部 HTTP(S) 路由規則的集合。

```
Services are sets of Pods with a network endpoint that can be used for discovery and load balancing. Ingresses are collections of rules for routing external HTTP(S) traffic to Services.
```

也可以創造很多 Service 下，用一個 Ingress 提供一個統一的轉送網址。


### 14. 檢查當前有哪些 Pods

檢查當前有哪些 Pods

```bash
kubectl get pods
```

```
q123717111@cloudshell:~ (idyllic-kiln-405005)$ kubectl get pods
NAME                                    READY   STATUS    RESTARTS   AGE
hello-world-rest-api-5b78b5c566-8mvtt   1/1     Running   0          2m29s
hello-world-rest-api-5b78b5c566-9t92s   1/1     Running   0          2m25s
hello-world-rest-api-5b78b5c566-hs57f   1/1     Running   0          35m
hello-world-rest-api-5b78b5c566-ksgb9   1/1     Running   0          2m25s
hello-world-rest-api-5b78b5c566-r8sjv   1/1     Running   0          2m25s
```

### 15. 手動呼叫自己撰寫的 deployment.yaml

撰寫設置 pod 的 deployment

**deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    labels:
        app: hello-world-rest-api
    name: hello-world-rest-api
    namespace: default
spec:
    replicas: 3
    selector:
        matchLabels:
            app: hello-world-rest-api
    template:
        metadata:
            labels:
                app: hello-world-rest-api
        spec:
            containers:
            - image: in28min/hello-world-rest-api:0.0.3.RELEASE
                name: hello-world-rest-api
```

撰寫設置 Service 開放 port 的 yaml。

**serivce.yaml**

```yaml
apiVersion: v1
kind: Service
metadata:
    labels:
        app: hello-world-rest-api
    name: hello-world-rest-api
    namespace: default
spec:
    ports:
    - port: 8080
        protocol: TCP
        targetPort: 8080
    selector:
        app: hello-world-rest-api
    sessionAffinity: None
    type: LoadBalancer
```

呼叫剛剛寫的 yaml

```bash
kubectl apply -f deployment.yaml
kubectl apply -f serivce.yaml
```

# GKE 概念 - Cluster

* Cluster 許多的VM 組成
    * Master Node: 管理整個 Cluster。
    * Worker Node: 運作  Workload。

* Master Node
    * API Server: 管理整個 K8S 的通訊。
    * Scheduler: 份配 pods 所在位置節點，防止 pod 出現在資源不足的節點，確保 pod 均勻分布在 Cluster 中，滿足使用者的手動調度。
    * Control Manager: 管理 deployments 與 replicasets，新增刪除 Pod, Service, Deployment, Ingress。
    * etcd: 分配資料庫儲存 Cluster 狀態。

* Worker Node:
    * 運作 pods
    * Kubelet: 管理與 Master Node 的通訊。

# GKE Cluster 的型態

* Zonal Cluster

    * Single Zone

    * Multi-zonal

* Regional cluster: 跨越指定 region 多個 zone 。

* Private cluster: VPC 為基礎的 cluster，節點只有 internal IP。

# GKE 概念 - Pod

* K8S 最小單位

* 每個 pod 都有臨時 IP 位址。

* 同 pod 中的容器分享著
    * Network
    * Storage
    * IP
    * Ports
    * Volumes

* Pod的狀態
    * Running
    * Pending
    * Succeeded
    * Failed
    * Unknown

# K8S Deployment 與 Replica Set

一個 deployment 可能可以有多個版本。

* deployment
    * Represents (代表) 一個 microservice。
    * 更新容器版本同時確保沒有斷線時間。

* Replica set
    * 確保特定數量的 pod 運作特定的 microservice 版本。

# K8S - Replica Set 概念驗證

先啟動好 K8S Cluster。

建立第一版 Container。

```bash
kubectl create deployment hello-world-rest-api --image=in28min/hello-world-rest-api:0.0.1.RELEASE
```

建立第二版 Container。

```bash
kubectl set image deployment hello-world-rest-api hello-world-rest-api=in28min/hello-world-rest-api:0.0.2.RELEASE
```

然後檢視一下replica set

```bash
kubectl get replicasets
```

我們可以看到兩個版本同時存在

```
q123717111@cloudshell:~ (idyllic-kiln-405005)$ kubectl get replicasets
NAME                              DESIRED   CURRENT   READY   AGE
hello-world-rest-api-5b78b5c566   0         0         0       8m3s
hello-world-rest-api-7dc5897557   3         3         3       108s
```

# K8S - Service

* 每個 pod 有自己的 IP，Service 可以用於開放 pod 的特定 port 給外部使用者。

* 當某個 pod 失效，Service 可以自動切換別的 pod。

* 三種型態的 Service

    * ClusterIP: 讓某個 pod 開放 port 給 cluster 內部的 IP 實體存取。例如一個僅對內部開放的資料庫。

    * LoadBalancer: 開放一個外部可存取的 port。例如網頁服務。

    * NodePort: 開放某個固定 port ，在所有 Node 上，讓外部得以存取。不過也可以用 Ingress 代替。

# Google 容器儲存庫

Google 的 私人版 容器儲存庫，類似 Dockerhub。

目前被稱為 **Artifact Registry**。

**容器名稱**

```
Naming: HostName/ProjectID/Image:Tag
```

例如:

```
gcr.io/projectname/helloworld:1
```

# 列出 GCP 中存放的 Image

```bash
gcloud container images list
```

# GKE 增加  Node pool

```
gcloud container node-pools create new-node-pool-name --cluster my-cluster
```

# GKE 其他備忘

* 把 master nodes 建立多複製到不同區域，可以達到高可用性。

* Control Plane 負責安排 node 中 CPU core 的負荷。

* K8S 支持 Stateful 容器部屬，也就是單一的，長期保存的，與穩定hostname 的。例如: Kafka, Redis, ZooKeeper。

* 是否能運作某種 services 用於蒐集 logs 跟監控，並且每個 Node 都有 ? DaemonSet 可以做到在每個 Node 上佈署同一種 Image。

* GKE 預設整合 GCP 的  Cloud Monitoring 與 Cloud Logging 服務。
    * Cloud Logging 的 System 與 Application Logs 可以導出到 Big Query 與 Pub/Sub。

# K8S 其他指令

### 列出pod/services/replicasets

```bash
kubectl get pods/services/replicasets
```

### 建立 deployment

這個可以用在建立與更新任意 deployment 與 service。

```bash
kubectl apply -f deployment.yaml
```

或者

```bash
kubectl create deployment
```

### 刪除 deployment

```bash
kubectl delete deployment hello-world
```

### 復原剛剛的 Deployment

```bash
kubectl rollout undo deployment hello-world --to-revision=1
```

# GKE問答

```
Q: 如何確保低成本與優化GKE實現?
A: Spot VM, 別用太多 region, Committed use discounts, E2 虛擬機, 適度使用 Node。

Q: 如何高效完整的 auto scaling 下使用 GKE ?
A: 參照上方筆記採用: Pod Autoscaler, Cluster Autoscaler。

Q: 希望執行第三方不被信任的 Code 在  GKE Cluster 上，怎麼做更好?
A: 建立一個額外 Node pool，然後執行在 GKE Sandbox 中。

Q: 你希望讓微服務只在 Cluster 裏頭通訊，怎麼做?
A: 建立 ClusterIP。

Q: 我的  Pod 卡在 pending。
A: Pod 沒辦法被安排到節點 (scheduled onto node)。 資源不足 (insufficient resources)

Q: 我的  Pod 卡在 waiting。
A: Pull the image 的時候失敗。
```

(P.130)