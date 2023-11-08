---
title: "Git選擇分支"
date: 2022-02-23T00:04:44+08:00
draft: false
featured_image: "/git.png"
tags: ["git","github"]
---
# 1.什麼是分支?
當我們在開發某個東西時，總存在著測試和開發中，無法正常上線的狀態之版本
而多人合力開發時，也有很多的細節需要整合
這時候就會使用分支
在此個部分，我們先來討論如何選擇分支進行開發。

# 2.選擇分支的指令
選擇主分支

```
git checkout master
```

選擇其他分支
git checkout 分支名稱
例如:我們的分支叫new_feature

```
git checkout new_feature
```

# 3.建立新分支
建立分支new_branch

```
git branch new_branch
```


# 4.合併分支
把new_branch合併回主幹

```
git checkout master
git merge new_branch
```

# 5.刪除分支
刪除new_branche
```
git branch new_branche -D
```