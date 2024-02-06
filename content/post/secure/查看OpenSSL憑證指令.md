---
title: "查看OpenSSL憑證指令"
date: 2024-02-06T12:05:49+08:00
draft: false
tags: ["secure","SSL","OpenSSL"]
featured_image: "/secure.jpg"
---

# 檢查憑證的指令如下

檢查憑證的指令可以用`-text`與`-noout`來查看憑證細節:

```bash
openssl x509 -in my.crt -text -noout
```

輸出類似:

```yaml
Certificate:
Data:
Version: 3 (0x2)
Serial Number: 3147495682089747350 (0x2bae26a58f090396)
Signature Algorithm: sha256WithRSAEncryption
Issuer: CN=kubernetes
Validity
Not Before: Feb 11 05:39:19 2019 GMT
Not After : Feb 11 05:39:20 2020 GMT
Subject: CN=kube-apiserver
Subject Public Key Info:
Public Key Algorithm: rsaEncryption
Public-Key: (2048 bit)
Modulus:
00:d9:69:38:80:68:3b:b7:2e:9e:25:00:e8:fd:01:
Exponent: 65537 (0x10001)
X509v3 extensions:
X509v3 Key Usage: critical
Digital Signature, Key Encipherment
X509v3 Extended Key Usage:
TLS Web Server Authentication
X509v3 Subject Alternative Name:
DNS:master, DNS:kubernetes, DNS:kubernetes.default,
DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP
Address:10.96.0.1, IP Address:172.17.0.27
```