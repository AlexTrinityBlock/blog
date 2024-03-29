---
title: "AWS證照SSA筆記"
date: 2022-08-18T09:00:00+08:00
draft: false
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

此外，建立RDS時:

* 需要自己選擇EC2的實體等級，例如儲存空間優化的，或者RAM優化的，會有不同價格。

* 選擇儲存用的硬體類型，類似EBS的選項，例如選擇SSD或HDD。

## RDS Backups

* Automated backups
    * 每日完整備份資料庫
    * Transaction logs 每五分鐘備份。這代表有辦法復原回五分鐘前的資料庫狀態。
    * 自動備份保留7天，可以付費延長到35天。

> SQL 中的 Transaction 功能用在進行多個 SQL 操作時，如果操作中途中斷，可以使用 ROLLBACK TRANSACTION 來復原資料庫為一連串操作前的狀態。

> Transaction logs 這個紀錄保存著 SQL 的每一筆資料更改。

* DB Snapshot
    * 由使用者自己觸發。
    * 可以根據你的需求決定保存時間。

## RDS - Storage Auto Scaling

* 可以自動隨著需求擴大 RDS 容量。

* 當RDS 偵測到你用完免費資料庫儲存容量時，將會自動擴展。

* Maximum  Storage Threshold: 手動設置限制資料庫的最大擴展容量，否則它將會無限擴展下去。

觸發自動擴展儲存空間的條件:

* 免費空間少於 10%

* 儲存空間太少，事件發生5分鐘以上。

* 自動調整後6小時內不會再次自動調整。

* 適用於所有類型的 RDS 關聯資料庫。

## RDS Read Replicas for read scalability

資料從 Main RDS 複製到 Read RDS Replicas上頭，然後用戶就可以從多個RDS取得資料，加快速度。(不過只有在讀取的時後) 

但這種方法只能保持 **最終一致性(eventually consistent)** 也就是說，Replicas RDS終究會更新到最新資料，但不代表每次讀取時資料都是新的。也就是非同步的(ASYNC)。

* 不同AZ間的資料傳輸是需要額外費用的。

* 但是有個例外，在不同AZ但同一個Region時，RDS Replicas的傳輸不需要額外付費。但如果跨Region需要額外收取傳輸費用。

## RDS Muti AZ (Disaster Recovery)

在不同AZ建立災害復原的RDS備份。

* SYN replication: 同步複製。

* One DNS name: 兩個資料庫同一個網址，會自動在一個資料庫伺服器損毀時將應用程式轉移連結到另外一個資料庫伺服器。

* 不可用來給用戶讀取，這種類型的備份，就只是一直等待著預防故障發生。

## RDS - From single AZ to  Multi AZ

從原本的一個AZ的RDS，擴展到多個AZ時:

* 中間不會導致資料庫下線(Zero downtime)，也不用關閉資料庫。

* 點擊一下即可。

在該服務內部發生的事情:

* 將第一個RDS建立一個可以跨區域的Snapshot 。

* 將Snapshot還原到另外一個AZ。

* 兩資料庫建立同步。

## RDS Security - Encryption

關於RDS的加密:

* At rest encryption

    * 使用AWS KMS 的 AES-256進行加密。

    * 如果主要RDS沒有加密，則RDS的replicas無法被加密。

    * Transparent Data Encryption (TDE)在Oracle與SQL server上可以使用。該技術是指，在資料寫入硬碟之前就完成加解密，也就是說就算小偷取得硬碟，也無法從中獲得明文資料。

* In-flight encryption

    * SSL certificates用於加密RDS資料於In-flight(我猜是指在網路傳輸的過程是加密的)。

    * 提供SSL certificate 選項，當你連線到資料庫時。

    * 可以強制所有SQL的客戶端要使用SSL。

## RDS Security Operations

* 加密RDS備份
    * RDS是否加密會影響到Snapshot是否加密。
 
    * 可以複製一個Snapshot時將其改成加密的。

* 加密一個沒有加密的RDS

    1. 取得Snapshot並在多複製一個時選擇加密。

    2. 用加密的Snapshot來還原出一個加密的資料庫。

    3. 將用應用程式遷移到新的資料庫，然後刪除舊的。

## RDS Network & IAM

* RDS 處於私有子網路，並且受到Security Group保護。

* 存取管理

    * IAM 可以幫忙管理 RDS 的使用，透過RDS API。
    
    * 傳統的帳號密碼也可以用來登入RDS。

    * IAM-based authentication 也可以用來登入 RDS MySQL 與 PostgreSQL。

    * 如果單純使用 RDS API 與 IAM 進行登入，就不需要密碼(如某個EC2實體有一個設定成可以登入MySQL的IAM Role，就不需要額外的密碼，該實體會用IAM Role取得　
    一個Auth Token 然後用該Token 加密SSL連線)。

    * Auth token 的存活時間為 15 分鐘。

## RDS Aurora

Aurora是AWS自產的一種資料庫類型，可以相容MySQL與PostgreSQL，不過在啟動時要先選擇。並且進行為了雲端的優化，在RDS上有MySQL 5 倍的速度，並且超過PostgreSQL 3 倍的效能。

* 會自動擴展大小，從10GB開始，可到達128TB。

* 有15個replicas，MySQL的5個更多，所以速度更快。

* 比一般RDS貴上20%。

* 資料會被複製6份，跨越3個AZ。
    
    * 4個用於寫入。

    * 3個可用於讀取。

    * 當某個節點損毀時，會在不同節點間使用Peer to Peer 自我修復。

    * 儲存橫跨100個Volume。

* 當主要資料庫節點失效，30秒內會被其他節點替代。

* 15個Read replicas，並且可擴展。

