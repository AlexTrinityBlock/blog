---
title: "Vue筆記7.同步表單與頁面文字"
date: 2021-03-16T00:06:55+08:00
draft: false
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記7.同步表單與頁面文字

可以藉由v-model來同步輸入框與物件內的資料  

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <!--要插入的目標位置-->
    <div id="tag01">
        <div>{{ text_content }}</div>
        <input v-model="text_content">
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            text_content: "日光之下皆是空虛" //此元素將與輸入框同步
        }
    })
</script>

</html>
```
