---
title: "Vue筆記6.以按鈕啟動函數"
date: 2021-03-15T18:52:53+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記6.以按鈕啟動函數

我們建立一段字串"我是貓"在vue物件中  
然後用"addWord()"這個函式來添加"~喵!"在字串後頭  
要將函式放入vue物件的方法如下  

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
        <div>{{ message }}</div>
        <button v-on:click="addWord">添加文字</button>
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    //將陣列元素放入data
    var object01 = new Vue({
        el: '#tag01',
        data: {
            message: "我是貓"
        },
        methods: {
            addWord: function() {
                this.message = this.message + "～喵！"
            }
        }
    })
</script>

</html>
```
