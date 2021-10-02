---
title: "python網路程式02:udp協定與port"
date: 2021-04-29T22:15:44+08:00
draft: true
featured_image: "/python.jpg"
tags: ["python","network"]
---
本篇引用自Foundations of Python Network Programming一書 

# 1.port的用途
port其實可以看作在網路傳輸訊息上頭的一個小標籤  
用來區分同一個ip位址所使用的多項網路服務  
### (1)常見的well know port: 0~1023 port
分配給常見主流的服務，如http 80 port,httpd 443 port。  
### (2)註冊的port: 1024~49151 port
使用者可以跟系統註冊，並且用某些程式來運作在這些port上頭。  
### (3)隨機分配使用的port: 49152~65535 port
例如今天你打開瀏覽器，你的電腦會分配一個port讓你連上google的443 port。

# 2.用udp傳訊息給自己
使用方式:  
(1)打開一個終端開啟伺服器模式  
```bash
python3 main.py server
```
(2)打開一個終端開啟客戶模式  
```bash
python3 main.py client
```
server就會發出一個udp內容給client  

main.py代碼：
```python
import argparse, socket #引入解析術入參數的函數庫與socket函數庫
from datetime import datetime #引入時間函數庫

MAX_BYTES = 65535 #udp最大的Datagram（數據報）

#server端函數
def server(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)#建立socket物件實例，AF = Address Family，DGRAM=datagrams 數據報模式
    sock.bind(('127.0.0.1', port))#綁定本機網路與要接收的port
    print('Listening at {}'.format(sock.getsockname()))
    while True:
        data, address = sock.recvfrom(MAX_BYTES)#接收內容時會得到兩個數值（python的return可以兩個數值），接收的數據和數據來源位址
        text = data.decode('ascii')#將收到的數據以ascii解碼
        print('The client at {} says {!r}'.format(address, text))
        text = 'Your data was {} bytes long'.format(len(data))
        data = text.encode('ascii')#將要發送的文字轉成ascii格式
        sock.sendto(data, address)#發送回目標ip位址與port(那個address物件包含ip跟port)

#client端函數
def client(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)#建立socket物件實例，AF = Address Family，DGRAM=datagrams 數據報模式
    text = 'The time is {}'.format(datetime.now())#取得現在時間
    data = text.encode('ascii')#將要發送的文字轉成ascii格式
    sock.sendto(data, ('127.0.0.1', port))#發送回目標ip位址與port
    print('The OS assigned me the address {}'.format(sock.getsockname()))#取得作業系統目前所分配的port號
    data, address = sock.recvfrom(MAX_BYTES)  #接收回應內容
    text = data.decode('ascii')#將收到的數據以ascii解碼
    print('The server {} replied {!r}'.format(address, text))

if __name__ == '__main__':
    choices = {'client': client, 'server': server}#建立一個字典dictionary，字串的client,server對應到上頭的兩個client,server函數
    parser = argparse.ArgumentParser(description='Send and receive UDP locally')#描述
    parser.add_argument('role', choices=choices, help='which role to play')#參數名稱是role 是個兩個選項的選擇，對應到client,server函數
    parser.add_argument('-p', metavar='PORT', type=int, default=1060,#參數名稱是-p 型別是整數，沒有輸入的話預設1060 port
                        help='UDP port (default 1060)')
    args = parser.parse_args()#將傳入的參數，放入args物件變數中
    function = choices[args.role]#將server,client選擇的函數放入function物件中
    function(args.p)#執行function物件函數時輸入port

```

# 3.用上方代碼模擬簡單的中間人攻擊

### 伺服器方
```
python3 main.py server
```
這時候我們模擬在伺服器老舊，網路速度緩慢  
先按下

<kbd>ctrl</kbd> +<kbd> z </kbd>
暫停整個伺服器端程式運作

### 客戶方
```
python3 main.py client
```
客戶方這時顯示
作業系統分配給客戶端40831 port
```
The OS assigned me the address ('0.0.0.0', 40831)
```
假定客戶端發送了一個訊息，然後恰巧被攻擊者攔截

### 攻擊方
攻擊方知道客戶端的port是40831，所以從客戶ip的40831 port偽造伺服器回應
```python
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto('fine'.encode('ascii'), ('127.0.0.1', 40831))
```
### 客戶方收到攻擊者偽造的伺服器回應
```
The server ('127.0.0.1', 47265) replied 'fine'
```
注意到，其實客戶方稍加檢查就會知道，伺服器的ip跟port不是原本伺服器的ip與port
但沒有注意與驗證的時候，就可能上當

