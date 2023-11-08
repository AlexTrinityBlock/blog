---
title: "Vue筆記 3:動態修改標籤屬性"
date: 2021-03-11T14:52:38+08:00
draft: false
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記 3:動態修改標籤屬性

稍微提到一下，如果這篇教學對你有幫助，請不要吝嗇教導你周圍的同事，我可以保證你一定會過得更快樂  

## HTMl標籤存在許多屬性

例如style屬性可以修改文字的顏色大小，基本上就是css  
還有title屬性，滑鼠停在該標籤上頭時會顯示出來的文字  

## 使用v-bind來動態修改屬性

v-bind:title="title_text"可以綁定title屬性到 title_text  
v-bind:style="text_color"可以綁定style屬性到text_color  

```html

<!DOCTYPE html>
<html lang="zh-hant-TW">

<head>
    <meta charset="UTF-8">
    <title>簡化版Vue學習</title>
</head>

<body>
    <!--要插入的目標位置-->
    <div id="tag01" v-bind:title="title_text" v-bind:style="text_color">
        若苦難必然會發生，行善受苦，總比行惡受苦好。
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>

<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            title_text: "",
            text_color: ""
        }
    })
    //此處將title屬性修改，這樣滑鼠停在文字上頭時就會顯示這段英文
    object01.title_text = "Be good! You can bear any pain."
    //這裡，我們動態修改文字顏色
    object01.text_color = "color:gray"
</script>

</html>
```

這樣的結果就是文字變成灰色  
滑鼠停在文字上時顯示 "Be good! You can bear any pain."  

