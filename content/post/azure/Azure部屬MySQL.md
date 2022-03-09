---
title: "Azure部屬MySQL"
date: 2022-03-09T10:00:44+08:00
draft: true
featured_image: "/azure.jpg"
tags: ["Azure"]
---

## 1.適用於 MySQL 的 Azure 資料庫

點選『適用於 MySQL 的 Azure 資料庫』

如果沒有的話，可以在上排選單。

![img](/blog/public/2022-03-08/az1.png)

## 2.建立

![img](/blog/public/2022-03-08/az2.png)

## 3.單一伺服器

![img](/blog/public/2022-03-08/az3.png)

## 4.建立MySQL伺服器

以下有幾個一定要記下來的，最好用複製的，忘記會極度麻煩。

>資源群組名稱  
>伺服器名稱  
>管理使正者名稱  
>密碼  

![img](/blog/public/2022-03-08/az4.png)

## 5.確認定價

![img](/blog/public/2022-03-08/az5.png)

## 6.建立完成

![img](/blog/public/2022-03-08/az6.png)

## 7.調整連線安全性

![img](/blog/public/2022-03-08/az7.png)

## 8.連線安全設置調整

這裡的防火牆規則，可以選擇讓你的MySQL可以由哪些遠端主機連線。

不過，如果你沒有自己的固定IP，也就是你的IP是浮動的話，你只能開放0.0.0.0讓所有的IP存取(不可避免的，這相對不安全)。

如果有必要也可以封鎖特定IP。

![img](/blog/public/2022-03-08/az8.png)

## 9.打開Azure終端機

在畫面右上角。

![img](/blog/public/2022-03-08/az9.png)

## 10.打開Azure終端機

![img](/blog/public/2022-03-08/az10.png)

## 11.登入MySQL

在Azure終端機輸入下列指令:

```bash
mysql --host=<伺服器名稱>.mysql.database.azure.com --user=<管理使正者名稱>@<伺服器名稱> –p
```

例如下面這樣:

```bash
mysql --host=imserver123.mysql.database.azure.com --user=imuser123@imserver123 –p
```

![img](/blog/public/2022-03-08/az11.png)

## 12.嘗試插入MySQL語法

```mysql
/*建立資料庫名稱為mvcdb*/
CREATE DATABASE mvcdb;

/*使用資料庫mvcdb*/
use mvcdb;

/*建立資料表，如果事先沒有同一個名稱的資料表的話，名為item*/
/*裡頭有三個項目ID,Name,Number*/
/*VARCHAR可以裝入文字內容，INT則是整數*/
CREATE TABLE IF NOT EXISTS item (
  ID VARCHAR(50) DEFAULT NULL ,
  Name VARCHAR(50) DEFAULT NULL,
  Number INT(11) NOT NULL
) ;

/*顯示資料表*/
SHOW TABLES;

/*插入一筆資料ID為A0001，名稱為BKO001，數量12*/
INSERT INTO item  (ID, Name, Number) VALUES  ("A001", "BKO001", "12");

/*選擇item資料表裡的所有資料*/
SELECT * FROM item;
```

![img](/blog/public/2022-03-08/az12.png)
![img](/blog/public/2022-03-08/az13.png)