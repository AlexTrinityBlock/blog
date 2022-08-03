---
title: "AWS觀念"
date: 2022-08-01T09:00:00+08:00
draft: true
featured_image: "/aws.jpeg"
tags: ["AWS"]
---

# Region

區域，例如美國東部，或者東京...

# Availability Zones

簡稱AZ，在一個區域裡頭，可以有數個AZ，例如同樣在東京，可以有兩個AWS機房。

# IAM

權限控管機制

# AWS CLI

AWS的命令行工具，可以遠端登入連線。

# EC2

Elastic Compute Cloud(彈性運算雲)，一種雲端的虛擬機服務。

不過也有非虛擬機的運算實體，例如`u-6tb1.metal`這種後頭有metal的就是。

## EC2 User data

啟動腳本，一個實例啟動時會自動執行。

可以用來安裝Python套件, NPM, 其他伺服器軟體等。

## EC2的IP

每個EC2實體都會有個公共IP與私有IP。

EC2重啟或暫停時都會更換公共IP，並且用戶無法從外側存取私有IP，那屬於AWS私有網路。

# EC2 Instance Store

由於EBS要跨越網路，EC2 Instance Store則是連接在實體主機上的高速I/O儲存區，所以很適合Buffer, Cache, Scratch data等任務。

* 實體刪除就會消失

* 硬體主機故障可能會消失

* 高速I/O

* 請自行備份

# Elastic Block Store

可以長期保存EC2實體的類似硬碟儲存空間。

EC2有兩種狀態:

* Stop: EBS中的內容持續到下次啟動。

* Terminate: EBS中的內容刪除。

其中種類有

1. gp2, gp3: 通用功能SSD。1GiB~16TiB。gp3快於gp2。
2. io1/io2: 高效能SSD。4GiB~16TiB。
3. io2 Block Express: 高效能SSD。4GiB~64TiB。
4. st1: HDD，但適合頻繁存取(不可用來開機)。
5. sc1: HDD，適合低頻率存取(不可用來開機)。

# Elastic Block Store Multi-Attach

普通的情況EBS一次只能附加在一個EC2上頭。

io1/io2則可以使用同一個EBS附加到不同的EC2上頭。

# Elastic Block Store Encryption

當你製作了一個加密的EBS時，所有資料在傳輸與儲存的時候都是加密的。

* 低延遲

* EBS加密的金鑰保管在KMS，金鑰為AES-256金鑰。

* EBS建立Snapshot的時候可以加密。

* 如果Snapshot是加密的，則建立EBS時也是加密的。

# AMI

Amazon Machine Image (AMI)由AWS負責維護的作業系統映像檔。

可以更快的配置跟啟動，因為AMI已經事先打包成映像檔了。

* Public AMI: AWS提供的映像檔，不果你也可以自己建立，或者到AWS Marketplace AMI去購買。

* 一個Region的AMI只能用在同一個Region。

# EC2 Optimizing CPU options

可以在CPU最佳化選項中，取消多執行緒來增加單一執行緒的運算效能，或者減少CPU並換成更多的Ram，並且減低或者維持成本。

# EC2 Cpacity Reservation

容量預留，可以在某個AZ預留需要使用的EC2資源。

# Elastic IP

AWS的固定公開IP租借，沒有特別要求的情況下，一個用戶最多租借5個，也可以要求更多。

這類的固定IP可以連到EC2實體上頭。

不過最建議的方式還是，EC2實體搭配Route52的DNS服務，雖然EC2實體IP可能會在重啟時改變，但是無論如何同一個網址仍然會導向新的IP。

使用方式是將一個IP附加到任意EC2實體。

# EC2 Placement Groups

有辦法策略的啟動EC2實體群集，共有3種策略。

* Cluster: 在同一個AZ裡頭建立一個網路低延遲的主機叢集，甚至在同一個機櫃上。每個實體間有高達10Gbps的網路速度。

* Spread: 主機不一定在同AZ，就算在同AZ，也不會在同一個實體機器上，避免風險。每個AZ最多7個實體。

