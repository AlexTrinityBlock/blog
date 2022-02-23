---
title: "Git的簡單使用"
date: 2022-02-23T00:03:44+08:00
draft: true
featured_image: "/git.png"
tags: ["git","github"]
---
# 1.Git的三個區域

  ### Working tree 工作樹
    我們甚麼都還沒做時，資料在這裡
  ### Staging Area 暫存區
    我們進行指令add 後資料在這裡
  ### Repository 儲存庫
    我們commit時資料進入儲存庫
    
# 2.Git基礎操作

### 宣告一個資料夾加入git
先cd到此資料夾下
輸入

``` 
git init 
```
### 建立一個檔案
例如我們建立個 README.md

``` 
touch README.md 
```
### 將檔案加入暫存區
將 README.md加入暫存區

```
git add  README.md 
```

### 查看資料夾的git狀態

```  
git status 
```

這時會發生甚麼呢?

```git 
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   README.md

```

訊息告訴我們沒有任何的commits，但有個新檔案README.md出現

### 提交檔案

正式提交與留下評論的方式如下

``` 
git commit -m “這是一個git提交，會存入儲存庫”
```
# 3.修改
當我們今天對檔案進行修改時
會發生什麼呢?
我們在 README.md 加入 try 這個字

我們下指令查看資料夾的git狀態

```  
git status 
```

結果

```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
```

跳出提示，修改尚未做提交前的暫存
也沒有新的內容被提交

我們下指令查看那些東西被改變了

```  
git diff 
```

結果:

```
diff --git a/README.md b/README.md
index e69de29..a9d8da7 100644
--- a/README.md
+++ b/README.md
@@ -0,0 +1 @@
+try
\ No newline at end of file
```
我們知道加了try字串

### 添加修改的方式

把所有修改的檔案紀錄到暫存區(不包括刪除)

``` 
git add .
```

把所有修改的檔案紀錄到暫存區，除了點開頭的隱藏檔(不包括刪除)

``` 
git add *
```

把所有修改的檔案紀錄到暫存區，包括刪除

```
git add --all
```

### 檢查暫存區的變更
可以在commit前觀察變更

```
git diff --cached
```

### 最後~提交

```
git commit -m '提交'
```

### 上傳到遠端git伺服器

例如你想要將master分之，上傳到origin伺服器時。

可以用以下指令進行上傳。

```
git push origin master
```

# 4.刪除

```
git rm README.md
git add --all
git commit "刪除"
```

# 5.更改名稱與移動

```
git mv README.md README2.md
git add --all
git commit "變更名稱"
```

