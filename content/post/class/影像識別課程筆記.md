---
title: "影像識別課程筆記"
date: 2021-10-01T09:00:44+08:00
draft: true
featured_image: "/secure.jpg"
tags: ["OpenCV"]
---

# 目錄

<a href="#week1">第一週</a>  
<a href="#week2">第二週</a>  

<span id="week1"></span>
# 第一週

## 什麼是影像？

影像是由許多x,y軸座標組成。  
單一個點的振幅，也可以視為光線的亮度，稱為『intensity』(強度)或『gray level』(灰階)。  

## 圖像分割Segmentation

圖像分割（segmentation）就是將圖片的邊緣標示出來，例如：自動駕駛汽車表示出行人身體的邊界，或者是醫學影像識別出腫瘤的邊界。  

以下是維基百科的詮釋:  
> 圖像分割的目的是簡化或改變圖像的表示形式，使得圖像更容易理解和分析。 圖像分割通常用於定位圖像中的物體和邊界（線，曲線等）。

## 醫療中的影像處理

### Single-modality-based diagnose

描述出腫瘤邊界，圖像分割出病變位置。

### Multi-modality-based diagnose

圖片轉換，例如：FFT（快速傅立葉轉換),DCT(離散餘弦轉換)

### 醫療影像中的實用技術

Image registration:  
影像對位，像是把X光與超音波兩種不同影像，重疊在一起來比對不同器材的不同掃描結果。  

Image fusion: 
> 將不同感測器獲得的同一場景圖像，或者同一感測器以不同工作模式或在不同成像時間下獲得的同一場景圖像，運用融合技術合併成一幅  

Image Reconstruction:  
影像重建  

Interpolation：  
內插，將圖片放大時，以某種算法來預測，中間空缺的部份。  

## 醫療中的圖像分割Segmentation

### Otsu 大津演算法
將有不同深淺的黑白影像(灰階)，轉換成只有最黑跟最白兩種顏色。  

### CCBHNC (contextual-constraint based Hopfield neural )
參見論文TENCON.1999.818634，一種二值化的方法。  

## 醫療中的邊緣偵測

偵測出一個物體，例如膝蓋的邊緣，然後轉換成類似鉛筆黑線於白紙上繪製出邊緣的效果。  

###  Laplacian-based method

### Marr-Hildreth

### CHEFNN

參見Chuan-Yu Chang "Contextual-based Hopfield neural network for medical image edge detection," Optical Engineering 45(3)