* Partition: 折衷辦法，數個實體為一組(partition)，每一個AZ最多7組，不同partition不會被分配到同一個，機櫃(Rack)。

# Elastic Network Interface(ENI)

能賦予EC2某種虛擬網卡。

有著單一的MAC address，但是可以讓實體有多個Private IP，在AWS的VPC中奏效。

可以用於故障轉移(failover)，例如當192.168.0.5的實體失效時，可以將該IP附加到另外一個有效的實體。

注意，只能在同一個AZ。

# Hibernate

讓EC2實體休眠。

將EC2的RAM中的內容儲存到EBS空間中，根目錄。

解除休眠後的啟動速度比完全重新啟動EC2更快。

EBS根目錄的內容是加密的。

* 需要小於150GB的Ram才可以。

* 可用於On-Demand, Reserved, Spot。

* 休眠不可大於60天

* EBS儲存空間一定要夠大，大於Ram大小，並且加密的。

# EC2 Nitro

不能直接使用，他是EC2底層的硬體與虛擬化技術。

提供更好的效能與安全。

只有少數較為便宜的EC2實體類型，沒有以外，多數的EC2實體都使用Nitro硬體技術。

# Security Group

指定一個EC2實例要開放哪一個Port，然後該Port使用哪個協定，類似簡易防火牆。但只能封閉不用的Port，卻沒辦法阻擋SQL injection或其他細緻的入侵。

* 選擇開放的Port(也可以是一個範圍的port)與該Port的協定，如80 port開放 HTTP協定，443 port開放HTTPS協定。

* 允許特定的來源IP。

# EBS

在CCP雲端從業人員等級，一個EC2只能附加一個EBS。

如有需要可以在中止EC2後保存資料(但要在建立時特別標注)。

可以視為某種在網路上的USB隨身碟。

* 綁定某個AZ。

* 可以快速的卸載或附加到某EC2上頭。

* 需要標注大小與IO速度。

## EBS的自動刪除機制

* Root volume type: 預設情況下會隨著EC2關閉而結束。

* Other EBS volume types: 預設不會隨關閉結束。

# EBS Snapshots

EBS某個時間的上的快照，也就是某種存檔。

有辦法跨越AZ。

## EBS Snapshot Archive

將Snapshot移動到不同的Archive Tier，減少存取速度，可以便宜75%。

24~72小時復原。

## Recycle Bin for EBS Snapshot

資源回收桶，可在一定的時間內復原刪除的Snapshot。

# EFS(Elastic File System)

* 也是儲存空間的一種，可以同時附加到多個EC2實體。

* 可以由多個不同AZ的實體分享檔案。

* 高可用性，不容易下線，可擴展，但是價格是三倍的gp2。

* NFSv4協定。

* 用Security group控制EFS存取。

* Linux為基礎的AMI。

* 不使用時用KMS加密。

* POSIX標準檔案API。

* 使用才計費。

* 同時1000個用戶，10GB吞吐量。

* 最大可以存取到PB等級。

## EFS效能模式設定(Performance mode)

* General purpose: 預設，低延遲。

* Max I/O: 延遲略高，但吞吐量與平行化效果更好。

## EFS吞吐量模式設定(Throughput mode)

* Bursting: 50MiB/s可以爆發到100MiB/s。

* Provisioned: 考慮吞吐量，但不考慮除存容量的大小，例如吞吐量為1GiB/s，但作用在1TB的容量上。

## EFS Storage Classes

### Storage Tiers

* Standard: 時常存取的檔案

* Infrequent access(EFS-IA): 比較便宜，但較少存取時會恢復的更慢。 

### Availability and durability

* Standard: 多個AZ。

* One Zone: 一個AZ並且可以加入EFS-IA的能力。

# ELB

Elastic Load Balancing (ELB) 將流量分配到不同的實體，支援內外部網路。

ELB有下列種類:

* Application Load Balancer: Layer 7，IP、執行個體、Lambda。

* Network Load Balancer: Layer 4。用於IP、執行個體、Application Load Balancer。

* Gateway Load Balancer: Layer 3 閘道 + Layer 4 負載平衡。用於IP、執行個體。

