---
title: "java的打包筆記1"
date: 2024-03-10T12:00:44+08:00
draft: false
featured_image: "/java.jpeg"
tags: ["java"]
---

# Java 直接打包成 jar

假定我們有個 hello.java

```bash
# 把檔案編譯成 hello.class
javac hello.java 
# 把  hello.class 轉換成  hello.jar，-c 代表建立 jar 檔案，-f 代表指定檔案名稱。
jar -cf hello.jar hello.class
#或者
jar -cf hello.jar *.class
```

# 使用 Maven 打包

```bash
# Maven 打包
mvn package
# Maven 刪除 target 後打包
mvn clean package
```

執行 target

```bash
java -cp target/打包檔名.jar package類別.App
```