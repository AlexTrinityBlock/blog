---
title: "NS2課程筆記"
date: 2021-10-12T09:00:49+08:00
draft: false
tags: ["NS2"]
featured_image: "/secure.jpg"
---

<span id="menu"></span>
# 目錄

<a href="#Intro">NS2使用什麼語言</a>  
<a href="#var">變數</a>  
<a href="#ReadFile">閱讀檔案</a>  
<a href="#expressions">判斷與表示</a>  
<a href="#ControlFlow">流程控制</a>  
<a href="#procedures">程序(類似函數)</a>  

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

## 布林判斷
表達式用於達到類似if/else的效果。常常用於判斷一個數值是否等於另外一個。  

以下我們故意產生一個必定為flase的內容。  

```tcl
set value [expr 0==1 ]
puts $value
```
當我們顯示出$value的結果時必然會是0  
<br/>
接著我們稍微改一下，結果就會是1了。  
```tcl
set value [expr 1==1 ]
puts $value
```

## 數學加法

expr也可以執行數學加法。

```tcl
set value [expr 2+2]
puts $value
```
這樣的結果會是4。  
除此之外，在[]裡頭的內容也可插入在字串裡頭。  


<span id="ControlFlow"></span>
# 流程控制

## if判斷式

```tcl
set var1 10

if {$var1 == 10} {
puts "var is 10"
}
```
這樣當if判斷為10時會顯示10。  

另外一個範例

```tcl
set temp 10

if {$temp > 5} {
    puts "Temp bigger than 5."
}
```
這時候會顯示Temp bigger than 5。  

## switch判斷式

```tcl
set var 2

switch $num_legs {
     1 {puts "Var is 1"}
     2 {puts "Var is 2"}
     default {puts "Var is not 1 or 2"}
}
```
結果會印出Var is 2

## for迴圈

```tcl
for {set i 0} {$i < 5} {incr i 1} {
    puts "i :$i"
}
```
這樣的結果會顯示
```
i :0
i :1
i :2
i :3
i :4
```
其中的
```
incr i 1
```
指的是每次i+1

## foreach迴圈

foreach會遍歷所有元素
```tcl
foreach var {m a g i c } {
    puts "$var !"
}
```
結果為
```
m !
a !
g !
i !
c !
```

<a href="#menu">回到目錄</a>  

<span id="procedures"></span>
# 程序(類似函數)

兩數相加的函數

```tcl
proc sum {a b} {
    return [expr $a + $b]
}

set var1 1
set var2 1

set result [sum $var1 $var2]

puts "Sum is $result"
```
我們可以注意到，函數輸出的數值，通常還是都要放入另外一個變數中。  

