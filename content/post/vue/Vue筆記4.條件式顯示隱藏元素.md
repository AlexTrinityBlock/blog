---
title: "Vue筆記4.條件式顯示隱藏元素"
date: 2021-03-15T15:31:27+08:00
draft: false
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記4.條件式顯示隱藏元素

我們如果希望某些頁面元素，  
在特定條件下隱藏或顯示。  
甚至是將所有頁面元素放入同一頁，  
僅在需要時顯示必要部份。  
我們就可以採取v-if。  

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
        <!--命運顯示與否，由activeObject01決定，而恩賜顯示與否由activeObject02決定-->
        <div v-if="activeObject01">命運</div>
        <div v-if="activeObject02">恩賜</div>
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            //我們可以注意到底下兩個數值都是布林值
            activeObject01: true,
            activeObject02: true
        }
    })
    object01.activeObject01 = false
</script>

</html>
```
