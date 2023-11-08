---
title: "如何用22port以外連上Git Server"
date: 2022-02-23T00:01:44+08:00
draft: false
featured_image: "/git.png"
tags: ["git","github"]
---

# Git伺服器的SSH port

基本上來說，git server所使用的ssh port就是22 port。

# 為何會有例外

由於自己架設的Git Server，22 port可能被用於其他用途，或者是被禁止，所以我們要到Git 設定檔去調整連入的port。

設定檔路徑

```bash
/home/你的使用者名稱/.ssh/config
```

由於很多時候這個檔案不存在，所以需要自己建立。

假設我們要針對一個自己架設的伺服器www.xxxooo1122.tw，然後用22022 port來連線Git server的SSH。

修改內容如下

/home/你的使用者名稱/.ssh/config
```bash
Host www.xxxooo1122.tw
Port 22022
```
也就是
```bash
Host (你的Git伺服器IP或者網址名稱)
Port (你開啟的port)
```

這樣一來就可以連線到特定的伺服器時，使用特定的port了。