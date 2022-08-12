---
title: "github免密碼上傳與RSA金鑰產生"
date: 2021-05-19T00:05:03+08:00
draft: true
featured_image: "/git.png"
tags: ["git","github"]
---

### 先決條件
這篇是建立在理解  
1. git基本使用
2. 擁有github帳號
3. 使用linux

上述條件達成才比較能夠理解本篇git的部份，  
建議上網找些資料學習。  
不過RSA金鑰的用途就算不理解這些也能夠先讀。

### 建立git郵件帳號

```
git config --global user.name "使用者名稱"
git config --global user.email 使用者郵件
```

### RSA金鑰是啥？
我們通常想要登入一個帳號，是需要密碼的。  
無論是windows,linux甚至銀行提款。  
但是由於密碼我們能記下的實在很短。  
所以有沒有可能將很長的密碼寫進檔案裡頭呢？  
RSA的某部份就是如此，生成的金鑰被除存在你的電腦中，  
RSA的預設長度為2048位元。  
就算是在撰寫本篇文章此時的2021年，當今的量子電腦也很難完成破解。  

### RSA加密的非對稱性
在RSA加密中，你要傳送一份文件。  
收件人會給你他的公鑰  
<span style='color:blue'>
你用公鑰將你的文件加密，  
而公鑰推論不出你文件的內容，也推論不出私鑰  
</span>
<span style='color:green'>
收件人接收到你的加密文件後  
用私鑰解密
</span>

### 如何在Linux上頭使用RSA
由於SSH的遠端通訊是採取RSA進行加密通訊。  
所以可以用SSH的功能直接生成一對RSA的公私鑰。  
```BASH
ssh-keygen -t rsa
```
接著只要一路按下enter（如果你不考慮各種細節的話）  
就可以生成一對公私鑰  
而這對生成的鑰匙預設除存在哪裡呢？  
通常是在使用者目錄下方的一個隱藏檔  
```bash
/home/使用者名稱/.ssh/
```
而我們打開了該目錄可以看到裡頭有兩個檔案  
<span style='color:red'>
id_rsa #私鑰  
id_rsa.pub ＃公鑰  
</span>

### 在github上頭使用公鑰免密碼傳輸
首先複製一下公鑰的內容(請一字不漏的)  
然後在github個人主頁的右上角點下  
進入<span style='color:red'>setting</span>  
然後選擇<span style='color:red'>SSH and GPG keys</span>  
點擊綠色按鈕<span style='color:green'>New SSH key</span>  
貼上剛剛複製的公鑰的內容  
按下<span style='color:green'>Add SSH key</span>  

### 下載專案
Clone專案時請選擇SSH的那一組網址  
然後  
```git
git clone 複製的ssh網址
```
完成以後push不再需要輸入密碼了  
git會讀取你
```bash
/home/使用者/.ssh
```
該目錄下方的私鑰進行加解密，同時也能讓github得知你已經擁有編輯檔案的權限  
