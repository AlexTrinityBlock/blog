---
title: "Vue筆記13覆蓋原本標籤行為"
date: 2021-03-18T20:50:44+08:00
draft: false
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記13覆蓋原本標籤行為

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <div id="tag01">
        <div> {{ message01 }}</div>
        <!--啟動自訂的表單提交-->
        <form v-on:submit.prevent="alert01">
            <!--原本html表單提交的動作會被覆蓋-->
            <input type="submit" />
        </form>
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            message01: "無訊息"
        }
    })

    function alert01() {
        object01.message01 = "自訂表單提交被觸發"
    }
</script>


</html>
```
