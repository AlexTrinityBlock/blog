---
title: "Gdb使用"
date: 2021-03-24T14:01:49+08:00
draft: true
tags: ["c","gdb","組合語言","反組譯"]
featured_image: "/code.jpg"
---

```gdb
GDB使用指令

---------------

提示gcc編譯時記得開啟g選項，編譯出來的產物才不會啟動優化，
同時可以使用gdb除錯

匯入檔案：gdb 檔案名稱
匯入後命令行左邊會變成(gdb)

顯示原始碼：(gdb) l     //請保留原碼在同資料夾
設定中斷點：(gdb) b 2     //在某一行原始碼中斷
設定中斷點：(gdb) b main    //在main函數中斷
開始運作：(gdb) r     //沒有意外會停在中斷點
下一行程式：(gdb) n 
下一行組合語言指令：(gdb) si
印出某個變數的內容與暫存器（例如變數number）：(gdb) p number 
顯示所有組合語言：(gdb)disas
觀看某個暫存器內容：(gdb)i r 暫存器名稱
確認return address：(gdb)i f //saved rip 的內容就是下一條指令的位址
觀看某個位址內容：(gdb)info address 位址
觀看某個變數位址：(gdb)p &變數名稱
檢查位址內儲存的數值：(gdb)x/s 位址
---------------

建議操作流程：

1.編譯
gcc -g 來源檔名  -o 目的檔名

2.載入gdb
gdb 目的檔名

3.以main為中斷點
(gdb)b main

4.執行
(gdb) r

5.顯示組合語言
(gdb)disas

6.下一指令
(gdb)ni

....
```

