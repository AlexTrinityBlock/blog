---
title: "Android將使用者輸入傳入後端02"
date: 2021-09-09T14:00:44+08:00
featured_image: "/android.jpg"
tags: ["android"]
---


# 1.目標

這次的目標是要把前端輸入欄位的內容，接收到後端的java，然後再重新傳回前端。  

從前端擷取內容，對於像是帳號密碼登入，輸入金額，或類似的操作都有著很高的重要性。

# 2.前端

我們要設置三個東西：

1. 文字輸入欄位
2. 文字輸出欄位
3. 觸發按鈕

他們的id分別是:

1. textToTarget
2. targetText
3. button

按鈕上依附的函數名稱:

```
onBtnClick
```
完整的前端xml描述：
```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <!--輸出的文字欄位-->
    <TextView
        android:id="@+id/targetText"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="200dp"
        android:text="Target"
        android:textSize="48sp"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

    <!--輸入的文字欄位-->
    <EditText
        android:id="@+id/textToTarget"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="100dp"
        android:ems="10"
        android:inputType="textPersonName"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/targetText" />

    <!--觸發函數的按鈕-->
    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="100dp"
        android:text="Button"
        android:onClick="onBtnClick"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/textToTarget" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

# 3.後端

```java

package com.example.frontback;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import android.view.View;//調整前端需要用的類別
import android.widget.TextView;//顯示輸出文字的欄位
import android.widget.EditText;//輸入文字的欄位

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onBtnClick(View view){
        EditText textToTarget =findViewById(R.id.textToTarget);//取得輸入文字，名為textToTarget
        TextView targetText = findViewById(R.id.targetText);//取得輸出文字，名為targetText
        String theInputInformation=textToTarget.getText().toString();//取得輸入文字，將其轉為字串
        targetText.setText(theInputInformation);//將字串放入輸出文字欄位
    }
}
```
