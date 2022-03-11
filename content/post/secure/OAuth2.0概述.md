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
    B -->|"2.Authorization Grant(接受用戶登入Google後取得的授權碼)"| A
    A --> |"3.Authorization Grant(將用戶授權碼傳給Google換取Token)"|C["Authorization Server(Googleg授權伺服器)"]
    C -->|"4.Access Token(返回存取Token給購物網站)"|A
    A -->|"5.Access Token(購物網將Token傳輸給儲存用戶資訊的資源伺服器)"|D["Resource Server(用戶資源伺服器)"]
    D -->|"6.Protected Resource(將被保護的用戶資訊傳給購物網站)"|A
</div>

[參考於RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749)

# Authorization Grant Code的實際樣貌

Authorization Grant Code也可以簡稱為Authorization Code，是第三方的網站，例如購物網站，或者以下的範例筆記網站Hackmd，取得用戶授權後所獲得的一組字串。

筆記網站在有了這組Authorization Code字串後，就可以向Google的資源伺服器索取關於使用者的一些祕密訊息。

**這是筆記網站向Google傳送的請求**

由於筆記網站Hackmd是採取get的方式傳送請求，所以多數的訊息會在URL裡頭。

```
 https://accounts.google.com/o/oauth2/v2/auth?response_type=code&redirect_uri=https%3A%2F%2Fhackmd.io%2Fauth%2Fgoogle%2Fcallback&scope=profile%20email&client_id=2128567378213-ddddcibvvn44slsdadbqigsdzc1no5exxas.apps.googleusercontent.com
```
我們可以來解析一下上頭的訊息

```
這個應該是Google的OAuth2伺服器
https://accounts.google.com/o/oauth2/v2/auth

這個則是告訴Google的認證伺服器，登入好後，重新跳轉回Hackmd的網站。
redirect_uri=https%3A%2F%2Fhackmd.io%2Fauth%2Fgoogle%2Fcallbac

這一段是說筆記網站可以存取的權限範圍有profile(個人檔案)與email，
%20是URL編碼的空白的意思。
scope=profile%20email

這一段則是我在Google的使用者ID
client_id=2128567378213-ddddcibvvn44slsdadbqigsdzc1no5exxas.apps.googleusercontent.com
```

**Google回應並且由客戶瀏覽器轉傳給筆記網站的Authorization Code**

我們可以看到下方code那一段，裡頭就是Authorization Code了。

```
code: 4/sAidkcpo907Xr5yFtANWh1TOObIFrA_WKBBQIIXnvuEX6myOl-tgdlSW4ly2skfivue84kf
scope: email profile https://www.googleapis.com/auth/userinfo.profile openid https://www.googleapis.com/auth/userinfo.email
authuser: 0
prompt: none
```

# Access Token的實際樣貌

**這一段內容是用戶瀏覽器無法看到的**

Authorization Server回應的Token的樣貌的HTTP requests通常長這樣。

注意下面這段的Token是放在HTTP Header中。

```
POST /rsvp?eventId=123 HTTP/1.1
Host: events-organizer.com
Authorization: Bearer 1/mZ1edKKACtPAb7zGlwSzvs72PvhAbGmB8K1ZrGxpcNM
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/1.0 (KHTML, like Gecko; Gmail Actions)

rsvpStatus=YES
```

以下就是Token內容
```
Authorization: Bearer 1/mZ1edKKACtPAb7zGlwSzvs72PvhAbGmB8K1ZrGxpcNM
```

而以下就是加密後的Token。
```
1/mZ1edKKACtPAb7zGlwSzvs72PvhAbGmB8K1ZrGxpcNM
```

# 關於OAuth2.0的安全問題參考資料

[OAuth2.0中文參考資料(極度推薦)](https://blog.yorkxin.org/posts/oauth2-1-introduction.html)

[PortSwigger部落格的OAuth2.0文章](https://portswigger.net/web-security/oauth)

[參考於RFC 6749關於OAuth2.0的規格](https://datatracker.ietf.org/doc/html/rfc6749)

[StackOverflow關於OAuth2.0的Token的樣子](https://stackoverflow.com/questions/25838183/what-is-the-oauth-2-0-bearer-token-exactly)

[OAuth2.0使用Bearer不記名Token的方法](https://datatracker.ietf.org/doc/html/rfc6750)

<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>