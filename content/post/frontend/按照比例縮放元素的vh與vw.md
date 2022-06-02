---
title: "按照比例縮放元素的vh與vw"
date: 2022-06-02T12:00:00+08:00
draft: true
featured_image: "/html-css-js.jpg"
tags: ["frontend"]
---

### 當我們想按照畫面比例縮放一個元素時


我們可以用以下兩種方式

### %比例

```css
width: 30%;
```

這個元素為父元素寬度的30%。

<div style="width:50%;height:200px;background-color:black;">
<div style="width:30%;height:100px;background-color:aqua;margin-top:10px;"></div>
</div>

### vw,vh比例

```css
width: 100vw;
```

這個元素為瀏覽網頁的裝置的寬度的百分之30。

<div style="width:50%;height:200px;background-color:black;">
<div style="width:30vw;height:100px;background-color:aqua;margin-top:10px;"></div>
</div>

### 用途

如果用在網頁上，vw,vh很適合依照裝置比例縮放的元素，或者是滿版的元素。