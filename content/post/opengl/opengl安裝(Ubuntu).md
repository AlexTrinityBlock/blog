---
title: "opengl安裝(Ubuntu)"
date: 2021-09-29T09:00:44+08:00
draft: false
featured_image: "/secure.jpg"
tags: ["opengl"]
---

## 1.Linux版本

此範例用在Ubuntu20.04

## 2.apt安裝opengl

安裝OpenGL與相關依賴

```
sudo apt install cmake make g++ libx11-dev libgl1-mesa-dev libglu1-mesa-dev libxrandr-dev libxext-dev  libglew-dev libglfw3 libglfw3-dev freeglut3-dev freeglut3
```
這邊主要使用的是glut  
如果確定需要的套件都有的話  
可以只輸入下列指令即可  
```
sudo apt install  freeglut3-dev freeglut3
```
此處附上維基百科的解釋  


>GLUT（英文全寫：OpenGL Utility Toolkit）是一個處理OpenGL程式的工具庫，負責處理和底層作業系統的呼叫以及I/O，並包括了以下常見的功能：
>定義以及控制視窗
>偵測並處理鍵盤及滑鼠的事件
>以一個函式呼叫繪製某些常用的立體圖形，例如長方體、球、以及猶他茶壺（實心或只有骨架，如glutWireTeapot()）
>提供了簡單選單列的實現

## 3.畫出一個視窗裡頭有正方形

### main.cpp

```cpp
//sudo apt-get install freeglut3-dev freeglut3
//gcc main.cpp  -o OutPut -lGL -lGLU -lglut
#include <GL/glut.h>

void displayMe(void)
{
    glClear(GL_COLOR_BUFFER_BIT);
    glBegin(GL_POLYGON);
        glVertex3f(0.0, 0.0, 0.0);//x,y,z軸座標
        glVertex3f(0.5, 0.0, 0.0);
        glVertex3f(0.5, 0.5, 0.0);
        glVertex3f(0.0, 0.5, 0.0);
    glEnd();
    glFlush();
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE);//顯示模式，GLUT_SINGLE繪圖較慢只有一個緩衝區，常用於靜態圖片。GLUT_DOUBLE則可以用於動畫，繪製速度相對快速。
    glutInitWindowSize(300, 300);//圖形視窗大小
    glutInitWindowPosition(100, 100);//圖形視窗顯示在桌面的位置
    glutCreateWindow("Is a window");//圖形視窗標題
    glutDisplayFunc(displayMe);//把上方我們自定義的函數，displayMe的內容顯示於視窗中
    glutMainLoop();//持續運作的主迴圈
    return 0;
}

```

## 4.編譯指令

編譯完畢後檔名是OutPut

```
gcc main.cpp  -o OutPut -lGL -lGLU -lglut
```

## 5.執行

```
./OutPut
```

## 6.可能的錯誤

### 錯誤情況1

```
/usr/bin/ld: /tmp/cc5TTO9z.o: undefined reference to symbol 'sqrt@@GLIBC_2.2.5'
/usr/bin/ld: /lib/x86_64-linux-gnu/libm.so.6: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status

```
解決方式：
編譯指令增加-lm

```
gcc ./main.c  -o OutPut -lGL -lGLU -lglut -lm
```


