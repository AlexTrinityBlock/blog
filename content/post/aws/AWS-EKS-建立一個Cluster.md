---
title: "AWS-EKS-建立一個Cluster"
date: 2023-11-21T13:00:00+08:00
draft: false
featured_image: "/aws.jpeg"
tags: ["AWS"]
---

## 簡述

簡單來說，使用 AWS CLI + eksctl 兩個工具，很快就可以佈署好，並且進行管理了。

比較多步驟的是在新環境中安裝 AWS CLI 。

## 1.用 Root acount 建立 IAM account

為了乾淨好管理，先採用 AWS Root acount 建立一個 IAM account。

流程如下:

1. 建立一個 IAM Group
2. 建立一個 IAM User 附屬在 IAM Group 下。(記得記下帳號密碼與登入連結)
3. 把 IAM 帳號啟用 AdministratorAccess 角色。
4. 登入 IAM 帳號 ，右上角啟用Security credentials，找到 Access key 並且建立一個 CLI Access key 
5. 安裝 AWS CLI https://aws.amazon.com/tw/cli/
6. 命令行輸入 `aws configure`，把剛剛的 Access key 輸入，登入 IAM 角色。

## 2.安裝 eksctl

在下列網址下載安裝 eksctl 

[https://eksctl.io/](https://eksctl.io/)

該命令行工具可以自動與 AWS CLI 連線，但要先設置帳戶。

如果在 Windows 記得把環境變數導向 eksctl.exe 存在的目錄。

可能的話 Windows 推薦用 Chocolatey 或 scoop 安裝。

或者乾脆用 Docker 裝。

```bash
docker run --rm -it public.ecr.aws/eksctl/eksctl version
```

## 3-a.輸入各項內容，直接啟用群集

注意! us-east-1 可能會發生無法建立路由表的情況，Cluster 建立失敗時，請換 region 。

我們以下建立的叢集訊息如下:

* name: dev-cluster
* nodegroup-name: dev-cluster-node-group
* node-type(機器類型): t2.medium
* nodes(預設機器數量): 3
* nodes-min: 3
* nodes-max: 7
* region(所在地區): us-east-2

```bash
eksctl create cluster --name dev-cluster --nodegroup-name dev-cluster-node-group  --node-type t2.medium --nodes 3 --nodes-min 3 --nodes-max 7 --managed --asg-access --region=us-east-2
```

## 3-b.使用腳本啟用群集

建立以下檔案

**cluster.yaml**

```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: basic-cluster
  region: eu-north-1

nodeGroups:
  - name: ng-1
    instanceType: m5.large
    desiredCapacity: 10
    volumeSize: 80
    ssh:
      allow: true # will use ~/.ssh/id_rsa.pub as the default ssh key
  - name: ng-2
    instanceType: m5.xlarge
    desiredCapacity: 2
    volumeSize: 100
    ssh:
      publicKeyPath: ~/.ssh/ec2_id_rsa.pub
```

(上頭這個範例機器比較大，比較昂貴些，可以減小成 t2.medium)

參考以下儲存庫

[https://github.com/eksctl-io/eksctl/tree/main/examples](https://github.com/eksctl-io/eksctl/tree/main/examples)

## 4.直接使用 kubectl

由於 `eksctl` 會自動連入 AWS VPC，所以以下指令可以直接觀察啟用的 nodes，如果沒有安裝 kubectl 再另行安裝。

```bash
kubectl get nodes
```