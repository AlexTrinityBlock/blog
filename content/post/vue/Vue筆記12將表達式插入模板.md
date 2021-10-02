---
title: "Vue筆記12將表達式插入模板"
date: 2021-03-18T20:50:23+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記12將表達式插入模板

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <div id="tag01">
        <!--此處會判斷布林值的真假-->
        {{ message01?'為真':'為假' }}
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            message01: true
        }
    })
</script>


</html>
```
