---
title: "OAuth2.0概述"
date: 2022-03-11T09:00:49+08:00
draft: true
tags: ["secure","cc","ddos"]
featured_image: "/secure.jpg"
---

### Ps. 此篇也會用於我嘉義大學的專題討論課程與ISLasb實驗室Meeting

# OAuth2.0簡化圖

實際的細節比這個多了一點點步驟，不過這是從簡單的角度來理解OAuth。

(流程圖太小可以用按住Ctrl並且按+，來放大網頁。)

<div class="mermaid">
graph LR
    A["Client(如某個購物網站)"] --> |"1.Authorization Request(請求用戶登入Google)"|B["Resource Owner(使用者)"]
    B -->|"2.Authorization Grant(接受跳轉到Google登入)"| A
    A --> |"3.Authorization Grant(將用戶導向Google登入)"|C["Authorization Server(Google登入認證伺服器)"]
    C -->|"4.Access Token(返回存取Token給購物網站)"|A
    A -->|"5.Access Token(購物網將Token傳輸給儲存用戶資訊的資源伺服器)"|D["Resource Server(用戶資源伺服器)"]
    D -->|"6.Protected Resource(將被保護的用戶資訊傳給購物網站)"|A


</div>


<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>