* Aurora的架構:

    下列兩種節點的數量可能會不一樣。

    * Writer Endpoint: 用來寫入的資料庫節點。

    * Reader Endpoint: 用來讀取的資料庫節點。

    此外也可以有客戶自訂的節點，可以自選更好的EC2實體類型，稱為 **Customer Endpoint**

## Aurora Serverless

* 可以自動隨著使用量擴展。適合用在低頻率與不可預測工作量時。

* 不需要手動進行容量設置。

* 以秒來進行支付，所以在不確定使用多久時，是有經濟效益的。

* 多個Aurora 使用Proxy群來分配給每個資料庫實體的流量，由Aurrora來管理。

## Aurora Multi-Master

每個資料庫節點都可以進行讀寫操作，多個主節點，可以用
故障轉移。

## Global Aurrora

* Aurrora Cross Region Read Replicas: 實用的故障轉移與故障復原功能，因為有多個備份。

* Aurrora Global Database(推薦)

    * 1個 Primary Region，讀寫都可以。

    * 5個次要的 secondary read-only regions 區域，Replication的延遲少於 1 秒。

    * 每個次要區 secondary regions 有16個 Read Replicas。

    * 有效減少延遲。

    * 可以從不同區域進行資料復原。RTO 復原時間目標，基本上小於1秒。

    ## Aurora Machine Learning

    * 通過 SQL 語法來調用 ML 服務。

        * Amazon SageMaker: 使用 ML model。

        * Amazon Comprehend: 用ML進行情感分析。

# Amazon ElasticCache Overview

* 管理 Redis 或者 Memcached。

* 高存取速度。

* 可以減輕資料庫負擔。

* Stateless 應用程式非常適合。

使用方式:

* 資料快取

    * 當更新RDS的資料時，刪除ElasticCache中的舊資料。

    * 但是如果要使用的話，應用程式就會由先存取資料庫，改成先存取ElasticCache，如果Cache沒有稱為Cache Miss，這個時候就將RDS的內容寫到Cache中。

* Session保存

    * 用來紀錄Session內容與Session Key。

## Redis 與 Memcached 簡述(不只在AWS)

* Redis

    * AOF(Append Only File): Redis的每一個操作，在Redis下線後可重新啟動，不過檔案比較大，檔案太大時可以重建。

    * RDB(Redis Database): 資料庫，每隔一定的時間紀錄Redis裡頭的內容。

* Memcached

    * 支援 multi-threaded

    * 無下線後的功能。

## Redis 與 Memcached 在AWS中

* Redis

    * 支持多AZ，並且支持故障復原。

    * 可以有 Read Replicas 來擃充使用者讀取的流量。並且防止其中一台下線。

    * AOF資料復原。

    * Backup and restore 保存與回復。

* Memcached

    * Multi-node: 多個節點來分散資料。

    * 沒有 Replication ， 風險較高。

    * 沒有 Backup and restore 。

## 在SSA考試中的ElasticCache

* ElasticCache不支援IAM登入。 IAM只支援AWS API-level的安全。

* Redis AUTH: 當建立叢集時，可以設置Redis的密碼。這樣可以增加安全性。一定要追加Security Groups。

* 支援SSL於flight encryption。

* Memcached支援SASL-based authentication (建議使用)。

* 兩種ElasticCache的使用模式：

    * Lazy loading: 儲存資料時，不存入快取，只放入資料庫。但當資料被使用者存取一次之後放入快取。

    * Write Through:  儲存資料時，同時放入資料庫與快取。

    * Session Store: 儲存Session，並且使用TTL(持續生存時間機制)。

    mportant ports:

* Read Replicas 沒有辦法進行故障回復，只能使用Multi-AZ。

* Multi-AZ使用時不用手動更改SQL的URL。

* RDS的replicas最大5個。

# 常見的Port助記

重要Port

* FTP: 21

* SSH: 22

* SFTP: 22 (same as SSH)

* HTTP: 80

* HTTPS: 443

RDS Databases ports

* PostgreSQL: 5432

* MySQL: 3306

* Oracle RDS: 1521

* MSSQL Server: 1433

* MariaDB: 3306 (same as MySQL)

* Aurora: 5432 (if PostgreSQL compatible) or 3306 (if MySQL compatible)

# Route53

## DNS 基本概念

將網址對應到IP的服務

* Domain Registrar: DNS網址註冊供應商Amazon Route53, GoDaddy。

* DNS Record: A (IPv4), AAAA (IPv6), CNAME (同一主機的網址別名), NS (指出哪個DNS伺服器對於該網址有權威性)。

* Zone File: 儲存DNS紀錄的檔案。

* Name Server: DNS負責(authoritative)某個網址名稱。

* Top level Domain(TLD): 頂層網址，位於網址的最尾端，如 `google.com` 裏頭的 `.com` 除此之外還有 `.us, .in, .gov, .org`。

* Second Level Domain(SLD): `google.com` 裏頭的 `google`。

* Subdomain: `api.www.example.com` 中的 `www` 就是Subdomain。

* SOA: 權限開始記錄（縮寫為SOA 記錄）是域名系統(DNS) 中的一種資源記錄，包含有關區域的管理信息，尤其是有關區域傳輸的信息。SOA 記錄格式在 RFC 1035 中指定。

## DNS的詢問路徑

假設一個公司內部有自己的網址，所以公司內部有一個DNS，這時公司中的某台電腦發出了DNS請求，以下是DNS的查詢路徑:

1. 公司內的電腦瀏覽網頁 `example.com`，瀏覽器發出DNS請求，請求先送達公司內部的DNS。由於為了使用公司內部的網址，所以所有瀏覽器都被手動設置DNS為公司內部瀏覽器。

