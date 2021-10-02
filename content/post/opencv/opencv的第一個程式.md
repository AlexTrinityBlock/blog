---
title: "opencv的第一個程式"
date: 2021-09-22T09:10:44+08:00
draft: true
featured_image: "/secure.jpg"
tags: ["opencv"]
---

## 1.要求

需要看懂，建議去看基礎的C++教學。

## 2.main.cpp

我們首先建立一個檔案，稱為main.cpp
內含我們主要的C++檔案

```c++
#include <stdio.h>
#include <opencv2/opencv.hpp>

using namespace cv;

int main(int argc, char* argv[]) {

  // 檢查是否有指定輸入影像檔案
  if ( argc != 2 ) {
    printf("請在終端輸入 Displayer <圖檔名稱> \n");
    return -1;
  }

  // 讀取影像檔案
  Mat image;
  image = imread( argv[1], 1 );

  // 檢查影像是否正確讀入
  if ( !image.data ) {
    printf("No image data n");
    return -1;
  }

  // 建立視窗
  namedWindow("Display Image", WINDOW_AUTOSIZE);

  // 用視窗顯示影像
  imshow("Display Image", image);

  // 顯示視窗，直到任何鍵盤輸入後才離開
  waitKey(0);

  return 0;
}

```

## 3.CMakeLists.txt

當沒有CMake編譯工具的時候，最困擾我們的是，我們要用C++導入某個函數庫時，需要輸入長長一串g++指令，  
並且會隨著編譯環境的差別(例如不同版本linux)，而出現差異。  
我們首先可以安裝好CMake編譯工具。

```
sudo apt install cmake
```

然後建立下列這個名為CMakeLists.txt的編譯文件

```CMake
cmake_minimum_required(VERSION 2.8)
project( DisplayImage )
find_package( OpenCV REQUIRED )
add_executable( Displayer main.cpp )
target_link_libraries( Displayer ${OpenCV_LIBS} )
```

加上解釋版

```CMake
cmake_minimum_required(VERSION 2.8) #最低要求版本
project( Displayer ) #專案名稱，稱為Displayer
find_package( OpenCV REQUIRED ) #尋找套件
add_executable( Displayer main.cpp ) #編譯後的檔案名稱稱為Displayer，來自main.cpp
target_link_libraries( Displayer ${OpenCV_LIBS} )#將檔案連結到OpenCV函數庫
```

## 4.編譯指令

進入裝有檔案的資料夾

```
cmake . 
```
進行編譯
```
make 
```
