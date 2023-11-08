---
title: "docker秒退的問題"
date: 2021-04-16T16:31:03+08:00
draft: false
featured_image: "/docker.png"
tags: ["docker"]
---

### docker為何秒退的猜測  

這只是猜測，個人實力不足，不能直接斷言問題所在。  
當docker中所有的程序（process）都執行完畢時，docker被設計為自動關閉  
它的系統本身沒有一個必然常駐的deamon存在  
也就意味著，如果希望一個docker ubuntu能夠持續存在  
是必要一直開著某個程序  
普遍來說，建立docker container時，它會預設持續開著/bin/sh或/bin/bash  
如果沒有任何一程序被開啟，我猜這就是導致秒退的原因。  

### 解決方法

會秒退常常發生在改寫了Dockerfile文件的屬性CMD時

```dockerfile
CMD  bash MyScript
```

在MyScript執行完畢之後，它就會自動秒退了  
我們這時可以加入一個閒置的bash程序，讓它持續運作  

```dockerfile
CMD  bash MyScript && /bin/bash
```
這樣子bash一直運作著，docker容器就不會自動關閉了




