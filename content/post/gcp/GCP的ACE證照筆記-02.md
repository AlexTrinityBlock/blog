---
title: "GCP的ACE證照筆記-02"
date: 2022-11-08T20:44:44+08:00
draft: false
featured_image: "/gcp.png"
tags: ["GCP"]
---
### Gcloud 的常用功能

```bash
# 初始化，登入GCP帳號
gcloud init
# 列出所有啟動的屬性，可以看到登入帳號與 projuct 名稱
gcloud config list
# 列出帳號
gcloud config list account
# 列出區域
gcloud config list region
# 列出 Project
gcloud config list project

# 列出 Configurations 
gcloud config configurations list
gcloud config configurations activate my-default-configuration
gcloud config list
gcloud config configurations describe my-second-configuration

#列出虛擬機
gcloud compute instances list
gcloud compute instances create
gcloud compute instances create my-first-instance-from-gcloud
gcloud compute instances describe my-first-instance-from-gcloud
gcloud compute instances delete my-first-instance-from-gcloud

# 列出所有位置的虛擬機
gcloud compute regions list
gcloud compute zones list

# 列出正在使用的虛擬機的位置
gcloud config list compute/region

gcloud compute machine-types list
 
gcloud compute machine-types list --filter zone:asia-southeast2-b
gcloud compute machine-types list --filter "zone:(asia-southeast2-b asia-southeast2-c)"
gcloud compute zones list --filter=region:us-west2
gcloud compute zones list --sort-by=region
gcloud compute zones list --sort-by=~region
gcloud compute zones list --uri
gcloud compute regions describe us-west4
 
gcloud compute instance-templates list
gcloud compute instance-templates create instance-template-from-command-line
gcloud compute instance-templates delete instance-template-from-command-line
gcloud compute instance-templates describe my-instance-template-with-custom-image
```

### Gcloud 的設置組

```bash
# 語法為 gcloud config set 大類別/小類別 值 
gcloud config set core/project VALUE
gcloud config set compute/region VALUE
gcloud config set compute/zone VALUE
gcloud config set core/verbosity VALUE

# 可以取消掉剛剛的設置值
gcloud config unset

# 設置Project
gcloud config set project $MY_PROJECT_ID
```