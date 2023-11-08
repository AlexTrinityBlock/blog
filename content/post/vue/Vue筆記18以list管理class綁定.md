---
title: "Vue筆記18以list管理class綁定"
date: 2021-03-19T00:39:36+08:00
draft: false
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記18以list管理class綁定

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
            list管理class可以產生
            顏色常駐為紅色，而大小則會改變
            效果
        -->
        <div v-bind:class="[active1,active2]">紅色的大字</div>
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            active1: "activeRed",
            active2: "activeFont"
        }
    })
</script>


</html>
```
