---
title: "Linux_mint卡在開始logo的解決"
date: 2021-03-20T11:07:13+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","gpu","開機失敗","grub","modeset","開機"]
---

# Linux_mint卡在開始logo的解決

linux mint 在某些情況下會卡在開機logo  
而引發這種情況的可能原因  
常常與顯示卡（gpu）有關連  
若顯示卡是nvidia的，  
顯示卡驅動程式分為開放原始碼社群自製的版本nouveau  
與nvidia官方的驅動程式  
有時候更新驅動程式後無法使用是nouveau的問題，  
但有時候nvidia官方的驅動程式也可能有錯，導致cpu功耗極高  
兩者我都遇到過  
接著我們進入正題，假設是顯示卡驅動程式的問題，該如何街決

## 1.修改grub開機參數

如果linux mint系統的完整啟動，看作是一場宴會  
宴會場地中有許多大大小小的裝飾（程式）  
那grub這個程式就是佈置會場的第一批工作人員  

當我們開機時第一個進入的選單，通常是grub的選單  
我們在這裡可以選擇作業系統，選擇使用的核心kernel  
或是調整開機參數  
此處我們需要的就是調整開機參數  

調整參數的方式就是在grub選單按下鍵盤E  
這個時候我們會進入調整開機參數的模式  
但改錯別擔心，在此處的調整都是暫時的  
找到以下兩個參數  

```shell
quiet //這個參數會導致開機時不會跑出一大堆字，即時顯示linux在開機途中做了什麼
```

```shell
 splash //這個參數會顯示logo
```

然後把上述兩個字刪除  
刪除quiet是為了，如果有任何錯誤，我們就可肉眼看到錯誤警告  
如果是基於顯示logo的腳本出問題，那讓他別顯示也好，或者顯示logo跟顯示卡驅動程式有所關聯，都有可能導致卡住  

接著輸入

```shell
 nouveau.modeset=0 
```

這樣會關閉社群開放原始碼的驅動程式  
可能會導致三個可能結果  

```shell
1.徹底缺少驅動程式無法啟動顯示卡，完全沒有畫面
2.啟動nvidia官方的驅動程式順利開機看到畫面
3.找不到顯卡，啟用cpu內建顯示功能（如果有的話），然後順利看到低畫質的畫面
```

## 2.如果順利進入畫面

一面祈禱，一面點開螢幕左下角選單  

```shell
選單->管理->驅動程式管理員
```

更新顯示卡驅動程式，然後最好選擇nvidia官方的驅動程式，如果順利的話，重新開機就能正常了  

## 補充說明

下列的參數代表什麼意思謹此說明

```shell

nomodeset //此參數輸入進去後會禁止所有的顯卡驅動程式，可能會黑畫面，或跑出低畫質的畫面

nvidia.modeset=0 //關閉nvidia官方驅動程式，除非你很確定你裝了開源驅動，而且官方的驅動程式有問題未更新，才這樣做

i915.modeset=0 //intel公司有些處理器內建顯示卡，而這個選項會關閉內建顯示卡，除非你很確定你內建顯示卡壞了，但又無法用任何方式調整到其他顯示卡再使用

acpi=off //原本電源與部份硬體的主控權，已經交給linux系統了，但如果acpi軟體故障，這樣設定可以把控制權交回給主機板，如果持續無法開機，這是可嘗試的最後選項之一

```
