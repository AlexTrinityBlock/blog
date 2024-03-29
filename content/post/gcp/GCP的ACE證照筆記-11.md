---
title: "GCP的ACE證照筆記-11-Cloud KMS (Cloud Key Management)"
date: 2023-11-29T17:00:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---

# Data States 資料狀態

* Data at rest: 資料在裝置上使用或者在備份中
    * Hard disk
    * Database
    * Backups
    * Archives

* Data in motion (運動中): 資料在網路傳輸中
    * 如資料從本地轉送到雲端儲存
    * 應用程式跟 Database 交互中
    * 兩種型態
        * 傳入或傳出雲端
        * 在不同雲端設備中互相傳輸

* Data in use: 資料在 RAM 中被使用

# 關於加密

* 第一原則: Defense in Depth
    * 進行多層的存取控制。

* 通常需要加密的內容
    * Hard disks
    * Database
    * File servers

* 但需要注意的事情是，資料在應用程式跟 Database 之間傳輸要加密

# Cloud KMS

建立與管理加密鑰匙 (cryptographic keys)

* 可以涵蓋兩種類型的 Key
    * Symmetric Key
    * Asymmetric Key

* 提供 API
    * Encrypt
    * Decrypt
    * Sign Data

* 支援本地端加密

* 整合到所有含 Data 的 GCP 服務
    * Google-managed key (不須任何手動設置)
    * Customer-managed key (使用從 KMS 來的鑰匙)
    * Customer-supplied key (提供你自己的 Key)

# 建立一組屬於自己的 Key Ring

**記得到IAM裏頭將帳號加上 Cloud KMS Admin 這個Role**

進入以下這個 Cloud Console 路徑。

搜尋  KMS > Key management > Create Key Ring > 建立鑰匙圈

然後選擇鑰匙的形式， Hardware Security Module (HSM) 硬體安全模組的價格非常貴 (儘管超級安全)，練習時可以先用 Software 。

注意， key Ring 與 Key 無法刪除，除非刪除 Project。

# 使用 GCE 建立虛擬機加密硬碟

VM instances > Create instances > Boot disk > Change > Show Advance Configuration > Encryption > Customer-managed encryption key > 選擇鑰匙 > Grant GCE 可以存取鑰匙。

