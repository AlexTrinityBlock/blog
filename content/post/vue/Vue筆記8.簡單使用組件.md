---
title: "Vue筆記8.簡單使用組件"
date: 2021-03-16T00:45:10+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記8.簡單使用組件

vue框架對於重複使用網頁部件（例如按鈕，分隔線）提出了解決方案  
這類重複使用部件內容有些複雜  
以下先用最簡單但是無法更改內容的方式展現  
下個章節會提及如何動態改變內容  

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <!--物件目標標籤-->
    <div id="tag01">
        <!--會被置換成模板的標籤-->
        <my-temp></my-temp>
        <my-sad></my-sad>
    </div>
</body>

<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    //註冊my-temp這個標籤
    Vue.component('my-temp', {
        template: '<div>這個世界善惡參半</div>'
    })

    //註冊my-sad這個標籤
    Vue.component('my-sad', {
        template: '<div>天國的門是窄的</div>'
    })

    //上頭註冊的標籤在任何vue實例中都能被呼喚

    //實體化vue物件，並一定要掛上標籤，此處是tag01
    var object01 = new Vue({
        el: '#tag01'
    })
</script>

</html>
```
