---
title: "如何有效的使用Fetch函數"
date: 2022-08-26T00:00:00+08:00
draft: true
featured_image: "/html-css-js.jpg"
tags: ["frontend"]
---

由於當前Fetch這種官方的前端AJAX函數，已經可以簡短的實現，再不換頁的情況下傳送訊息。所以可能的話盡量使用原生的Fetch函數來實現AJAX呼叫。

## Fetch 的 Post 範例

很多時候，Fetch的Post內容會意外的接收不到，這時候就需要用下面的格式加上Header，來生成完整的HTTP請求。

```javascript
// Fetch函數
fetch("帶http或https的網址", {
    // 方法為Post
    method: "post",
    // Header 一定要加入，否則在Laravel一類的框架可能會接收不到
    headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-Requested-With": "XMLHttpRequest",
    },
    // 將要傳送的內容轉換成JSON格式
    body: JSON.stringify({
        name: "王小明"
    })
}).then((response) => {
    // 將收到的回應轉換成JSON物件
    return response.json();
}).then((jsonObj) => {
    // 印出結果的JSON物件
    console.log(jsonObj);
});
```