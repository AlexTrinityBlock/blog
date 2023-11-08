---
title: "ASP.net找不到csc.exe"
date: 2022-03-01T12:00:44+08:00
featured_image: "/asp_net.png"
tags: ["ASP.net"]
---

打開上排選單的

工具>NuGet套件管理員>套件管理器主控台

然後輸入以下指令。

```
Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r
```