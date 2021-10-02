---
title: "suricata入侵防禦系統(IPS)"
date: 2021-07-19T09:00:49+08:00
draft: true
tags: ["secure","cc","ddos"]
featured_image: "/secure.jpg"
---

# 作者
阿維

# 環境
拜託，使用Ubuntu吧!  
不然要從頭編譯suricata。  
雖然可以，但是比較麻煩。  

# 安裝

安裝PPA

```
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
```

安裝suricata與json解析器jq

```
sudo apt-get install suricata jq
```

檢查安裝狀態
```
sudo suricata --build-info
```

檢查執行狀態，正常來說一安裝好自動啟動
```
sudo systemctl status suricata
```

# 基本配置

### 網路位址

確認自己的網路界面
```
ip addr
```
我們的網路界面是enp1s0
ip 是192.168.122.123

打開配置檔，路徑如下
```
sudo nano /etc/suricata/suricata.yaml
```
我們可以看到開頭有段ip範圍
```yaml
vars:
  # more specific is better for alert accuracy and performance
  address-groups:
    HOME_NET: "[192.168.0.0/16,10.0.0.0/8,172.16.0.0/12]"
```
考慮到我們的ip只有一個網段要處理所以改成
```yaml
vars:
  # more specific is better for alert accuracy and performance
  address-groups:
    HOME_NET: "[192.168.0.0/16]"
```

### 紀錄檔案

我們往下看可以看到紀錄檔的位置
```yaml
default-log-dir: /var/log/suricata/
```

接著是紀錄檔案的頻率
```yaml
# Global stats configuration
stats:
  #啟動檔案紀錄
  enabled: yes
  # The interval field (in seconds) controls the interval at
  # which stats are updated in the log.
  #紀錄頻率為8秒1次
  interval: 8
  # Add decode events to stats.
  #decoder-events: true
  # Decoder event prefix in stats. Has been 'decoder' before, but that leads
  # to missing events in the eve.stats records. See issue #2225.
  #decoder-events-prefix: "decoder.event"
  # Add stream events as stats.
  #stream-events: false
```

紀錄檔案的檔案名稱
```yaml
# Configure the type of alert (and other) logging you would like.
outputs:
  # 警報紀錄會存在fast.log檔案裡頭，類似snort
  - fast:
      enabled: yes
      filename: fast.log
      append: yes
```

### 更改af-packet的網路界面

我們剛剛說到我們的網路界面是enp1s0  
所以接著我們要更改af-packet的界面  

af-packet是啥呢？是linux的核心功能，類似接收來自網路的數據包的界面。  

原本是:
```yaml
af-packet:
  - interface: eth0
```
改成:
```yaml
af-packet:
  - interface: enp1s0  
```
底下pcap也順便改成
```yaml
pcap:
  - interface: enp1s0
```

# 更新規則集

### 更新規則集來源庫

更新規則集來源庫
```
sudo suricata-update update-sources
```

列出規則集的來源庫

```
suricata-update list-sources
```

同意來自某些來源庫的規則

```
sudo suricata-update enable-source 來源庫
```

例如:
```
sudo suricata-update enable-source et/open && \
sudo suricata-update enable-source oisf/trafficid && \
sudo suricata-update enable-source ptresearch/attackdetection && \
sudo suricata-update enable-source sslbl/ssl-fp-blacklist && \
sudo suricata-update enable-source sslbl/ja3-fingerprints && \
sudo suricata-update enable-source etnetera/aggressive && \
sudo suricata-update enable-source tgreen/hunting
```

### 將所有原本警告的規則集調整成徹底丟棄封包

如果沒這樣做，多數的危險行為還是會被放行，所以我們直接丟棄所有危險行為。

建立一個將警告轉換成丟棄封包的調整設定檔:
```
sudo touch /etc/suricata/modify.conf
```
編輯設定檔
```
sudo nano /etc/suricata/modify.conf
```
然後在這個設定檔裡頭輸入，這會將所有警告替代為直接的制止行動  
```
re:. ^alert drop
```

### 更新並且套用我們的調整1

```
----------
!!!警告!!!
更新規則集的時候，請關閉suricata
因為規則集中會有惡意程式的特徵
會被suricata自己阻擋掉，導致更新失敗!
----------
```

更新規則集
```
sudo suricata-update --modify-conf /etc/suricata/modify.conf
```

安裝位置在
```
/var/lib/suricata/rules/suricata.rules
```

### 更新並且套用我們的調整2

如果全部都阻擋，為你帶來了困擾，例如Tor不能用...啥的。  
那你可以不要將所有規則集合併

