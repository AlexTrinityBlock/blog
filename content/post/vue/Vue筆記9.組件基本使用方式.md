---
title: "Vue筆記9.組件基本使用方式"
date: 2021-03-16T01:20:54+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記9.組件基本使用方式

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
        <!--
            v-for:讓模板循環數次，每次循環中item內容來自input_list的一個元素
            v-bind:input_item:將模板的input_item屬性綁定在上述的item中
        -->
        <my-temp v-for="item in input_list" v-bind:input_item="item" v-bind:key="item.id"></my-temp>
    </div>
</body>

<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    //註冊my-temp這個標籤
    Vue.component('my-temp', {
        props: ['input_item'],
        template: '<div>{{ input_item.text }}</div>'
    })

    //實體化vue物件
    var object01 = new Vue({
        el: '#tag01',
        data: {
            /*輸入清單陣列元素*/
            input_list: [{
                    id: 0,
                    text: "愛是恆久忍耐"
                }, {
                    id: 1,
                    text: "又有恩慈"
                }, {
                    id: 2,
                    text: "信實良善"
                }

            ]
        }
    })
</script>

</html>
```