2. 公司內部的Local DNS Server 的找不到該網址，所以將請求轉發到 Root DNS Server ，Root DNS Server 將這則請求轉發到負責`.com`的 TLD DNS Server。

3. TLD DNS Server 接著將請求轉發到負責 `example.com` 的 SLD DNS Server。

## DNS Record

DNS中的網址紀錄

* Domain/Subdomain

* RecordType: A, AAAA

* Value: IP位址，如: 12.34.56.78

* Routing Policy: DNS回應請求的方法。

* TTL: DNS紀錄快取在DNS server的時間。

## AWS 中的 Route53

Route53可以支持公有網路，與AWS私有網路VPC的DNS服務。

* 考試的當下，公私有網路都有效的網址是一個月$1美元，公有網路$0.5美元，AWS VPC私有網路$0.5美元。也就是一年12美元。

## Route53 Records TTL(Time To Live)

TTL: Time To Live 持續存活時間，提示發出DNS請求的電腦，這個DNS查詢應該要在該客戶電腦保存多久。

* 短TTL: 假設TTL只有一分鐘，你一旦變更網址，一分鐘內客戶重新向DNS發出請求時，網址就會刷新

    * 網址更新快
    
    * 價格昂貴，因為客戶會頻頻向DNS請求，帶來大量費用。

* 長TTL: 假設TTL為一天，則更新網址後，客戶可能要一天後才會察覺。

    * 網址更新慢

    * 便宜

## Route53 NS紀錄與A或AAAA紀錄的差異

假設我們的網址為`example.com`

有子網域`cool1.example.com`與`cool2.example.com`

* NS與SOA紀錄: 通常用在Domain Name上頭，也就是`example.com`。但僅有NS與SOA紀錄時，是無法將網頁導向特定IP的，還要有下方的A或者AAAA紀錄將該網址的子網域導向特定IP。

* A或者AAAA紀錄: 可以將`example.com`下的子網域`cool1.example.com`與`cool2.example.com`，導向不同的IP位址。

## 測試網域是否註冊成功的指令

下列兩個指令在安裝後都可以查詢自己的網址是否對應到正確IP。

```
nslookup
```

與

```
dig
```

## Route53 中的 CNAME 與 Alias

兩者都是網址的別名，也就是說當你有一個網址時，你可以讓另外兩三個網址都導向這個網址。

不過也存在略為不同之處，例如: Alias 是免費的，CNAME不是，下方會有更詳細的說明。

* CNAME

    例如:`www.example.com`增加一個別名`abc.example.com`
    
    * 不可以用根網址轉址，例如: 可以用`www.example.com`轉址，但不可以轉到`example.com`因為它屬於Root Domain。

    * 額外付費。

    * 可以直接用在EC2實體轉址。

* Alias

    * 可以進行網址轉換，如:`www.example.com`增加一個別名`abc.example.com`。

    * 可以轉換到根網址Root Domain，如`www.example.com`增加一個別名`example.com`。

    * 免費。

    * 僅能連接到非EC2的AWS服務，普遍來說如果有多個實體，建議連接到:
        * 各種ELB類型的服務如:ALB
        * 靜態網站的CloudFront
        * 一整組的網站服務Beanstalk
        * API閘道Amazon API Gateway
        * 儲存空間S3 Website
        * 私有網路站點VPC interface Endpoints
        * 連線加速服務Global Accelerator
        * 同一個Hostzone下的Route53服務。

## Route53 Health Check

網站健康檢查器，可以自訂要檢查哪些你所擁有的IP位址上的網站，如果該網站失效，它會讓DNS自動挑選健康狀態良好的IP位址，作為DNS回應回饋給用戶。

以下為Health Check可以監控的目標:

* 網站與線上應用程式

* 其他的Health Check: 當某個Health Check報錯時，可以依照規則也跟著報錯，例如:監控3個IP的健康檢查器，同時報告失效時，DNS改變路徑。

* CloudWatch Alarms: 如果我們要監控的目標在VPC內，健康檢查器無法觸及，所以就可以檢查CloudWatch Alarms，如果CloudWatch Alarms報告VPC內的服務失效，就可以做出應變策略。

  可以應用的範圍如下:
  
  * 監控RDS
  * DynamoDB
  * 其他自訂監控指標

除此之外還有一些特性:

* 全球有15個Health Checker，同時檢查網站的可到達性。
* 預設30秒檢查一次，如果檢查頻率更高，價格更貴。
* 大於18%的Health Checker判定網站健康，則視為健康。
* 回應狀態碼2XX~3XX代表狀態健康。
* 可檢查前5120 Bytes。

其中有一個功能
* Caculated Health Checks
  * 可以同時監控多個Health Checker
  * 可以設置AND, OR, NOT 功能。
  * 如: 網站1 AND 網站2 同時失效時，Caculated Health Checks 回報 Unhealth。

## Route53 Routing Policies

DNS是可以選擇回應策略的，例如你希望將網址轉換的IP平均分散到三個IP位址上頭，這是可以的。

但是這不能完全替代Load Balancer，因為如果一個用戶真的執意要以一個特定的IP連上你擁有的伺服器，DNS是會被繞過去的。

但是對於一般正常使用的用戶來說，可以軟性的將負載分散到不同IP上。

以下為幾種不同的DNS Routing Policies:

* Simple
    最簡單的DNS方案，一個網址通常對應一個IP，但是如果執意要對應多個IP，則會隨機將網址對應到不同IP。
    
    * 沒有Health Check，無法確認主機健康狀態。
    
* Weighted
    以不同的百分比，將同一個網址導向不同的IP。例如:有三台主機，可以非配分別為
    
    * 主機1的IP:45%
    * 主機2的IP:45%
    * 主機3的IP:10%

    雖說主機3的權重比較小，但還是有機會將請求傳送到主機3。
    * 可附加Health Check，可以避開失效的主機。
    
