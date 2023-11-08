---
title: "Android snackbar與除錯log04"
date: 2021-09-10T09:00:44+08:00
featured_image: "/android.jpg"
tags: ["android"]
---


# 1.目標

各種程式語言在執行的時候都可以看到一些log，方便我們除錯與對程式進行調整。  
Android上也存在著顯示log的工具。  

除此之外，還有一個功能就是，APP可以即時在畫面下方顯示灰色的提示條，  
這個功能稱為snackbar。  

# 2.log

log需要引入的類別：

```java
import android.util.Log;
```

log分為幾種：

1. Log.v():詳細模式
2. Log.d():debug模式專用
3. Log.i():輸出訊息
4. Log.w():警告模式
5. Log.e():錯誤顯示

函數的參數有
```java
Log.i(<標籤，隨便取名>,<想要顯示的log訊息>);
```
實際應用

```java
package com.example.test1;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.*;
import android.view.View;
import android.util.Log;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onBtnClick(View view){
        Log.d("ImALabelForLog","123123123");
    }
}
```
# 3.Snackbar

引入類別
```java
import com.google.android.material.snackbar.Snackbar;
```
具體使用方式

```java
package com.example.test1;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.*;
import android.view.View;
import com.google.android.material.snackbar.Snackbar;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onBtnClick(View view){
        Snackbar.make(view, targetText, Snackbar.LENGTH_LONG)
                .setAction("Action", null).show();
    }
}
```
