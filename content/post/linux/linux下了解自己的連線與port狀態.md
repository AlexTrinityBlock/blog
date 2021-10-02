---
title: "linux下了解自己的連線與port狀態"
date: 2021-07-16T10:29:36+08:00
draft: true
featured_image: "/debian1.jpeg"
tags: ["linux","network"]
---

# 大綱

本文章探討兩個可以用來了解當前port狀態的工具，ss與NetHogs。  
ss是大多是linux發行版的內建工具。  
NetHogs則可以非常即時的來觀察目前電腦在進行哪個傳輸。  


# 用ss指令了解網路狀態

ss指令與過去常用的netstat指令的效果接近，但是內建一些分類功能，所以如果要分類出目前哪些port正在用TCP，而哪些是UDP的話相當方便。在現在比較新的linux發行版裡頭常常預裝好了ss。  

由於有的process的觀察需要root權限，所以建議用root執行。

### 列出所有連線

數量會很多，但不會附帶process名稱

```
sudo ss
```

### 列出連線加上process

可以詳細觀察到哪個port被哪個程式使用

```
sudo ss -p
```

還可以加上grep指令來篩選

```
sudo ss -p |grep chrome
```

或混合使用
```
sudo ss -p -l -t
```

### 列出監聽與非監聽的port

也會有大量的內容出現

```
ss -a
```

### 列出TCP的port

```
ss -t
```

### 列出UDP的port

```
ss -u
```

### 列出監聽的port

```
ss -l
```
可以搭配tcp或udp
```
ss -lt
```
或
```
ss -lu
```

### 列出非監聽與監聽的port指定TCP 或UDP
```
ss -ua
```
```
ss -ta
```

### 顯示TCP與UDP的連線數量統計
```
sudo ss -s
```

### 顯示IPv4或IPv6的連線

```
sudo ss -4
```

```
sudo ss -6
```

### 顯示特定port的內容

以下為顯示22port的內容
```
 ss -at '( dport = :22 or sport = :22 )'
```

### 監聽與建立的差異

當一個port尚未與遠端建立連線時，這個TCP socket的狀態稱為listen(監聽)。  
當連線已經建立完畢時，這個TCP socket的狀態稱為established。  

我們要如何用ss找到已經建立連線的port呢？

下列方式會將所有正在監聽與已經建立連線的socket列出
```
ss -at
```

這個則是列出已經建立連線的sokcet
```
ss -et
```
### ss使用文檔

```
man ss
```

#  NetHogs

這是一個類似top的工具，可以即時顯示電腦中哪個連線特別活躍，用視覺化的方式。  
如果使用debian的話可以用以下指令下載:  
```
sudo apt install  nethogs
```
用下列指令執行:
```
sudo nethogs
```

## NetHogs追蹤模式

會一行一行即時跑出正在連線的process

```
sudo nethogs -t
```
## NetHogs混雜模式

用於網路嗅探，有辦法看到不屬於自己的封包，但必須先部屬好中間人攻擊一類的。  

```
sudo nethogs -p
```

