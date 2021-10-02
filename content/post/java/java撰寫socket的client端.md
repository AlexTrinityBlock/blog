---
title: "java撰寫socket的client端"
date: 2021-09-24T20:00:44+08:00
draft: true
featured_image: "/java.jpeg"
tags: ["java"]
---


# 1.緣由

我今天在實驗室跟學長一起研究Java中Socket的撰寫，在此進行筆記以免忘記。  
Socket是由server與client組成，有時間將會補上Server的程式碼，並且加上註解。  
注意！這個與安卓的略為寫法不同，沒辦法混用。  

# 2.Java Socket Client端

```java
import java.net.*;
import java.io.*;


public class SocketClient {

    public static void main(String args[]) {
        //IP
        String address = "127.0.0.1";
        //Port號
        int port = 8765;

        //建立socket物件
        Socket client = new Socket();

        //建立"專門儲存ip與port號的物件"
        InetSocketAddress isa = new InetSocketAddress(address,port);
        try {
            //等待10秒，超過就失敗
            client.connect(isa, 10000);

            //建立取得傳輸內容的物件
            BufferedOutputStream out = new BufferedOutputStream(client.getOutputStream());
            //寫入要傳輸的訊息stream
            out.write("傳段訊息試試。瑪莉有個小狗\n".getBytes());
            //傳送訊息
            out.flush();
            //寫入要傳輸的訊息stream
            out.write("傳段訊息試試。瑪莉有個小貓\n".getBytes());
            //傳送訊息
            out.flush();


            //接收訊息的部份
            String line;
            //建立接收訊息的stream
            InputStream input = client.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(input));

//            //將接收到的訊息存入line
//            line = reader.readLine();
//            //螢幕上顯示
//            System.out.println(line);


//            如果要持續讀取訊息請這樣
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }



            //結束輸出與連線
            out.close();
            client.close();

        //連線失敗，或超過十秒時輸出
        } catch (java.io.IOException e) {
            System.out.println("連線失敗，原因如下:");
            System.out.println("IOException :" + e.toString());
        }
    }

}
```


