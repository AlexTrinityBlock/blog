---
title: "AppArmor研究_1"
date: 2021-06-16T10:01:49+08:00
draft: true
tags: ["secure","AppArmor","資安","auditd"]
featured_image: "/secure.jpg"
---
AppArmor 是一款附帶在Ubuntu linux裡頭的核心安全模組，是用來進行強制存取控制(MAC)的。  

假定我們今天運作著PHP網頁伺服器，而裡頭某個漏洞，這個時候駭客照理來說可以寫入某個檔案到我們的電腦中，不過如果我們設置了AppArmor，限定了Apache,PHP都只能存取特定的資料夾，這樣駭客就沒辦法利用這個寫入檔案的能力，來在其他/etc或是/bin動手腳。(至少，比較難以達成)  

我們正常時候，linux的權限由:  
某個使用者，是否能夠讀,寫,執行，來進行權限劃分。或者基於某個應用程式的capabilities(能力)來劃分。這種以使用者為中心的權限設定稱為DAC(discretionary access control)。  

而AppArmor的特色在於，他是以程式為權限劃分，例如：我的文字編輯器可以設置為，只能讀取寫入/home底下的檔案。這種權限劃分方式，稱為MAC(mandatory access control)。  

與AppArmor類似的有SElinux，不過AppArmor的授權條款是自由的GNU。  

AppArmor設定檔的位置在
```
/etc/apparmor.d/
```
而且設定檔有特別的命名規則，參考如下
我們要設定這個檔案的權限
```
/usr/bin/certspotter
```
我們的設定檔的名稱與路徑
```
/etc/apparmor.d/usr.bin.certspotter
```
## 檢查狀態
以下這個指令可以查看目前有哪些程式處於抱怨模式，哪些程式處於強制模式。
```
sudo apparmor_status
```
## 開始練習
我們以/usr/bin/certspotter為練習目標。  

安裝設定檔生成工具:
```
sudo apt install apparmor-easyprof apparmor-notify apparmor-utils
```
(安裝後aa-logprof程式可以讓我們更輕鬆的知道，哪些程式跨越權限，或被阻止存取。)  

安裝測試用的程式  
```
sudo apt install certspotter
```
## 生成certspotter的設定檔
由於從頭開始手打certspotter設定檔及其麻煩，所以我們可以用這個小工具生成設定檔。  
```
aa-easyprof /usr/bin/certspotter
```
這會產生一個設定檔的骨架，看起來向下面這個樣子:
```
# vim:syntax=apparmor
# AppArmor policy for certspotter
# ###AUTHOR###
# ###COPYRIGHT###
# ###COMMENT###

#include <tunables/global>

# No template variables specified

"/usr/bin/certspotter" {
#include <abstractions/base>

# No abstractions specified

# No policy groups specified

# No read paths specified

# No write paths specified
}
```
真正的把設定檔寫進硬碟
```
aa-easyprof /usr/bin/certspotter > usr.bin.certspotter
```
這個時候在目前的資料夾下頭會產生一個usr.bin.certspotter檔案  
我們將這個檔案移動到設定檔的資料夾裡頭  
```
sudo mv usr.bin.certspotter /etc/apparmor.d
```

## 將certspotter設定檔寫入kernel
```
sudo apparmor_parser -r /etc/apparmor.d/usr.bin.certspotter
```

## 執行certspotter
由於我們剛剛沒有給它存取任何檔案的權限，所以一旦它開始執行時，要讀寫任何檔案時會立即崩潰。  
```
certspotter
```
執行失敗
```
certspotter: /home/testuser/.certspotter/watchlist: open /home/testuser/.certspotter/watchlist permission denied
```
我們注意到這個程式試圖建立某種設定檔在/home/testuser/.certspotter/watchlist  
但是權限不足，這個就是AppArmor的效果。  

## 檢查log
一般來說，如果程式執行被阻擋，都會被記載在底下的這個位置
```
/var/log/syslog
```
(也可能是/var/log/syslog.1)  
但隨著不同發行版也會多少有不同  

由於kernel會限制AppArmor紀錄下拒絕紀錄的頻率。  
如果要避免這個情況發生，可以安裝一個稱為auditd的軟體

如果有裝，可能會將拒絕紀錄存在以下路徑  
```
/var/log/audit/audit.log 
```
可以嘗試找找看

如果不希望kernel限制AppArmor拒絕紀錄的頻率，可以調整設置。  
```
sudo sysctl -w kernel.printk_ratelimit=0
```

## 進階檢查log的方式

我們可以使用以下程式(如果沒有自行安裝)
```
aa-notify
```
它會根據syslog或audit.log找出AppArmor的拒絕紀錄。  

範例，檢查昨天的拒絕紀錄:
```
/usr/bin/aa-notify -s 1 -v
```
接著我們將用簡單的方式檢查log
```
aa-logpr
```

## 將certspotter從強制模式改為抱怨模式
抱怨模式只會留下紀錄，但是不會阻止該程式寫入允許範圍外的檔案。  
```
sudo aa-complain certspotter
```
然後再執行一次  
```
certspotter
```
我們在log裡頭發現了報錯，但是卻沒有在執行時被阻止
```
Feb 23 13:34:24 tutorials audit[18643]: AVC apparmor="ALLOWED" operation="recvmsg" profile="/usr/bin/certspotter" pid=18643 comm="certspotter" laddr=10.0.2.15 lport=46314 faddr=10.0.2.16 fport=443 family="inet" sock_type="stream" protocol=6 requested_mast="receive" denied_mask="receive"
```
上面的紀錄我們看見了，這個程式存取網路的事情被記錄下來，因為我們在規則裡頭沒有允許它存取網路。  

(...待續)
## 參考文件
https://discourse.ubuntu.com/t/how-to-create-an-apparmor-profile/13984?_ga=2.73797522.1282509034.1623824502-1665858849.1623824502
