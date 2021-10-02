---
title: "Vue筆記11偵測元素的創建與變更"
date: 2021-03-17T11:52:40+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記11偵測元素的創建與變更

```html
<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>

    <div id="tag01">
        <div>{{ text01 }}</div>
        <div style="color:red">{{ changeAlert }}</div>
        <button id="btn-01">Change1</button><br>
        <button id="btn-02">Change2</button>
    </div>

</body>

<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    //資料，裡面有tex01為文字內容
    //我們會將等等偵測到創造與更改
    //之警告放入changeAlert元素中                       

    var vueObjectData = {
        text01: 'faith',
        changeAlert: ''
    }

    var object01 = new Vue({
        el: '#tag01',
        data: vueObjectData,
        //此處的created屬性可以在該物件產生瞬間執行
        created: function() { //此處不可使用()=>箭頭函數
            this.changeAlert += '此物件被創造了'
        }

        /*
        此處還可以放置一個beforeCreate屬性，會在物件創造前呼叫
        使用方法等同上頭的create
        */
    })


    //$watch屬性用來偵測物件元素的改動
    //每當object01中的text01元素改動時，就會觸發下列函式
    object01.$watch('text01', function(newValue, oldValue) {
        this.changeAlert += '[改動!]'
    })

    /*
    object01.$mount(document.getElementById(某標籤id))    
    可以重新將物件掛載到其他html標籤
    但最好小心使用，因為不一定所有子元素都會被有效掛載
    記得～事情越簡單越好
    */
</script>

<script>
    document.getElementById('btn-01').addEventListener("click", function() {
        vueObjectData.text01 = "hope"
    })
    document.getElementById('btn-02').addEventListener("click", function() {
        vueObjectData.text01 = "love"
    })
</script>

</html>
```
