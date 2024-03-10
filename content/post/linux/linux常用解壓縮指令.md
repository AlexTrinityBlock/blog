---
title: "linux常用解壓縮指令"
date: 2024-03-09T21:00:25+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux"]
---

# tar

假定我們有個目錄稱為 ./my

## 壓縮

```bash
# 壓縮
tar -czvf my.tar.gz ./my
# 單純歸檔
tar -cvf my.tar ./my
```

c：建立一個新的歸檔檔案。
z：使用 gzip 壓縮。
v：顯示執行過程中的詳細資訊（verbose 模式）。
f：指定歸檔檔案的名稱。

## 解壓縮:

```bash
tar -xvf my.tar
```

x：表示提取檔案。
v：表示詳細模式，會顯示更多的信息。
f：表示接下來的參數是一個檔案名稱。

# 7z

假定我們有個目錄稱為 ./my

壓縮:

```bash
7z a my.7z ./my
```

解壓縮:

```bash
7z x my.7z
```

# zip

假定我們有個目錄稱為 ./my

壓縮:

```bash
# 壓縮目錄
zip -r my.zip ./my
```

-r：遞迴地壓縮目錄中的所有檔案。

解壓縮:

你可以使用 unzip 命令來解壓縮檔案。

```bash
# 解壓縮
unzip my.zip
```