* Latency
    
    挑選離用戶網路延遲最短的主機IP回傳給用戶。
    
    * 可附加Health Check，可以避開失效的主機。

* Failover
    
    原本的伺服器IP以外，多建立一個備用伺服器IP。當原本的伺服器失效，就會自動轉移到替代伺服器。
    
    可能需要在該伺服器上頭附加Health Check才可奏效。
    
    * Primary: 主要伺服器，一般情況運作該伺服器。
    * Secondary(Disastar Recovery): 次要伺服器，當主伺服器失效時，會自動移轉到備用伺服器。主伺服器復原時，則會將網址連接回主伺服器。

* Geolocation

    可以在同樣的網址下，設置以客戶離伺服器的地理位置距離，所分配的不同伺服器。
    
    例如同一個網址，在亞洲的人連到亞洲伺服器，歐洲人則連到歐洲伺服器。
    
* Geoproximity

    這種路由方式類似上方的地理位置路由，但是可以手動擴大某個區域的大小。
    
    例如：原本印度的某處被劃分在亞洲，但是我們將歐洲的Bias +30 這時候由於歐洲的劃分位置擴大，所以印度可能會被劃分為歐洲。
    
* Traffic flow

    用來編輯DNS流量的服務，可以建立如Geoproximity的複雜流量規則。不過複雜的流DNS設置通常是昂貴的，一個月甚至會收取高達1500台幣的費用。
    
* Multi-Value

    有Health Check的一般DNS路由。在dig或者nslookup下會可以一次跳出網址對應的數個可供選擇的IP。
    
    當某一個IP的伺服器不健康時，則會自動停止DNS路由。


## 用第三方的DNS供應商連接到Route53

由於Domain Registrar可以註冊網址的供應商，不等同有著完整多樣化功能的Route53這種DNS Service。

所以當要同時使用Route53與更便宜的DNS網址供應商時，可以採取以下步驟:

1. Route53 中建立 Hosted Zone
2. 將第三方 DNS 的 NS 紀錄導向 Route53 的 Name Servers 。

# Elastic Beanstalk

涵蓋一整個網站需要的AWS服務組合包，捆包出租 EC2(伺服器), ELB(負載平衡), Health Check(健康檢查器), Elastic IP, ASG(自動擴展), Route53 ... 等等。

並且會將架構組合好，但每個細節仍然可以自己管理，建立時也可以自訂。

由於多數的網站架構都差不多，所以一般的網站架構用 Elastic Beanstalk 就可以組合出一個網站了。

## Elastic Beanstalk 是個免費整合服務

雖然整合免費，但裡頭的實體與服務都要付錢。

## Elastic Beanstalk 的部份

* Application
    * Beanstalk中的環境, 版本, 設置
* Application Version
    * 客戶的程式碼的版本控制
* Enviroment
    * 應用程式的版本與該版本使用的環境設置，一次只能運行一個版本。

## Elastic Beanstalk 支持的程式語言

* Go
* Java
* Java Tomcat
* .Net Core Linux
* .Net
* Node.js
* PHP
* Python
* Ruby
* Packer Builder
* Single-container docker
* Multi-container docker
* Preconfig Docker

## Elastic Beanstalk 中的 Web server Tier 與 Worker Tier

* Web server Tier
    * ELB+多AZ的ASG的EC2。
* Worker server Tier
    * ELB+多AZ的SQS Queue。

## Elastic Beanstalk 節約費用的方法

* 可以使用長期的主機預約，如: 1年到3年期。可以節省部份的費用。

## 共享 Session 與 Token 的正確方法

* 應該儲存在
    * EFS
    * Amazon ElastiCache(如: Redis) 儲存 Session。
    * 加密後儲存在用戶Cookie

* 可能的話不要儲存在EBS也就是虛擬機中的本機儲存，因為如果ELB把用戶分配到不同伺服器時，用戶可能就會直接被登出或者遺失資料。

## Golden AMI 可以快速啟動使用的虛擬機映像

Golden AMI 可以把預先安裝配置好所有軟體服務的虛擬機映像檔 Image，可以立刻開機立刻使用。不用在啟動虛擬機後花漫長的時間安裝編譯套件，最後才能完成自動水平擴展。

# S3

S3是一個類似雲端硬碟的AWS儲存服務。

S3可以:

* 放置靜態網頁公大家瀏覽
* 放置圖片
* 儲存私有檔案，並且設置IAM以供特定的使用者使用。

## S3的常見名詞

* Bucket
    * 桶子，基本上可以當成資料夾的意思。
    * 設定名稱時，不能與任何其他人設置的Bucket同樣名稱。
    * 要設置儲存的物理區域Region
    * 名稱要小寫英文, 無底線, 3-64個字元, 不能是IP。
    * Versioning:
        Bucket 這一層要決定裡頭的 Object 是否需要 Versioning (版本控制) 。
        * 可以復原過去版本的Object檔案。
        * 沒有啟用版本控制之前，Version ID 為 null。
        * Suspending Versioning: 不會將新的檔案加入版本控制，但也不會刪除過去的版本。
        * 
* Object
    * 檔案，必須裝在桶子裡頭。
    * key:
        可以存取桶子的路徑。
        * s3://桶子名稱/檔案名稱
        * s3://桶子名稱前半段/桶子名稱後半段/檔案名稱
    * 雖然看起來很類似資料夾，但不是資料夾。
    * 單一檔案最大尺寸5TB。
    * 假如上傳的檔案大小超過5GB，就必須使用多部份上傳 (multi-part upload)
    * Metadata: 可以附加檔案的額外訊息，如:版本，說明。
    * Tags: 可以用Unicode字元，來替檔案上標籤，如某些一批圖檔上可以都上標籤 "水果" 。
    * Version: 版本號。

