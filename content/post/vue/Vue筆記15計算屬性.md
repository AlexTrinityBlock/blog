---
title: "Vue筆記15計算屬性"
date: 2021-03-18T20:50:44+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記15計算屬性

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <div id="tag01">
        <!--可以在綁定範圍內直接調用-->
        {{ addWord }}<br>{{ addWord }}<br>{{ addWord }}
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            message: "天氣晴朗"
        },
        //此物件屬性適用於計算或取得資料
        //message改動時回重新執行
        //若沒改動時則會使用快取內容
        //不會重新執行函數
        //所以就算上頭印了三次，實際也只執行一次
        //但是method:{}屬性不同，每呼叫一次都會執行一次函數
        computed: {
            addWord: function() {
                alert("執行")
                return this.message + "心情愉快"
            }
        }

    })
</script>


</html>
```
