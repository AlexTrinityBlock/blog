---
title: "Vue筆記17另一種class綁定方式"
date: 2021-03-19T00:39:05+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記17另一種class綁定方式

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<style>
    .activeRed {
        color: red;
    }
    
    .activeFont {
        font-size: 30px;
    }
</style>

<body>
    <div id="tag01">
        <!--
            當isActive被觸發時，將activeRed紅色屬性賦予標籤文字，
            同時isActiveFont也被觸發，activeFont字體放大class也被賦予
        -->
        <div v-bind:class="classObject">啟動會變紅</div>
        <button @click="activeNow">啟動</button>
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            classObject: {
                "activeRed": false,
                "activeFont": false
            },
        }
    })

    function activeNow() {
        object01.classObject.activeFont = !(object01.classObject.activeFont)
        object01.classObject.activeRed = object01.classObject.activeFont
    }
</script>


</html>
```