## S3 Stroage Class (儲存等級)

* S3 Standard
    * 存取速度快，但是最貴。
* S3 Intelligent-Tiering:
    根據存取頻率自動將資料移至最具成本效益的存取方案。
    * 經常、不常和封存即時存取層具有與 S3 Standard 相同的低延遲和高輸送量效能。
    * 不常存取方案最多可節省 40% 的儲存成本。
* S3 Standard-IA
    * IA 適用於不常存取但需要在必要時進行快速存取的資料。為傳輸中資料提供 SSL 支援以及提供靜態資料加密。
* S3 One Zone-IA
    * IA 適用於不常存取但需要在必要時進行快速存取的資料。其他 S3 儲存類別會將資料存放到至少三個可用區域 (AZ)，但 S3 單區域 – IA 不一樣，它會將資料存放到單一 AZ 中，而且成本較 S3 標準 – IA 減少 20%。
* S3 Glacier Instant Retrieval
    * 可為很少存取且需要在幾毫秒內擷取的長期資料提供最低成本的儲存。當您的資料每季度存取一次時，請使用 S3 Glacier Instant Retrieval，相較於使用 S3 Standard-Infrequent Access (S3 Standard-IA) 儲存類別，您最多可節省 68% 的儲存成本。
* S3 Glacier Flexible Retrieval
    * 針對每年存取 1-2 次且非同步擷取的封存資料提供低成本儲存，成本最多可降低 10% (相較於 S3 Glacier Instant Retrieval)。
* S3 Glacier Deep Archive
    * 最低成本儲存類別，支援長期保留和數位保留一年存取一或兩次的資料。它專為客戶而設計的 – 特別是那些受到高度監管之產業中的客戶，例如金融服務，醫療保健和公共部門 – 其資料集需要保留 7 到 10 年或更長時間，以符合法規合規要求。

## S3 的加密

S3 提供數種加密種類，以 AES-256 為加密演算法。

* SSE-S3
    * 加密檔案，並且由AWS自動管理Keys，所以用戶甚至不會注意到。
    * 用AWS API 上傳的話，需要在 HTTP Request header 加上  **"x-amz-server-side-encryption":"AES256"** 來要求上傳後的加密。
* SSE-KMS
    * 以AWS Key Management Service (KMS) 進行鑰匙管理。
    * 用AWS API 上傳的話，需要在 HTTP Request header 加上  **"x-amz-server-side-encryption":"aws:kms"** 來要求上傳後的加密。
* SSE-C
    * 自己上傳AES金鑰，AWS不會幫你保存，所以記得自己保存好金鑰。
    * 由於要傳遞鑰匙，所以強制使用HTTPS。
* Client Side Encryption
    * 客戶端自己用 S3 Encryption SDK 加密後上傳。

## S3 安全設置

* 使用者為基礎
    * 可以到IAM設置允許某些使用者可以存取S3。
* 資源為基礎(Resource base)
    * Bucket Policies: S3 console 中選擇使否可以跨帳號存取。以Json格式定義，Allow/Deny為控制選項。
    * Object Access Control List: 更加細緻的操作，可能是決定某個檔案是否可以被某些用戶存取。
    * Bucket Access Control List: 以Bucket為單位。
    * 建議關閉公共存取。
    * 可以將整個S3放入VPC中。
    * 可以將一個S3 bucket 存取的紀錄Log放入另外一個 S3 bucket，也可用Athena來分析這些Log。
    * 對S3的API呼叫，可以放入AWS CloudTrail。
    * 可以使用者設置刪除檔案時採取MFA(雙因子認證)。
    * Pre-Signed URL: 可以短時間存取S3資源的URL。
    * Policy用ARN(Amazon Resource Name， AWS 資源中獨一無二的名字)來定義要指定哪一個物件。

 ## S3 網頁
 
 S3 服務可以運作靜態網頁，將網頁傳上S3後即可。
 
 1. 在Bucket中設置。
 2. 上傳 index.html，與其他的圖片 JS ,CSS等。
 3. 上傳 error.html，該頁面會在網頁找不到時顯示。
 4. 在Policy中開啟權限，讓所有使用者都可以閱讀。
 
 網址為
```
 bucket名稱.s3-website-AWS區域.amazonaws.com
 ```
 
 ## S3 CORS (跨來源資源共用)

 ### CORS 是啥？

 假如你的網站需要引用來自別人的網站的圖片。(或者你的另個網址不同的網站。)

 如果你從你的網站HTML或後端發送Request去取他的圖片，對方伺服器沒有同意CORS，就會失敗。

 所以，CORS意味著可以跨網站，或者跨主機IP來請求資源或呼叫API。

 ### CORS Header

 伺服器在回應請求時，會夾帶一個Header，代表已經同意該網站的HTTP請求了。

 ```
Access-Control-Allow-Origin: 允許的網站位址
 ```

### S3中的使用方式

在S3中允許CORS，就可以讓別人的網頁來存取我們S3中的內容。

甚至另外一個S3靜態網頁，來存取我們S3中的內容。

* 記得在建立Bucket的時候設置Static Website enable。
* 允許CORS。

## S3 一致性模型(Consistency Model)

* Strong Consistency
    強一致性，當一個檔案在寫入完成時，所有的讀取暫停或者中止，直到最新版本的檔案上傳完成。再給讀取者使用最新版本的。
    這個好處意味著，任何時刻下載到的檔案版本都是最新的。

    * 這是免費服務。
    * 不會有太大效能衝擊，因為檔案上傳完成到S3更新，只有一瞬間。

