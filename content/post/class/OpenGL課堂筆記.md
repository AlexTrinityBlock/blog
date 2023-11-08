---
title: "OpenGL課堂筆記"
date: 2021-10-07T10:00:49+08:00
draft: false
tags: ["OpenGL"]
featured_image: "/secure.jpg"
---

<span id="menu"></span>
# 目錄

<a href="#week1">第一週</a>  

# 推薦書

>Edward Angel and Dave Shreiner, Interactive Computer Graphics: A Top-Down Approach With Shader-Based Opengl, 6th Edition, Addison-Wesley Pub. Co., April 10, 2011.  ISBN：978-0132545235.  

>Edward Angel and Dave Shreiner, Interactive Computer Graphics: A Top-Down Approach Using WebGL, 7th Edition, Addison-Wesley Pub. Co., March 10, 2014. , ISBN：978-0133574845.  


<span id="week1"></span>
# 第一週

## 畫出四個點

Ubuntu上頭安裝OpenGL的指令。

```
sudo apt-get install freeglut3-dev freeglut3
```

#### 主程式

繪製出四個點的程式  
main.cpp

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glPointSize(50.0);
    glBegin(GL_POINTS);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,-10);
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,10);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,10);
        glColor3f(0.0f, 0.0f, 0.0f);
        glVertex2f(10,-10);

    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, -20.0, 20.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```
接著我會分段說明，這四個點的繪製相關原理。

當要開始繪製時，要先用

```
glBegin(GL_POINTS);
<要畫的內容>
glEnd();
```

#### 顏色與點座標

左上角的那個點是綠色，所以我們將顏色進行賦予。  

```cpp
glColor3f(0.0f, 1.0f, 0.0f);
```
並且座標是(-10,-10)

```cpp
glVertex2f(-10,-10);
```

#### 攝影機左右邊界

由於沒有特別設置下，攝影機會離目標物體非常近，所以我們將攝影機拍攝範圍拉大。  

```cpp
glOrtho(攝影機從中心點到左邊的距離,中心點到左邊的距離,中心點到下面的距離,中心點到上面的距離,近,遠);
```

由於我們是個2D圖形，所以遠近中，只要遠不要是0，則可以輸入任意數值，不會發生改變。  

我們如果將右側攝影機派社範圍調整成0，就是能拍攝到左側的影像，所以只會有兩個點:

```cpp
 glOrtho(-20.0, 0.0, -20.0, 20.0, 0.0, 1.0);
```
我們如果將左側攝影機派社範圍調整成0，就是能拍攝到右側的影像，所以也只會有右邊兩個點:

```cpp
 glOrtho(0.0, 20.0, -20.0, 20.0, 0.0, 1.0);
```

上下側的攝影機也是同樣道理。

## 繪製線條GL_LINES

我們接著來繪製一條線條  
GL_LINES會將美兩個座標視為一條線。  

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glLineWidth(50.0);
    glBegin(GL_LINES);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(0,10);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(0,-10);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```
在繪製線條之前我們記得先定義好線條的寬度，在這裡設置50

```cpp
glLineWidth(50.0);
```

並且我們在開始繪製的地方，聲明要進行線條繪製

```cpp
glBegin(GL_LINES);
```

由於線條是由兩個點構成的，所以繪製線條的方式，就是定義兩個點，然後中先的線條與顏色就會自動補上。  
此處我們第一個點設置紅色，位置在(0,10)  
此處我們第二個點設置紅色，位置在(0,-10)  

```cpp
glColor3f(1.0f, 0.0f, 0.0f);
glVertex2f(0,10);
glColor3f(0.0f, 1.0f, 0.0f);
glVertex2f(0,-10);
```

這樣就會在畫面中央出現一條，由上(y=10)到下方(y=-10)，位於畫面中央(x=0)，由紅色漸變為綠色的線條了。  


## 繪製線條GL_LINE_STRIP

GL_LINE_STRIP與LINES有點類似，但是不同在於，當輸入第三個座標點時，GL_LINE_STRIP會將其解釋為一連串的點連線，而LINE則需要再定義一個點才能夠完成兩點連線。  

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glLineWidth(50.0);
    glBegin(GL_LINE_STRIP);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}

