---
title: "Vue筆記 2:將字串插入目標標籤"
date: 2021-03-11T14:49:54+08:00
draft: true
featured_image: "/vue.png"
tags: ["vue","前端"]
---

# Vue筆記 2:將字串插入目標標籤

我們注意到vue導入特定文字需要四個部份：  
 1.目標html標籤，下列範例為tag01  
 2.目標標籤中的文字區塊，這裡為message01  
 3.被建立起來的vue物件，這裡為object01  
 4.在vue物件生成的同時插入該物件的訊息，el:標籤id,data:標籤內容

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
        {{ message01 }}
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!--引發字串插入效果的js-->
<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            message01: 'Life is sad but beautiful!'
        }
    })
</script>

</html>
```

此時畫面上會顯示

```text
Life is sad but beautiful!
```

## 動態修改標籤內容

如果要隨著需求動態修改標籤內容  
可以直接修改物件屬性  
以下範例：  

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
        {{ message01 }}
    </div>
</body>
<!--引入Vue-->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!--引發字串插入效果的js-->
<script>
    var object01 = new Vue({
        el: '#tag01',
        data: {
            message01: 'Life is sad but beautiful!'
        }
    })
    //動態修改標籤內的字串內容
    object01.message01 = "The one who is sad, who is blessed."
</script>

</html>
```

此時畫面上會顯示

```text
The one who is sad, who is blessed.
```
