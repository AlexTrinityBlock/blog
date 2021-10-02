---
title: "Android長期保存資料於SharedPreferences03"
date: 2021-09-09T15:00:44+08:00
draft: true
featured_image: "/android.jpg"
tags: ["android"]
---


# 1.目標

將資料存入Android的SharedPreferences，進行長期保存

*官方文檔*
https://developer.android.com/reference/android/content/SharedPreferences

# 2.前端

欄位：

1. 文字輸入欄位(將資料存入SharedPreferences)
2. 文字輸出欄位(從SharedPreferences取得資料)
3. 觸發按鈕(啟動上述過程)

前端欄位ID:

1. textToTarget
2. targetText
3. button

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

之後是後端的實踐，其中有幾個點是要注意的，特別是權限：

```java
package com.example.frontback;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import android.view.View;
import android.widget.TextView;
import android.widget.EditText;
import android.content.SharedPreferences;

public class MainActivity extends AppCompatActivity {

    //應用程式啟動時的函數
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    //按鈕壓下去後啟動的函數
    public void onBtnClick(View view){
        EditText textToTarget =findViewById(R.id.textToTarget);//取得文字輸入欄位
        String theInputInformation=textToTarget.getText().toString();//將輸入內容轉成字串

        /**
            SharedPreferences
            首先要取得一個SharedPreferences物件
            如果這個APP沒有事先建立一個檔案的話會在/data/data/[package.name]/shared_prefs/下建立一個檔案
            此處的檔案名稱應該是exampleTester.xml
            
            該檔案有幾種模式
            MODE_PRIVATE:只有這個APP
            MODE_WORLD_READABLE:所有APP都看得到
            MODE_WORLD_WRITEABLE:所有APP都看得到還能寫入
            MODE_MULTI_PROCESS:可以讓多個proccess同時存取
                        
        **/
        SharedPreferences pref = getSharedPreferences("exampleTester", MODE_PRIVATE);

        //將資料存到Preferences裡頭並且這筆資料的名稱叫"Data"資料內容取自變數theInputInformation，commit()是提交儲存。
        pref.edit().putString("Data", theInputInformation).commit();

        //從getSharedPreferences中取出資料，首先要指定儲存庫的檔案名稱exampleTester，然後存取模式，getString(<資料的名稱類似key>,<當沒有資料時預設的回傳數值>)
        String dataFromStorge=getSharedPreferences("exampleTester", MODE_PRIVATE).getString("Data","");
        
        //畫面上顯示資料
        TextView targetText = findViewById(R.id.targetText);
        targetText.setText(dataFromStorge);
    }
}
```

# 4.用adb檢查剛剛儲存的資料

一般來說下載過Android Studio之後會一併下載Android SDK，而adb這個安卓調適工具就在Android SDK裡頭  
至於具體adb在哪裡，請參考官方文檔  

https://developer.android.com/studio/command-line/adb

```
cd adb資料夾
```

由於我們剛剛是使用私有權限進行儲存的，所以需要先root才能看得到:
```
./adb root
```
取得權限之後登入設備
```
./adb shell
```
如果有多台裝置，可以先調出裝置列表

```
adb devices 
```

然後在進行登入
```
./adb -s <剛剛看到的裝置名稱> shell
```

我們來看看剛剛的檔案

```
cat /data/data/com.example.frontback/shared_prefs/exampleTester.xml                                                    
```

以下結果：

```xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="Data">I am data1</string>
</map>
```
我們可以看到，在剛剛名為Data的資料下，我們見到裡面儲存了一個"I am data1"字串。
