---
title: "GCP的ACE證照筆記-03-Instance Groups"
date: 2022-11-08T20:48:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# Instance Groups

可以採用數個 VM template 組成一個群組進行管理。

## 兩種型態的 Instance Groups:

* Managed:

    自動擴展的同一種 template 並且自動修復與自動管理釋放虛擬機。

* Unmanaged:

    許多不同型態的 template 組成，無法自動擴展修復。

## Instance Groups 的地區性

可基於 Zone 或者 Region。

* 自動擴充

    如果 instance crash ，會自動重新啟動。

* Health check

    可以檢查 APP 故障，透過每隔一段時間發送 Request 來偵測。

* Auto Scaling

    隨著 CPU 用量增加或者減少 VM。
    
    * Maximum, Minimum 的 VM 量設置。
    
    * Autoscaling metrics，自動擴展指標  CPU Utilization 等。

    * Cool-down period，每一次自動縮放之間的時間差異。

    * Scale In Controls，防止虛擬機數量突然下降，例如設置不會突然下降超過 10% ，或者 3 個。

* Load Balancer

    自動負載平衡。

* Multiple zones

    多區域建立 instances。

* 更新 APP 版本

    * Rolling updates: 滾動式更新。
    
    * Canary Deployment: 在全面更新之前，先更新部分。

* Autohealing

    自動在應用程式失效時，重新開啟虛擬機。

    但需要注意 ! 要設置在剛啟動虛擬機時，先緩緩 (Health check with Initial delay) 不然剛啟動虛擬機時，服務往往尚未啟動。

* Rolling update

    滾動更新，更新新的虛擬機 template。

    * Proactive，主動更新虛擬機。

    * Opportunistic，在自動縮放時悄悄更新。

    * Maximum surge，任何時間點增加多少個VM。

    * Maximum unavailable，更新時間最多有多少VM同時不可用。

* Rolling Restart/replace

    沒更新 template 下替換掉存在的 VM。同上，仍要設置，Maximum surge 與 Maximum unavailable。

 ## 命令行創建 Instance Groups

建議 Instance template 可以用 Global 方便找尋，如果採 Region 則要在 Gcloud 輸入包含地區的全稱。

以下指令為建立一個 instance-groups:

* instance-groups 名稱: my-vm-cluster

* 地區: us-central1-a 

* 採用的 template: debian-docker

* instance 數量: 2

```bash
gcloud compute instance-groups managed create my-vm-cluster --zone us-central1-a --template debian-docker --size 2
```

其他可用參數

```bash
--health-check
--initial-delay
--cool-down-period
--scale-based-on-cpu
--target-cpu-utilization
--min-num-replicas
--initial-delay
--health-check
```

## 設置 Autoscaling

```bash
gcloud compute instance-groups managed set-autoscaling  my-vm-cluster --max-num-replicas=10
```

## 更新 Policies

```bash
gcloud compute instance-groups managed update my-vm-cluster --initial-delay=120
```

## 調整虛擬機數量
```bash
gcloud compute instance-groups managed resize my-vm-cluster --size=5
```

## 重建 Instances

```bash
gcloud compute instance-groups managed recreate-instances my-mig --instances=myinstance-1,my-instance-2
```

## 更新 Instances

```bash
gcloud compute instance-groups managed update-instances my-mig --instances=my-instance3,my-instance-4
```

## 更新 Instances-template

```bash
gcloud compute instance-groups managed set-instance-template my-mig --template=v2-template
```

## 重啟 Instances

```bash
 gcloud compute instance-groups managed rolling-action restart mymig
```

## 刪除後重建 Instances

```bash
gcloud compute instance-groups managed rolling-action replace my-mig
```

## 用新 template 更新 Instances

### Basic Version 更新全部 Instances

```bash
gcloud compute instance-groups managed rollingaction start-update my-mig --version=template=v1-template
```

### Canary Version 更新部分 Instance 到 v2 template

```bash
gcloud compute instance-groups managed rolling-action start-update my-mig --version=template=v1-template --canary-version=template=v2-template,target-size=10%
```

### 情境1

確保至一個 instance 長期健康存在於所有時間。

```bash
gcloud compute instance-groups managed set-autoscaling my-group --max-numreplicas=1 --min-num-replicas=1
```

### 情境2

更新版本時不希望減少可用 Instance 的數量，並且一次只更新一個 Instance。

```bash
gcloud compute instance-groups managed rolling-action start-update my-group --version=template=my-v1-template --max-surge 1 --max-unavailable 0
```

(P.69)