```
sudo suricata-update --modify-conf /etc/suricata/modify.conf --no-merge
```

然後進到規則集資料夾

```
/var/lib/suricata/rules/
```

然後將裡頭的

```
tor.rules
```
刪除

然後編輯設定檔:
```
sudo nano /etc/suricata/suricata.yaml
```
找到以下這段:
```
rule-files:
  - suricata.rules
```
指定引入你要的規則
```
rule-files:
  - r1.rules
  - r2.rules
...
```
這樣suricata才會讀所有設定檔，而不是單一個suricata.rules

### 重新啟動

重新啟動之後套用更新

```
sudo systemctl restart suricata
```

# 檢查紀錄檔

```
sudo tail /var/log/suricata/suricata.log
```

我們可以看到這行出現

```
<Notice> - all 4 packet processing threads, 4 management threads initialized, engine started.
```

代表正常執行

### 檢查8秒更新一次的log檔

```
sudo tail -f /var/log/suricata/stats.log
```
tail -f可以即時看到變化

### 檢查警報是否正常觸發

這裡有個測試用的規則，將會測試警告是否正確觸發

用tmux開啟兩個終端
一個打開，即時觀察警報狀態:
```
sudo tail -f /var/log/suricata/fast.log
```

一個觸發警報:
```
curl http://testmynids.org/uid/index.html
```

接著就能看到警報了

### 用漂亮的json格式看到警報

```
sudo tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'
```
這時候觸發警報就能看見漂亮的json格式顯示  
  
### 顯示所有統計數據(8秒一次那個):
```
sudo tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="stats")'
```

### 顯示內核捕捉的數據包數量
```
sudo tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="stats")|.stats.capture.kernel_packets'
```

# 真正將suricata變成IPS(入侵防禦系統)

由於suricata一開始被做成以service的型態運作的程式。  

而預設的suricata運作時並不是以入侵防禦系統(IPS)運作的，而是以入侵偵測系統(IDS)運作。  

真正遇到某種打擊時，也只會發出警告。  

所以這個時候，我們必須做出一些調整。  

但在那之前，我們要先了解Linux的一個核心功能，NFQUEUE。  

這個功能簡單來說就是，將網路流入的封包，外包給一般的程式進行檢查與調整。  

我們可以這樣理解:

```
網路 -> NFQUEUE -> 我們的電腦
```

但是有個很關鍵的問題是，當沒有任何程式在NFQUEUE中運作時，我們的電腦是沒辦法連上網的。  

所以接著我們的步驟是:

> 1.關掉預設的suricata service
> 2.啟動suricata在NFQUEUE中運作
> 3.將網路切換到NFQUEUE

步驟不能錯誤，否則會失去網路連線能力  

### 關閉預設作為service的suricata

```
sudo service suricata stop
```

### 啟動suricata在NFQUEUE中運作

參數q表示讓suricata在NFQUEUE中運作。  
參數0是因為NFQUEUE其實可以有好幾條通道，0代表第0條，也就是預設的通道。  
參數D代表背景運作。  
```
sudo suricata -q 0 -D
```

### 將網路切換到NFQUEUE

確保suricata正常運作之後，就能夠將網路切換到NFQUEUE。  

如果你想要過濾，從外網進到我們的電腦的網路流量，請輸入這個。  
```
sudo iptables -I INPUT -j NFQUEUE
```

如果你想過濾我們內網向外部流動的流量，請輸入這個。  
但是如果IPS誤判的時候，我們可能自己會被自己的IPS阻擋，無法將訊息傳出。甚至你打算對某些網站進行弱點掃描或是一些入侵模擬時，你會被自己擋住。  
如果你真的打算過濾自己，請輸入:

```
sudo iptables -I OUTPUT -j NFQUEU
```

### 檢查防火牆配置狀態

如果你發現網路還能用，恭喜你，應該成功了。  
你可以檢查一下iptables現在是否儲存著你剛剛的配置。  

```
sudo iptables -vnL
```

### 我的網路完全無法連上了

別擔心，我們可以簡單的重置iptables防火牆設定。  

```
sudo iptables -F
```

某些情況你的網路還是連不上，別擔心，重新開機即可。  

# 正確的關閉IPS

由於我們剛剛設置了NFQUEUE所以，如果我們要正確關閉IPS的話，要先關閉NFQUEUE。

### 清除防火牆規則

```
sudo iptables -F
```

### 關閉suricata

找尋suricata的PID
```
sudo ps -aux |grep suricata
```

關閉suricata的PID
```
sudo kill  suricata的PID
```

# suricata轉成IPS的真正解決方案

我們如果希望suricata可以用IPS的方式主動防禦威脅，但是又不用每次都手動啟動，就需要去更改服務檔案。