* Classic Load Balancer: Layer 4/7。

除此之外，還有附帶4個重要功能:

* 如果其中某些伺服器失效了，可以將流量導向可用伺服器。

* 可以暴露單一的IP給DNS。

* 可將SSL憑證賦予在負載平衡器上。

* Health Checks: 即時檢查某實體的健康，例如檢查某實體80 port的HTTP協定index.html是否運作。

## Sticky Sessions(這是概念，不是AWS服務)

除此之外，還需要進行Sticky Sessions或者Sticky cookies，這是什麽呢？

>如果我們有三台網頁伺服器，我們在第一台登入成功了，不過第二次我們被分配到第二台，結果就必須要第二台伺服器重新登入一次。因為只有第一台紀錄著我們的Session。

1. 根據IP來決定要分配到哪一台主機，這樣主機固定不變，就不會有Session無法紀錄的問題。免費的Nginx就可以實現。

2. 資料庫存放Session，存取速度慢，適合低流量時使用，但可以簡單的共享Session key。

3. NFS，網路文件系統，類似共享一個磁碟系統，但是存取速度也十分慢。

4. Memory Cache: 常見的如memcached、Redis，類似資料庫，但是內容儲存在RAM中，響應速度快，是個好方法，不過如果電源斷電無法保存(但可以用異地除存來緩解)。

## ALB

ALB (Application Load Balancer)

Layer 7 層級，例如Http協定的負載平衡器。

透過Target Group來分配流量，不需要僅綁定IP。也就是說可以用伺服器的功能或者名稱來分配流量。

也可以分配流量在同一台機器上的不同Container，如Docker。

*  On-Premises、EC2、Lambda 可作為 Target。

* 支援使用 AWS WAF，內建 AWS shield緩解DOos。

* 比CLB便宜，但不能進行純TCP轉送。

* HTTP, HTTPS, Web Socket。

* 可以將HTTP重導向到HTTPS。

* 可以用URL, 網址, 請求參數，來將流量導向不同的主機。例如:網址路徑為搜尋服務時，會導向網路流量擴充的實體。或者運算服務時，會導向運算能力優化的實體。

* 可以重導向不同的Port。

* 可以導向多個Target Group。

### 跨越負載平衡器後，如何知道客戶端的IP呢？

客戶的IP在通過負載平衡器後會被存入HTTP Header禮頭的X-Forwarded-For裡頭，並且也可以看到客戶端的Port (X-Forwarded-Port)與協定(X-Forwarded-Proto)

## CLB(Classic Load Balancers)

* 支援HTTP, HTTPS, TCP and SSL listens。

* 支援 Sticky sessions (cookies)

* 只能在同一個網址下運作。

* 通用性高但昂貴。

* 可以在VPC裡頭。

* 可設置來源IP。

## NLB

Network Load Balancer，在每個AZ有一個IP，並且可以額外附加Elastic IP。

* 支援TCP, TLS, UDP。

* 高效能，最小耗時為100ms，非常快速。

* 用於高速TCP, UDP轉發。

* Target Group可以有EC2, IP(私有IP), 另外一個ALB。

* 從目標實體的角度，透過NLB的傳輸看起來會很像客戶從外部網路進行連線，所以某些情況Security Group要開放外部IP。

## GWLB

Gateway Load Balancer。

有辦法在AWS管理第三方網路虛擬應用程式。

例如部屬第三方供應商的防火牆，入侵偵測系統，深度封包檢測(檢查封包的IDS的一種)。

* Layer3 IP協定。

* 同時有轉送與負載平衡兩種功能。

* 可以轉送給EC2, 與特定IP。

## Sticky Sessions 又稱為 Session Affinity (AWS上的)

AWS上頭的實踐方法是，將同個客戶的IP的請求，轉送到同一台的EC2實體。

### Application-based cookies

* 客戶自訂cookie

    * 可以包含客戶自訂的cookie內容。
    
    * cookie名稱要有別於Target Group。

    * 別用AWS關鍵字。

* Application cookies

    * 由Load balancer生成

    * Cookie 名稱是 AWSALBAPP

