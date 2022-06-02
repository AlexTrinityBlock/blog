---
title: "Bootstrap響應式網頁出現白邊"
date: 2022-06-02T09:00:00+08:00
draft: true
featured_image: "/html-css-js.jpg"
tags: ["frontend"]
---

### 問題

在使用Bootstrap時，響應式網頁在手機上出現了白色的邊框。

雖然已經使用.container或者.container-fluid了，但仍然無法消去白邊!

### 解決

<h3 style="color:red;">
別在響應式元素.container與.container-fluid或row上，加入橫向的matgin或者padding !!!
</h3>

因為這樣會破壞掉Bootstrap原本的響應式布局。

在手機或者電腦的頁面上出現畫面大小錯誤。

### 建議用在container的CSS元素

```css
div{
    margin-top: 10px;
    margin-bottom: 10px;

    padding-top: 10px;
    padding-bottom: 10px;
}
```

### 不建議用在container的CSS元素(會破壞Bootstrap布局)
```css
div{
    margin:10px;
    margin-left: 10px;
    margin-right: 10px;

    padding:10px;
    padding-left: 10px;
    padding-right: 10px;
}
```