# 4.遠端udp需要顧慮的部份
這個範例中，當server沒有回應時，client會不斷重發請求，但是每次的請求會等待更多時間，因為頻繁的重發請求會引起網路壅塞。
```python
import argparse, random, socket, sys

MAX_BYTES = 65535

def server(interface, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)# DGRAM會傳出udp訊號
    sock.bind((interface, port))
    print('Listening at', sock.getsockname())
    while True: #持續接收來自client的內容
        data, address = sock.recvfrom(MAX_BYTES)#接收客戶端的來源ip port與內容
        if random.random() < 0.5: #為了模擬丟包，所以概率性的不回應客戶
            print('Pretending to drop packet from {}'.format(address))
            continue
        text = data.decode('ascii')#收到的訊號以ascii解碼
        print('The client at {} says {!r}'.format(address, text))
        message = 'Your data was {} bytes long'.format(len(data))
        sock.sendto(message.encode('ascii'), address)#傳送回應訊息

def client(hostname, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)# DGRAM會傳出udp訊號
    sock.connect((hostname, port))#連線connect到特定ip,port方便之後用send重發請求
    print('Client socket name is {}'.format(sock.getsockname()))

    delay = 0.1  # 等待秒
    text = 'This is another message'
    data = text.encode('ascii')
    while True:
        sock.send(data)
        print('Waiting up to {} seconds for a reply'.format(delay))
        sock.settimeout(delay)#設定sock.recv等待時間
        try:
            data = sock.recv(MAX_BYTES)
        except socket.timeout as exc:#捕捉socket.timeout訊號
            delay *= 2  # 把下次sock.recv等待時間延長
            if delay > 2.0:#如果等待時間大於2
                raise RuntimeError('I think the server is down') from exc #送出socket.timeout訊號與字串
        else:
            break   # 如果什麼都沒發生則離開while迴圈

    print('The server says {!r}'.format(data.decode('ascii')))

if __name__ == '__main__':
    choices = {'client': client, 'server': server}
    parser = argparse.ArgumentParser(description='Send and receive UDP,'
                                     ' pretending packets are often dropped')
    parser.add_argument('role', choices=choices, help='which role to take')
    parser.add_argument('host', help='interface the server listens at;'
                        ' host the client sends to')
    parser.add_argument('-p', metavar='PORT', type=int, default=1060,
                        help='UDP port (default 1060)')
    args = parser.parse_args()
    function = choices[args.role]
    function(args.host, args.p)
```

# 5.udp廣播

如果區域網路還有其他主機server開著同樣的port也會收到
```python
import argparse, socket

BUFSIZE = 65535

def server(interface, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((interface, port))
    print('Listening for datagrams at {}'.format(sock.getsockname()))
    while True:
        data, address = sock.recvfrom(BUFSIZE)
        text = data.decode('ascii')
        print('The client at {} says: {!r}'.format(address, text))

def client(network, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)#這一行來定義廣播
    text = 'Broadcast datagram!'
    sock.sendto(text.encode('ascii'), (network, port))

if __name__ == '__main__':
    choices = {'client': client, 'server': server}
    parser = argparse.ArgumentParser(description='Send, receive UDP broadcast')
    parser.add_argument('role', choices=choices, help='which role to take')
    parser.add_argument('host', help='interface the server listens at;'
                        ' network the client sends to')
    parser.add_argument('-p', metavar='port', type=int, default=1060,
                        help='UDP port (default 1060)')
    args = parser.parse_args()
    function = choices[args.role]
    function(args.host, args.p)
```
# MTU最大傳輸單元
網路傳輸時，允許把資料分成許多小片，但是每一片段的大小不能太大，如果太大就會無法傳送。這個最大的值稱為MTU(Maximum Transmission Unit)
```python
import argparse, socket, sys

# Inlined constants, because Python 3.6 has dropped the IN module.

class IN:
    IP_MTU = 14
    IP_MTU_DISCOVER = 10
    IP_PMTUDISC_DO = 2

#這個程式只能在linux上頭進行
if sys.platform != 'linux':
    print('Unsupported: Can only perform MTU discovery on Linux',
          file=sys.stderr)
    sys.exit(1)

def send_big_datagram(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.IPPROTO_IP, IN.IP_MTU_DISCOVER, IN.IP_PMTUDISC_DO)
    sock.connect((host, port))
    try:
        sock.send(b'#' * 65536)#將會傳送65535個byte字元，數值條下可能就會傳輸成功
    except socket.error:#捕捉socket.error錯誤
        print('Alas, the datagram did not make it')
        max_mtu = sock.getsockopt(socket.IPPROTO_IP, IN.IP_MTU)#取得最大傳輸單元應該是65535
        print('Actual MTU: {}'.format(max_mtu))
    else:
        print('The big datagram was sent!')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Send UDP packet to get MTU')
    parser.add_argument('host', help='the host to which to target the packet')
    parser.add_argument('-p', metavar='PORT', type=int, default=1060,
                        help='UDP port (default 1060)')
    args = parser.parse_args()
    send_big_datagram(args.host, args.p)
```