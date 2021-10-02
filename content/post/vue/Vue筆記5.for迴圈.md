---
title: "Vue筆記5.for迴圈"
date: 2021-03-15T18:31:39+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記5.for迴圈

若我們希望某個元素重複出現，例如卡片或商品外框  
但是內容要求不同，例如商品名稱，我們可採用v-for  

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
        <!--要執行迴圈的標籤-->
        <!--item可以隨意命名，此處只是個代號-->
        <div v-for="item in items">
            {{item.text}}
        </div>
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    //建立陣列元素
    var element = [{
        text: "仁愛"
    }, {
        text: "喜樂"
    }, {
        text: "和平"
    }, {
        text: "忍耐"
    }]

    //將陣列元素放入data
    var object01 = new Vue({
        el: '#tag01',
        data: {
            items: element
        }
    })
</script>

</html>
```
