---
title: "Vue筆記14vbind與von縮寫"
date: 2021-03-18T20:50:44+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記14vbind與von縮寫

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <div id="tag01">
        <!-- v-bind:href="url"可以簡化成：href="url" -->
        <a :href="url">google連結</a><br>
        <!-- v-on:click="alert01"可以簡化成@click="alert01" -->
        <div @click="alert01">按我</div>
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            url: "https://www.google.com/",
        }
    })

    function alert01() {
        alert('hi')
    }
</script>


</html>
```