### 修改預設參數腳本

```
sudo nano /etc/default/suricata
```

這個腳本裡頭會定義suricata會用IDS(只有警告)或IPS(警告加防禦)  
來執行。  

<br>

將這段:
```
LISTENMODE=af-packet
```

改成這樣:
```
LISTENMODE=nfqueue
```

就能夠從IDS轉變成IPS了。  
這樣它就會在NFQUEUE中等待流量傳入。  

但是，我們仍需要在啟動腳本中設定，啟動時打開將流量轉送到NFQUEUE  

### 修改啟動腳本

```
sudo nano /etc/init.d/suricata
```

下列這段是關於service suricata start的啟動行為  


```bash

# See how we were called.
case "$1" in
  start)
       if [ -f $PIDFILE ]; then
           PID1=`cat $PIDFILE`
           if kill -0 "$PID1" 2>/dev/null; then
               echo "$NAME is already running with PID $PID1"
               exit 0
           else
               echo "Likely stale PID `cat $PIDFILE` with $PIDFILE exists, but process is not running!"
               echo "Removing stale PID file $PIDFILE"
               rm -f $PIDFILE
           fi
       fi
       check_run_dir
       echo -n "Starting suricata in $IDMODE mode..."
       $DAEMON $SURICATA_OPTIONS > /var/log/suricata/suricata-start.log  2>&1 &
       echo " done."
       ;;
```
按照以下指示插入兩行，改成:
```bash

# See how we were called.
case "$1" in
  start)
       if [ -f $PIDFILE ]; then
           PID1=`cat $PIDFILE`
           if kill -0 "$PID1" 2>/dev/null; then
               echo "$NAME is already running with PID $PID1"
               exit 0
           else
               echo "Likely stale PID `cat $PIDFILE` with $PIDFILE exists, but process is not running!"
               echo "Removing stale PID file $PIDFILE"
               rm -f $PIDFILE
           fi
       fi
       check_run_dir
       echo -n "Starting suricata in $IDMODE mode..."

       #mkdir if not exist(如果log資料夾不存在就建立它)
       mkdir -p /var/log/suricata/

       $DAEMON $SURICATA_OPTIONS > /var/log/suricata/suricata-start.log  2>&1 &

       #enable nfqueue(啟動nfqueue讓iptables防火牆將封保檢查工作外包給suricata)
       iptables -I INPUT -j NFQUEUE

       echo " done."
       ;;
```
### 修改關閉腳本

同一份文件下我們會看到關閉腳本  

關閉腳本原始的樣子是這樣  

```bash
  stop)
       echo -n "Stopping suricata: "
```
在 echo -n "Stop ...這段底下插入這個，為了在關閉IPS的時候確實將iptables網路回復原本狀態
```bash
  stop)
       echo -n "Stopping suricata: "
       #disable all NFQUEUE setting(關閉所有NFQUEUE)
       while true
       do
           sudo iptables  -D  INPUT -j NFQUEUE  > /dev/null 2>&1 || break
       done
```
然後重新載入deamon
```
sudo systemctl daemon-reload
```

如果你還有執行其他的NFQUEUE程式，那請修改上述腳本用更精準的方式關閉。  

例如:
指定0號queue啟動
```
iptables -A INPUT -j NFQUEUE --queue-num 0
```
指定0號queue關閉
```
iptables -D INPUT -j NFQUEUE --queue-num 0
```

# 我個人使用suricata的啟動與關閉腳本

<span style="color:red">這是我個人的作法，請不要未經評估貿然使用，造成損失並不負責(我自己是用的很開心)</span>  

啟動腳本  
suricata-guard  
```bash
#!/bin/bash
sudo mkdir /var/log/suricata/
sudo suricata -q 0 &
sudo iptables -I INPUT -j NFQUEUE
```

<br>

關閉腳本  
suricata-stop  

```bash
#!/bin/bash
sudo killall  sudo suricata -q 0
while true
do
    sudo iptables  -D  INPUT -j NFQUEUE  > /dev/null 2>&1 || break
done
```

<br>

防止本機被鎖定的規則(請加入suricata.yaml規則清單) 
 
```
pass ip 127.0.0.1 any <> 127.0.0.1 any (msg:"pass local"; sid:10001;)
pass tcp 127.0.0.1 any <> 127.0.0.1 any (msg:"pass local"; sid:10002;)
pass udp 127.0.0.1 any <> 127.0.0.1 any (msg:"pass local"; sid:10003;)
pass icmp 127.0.0.1 any <> 127.0.0.1 any (msg:"pass local"; sid:10004;)
```

