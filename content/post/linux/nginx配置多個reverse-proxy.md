---
title: "nginx配置多個reverse-proxy"
date: 2023-11-21T21:29:36+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","apt"]
---

我們可以看到 nginx 的配置檔案位於下面的位置。

```bash
/etc/nginx/nginx.conf
```

我們可以用下列方法來重新導向我們的 Domain name，可以導向容器，或者其他運作中的程式實例。

**nginx.conf**
```
server {
  server_name example1.com;
  location / {
    proxy_pass http://backend1;
  }
}

server {
  server_name example2.com;
  location / {
    proxy_pass http://backend2;
  }
}
```