### Duration-based Cookies

* 由Load balancer生成

* 使用ALB時Cookie 名稱為 AWSALB。

* 使用CLB時cookie名稱為AWSELB。

## Cross-Zone Load Balancing

跨AZ的負載平衡。

該方法假設美國西部有8個EC2實體，東京有2個，則每個EC2實體都會被分配到10%流量。

如果沒有特別跨AZ就會簡單的美國50%流量，東京50%流量，而不考慮EC2實體數量。

* ALB: 自帶跨區，不能取消。

* NLB: 不會預設啟動，每個AZ啟動要加錢。

* CLB: 不會預設啟動，但啟動不會加錢。

## ELB與SSL和TLS

可以在負載平衡器上添加SSL Certificate。

SSL是Secure Socket Layer，TLS比較新為 Transport Layer Security。

SSL Certificate可以在很多網站上申請到，有的免費有的付費，並且會在一段時間後過期。也可稱為X509 certificates。

* ACM (AWS Certificate Manager): 可以用來管理SSL certificate。

* HTTPS listener: ELB用來處理與客戶加密流量的功能。

* SNI(Server Name Indication): 支援同一個IP上頭有幾個不同的網站，並且每個網站都有獨立的憑證，類似虛擬主機。使用者需要配備支援該協定的瀏覽器。

* SNI 服務只支援，ALB, NLB, CloudFront。但CLB不支援。

* 這意味著只要1個ELB就可以服務多個網站(網址不同的前提)，並且該ELB要儲存多個憑證。不用更多成本來設置很多個ALB。

我們可以從下列比較:

* CLB: 只能有一個憑證。

* ALB: 可以有多個憑證，多個HTTPS listener，以SNI協定實現。

* NLB: 可以有多個憑證，多個HTTPS listener，以SNI協定實現。

## ELB 中的 Connection Draining 

Connection Draining 中文直譯為連結耗盡，也就是當一個實體已經許久沒有回應時，將不再把連線流量交給該實體。

在不同ELB中的名稱:

* CLB: Connection Draining

* Deregistration Delay: ALB & NLB

可以設定時間，1-3600秒之間，設置0為取消。

# Auto Scaling Group

當一個EC2實體不足時，會自動啟動更多的實體和架構，雖然要付更多費用，但可以讓尖峰客戶流量時段，得以緩解。

* scale out: 增加EC2

* scale in: 減少EC2

由於該服務的特殊性質，所以基本上是掛在 **ELB** 底下。

* ASG 是免費服務。

有分為三個數量:

* Minimum Capacity: 最少至少啟動的實體數量。

* Desired Capacity: 希望維持的實體數。

* Maximum Capacity: 最大的實體數量。

ASG也可以注意到實體健康狀態。

## ASG Launch Template
可以事先撰寫好的腳本，類似Docker-compose.yaml或k8s的風格，來定義AMI, 實體種類數量, EBS, Security Groups, SSH key pair, IAM, 網路設置與ELB。

類似下方:

```yaml
---
AutoScalingGroupName: my-asg
MixedInstancesPolicy:
  LaunchTemplate:
    LaunchTemplateSpecification:
      LaunchTemplateName: my-launch-template
      Version: $Default
    Overrides:
    - InstanceType: c5.large
    - InstanceType: c5a.large
    - InstanceType: m5.large
    - InstanceType: m5a.large
    - InstanceType: c4.large
    - InstanceType: m4.large
    - InstanceType: c3.large
    - InstanceType: m3.large
  InstancesDistribution:
    OnDemandBaseCapacity: 1
    OnDemandPercentageAboveBaseCapacity: 0
    SpotAllocationStrategy: capacity-optimized
MinSize: 1
MaxSize: 5
DesiredCapacity: 3
VPCZoneIdentifier: subnet-5ea0c127,subnet-6194ea3b,subnet-c934b782
```

## ASG 與CloudWatch Alarms

CloudWatch Alarms 可以設置為平均CPU使用量或者客戶自訂的指標(metric)，當CPU負載過高時自動增加EC2實體。


