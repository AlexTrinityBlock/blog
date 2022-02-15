---
title: "ASP.net架構簡介"
date: 2022-02-15T12:00:44+08:00
draft: true
featured_image: "/asp_net.png"
tags: ["ASP.net"]
---

# ASP.net初探
這只是隨意概括的淺談ASP.net的架構。

在這邊展示的是ASP.net的MVC架構網站的一個概括模型。

# 進入點與外層資料夾結構

我們的程式名稱稱為T001，我們可以看到專案生成了一個T001資料夾。

裡頭有個進入點T001.sln，可以直接用Visual Studio開啟，啟動我們的專案。

其中.sln檔案也就是Visual Studio.Solution，解決方案檔案，一個能將我們專案裡頭各種檔案資源組織的檔案。


![img](/blog/public/2022-02-15/1.png)

進入專案後看到的檔案

![img](/blog/public/2022-02-15/2.png)

# 專案中不同資料夾的用途

![img](/blog/public/2022-02-15/3.png)


# 在主頁面_Layout.cshtml中的內容

![img](/blog/public/2022-02-15/4.png)

# HomeController中的C#程式

在Controller中的內容有辦法送到前端，例如某些的參數或者陣列。

![img](/blog/public/2022-02-15/5.png)

# Index.cshtml中的內容

![img](/blog/public/2022-02-15/6.png)