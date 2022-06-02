---
title: "Bootstrap響應式網頁出現白邊"
date: 2022-06-02T09:00:00+08:00
draft: true
featured_image: "/html-css-js.jpg"
tags: ["frontend"]
---

## 問題

在使用Bootstrap時，響應式網頁在手機上出現了白色的邊框。

雖然已經使用.container或者.container-fluid了，但仍然無法消去白邊!

## 1.避免在響應式網頁中加上橫向擴大縮小元素

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

## 2.禁止手機瀏覽器縮放

***雖然會造成一些改變，但這個方法極度管用***

如果你用了

1. 大量動畫特效
2. fixed滿版元素
3. 各式載入畫面
4. 其他會動態影響畫面大小的操作

導致手機上頭畫面出現意外的白色邊框之類的，這種情況可以使用

***禁止手機的縮放***的方式來彌補。

使用以下標籤，會禁止所有手機網頁的縮放，但有無法放大文字的缺點。

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
```

但也沒關係，可以靠各種巧思，或者圖片另外連接來放大，來進行替代。

## 3.用vw,vh帶替%設定寬高

vh代表閱讀裝置的高度的比例，例如100vh代表裝置高度的百分之百。而vw則是寬度。

另外一種寬高的表現為%。width:100%，代表這個物體為其父元素的百分之百寬，但<span style='color:red'>不代表裝置的高度百分之百。</span>

所以當你需要一個佔滿整個橫向版面的圖片時可以嘗試以下兩種方式。

```css
width:100%;
```

或者

```css
width:100vw;
```

但是實際測試的結果來看，<span style='color:red'>不一定所有瀏覽器都穩定支持vw與vh。</span>

所以建議兩者都嘗試，如果仍然無解的話，請嘗試上面的方式，封鎖瀏覽器縮放。

## 4.Javascript手動修正

***　這種方法沒有經過驗證適用於所有裝置，除非別無選擇，否則建議方法2優先。 ***

```javascript
const scrollbarWidth = window.innerWidth - document.body.clientWidth
document.body.setProperty("--scrollbarWidth", `${scrollbarWidth}px`)
```

```css
:root {
	--viewportWidth: calc(100vw - var(--scrollbarWidth));
}
```

參見下列網誌:

[https://destroytoday.com/blog/100vw-and-the-horizontal-overflow-you-probably-didnt-know-about](https://destroytoday.com/blog/100vw-and-the-horizontal-overflow-you-probably-didnt-know-about)