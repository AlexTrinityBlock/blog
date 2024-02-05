---
title: "關於OpenSSL憑證-建立自簽CA憑證與憑證登入授權要素"
date: 2024-02-05T23:00:49+08:00
draft: false
tags: ["secure","SSL","OpenSSL"]
featured_image: "/secure.jpg"
---

# 關於 CA

Certificate Authority，也就是 SSL 數位憑證的簽發機構。CA 負責對申請 SSL 憑證的網站進行身份驗證，並為其簽發一個包含公開金鑰和其他資訊的數位憑證。

# 創建一個 CA 自簽證書

既然在 SSL 中我們需要一個 CA ，我們這就來製作一個 CA 憑證。

### 1. 憑證金鑰

首先要有個鑰匙，雖然 ECDSA 也可以，但我們就來個經典 2048 bit 的 RSA 好了:

```bash
openssl genrsa -out ca.key 2048
```

我們目前有:

```
ca.key: 鑰匙檔案
```
   
### 2. 憑證簽署要求（Certificate Signing Request）

我們接著要生成一個憑證簽署要求（Certificate Signing Request）的CSR檔案，副檔名為 .csr ，在這個階段需要填入 CN (CN 是 Common Name) 平常使用網址，在此處我們用於 K8S ，就稱他為 KUBERNETES-CA 好了。

```bash
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
```

我們目前有:

```
ca.key: 鑰匙檔案
ca.csr: 憑證簽署要求檔案
```

### 3. 憑證檔案

接著我們就來生成憑證 (Certificate) 了，一般情況我們是將 .csr 檔案交給 CA 簽署。但既然我們自己要升成一個 CA 憑證，我們自己就是自己的 CA。

也就是用自己的鑰匙 ca.key ，簽署自己的憑證請求 ca.csr。

```bash
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
```

我們目前有:

```
ca.key: 鑰匙檔案
ca.csr: 憑證簽署要求檔案
ca.crt: 憑證檔案
```

# 用憑證登入某個主機叢集

既然我們有了自己的 CA 憑證，就可以用 CA 憑證簽發各種其他憑證了。

例如我們用 CA 憑證簽發 K8S 的 Admin 憑證:

生成鑰匙:

```bash
openssl genrsa -out admin.key 2048
```

發出憑證簽署要求，下面 CN 名稱是 kube-admin，OU 是 Organization Unit 的縮寫為 system:masters:

```bash
openssl req -new -key admin.key -subj \
"/CN=kube-admin/OU=system:masters" -out admin.csr
```

接著產生憑證，注意此處需要有 CA 憑證與 CA 鑰匙，安全的考慮這個步驟應該發生在 CA 主機上:

```bash
openssl x509 -req -in admin.csr –CA ca.crt -CAkey ca.key -out admin.crt
```

如果要採用這類型的憑證與鑰匙，使用 CURL 發出某個 HTTPS 請求，需要下方 3 要素:

```
ca.crt: CA 憑證
admin.crt: 管理員憑證
admin.key: 管理員鑰匙
```

具體指令如下:

```bash
curl https://網址 \
--key admin.key --cert admin.crt \
--cacert ca.crt
```