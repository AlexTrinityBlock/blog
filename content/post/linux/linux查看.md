---
title: "linux查看Journalctl的log"
date: 2024-02-06T12:01:44+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","journalctl"]
---

# Journalctl 檢查近期 Linux 的Log。

`-f`: 在終端機上持續輸出。

`-n 100`: 近期 100 條 Log。

```bash
journalctl -f -n 100
```