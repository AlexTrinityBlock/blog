---
title: "python網路程式01:基礎"
date: 2021-04-29T16:15:44+08:00
draft: false
featured_image: "/python.jpg"
tags: ["python","network","網路"]
---
本篇引用自Foundations of Python Network Programming一書 
本章討論如何使用python發出http請求

# 1.用網址取得主機ip
```python
import socket

if __name__ == '__main__':
    hostname = 'maps.google.com' #此處是google地圖的網址
    addr = socket.gethostbyname(hostname) #放入socket函數中
    #最後將結果用format插入字串    
    print('網址 {} 的ip位址是 {}'.format(hostname, addr))
```

# 2.用Nominatim的API查詢地址的座標
```python
#引入Nominatim專用函數庫進行座標查詢
from geopy.geocoders import Nominatim 

if __name__ == '__main__':
    #一段英文地址
    address = '207 N. Defiance St, Archbold, OH'
    user_agent = 'hello'#這段伺服器端會看到，一般會透漏瀏覽器等資訊
    #伺服器回傳的地理位置會存入location物件中    
    location = Nominatim(user_agent=user_agent).geocode(address)
    #印出緯度與經度    
    print(location.latitude, location.longitude)

```

# 3.用requests函數庫發送http請求，取得座標
```python
#發送http請求的函數庫
import requests


def send_request(address):
    base = 'https://nominatim.openstreetmap.org/search'#網址
    parameters = {'q': address, 'format': 'json'}#輸入地址參數，格式為json
    user_agent = 'hello'#這段伺服器端會看到，一般會透漏瀏覽器等資訊
    headers = {'User-Agent': user_agent}#組合請求header
    response = requests.get(base, params=parameters, headers=headers)#發送
    reply = response.json()#取得回應的json格式
    print(reply[0]['lat'], reply[0]['lon'])#印出內容

if __name__ == '__main__':
    send_request('207 N. Defiance St, Archbold, OH')

```

# 4.直接使用http函數庫
```python
import http.client#引入http模塊
import json #引入json模塊
from urllib.parse import quote_plus #引入將文字轉換成url格式的模塊

#之所以要這個是因為api的網址是nominatim.openstreetmap.org/search
base = '/search'

def geocode(address):
    #將整個請求組合起來，quote_plus()可以將原本不能放入url的文字轉成url可接受的格式    
    path = '{}?q={}&format=json'.format(base, quote_plus(address))
    #此處的b是將字串轉換成byte格式，才可經由http傳輸    
    user_agent = b'Foundations of Python Network Programming example search3.py'
    headers = {b'User-Agent': user_agent}
    #網址連接    
    connection = http.client.HTTPSConnection('nominatim.openstreetmap.org')
    #請求的方式主要有get,post,put,delete四種，目前主流是get,post
    #單純取得資料一般用get    
    connection.request('GET', path, None, headers)
    #原始的回應
    rawreply = connection.getresponse().read()
    #轉換成json並且以utf-8編碼    
    reply = json.loads(rawreply.decode('utf-8'))
    print(reply[0]['lat'], reply[0]['lon'])

if __name__ == '__main__':
    geocode('207 N. Defiance St, Archbold, OH')

```
# 5.使用socket發送http字段
```python
import socket #原始的socket連線
import ssl #https安全連線模塊（傳輸會加密）
from urllib.parse import quote_plus #引入將文字轉換成url格式的模塊

#從http的角度是個get的請求，從socket的角度就是如下的字串
request_text = """\
GET /search?q={}&format=json HTTP/1.1\r\n\
Host: nominatim.openstreetmap.org\r\n\
User-Agent: Foundations of Python Network Programming example search4.py\r\n\
Connection: close\r\n\
\r\n\
"""

def geocode(address):
    #未加密的socket連線
    unencrypted_sock = socket.socket()
    #由伺服器443 port進行連線
    unencrypted_sock.connect(('nominatim.openstreetmap.org', 443))
    #加上https加密連線
    sock = ssl.wrap_socket(unencrypted_sock)
    #將上方的請求字串拼接
    request = request_text.format(quote_plus(address))
    #將其轉ascii編碼，然後送出
    sock.sendall(request.encode('ascii'))
    #得到的原始回應會是byte型態的
    raw_reply = b''
    while True:
        #一次接收4096個byte
        more = sock.recv(4096)
        #都接收完後停止迴圈
        if not more:
            break
        raw_reply += more
    print(raw_reply.decode('utf-8'))

if __name__ == '__main__':
    geocode('207 N. Defiance St, Archbold, OH')

```
# 6.備註

*雖然ip協定一個數據包最大可以64kb，但是乙太網路某些時候只支持更小的數據包所以會切分數個fragment。  

*如果要了解關於ip的更多知識，可以讀IETF發布的RFC文檔。

*網路傳輸常常在unicode與原始的ascii之間切換，utf-8最常使用。