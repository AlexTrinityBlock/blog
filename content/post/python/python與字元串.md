---
title: "python與byte串與網路"
date: 2021-05-15T00:00:44+08:00
draft: false
featured_image: "/python.jpg"
tags: ["python","network","byte","bytes"]
---
本篇引用自Foundations of Python Network Programming一書 
## bytes串與網路的關係
在網路傳輸時如socket，是無法直接採取Unicode來傳遞資訊的，  
也就是說，你無法原封不動的傳遞一整段中文字。  
因次要傳送字串最不容易出錯方式，就是直接將其轉成byte串，  
這種型態可以直接視為傳輸一串串16進位的數字。
## 二進制轉換
在python命令行中直接把二進制轉成十進制  
0b代表是採取二進制表示  
二進制的10代表十進制的數字2
```python
>>>0b10
2
```
## 把list轉成二進制bytes字串
建立一個list  
[1,0,1,0]  
然後轉換成bytes字串
```python
>>> byte_string=bytes([1,0,1,0])
>>> byte_string
b'\x01\x00\x01\x00'
>>> list(byte_string)
[1, 0, 1, 0]
```
最後再轉換回list

## 把整數轉換成ascii
整數35再ascii標準中為#
```python
>>> chr(35)
'#'
```
## 將中文轉成byte串
將中文轉換成utf-8編碼的byte串  
通過網路之後還原，  
就可以達成用網路傳輸中文了  
```python
>>> chinese_code="你好".encode("utf-8")
>>> chinese_code
b'\xe4\xbd\xa0\xe5\xa5\xbd'
```

## 一個思考，十六進制與縮短字符傳送
由於在網路傳輸時所有的訊息都是以byte串來傳遞，  
甚至是數字也是。  
那是否可能十進制數字傳成16進位數字來減少傳送的字符量。  

```python
>>> hex(9999999999)
'0x2540be3ff'
```
9999999999有十個字元，但是2540be3ff只有九個字元。
