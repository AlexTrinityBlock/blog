---
title: "GCP的ACE證照筆記"
date: 2022-11-08T10:00:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# GCP-ACE 證照筆記

Associate Cloud Engineer Certification 助理雲端工程師證照

## Region

遍布全球的地區，一個地區會有多個 Zone 機房。

目前有 20 個以上。

## Zones

資料中心 (data centers)，同 region 的 zone 資料互傳延遲很低。

---

## GCE

Google Compute Engine，一種可以租用的虛擬機 (Virtual Machines)。

可以負載平衡 (load balancing)。

可以自動擴展 (auto scaling)。

可以配置的虛擬機間網路。

可以自製虛擬機映像檔 (Image) ，也就是虛擬機硬碟，來快速佈署多個虛擬機。

可以設置啟動時自動運作的腳本 ”Startup script”，來安裝各種東西。

### GCE 虛擬機型號

通用計算型(General Purpose): E2, N2, N2D, N1

記憶體優化型(Memory Optimized): M2, M1

運算優化型(Compute Optimized): C2

### GCE 內外部 IP

External: 公網 IP，如果要做為遊戲伺服器或者網站至少要一個。

Internal: 內網 IP，是少要一個。

Static IP: 固定 IP ，租用後持續需要費用，可以附在不同虛擬機。

### GCE Instance templates

可以撰寫一種虛擬機的硬碟大小，啟動腳本，租用的CPU核心數量的設置，方便進行大量複製與建置虛擬機。

---

## Discounts

折扣。

- Google Kubernetes Engine (輕量容器) 與 Compute Engine (虛擬機)都可以使用。
- App Engine 自動購買虛擬機的機器人，使用 Flexible, Dataflow，購買的虛擬機也沒有折扣。
- 某些型號的虛擬機沒折扣，如E2, A2。

### Sustained use discounts

自動的”持續使用優惠”，無須手動操作，如果一個虛擬機架設許久，就會有折扣。

如果用超過25%個月，則開始增加折扣，從20%~50%，用越多省越多。

### Committed use discounts

如果使用年限可以預測 (如手機遊戲一次伺服器至少租用一年)，這時候可以使用這種契約折扣。

採取1~3年期租約，最高折扣到70%。

### Sopt VM, Preemptible VM

搶佔式虛擬機，每個資料中心用剩下的虛擬機會打折出租，但任何時候都有可能會被其他客戶租走，所以隨時會意外關機。

- 便宜，減少60%-91%租金，隨著當前虛擬機市場動態變更價格。
- 被別的客戶更高價租走前，會有30秒警告。
- 無服務水準協議(*SLA*)。
- 無法自動重新啟動。
- 無法遷移到別的正是虛擬機。
- 無法用免費試用抵用金。
- 可以用在有個高容錯能力的程式上，如區塊鍊。

---

## Billing 帳單

帳單以每秒計算，最短一分鐘內更新。

當虛擬機關閉時，儘管不會收取運算費用，但會收取虛擬機硬碟儲存費用。

### Budget alerts 額度警告

請永遠建立額度警告，虛擬機若因為各種理由增加大量費用 (如客戶量大增，出現超高昂的網路費用)，就可以透過警告幫助技術人員及時停止損失。

---

## Live Migration & Availability Policy 遷移與可用性政策

Live Migration 的情況是指在主機不關機的情況下，進行軟體更新或者硬體修改或者升級。

### Live Migration

- 可以將執行中的 VM 前移到同一個 zone 的別的主機。
- 不用修改任何 VM 屬性。
- 支持 SSD。
- 不支持GPU與搶佔主機。

### Availability Policy 可用性政策

- 當各 zone 進行機房維護時: 預設將 VM 遷移到其他硬體。
- 如果不是由使用者發起的重啟，則 GCP 會自動重啟主機。

---

## Custom Machine Types 自訂機器型別

E2, N2, N1 之間可以自訂 CPU, RAM 等數量，決定自己的使用量與機器類型。

---

## GPUs

- 不支持所有機器型態
- 當主機維護時，無法遷移，只能關閉。

---

## Sole-tenant nodes

單一節點用戶，整台機器租用，價格非常昂貴，但可以確保安全合規。

- 沒有承諾使用折扣 (Committed use discounts)
- 有自動的續用折扣 (Sustained use discounts)
- 要為每個 CPU 與 RAM 容量付費，甚至沒有使用時。

---

## VM mamager

可用於管理多個 VM 的作業系統更新。

- Patch: 更新補丁

---

## Gcloud

GCP命令行可裝在本地，提供各式命令行工具

- Cloud Storage - gsutil
- Cloud BigQuery - bq
- Cloud Bigtable - cbt
- K8S - kubectl