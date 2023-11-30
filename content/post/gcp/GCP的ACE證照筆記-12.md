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

        * Local SSDs

            * 本地的 SSD，可以視為接在虛擬機上

            * 僅適用於某些機型 c3-standard-88-lssd，結尾有 lssd 的。

            * 僅用於暫存資料，無法永久保存

            * 不可作為開機硬碟

* File Storage: 

    * 不需額外手動就可以創建檔案，複製，刪除，重新命名，甚至分享給別人檔案。

    * 可以應用在需要儲存同時又能簡單分享，並且影片編輯。

    * 企業需要及時分享檔案，並且需要有安全權限階層。

    * 可以簡單分享給很多個虛擬機，同時可以讀也可以寫。

    * GCP 的名稱為 Filestore