---
title: "Mermaid畫出流程圖"
date: 2022-03-09T14:30:44+08:00
draft: true
featured_image: "/secure.jpg"
tags: ["math"]
---

我們可以用Mermaid這個Javascript函數庫來繪製出流程圖。

<div class="mermaid">
graph TD
    A(程式開始) --> B{A>1 and B=0}
    B -->|True| D(Y=A)
    B -->|False| E{A=2 or x>1}
    D --> E{A=2 or x>1}
    E{A=2 or x>1} --> |False| G(程式結束)
    E{A=2 or x>1} --> F(Y=X)
    F(Y=X) --> G(程式結束)
</div>


<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>

```html
<div class="mermaid">
graph TD
    A(程式開始) --> B{A>1 and B=0}
    B -->|True| D(Y=A)
    B -->|False| E{A=2 or x>1}
    D --> E{A=2 or x>1}
    E{A=2 or x>1} --> |False| G(程式結束)
    E{A=2 or x>1} --> F(Y=X)
    F(Y=X) --> G(程式結束)
</div>


<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
```