## ASG的Dynamic Scaling Policies

* Target Tracking Scaling
    * 簡單的設置，追蹤某個指標。
    * 例如：努力維持在每個實體CPU耗用率為 40%。
    * 例如：努力維持在每個實體最大連線數量為1000以下。
* Simple / Step Scaling
    * 例如:當CloudWatch alarm 於平均CPU耗用大於 70%時被觸發時，增加2個實體。
    * 例如:當CloudWatch alarm 於平均CPU耗用小於 30%時被觸發時，減少1個實體。
* Scheduled Action
    * 根據過去的使用模式，進行調整。
    * 例如: 每週5下午5點，增加最少實體數量到10個。
* Predictive scalling
    * 持續預測負載，預先擴展。
    * 根據歷史紀錄以 Machine Learning 進行預測

## ASG 預測指標 (Metric)

* CPU Utilization: 平均所有的CPU的使用率。

* Request Counter Per Target: 確保每個EC2實體，收到的Request 頻率都是一致的。

* Average Network In/Out: 平均網路I/負載，如果要使用這個，建議用在高網路流量的服務，有時CPU仍有剩餘，但網路流量不夠用的那類服務。

* 其他CLoudWatch可以偵測到的指標。

## ASG - Cooldown Period

冷卻時間，每次啟動負載平衡時，都會重置冷卻時間，預設為300秒。

* 可以使用Ready-to-use AMI映像檔來加快啟動實體速度和減少冷卻時間。

## 測試負載平衡測試

Google 搜尋:

```
install amazon stress linux 2
```

然後下載測試工具，當前安裝指令是，連入EC2終端後輸入下列指令:

```
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
```

啟動CPU壓力測試

* -c 4: 4個CPU核心。

```
stress -c 4
```

該舉動會產生CPU運作 100%的效果。

## ASG在助理架構師考試中可能會考的題目

> 簡單來說，如果ASG要自動關閉實體，它會挑選實體數量最多的AZ，並且選擇最早啟動的那個。

> 實體在啟動階段但尚未啟動完全稱為Pending status，啟動完畢後轉進InService狀態。Pending status時可以用選項添加自訂的額外軟體安裝，或者腳本執行。

> 實體正在結束時稱為terminating status，也可以添加一些額外動做。 

![img](/blog/public/2022-08-03/lifecycle_hooks.png)

> 建立實體的必要條件有AMI, Instance Type, Key Pair (用來訪問實體) ,Security Groups，與其他參數。

> 在過去AWS運作一個實體要使用Launch Configuration。

> 較新的實體運作方法為Launch Template，撰寫好可以繼承重用的模板，可以用在 On-Demand 與 Spot Instance 實體的創見。

> T2 unlimited burst，其功能是如果CPU超量使用，則可以額外付費提供更高的運算能力。

> Network Load Balancer 提供一個 static DNS name (網址) 與 static IP (靜態IP)

> Application Load Balancer 與 Classic Load Balancer僅提供一個 static DNS name (網址)但不提供靜態IP。

> Auto Scaling Group 發現有實體處於不健康狀態時，就會先建立新的實體，然後結束掉舊的實體。

# RDS

RDS (Amazon Relational Database Service) 是個關聯式資料庫服務。使用SQL query 語法呼叫。

可以建立以下類型的資料庫:

* PostgreSQL

* MySQL

* MariaDB

* Oracle

* Microsoft SQL Server

* Aurora: AWS自製的資料庫類別。

RDS 的優點如下:

* 不用自己管理 Server 。

* 基底作業系統會由 AWS 自動更新。

* 持續的進行備份，並且可以復原回某個時間點。

* 提供 Read replicas，也就是可以複製當前的資料庫為幾個一模一樣的複製體，讓客戶讀取資料時，可以從多個資料庫讀取，不會所有資料庫讀取流量都在同一個資料庫。可以達成讀取加速。

* 多個 AZ

* 水平垂直擴展

* 底層儲存於 EBS

但有個限制:

* 不能自己用SSH去連結到資料庫運作的實體。

## RDS 備份

* Automated backups
    * 每日完整備份資料庫