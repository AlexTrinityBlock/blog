---
title: "SSH使用特定PEM檔案登入"
date: 2022-07-05T09:00:36+08:00
draft: true
featured_image: "/debian1.jpeg"
tags: ["linux","ssh"]
---

我們常常使用SSH登入某台主機或電腦，SSH可以用密碼或者金鑰檔案進行登入。

由於金鑰檔案的長度會比人類可以記憶的密碼長的多，所以通常而言更加安全。

以下是我們的鑰匙檔案:

```
keyfile.pem
```

## 1.暫時用PEM檔案的方法

假設我們要登入下面的網址:

```
domain.com
```

並且使用以下的使用者:

```
user
```

用在pem檔案常常更換的情境下，一次性的使用pem檔案。

則可以使用下列指令:

```bash
ssh -i keyfile.pem user@domain.com
```

## 2.永久使用PEM檔案的方法

這將會把pem檔案加入現有的pem檔案儲存庫:

```bash
ssh-add ~/keyfile.pem
```