## S3 MFA 刪除

S3 可以設置透過手機認證來保護物件，防止誤刪或者惡意刪除。

* 只有Root用戶可以設置。

* 可以設置
    * 刪除特定版本的S3物件。
    * 凍結版本時。
* 這些操作不需要MFA
    * 啟動版本紀錄
    * 監聽版本的刪除

* 目前只能透過CLI設置。

## S3 的預設加密

如果在Plicy裡頭設置 "force encryption" 這樣在使用API PUT S3 物件時，如果沒有加上要求加密的Header，就會失敗。

在Bucket設定加入"default encryption"來解決上傳時需要確認加密方式的問題，這樣會按照加密政策自動加密檔案。

## S3 中的 Log

* 請將Log放入另一個S3中，否則會產生Log迴圈，Log加入時的動作引發新Log產生，產生巨量費用。
* 記錄下來的Log可以交給 AWS Athena 服務分析。

## S3 Replication (複製品，備份用)

* 必須啟動版本控制。
* Cross Region Replication(CRR): 跨區域複製，低延遲，可以跨帳號，用於備份或者加速存取。
* Same Region Replication(SRR): 同區域複製，用於將數個Log聚合，即時備份，或者用於生產的程式與開發中的程式的資料複製。
* 非同步
* 需要給予適合的IAM權限。

其他特性:

* 沒有特別設置時，只有新加入的物件才會被複製，舊的物件則不會被複製。
* S3 Batch Replication 可以將已經存在的舊檔案一起進行複製。
* 特別設置時可以複製版本控制中的刪除標籤，但是檔案仍然存在，不能把真實的刪除狀態複製，防止惡意刪除或者誤刪。
* 不可以A桶複製到B桶，B桶複製到C桶。這稱為"Chaining of Replication"

## S3 pre-signed URLs

可以生成一組暫時的URL網址，讓別人或者指定的AWS用戶下載或者上傳資源。

* 下載: 可以用SDK與CLI來生成URL。
* 上傳: 僅能用SDK，難度較高。
* 預設到其實時間為60分鐘。
* 生成URL的用戶對於S3資源的權限，會繼承到URL的使用者。如果URL用戶只能讀取該S3的資源，那拿到URL的人也僅能讀取。
例如:
* 允許登入的用戶可以下載某些私人專有的內容。
* 允許動態生成URL讓某些用戶下載內容。
* 暫時允許某些用戶上傳檔案。

## S3 Lifecycle Rules

* 可以隨著時間把目前不會用到的檔案，移轉到比較便宜儲存區域。
* 一般會啟動S3版本控制，把舊版本或者刪除的檔案移轉到便宜的區域。
* 從便宜的長期儲存區是無法自動移轉回來的，必須手動下載後作為新版本。

## S3 Analytics - Storage Class Analysis

可以分析，需要設置多常的時間把物件從Standard 移轉到 Standard IA 。也就是 Lifecycle 設置。

* 首次啟動需要24~48小時

* 要跟 Lifecycle一起設置，並且根據回報決定要設置如何的 Lifecycle。

## S3 Multipart Upload

將檔案切成幾小份**平行**上傳，也就是說當本地網速不是瓶頸時，甚至可以比較快。

* 當檔案大於 100 MB 建議用此方法。

* 當檔案大於 5 GB 一定要用此方法。

## S3 Transfer Acceleration

S3 傳輸加速器，可以付費透過 AWS 私有網路專線加速 S3 檔案傳輸。

## S3 Bytes-Range-Fetchs

平行的指定檔案的某一部份進行下載。

 例如:

 我們的檔案有3個Bytes。

 我們可以開啟三個連線，

 分別下載第1, 2, 3 個 bytes。

 這樣可以達到更快的速度。

## S3 Select

如果我們要查詢S3某個檔案的內容時，一定要把檔案整個下載來嗎？

如果我們要找尋的檔案內容如下:

***某個檔案.json***
```json

{
    "姓名":"小明",
    "年齡":30
}
```

或者

***某個檔案.csv***
```csv
姓名, 年齡
小明, 30
```

我們可以用 S3 Select，並且使用SQL語法查詢檔案內容，但是僅限以下的檔案格式:

* CSV
* JSON
* Apache Parquet
*  GZIP 或 BZIP2 壓縮的JSON與CSV檔案

操作時使用:

* AWS CLS
* QWS API

優點:

* 有效減少網路傳輸費用

## S3 Event Notification

當發生以下事件時驅動某個動作:

* 新增S3檔案
* 刪除S3檔案
* 修改S3檔案
* 查詢S3檔案

可以觸發的事件有:

* SNS
* Lamdba
* SQS
* 更多服務...

要透過 *** Amazon Event Bridge *** 來將事件轉送到各種服務。

例如:
    當用戶頭像上傳時，可以觸發S3事件，立刻生成頭像縮圖。

Amazon Event Bridge的功能有:

* Advance filtering options: JSON 格式限制某些特定事件傳達。如限定某些metadata, name, 檔案大小。
* 可用事件觸發多種服務

## S3 - Requester Pays

一般而言網路傳輸的費用是由 S3 的持有者來支付。

Requester Pays 的傳輸費用則是由下載你的檔案的 AWS 用戶支付。

# Amazon Athena

可以分析 S3 中的:

* CSV
* JSON
* ORC
* Avro
* Parquet

費用:

* 每　TB　$5 美金

特點:

* SQL語法
* Serverless服務
* 分析完畢後傳遞到 Amazon Quick Sight 進行可視化的儀表板展示。

使用時機:

    可以將各種服務的事件儲存，ELB的Log, CloudTrail, ELB Log, VPC 流量。

## S3 Glacier Vault Lock

