---
title: "NS2課程筆記"
date: 2021-10-12T09:00:49+08:00
draft: true
tags: ["NS2"]
featured_image: "/secure.jpg"
---

<span id="menu"></span>
# 目錄

<a href="#Intro">NS2使用什麼語言</a>  
<a href="#var">變數</a>  
<a href="#ReadFile">閱讀檔案</a>  
<a href="#expressions">判斷與表示</a>  

<span id="Intro"></span>
# NS2使用什麼語言
NS2使用一種稱為TCL的語言，如果想了解更多的語法可以去查詢TCL。

<a href="#menu">回到目錄</a>  

<span id="var"></span>
# 變數

設置變數或字串的方式是採取set保留字。

```tcl
set str "This is a string"
```

顯示變數的方法是

```tcl
put $str
```
或者可以在字串插入變數

```tcl
put "The word is $str"
```

字串變數拼接的方式

```tcl
set str3 "$str1 $str2"
```
<a href="#menu">回到目錄</a>  


<span id="ReadFile"></span>
# 閱讀檔案

將檔案讀到 FileContent變數

```tcl
set FileContent [open hello.txt r]
```

寫入檔案  
寫入檔案的時候用put指令

```tcl

set testfile [open hello.dat w]
  
puts $testfile "hello1"
```

<a href="#menu">回到目錄</a>  

<span id="expressions"></span>
# 判斷與表示


