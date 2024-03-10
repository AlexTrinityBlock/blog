---
title: "adduser 和 useradd 的差異"
date: 2024-03-10T13:29:36+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","apt"]
---
adduser 和 useradd 的差異:

# adduser 用法

```bash
sudo adduser [選項] 用戶名

# 無選項添加新用戶: 會提示您輸入用戶的密碼和其他信息。
sudo adduser 用戶名

# 添加系統用戶: 這將添加一個沒有家目錄的系統用戶。
sudo adduser --system 用戶名

# 指定用戶家目錄: 可以指定一個非標準位置的家目錄。
sudo adduser --home /自定義/家目錄 用戶名

# 添加用戶到特定群組: 將用戶添加到已存在的群組。
sudo adduser --ingroup 群組名 用戶名
```

# useradd 用法

```bash
sudo useradd [選項] 用戶名

# 無選項添加新用戶: 創建一個新用戶，但不會設置密碼或家目錄。
sudo useradd 用戶名

# 指定家目錄: 創建一個新用戶並指定家目錄。
sudo useradd -d /自定義家目錄 用戶名

# 指定用戶ID: 為新用戶指定一個特定的用戶ID。
sudo useradd -u 用戶ID 用戶名

# 創建無家目錄的用戶: 添加一個新用戶但不為其創建家目錄。
sudo useradd -M 用戶名

# useradd 命令可以在創建用戶的同時將用戶添加到一個或多個群組中
# sudo useradd -g 主群組 -G 附加群組,附加群組2,... 用戶名
sudo useradd -g users -G wheel,developers nathan
```