如果今天要有一間公司來保證你儲存的資料沒有被更改，那AWS是一個選項。

該服務可以確保存入Glacier的檔案不可能被更改。

屬於WORM(write one read more)儲存一次，讀取多次的模型。

## S3 Object Lock

鎖定S3檔案不會被更改

屬於WORM(write one read more)儲存一次，讀取多次的模型。

* Object Retention 物件的保留
    * Retention Period: 指定物件保留時間。
    * Legal Hold: 同樣保留物件不會被更改，但是沒有所謂無法更改的逾期時間，也就是永遠無法被更改。
* Model 模式
    * Govermance Mode: 不可覆蓋或刪除資料，正常情況下也無法修改該設定，確保合約等關鍵資料不會被變更。
    * Compliance Mode: 不可以被覆蓋與刪除，不可變更的狀態不可以調整，甚至連 AWS Root 帳號都不行。不可變更的時間無法提前結束。
 

# IAM

IAM (Identity and Access Management，識別與存取管理) 是 AWS 中用來定義某個用戶，是否有權限進行某些操作的權限設定。

* Roles(角色)
    IAM 中如果我要開啟某群人有管理S3儲存庫的權限，這時候我可以創造一個Role，稱為"S3 管理員"，然後將這個Role賦予給需要管理S3的人們。

    每個Role底下可以有數個Police，以"S3管理員"為例，他們有:

    * 新增S3物件
    * 刪除S3物件
    * 列出存在的S3物件

    上述的Police，而每個Police都可以針對某個 AWS 中的物件與服務 (要指定資源的名字，也就是ARN)　進行細部的調整。

    * 其實有很多預設的Role可以供選擇。
    * Policy 不能和預設的Role衝突，例如同時允許和拒絕存取S3。

* Policy

    AWS 中可以賦予每個Role角色的政策

    * 指定某個服務或Bucket資料夾或者檔案的存取權限。
    * 建議用 Policy Genetator 生成。
    * 可以用免費的 IAM Policy Simulator 來檢查Policy是否與預設的Role 衝突。

## EC2 實體如何知道自己所擁有的IAM Role ?

由於有的帳戶操作功能可以由 AWS EC2 實體來完成，例如新增一個S3或新增另一個EC2, 存取S3中的物件等。

所以有時候會賦予EC2一個自己的Role。

* EC2實體知道自己的Role角色名稱，但是不知道細節的Policy。
* 可以在AWS的內網，也就是CloudShell或者其他AWS CLI工具登入查看。

查看方式

```bash
curl  http://實體的VPC內網IP/lastest/meta-data/iam/security-credentials/Role名稱
```

# AWS SDK (AWS標準開發工具)

* 可以用各種程式語言來購買與建構 AWS 服務的程式碼套件。 支援語言有:
    * java
    * .NET
    * Node.js
    * PHP
    * Python
    * Go
    * Ruby
    * C++

* 當我們使用 DynamoDB 這類高度 AWS 自訂的資料庫時，必須使用 SDK 。

* AWS CLI 也是用 AWS Python SDK 的 Boto3 寫成的。

# Cloud Front

一種稱為CDN (Content Deliver Network) 的快取服務，可以在鄰近用戶的地方，把網頁之前傳輸過的東西保留一份有存在時效的備份。如果該地區有其他使用者，則可以快速的取得檔案，不用大老遠的跑到伺服器要檔案。

* 適合靜態網頁

* 用於 AWS EC2 動態網頁也不是不行，但是功能會比較像是橋接 VPC 私有網路中的 EC2 與公共網路的橋樑。

* 全球有 216 個左右的節點。

* 自帶 AWS WAF 與 AWS shield 可以預防 DDos 與其他攻擊。

* 可以讓內網 VPC 服務與外網溝通。

## Cloud Front 與 S3 bucket

* 可以將內容快取在離用戶較近的位置
* 可以用 OAI (Origin Access Identity) 提供 Cloud Front 額外的安全。用戶無法直接使用 S3 網址存取物件，只能透過 Cloud Front。
* 可以作為一個存取S3 bucket 的入口。


## Cloud Front 可配合的 HTTP 服務:

* ALB
* EC2
* S3 Website
* 任何 HTTP 後端

## CloudFront Signed URL/Cookie

當你有個希望特定的用戶才能進行下載的S3檔案連結時，這個服務可以派上用場。

CloudFront可以建立特定的URL與Cookie允許存取躲在CDN後頭的S3資源。

### CloudFront Signed URL/Cookie 可以使用的 Policy

* 添加URL連接逾期時間。
* 允許特定的IP範圍，才能存取此檔案。
* Trusted Signer(可指定特定的AWS帳號)。

### CloudFront Signed URL/Cookie可存取範圍的差異

* Signed URL
    分別存取單一的檔案，例如：單一的電影檔案，或者一個音樂mp3檔案。
* Signed Cookie
    有這個Cookie時，一次可以存取多個檔案。
    
## CloudFront 價格

CloudFront 的 Edge location 分散於全世界，分於散播資源。

不同的資料流出不同地區的Edge location需要支付價格不同的網路費。

### Price Class 不同的價格等級

1. Price Class All:
    所有區域的CDN都能使用，擁有最佳效能。
3. Price Class 200:
    除了最貴的區域外，其他區域都有。
5. Price Class 100:
    只有最便宜的一些區域。
    
## CloudFront - Multiple Origin

可以將從一個CDN網域，導向不同的內容。

例如:

```
CloudFront網址/api
```

導向某個ALB與EC2的組合。

```
CloudFront網址/file
```

導向某個S3 bucket。

同一個網址，不同的路徑，但是可以導向不同的 AWS 服務。

## CloudFront Origin Group

