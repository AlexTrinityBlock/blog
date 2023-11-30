---
title: "GCP的ACE證照筆記-12-Storage 儲存"
date: 2023-11-30T16:00:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# Storage

儲存分成兩種

* Block Storage

    * 類似許多二進位訊息的儲存區塊，可以作為硬碟直接掛上。從一個更高的角度來看，硬碟儲存的是一串 0 與 1 ， 映像檔也是如此。而 Block Storage 不介意裏頭儲存的二進位資訊是不是存在檔案系統  (如: ext4, NTFS) ，總之都可以存。

    * 如果儲存的是虛擬機硬碟，需要接上虛擬機才能存取。

    * 一個 Block Storage 可以想像成一個硬碟，可以提供多個虛擬機有讀取寫入權限。 (但典型來說，一個虛擬機掛載一個，會比較安全)

    * 可以一個虛擬機連接讀寫多個 Block Storage devices

    * 用來作為

        * Direct - attached storage (DAS): 類似硬碟。

        * Storage Area Network (SAN): 高速網路連接上儲存裝置池。

    * 主要有兩種可選

        * Persistent Disks

            * Zonal: 資料複製到多個 Zone

            * Regional: 資料複製到多個 Zone

            * 可永久保存，並且作開機硬碟

            * 可以自由選擇與伸縮大小

            * 獨立於虛擬機，可以自由連接與離線於虛擬機

            * Regional: 可以副本於同一個 Region 的兩個 zone。 價格為 Zonal 的兩倍左右
            
            * Zonal: 可以在一個 Zone 有多個副本

            * Snapshots: 支持

        * Local SSDs

            * 本地的 SSD，可以視為接在虛擬機上，有著超快的 IOPS (超快硬碟存取)

            * 僅適用於某些機型 c3-standard-88-lssd，結尾有 lssd 的

            * 僅用於暫存資料，無法永久保存

            * 不可作為開機硬碟

            * 支持 live migration，所以機房維修時不影響

            * 自動加密，但無法手動配置

            * 支持 SCSI 與 NVMe 接口

            * NVMe-enabled +  multi-queue SCSI images 可以得到最高效能

            * 用於高速 IO (10 - 100 倍於普通硬碟)

            * 適合 Caches 或者其他暫存資訊

            * 無法連接到其他  VM

            * Snapshots: 不支持

* File Storage: 

    * 不需額外手動就可以創建檔案，複製，刪除，重新命名，甚至分享給別人檔案。

    * 可以應用在需要儲存同時又能簡單分享，並且影片編輯。

    * 企業需要及時分享檔案，並且需要有安全權限階層。

    * 可以簡單分享給很多個虛擬機，同時可以讀也可以寫。

    * GCP 的名稱為 Filestore

# 比較各種 Persistent Disks

* Network block storage

* 可以用在自己維護的資料庫

以下三種可以選擇的硬碟類型

* Standard

    * 機械硬碟

    * pd-standard

    * 順序讀寫效能普通

    * 隨機讀寫效能差

    * 超便宜

    * 適合大量數據冷儲存

* Balanced

    * 固態硬碟

    * pd-balanced

    * 順序讀寫效能好

    * 隨機讀寫效能好

    * 價位中等

* SSD

    * 固態硬碟

    * 順序讀寫效能超好

    * 隨機讀寫效能超好

    * 較貴

    * 適合高速讀寫場景

# Persistent Disks 進行 Snapshots

* 可以用 Snapshots 建立 VM

* Snapshots 可以掛載到 VM 上

* Snapshots 可以是多個 Regional

* Regional 可以跨 Project

* Snapshots 可複製

* Snapshots 是增量儲存，所以可以僅刪除 Snapshots 中最近新增的資料

# Persistent Disks 進行 Snapshots 建議

* 避免太頻繁的 Snapshots ，一個小時別超過一次。

* Snapshots 進行時，虛擬機硬碟效能會下降。 故建議在非尖峰時期進行。

* 從 Disk 進行 Snapshots 更快，從 images 進行 Snapshots 更慢。

* 但用 Image 做出一個新的 Disk 更快， Snapshots 做出一個 Disk 更慢。

* 如果要快速建立很多虛擬機，建議用 Snapshots 建立一個 Image 後，用 Image 建立虛擬機。

* 建議用於虛擬機的 backups, cloning, replication

# 比較表

![image](/blog/public/2023-11-30/imagevssnapshot.png)

# 用 Gcloud 建立硬碟

```bash
gcloud compute disks create my-disk-1 --zone=asia-east1-a
```