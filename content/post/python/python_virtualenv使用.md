---
title: "python_virtualenv使用"
date: 2021-04-29T14:43:44+08:00
draft: false
featured_image: "/python.jpg"
tags: ["python","virtualenv"]
---

## 1.安裝virtualenv虛擬環境
linux mint或ubuntu上頭安裝時可以用apt來進行安裝

```bash
sudo apt install virtualenv
```
或直接用pip3來安裝  
```bash
pip3 install virtualenv
```
## 2.建立虛擬環境
我們建立的環境名稱叫 projectenv  
版本用python3
``` bash
virtualenv -p python3 projectenv 
```
這樣就會生成一個資料夾projectenv  

## 3.啟動虛擬環境
進入資料夾
``` bash
cd projectenv
```
觸發啟動腳本
``` bash
source ./bin/activate
```
如果你注意到命令行的前頭發生改變多了(projectenv) ，就是成功啟動了  
接著我們檢查安裝了哪些套件  
``` bash
pip3 list
```
關閉虛擬環境
``` bash
deactivate
```
以後安裝套件都會裝在這個projectenv資料夾了