可以將一個CloudFront網址導向一個主要的EC2 or S3，和一個次要的EC2 or S3資源。

當主要的EC2 or S3資源失效時，就可以自動切換到次要資源。

## CloudFront Field-Level Encryption

HTTPS 協定為基礎額外的加密保護。

加設要傳遞信用卡密碼，當POST資料傳遞到EC2伺服器之前，都無法解開，而唯一的私鑰被放在EC2主機，也就是需要接收資料的伺服器。

就算網路傳輸的中間過程被破解了，破解者也沒有最終伺服器所擁有的私鑰。

# AWS Global Accelerator

使用AWS私有網路線路，來加速AWS服務在網路的傳遞。

## 論Unicast IP 與 Anycast IP

* Unicast IP: 常見情況，一個伺服器有一個IP。
* Anycast IP: 多個網路上的伺服器有同一個IP。

Anycast IP 可以讓使用者自動選擇距離更近的Global Accelerator節點連上。

## AWS Global Accelerator的特色

* AWS 私有網路
* 全球性的加速應用程式連線速度
* Heath Check 檢查健康程度，並且可以接受一個EC2失效時導向另一個EC2。
* 提供兩個外部IP，可以加入白名單來增加安全性。
* 自帶 AWS Sheild 的 DDos 保護。

# AWS Global Accelerator 與 CloudFront 的比較

* CloudFront
    * 加速可以快取的內容。
    * 動態網頁內容。
    * 主要用在HTTP協定。
* Global Accelerator
    * 可以加速所有的TCP, UDP用途較CloudFront廣泛。
    * 通過最接近的本地 AWS 專線。
    * 遊戲與聲音的UDP與IoT物連網的MQTT也可以通行。
    * 也是適合使用靜態IP的HTTP服務。
    * 快速的Heath Check 與網路和伺服器的故障轉移。

# AWS Snow Family 概觀

可以租回家的AWS電腦。

* Data migration 資料遷移
    * Snowcone
    * Snowball Edge
    * Snowmobile
* Edge Computing 邊緣運算
    * Snowcone
    * Snowball Edge

## Snowcone

一台可以儲存與運算的小型主機，支付每次寄回去的費用。

* 輕量化。
* 8 TB。
* 自己提供電線與電池。
* DataSync agent: 連網路後可以資料自動同步的程式，已經預裝好了。

## Snowball Edge

一台可以儲存與運算的中型主機，支付每次寄回去的費用。

* Snowball Edge Storage Optimized
    * 80 TB HDD 容量，S3 儲存區塊。
* Snowball Edge Compute Optimized
    * 42 TB HDD 容量，S3 儲存區塊。

* 最多可以到15個儲存節點。

## AWS Snowmobile

* 1 EB = 1000 PB = 1000000TBs
* 每個 Snowmobile 有 100 PB 的容量。
* 溫度控制, GPS, 24/7 影像監控。
* 傳輸超過 10 PB 的資料建議使用。
* 可以加到EB

## Snow Family 資料的傳遞流程

1. 上AWS租借 Snowball
2. 安裝 Snowball Client/ AWS OpsHub 到你的伺服器。
3. Snowball 連接到你的伺服器，然後將檔案從伺服器複製到 Snowball 。
4. 寄 Snowball 回 AWS。
5. 資料會被 AWS 上傳 S3 。
6. Snowball 會被徹底清空。

## Snow Family - Edge Computing

以下皆可運作 EC2 實體與 AWS Lambda function，使用 AWS IoT Greengrass。

* 租用1年或者3年都有降價方案。

實體類別:

* Snowcone
    * 2CPUs
    * 4GB RAM
    * 可以有線與無線連線
    * USB-C 電源線 或者 可以選的電池
* Snowball Edge Storage Optimized
    * 40 CPUs
    * 80 GB RAM
    * 80 TB HDD 容量，S3 儲存區塊。
* Snowball Edge Compute Optimized
    * 52 CPUs
    * 208GB RAM
    * 可以選的 GPU
    * 42 TB HDD 容量，S3 儲存區塊。

## AWS OpsHub

一個可以裝在自己電腦或筆電上的，可以操作 Snow Family 的 GUI 圖形程式。

* 解鎖或者配置單一或者 Snow Family 叢集。
* 傳輸檔案。
* 管理 Snow Family 。
* 監控各項指標。
* 在 Snow Family 上運作 EC2, AWS DataSync, NFS 等。

# AWS Macie

深度學習，檢查是否有敏感資料外洩。
可以分析S3，然後將結果傳回 Cload Watch Event bridge。

# Cloud HSM

Cloud HSM 使用硬體加密。(KMS 使用軟體加密。)

* FIPS I 40-2 Level 3 保障。
* 支持 SSL/TLS 鑰匙。
* Redshift 保障。
* 多個AZ

# AWS Shield

防禦 DDos ，包含

* SYN/UDP flooding
* 網路監控

## Advance 方案

* 每個組織，$3000 美元一個月。
* 涵蓋Layer 7
* 防禦範圍更廣。

# AWS GuardDuty

用ML偵測容器和虛擬機受到的威脅。

可用來偵測的內如下:

* CloudTrail Event Logs
* VPC Flow Logs
* DNS Logs
* K8S Audit Logs

例如: K8S 容器如果被入侵，就可以檢測到。

檢測流程大概是這樣:

AWS GuardDuty -> CloudWatch Event -> 觸發 AWS Lamdba 與 SNS 。


# Amazon Inspector

虛擬機與網路的安全偵測

* 檢查非預期的流量。
* 檢查運作中的 OS 是否有安全漏洞。
* 檢查上傳的容器是否有漏洞。

可以用來觸發

* Security Hub
* CloudWatch Event Bridge -> 然後接著觸發SNS發email等。

