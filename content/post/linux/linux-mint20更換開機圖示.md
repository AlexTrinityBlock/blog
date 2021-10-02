---
title: "Linux Mint20更換開機圖示"
date: 2021-03-01T13:01:33+08:00
draft: true
featured_image: "/debian1.jpeg"
tags: ["linux","開機","自訂"]
---

### 下載喜歡的開機圖示

[下載開機圖示1](https://www.cinnamon-look.org/browse/cat/108/ord/top/)  
[下載開機圖示2](https://www.gnome-look.org/browse/cat/108/order/latest/)  

打開圖示資料夾取出最裡層的資料夾  
然後將其複製到以下位置  
```
/usr/share/plymouth/themes
```

### 修改圖示檔案設定文件 

修改預設的開機圖示檔 default.plymouth
```
[Plymouth Theme]
Name=Mate Red
Description=A theme that features an animated Linux Mint logo.
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/mate_red
ScriptFile=/usr/share/plymouth/themes/mate_red/mate_red.script
```
把ImageDir改成你下載的圖示的資料夾
```
ImageDir=/usr/share/plymouth/themes/下載圖示的資料夾
```
然後將執行腳本改成ScriptFile改成下載圖示資料夾中的腳本  
腳本的副檔名通常為script
```
ScriptFile=/usr/share/plymouth/themes/下載圖示的資料夾/下載圖示的資料夾.script
```
然後將他編譯成二進制的檔案

```
sudo update-initramfs -u
```

完成～！


