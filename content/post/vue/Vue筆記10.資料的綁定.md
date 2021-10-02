---
title: "Vue筆記10.資料的綁定"
date: 2021-03-17T11:02:30+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記10.資料的綁定

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
        <div>{{ text01 }}</div>
        <div>{{ text02 }}</div>
        <div>{{ text03 }}</div>
        <button id="btn-01">Change</button>
    </div>
</body>

<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    //資料除存物件
    var vueObjectData = {
        text01: 'faith',
        text02: 'love',
        text03: 'nothing'
    }

    //實體化vue物件
    var object01 = new Vue({
        el: '#tag01',
        data: vueObjectData, //將資料除存物件與實體化物件榜定
    })

    //我們直接修改資料除存物件也可以產生更動
    document.getElementById('btn-01').addEventListener("click", function() {
        vueObjectData.text03 = "hope" //按下按鈕時將資料除存物件3改成hope
    })
</script>

</html>
```