```

## 繪製線條GL_LINE_LOOP

GL_LINE_LOOP會將所以的點進行連線，形成一個環形的物體，例如我們下方定義三個點，他將會被圍起來組成一個三角形。  

```cpp
//sudo apt-get install freeglut3-dev freeglut3
//gcc main.cpp  -o OutPut -lGL -lGLU -lglut
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glLineWidth(50.0);
    glBegin(GL_LINE_LOOP);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 繪製點狀線條 GL_LINE_STIPPLE

Stipple 就是點畫的意思。
我們可以對於圖形啟動點畫功能。

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glEnable(GL_LINE_STIPPLE);

    glLineWidth(50.0);
    glLineStipple(3,0xcccc);
    glBegin(GL_LINE_LOOP);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 繪製三角形 GL_TRIANGLES

給三個座標點即可繪製三角形。

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glLineWidth(50.0);
    glBegin(GL_TRIANGLES);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 繪製相黏折疊的三角形 GL_TRIANGLE_STRIP

當我們輸入四個點，但是卻用GL_TRIANGLES的三角行時，第四個點會被忽略。
GL_TRIANGLE_STRIP則可以將每個點視為相黏的三角形，進而創造複雜的三角形圖形。  

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(0.0f,0.0f,0.0f,0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glLineWidth(50.0);
    glBegin(GL_TRIANGLE_STRIP);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(10,10);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 繪製相黏的扇狀三角形 GL_TRIANGLE_FAN

這個功能與上一篇的GL_TRIANGLE_STRIP有點類似，但是同樣的點，生成三角形的模式不太一樣，GL_TRIANGLE_FAN將會蒐集每個點生成扇形的三角形。  

我們此處特地簍空來看看它的扇形三角形的結構，以下為簍空的函數。  

```cpp
glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
```

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(0.0f,0.0f,0.0f,0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);

    glLineWidth(50.0);
    glBegin(GL_TRIANGLE_FAN);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(10,6);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(10,11);
    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-20.0, 20.0, -20.0, 20.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```
## 繪製數個分離的矩形 GL_QUADS

GL_QUADS會將每四個解釋為一個矩形，進而會出多個矩形。

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(0.0f,0.0f,0.0f,0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);

    glLineWidth(50.0);
    glBegin(GL_QUADS);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(10,10);

        //---------------------------

        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(15,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(15,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(35,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(35,10);

    glEnd();

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-50.0, 50.0, -50.0, 50.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 混合線條與分離的矩形

似乎可以用不同的 **glBegin()** 與 **glEnd()** 來繪製出混何不同形狀的產物。

```cpp
//sudo apt-get install freeglut3-dev freeglut3
//gcc main.cpp  -o OutPut -lGL -lGLU -lglut
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(0.0f,0.0f,0.0f,0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);

    glLineWidth(50.0);

//--------------------------------------

    glBegin(GL_QUADS);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(10,10);



        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(15,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(15,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(35,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(35,10);
    glEnd();

//--------------------------------------

    glBegin(GL_LINES);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-15,10);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-15,-10);
    glEnd();

//--------------------------------------

    glFlush();
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-50.0, 50.0, -50.0, 50.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 相黏的矩形組 GL_QUAD_STRIP

GL_QUAD_STRIP這個形狀，會將數個不同的座標視為黏合在一起的矩形。  
所以我們建立兩個矩形之後，中間會產生兩條線段，將其連接。  

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(0.0f,0.0f,0.0f,0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);

    glLineWidth(50.0);

//--------------------------------------

    glBegin(GL_QUAD_STRIP);

        //QUAD 1
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(10,10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);

        //--------------------------
        //QUAD 2

        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(15,20);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(15,0);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(35,20);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(35,0);


    glEnd();


    glFlush();
//--------------------------------------
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-50.0, 50.0, -50.0, 50.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

## 多邊形 GL_POLYGON

會按照順序，將選到的點串成多邊形。

```cpp
#include <GL/glut.h>

void displayMe(void)
{
    glClearColor(0.0f,0.0f,0.0f,0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);

    glLineWidth(50.0);

//--------------------------------------

    glBegin(GL_POLYGON);

        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-10,10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(-10,-10);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(10,-10);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(15,0);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(35,0);

        glColor3f(1.0f, 0.0f, 1.0f);
        glVertex2f(35,20);

    glEnd();


    glFlush();
//--------------------------------------
}

void init()
{          
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrtho(-50.0, 50.0, -50.0, 50.0, 0.0, 1.0);
	 glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Is a window");
    glutDisplayFunc(displayMe);
    init();
    glutMainLoop();
    return 0;
}
```

<a href="#menu">回到目錄</a>  


