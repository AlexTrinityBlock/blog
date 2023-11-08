---
title: "Git復原失誤的操作"
date: 2022-02-23T00:03:44+08:00
draft: false
featured_image: "/git.png"
tags: ["git","github"]
---
# 以Revert復原已經提交的變更

每次的變更都會留下雜湊質值
``` 
git log 
``` 
可以查看
要復原變更可以以雜湊值復原

```
git revert acc6af6 
```

如果復原時跳出UNIX式的VI編輯器介面
請按 ESC
然後輸入 :wq

# 以Reset復原尚未提交的變更

在commit之前復原，當前的文件也會回歸pull 下來的狀態,commit被丟棄
 
``` 
git reset --hard 
```

在commit之前復原，暫存區清空(add 的部分消失),commit被跑到工作目錄

``` 
git reset --mixed 
```

commit被跑到暫存區

``` 
git reset --soft 
```
