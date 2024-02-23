---
title: "Linux Service小筆記"
date: 2024-02-23T13:50:44+08:00
draft: false
featured_image: "/debian1.jpeg"
tags: ["linux","Service"]
---

# Service 啟動與關閉

Service 可以用在希望開機時自動運作一組程式或者 Bash 腳本，可以自動的啟動或者關閉一連串流程，甚至可以在程式崩潰時重啟。

這類操作由指令 service 與 systemctl 負責。

## systemctl 指令

以下是 systemctl 有關的指令:

```bash
# 啟動
sudo systemctl start <服務名稱>
# 關閉
sudo systemctl stop <服務名稱>
# 打開開機啟動
sudo systemctl enable <服務名稱>
# 關閉開機啟動
sudo systemctl disable <服務名稱>
# 重新啟動
sudo systemctl restart <服務名稱>
# 檢查狀態
sudo systemctl status <服務名稱>
# 重新載入設定檔
sudo systemctl reload <服務名稱>
# 查看所有服務
sudo systemctl list-units
# 查看所有正在運行的服務
sudo systemctl list-units --state=running
# 查看所有已啟用的服務
sudo systemctl list-units --state=enabled
# 查看所有已失效的服務
sudo systemctl list-units --state=failed
# 搜尋服務
sudo systemctl search <服務名稱>
# 取得服務設定檔
sudo systemctl cat <服務名稱>.service
# 編輯服務設定檔
sudo vi <服務名稱>.service
# 重新載入所有服務設定檔
sudo systemctl daemon-reload
# 幫助
sudo systemctl help
```

# 查看日誌

```bash
sudo journalctl -u <服務名稱>
```

# service 指令

另外我們可以用 service 指令完成相同操作，這次我們用具體指令來作範例:

```bash
# 啟動 ssh 服務
service ssh start
# 關閉 httpd 服務
service httpd stop
# 檢查 nginx 服務狀態
service nginx status
# 重新啟動 postfix 服務
service postfix restart
# 啟用 mariadb 開機啟動
service mariadb enable
# 關閉 redis 開機啟動
service redis disable
# 重新載入 dovecot 設定檔
service dovecot reload
```

# Service 執行腳本

系統服務執行腳本位置在:

```
/usr/lib/systemd/system/
```

自定義腳本默認在:

```
/etc/systemd/system/
```

如何查看服務腳本的位置?

```bash
systemctl show <服務名稱>
```

一般撰寫腳本的檔案名稱像是這樣:

```bash
/usr/lib/systemd/system/<服務名稱>.service
```

我們可以來觀察一下 SSH Server 腳本:

**/usr/lib/systemd/system/sshd.service**

```TOML
[Unit]
Description=OpenSSH server daemon
Documentation=man:sshd(8) man:sshd_config(5)
After=network.target sshd-keygen.service
Wants=sshd-keygen.service

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/sshd
ExecStart=/usr/sbin/sshd -D $OPTIONS
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
```

### [Unit]

Description：描述此服務的用途，這裡是「OpenSSH server daemon」（OpenSSH 服務守護程式）。

Documentation：指向相關文件的位置，這裡是 man:sshd(8) 和 man:sshd_config(5) 手冊頁。

After：指明此服務在哪些服務啟動之後才啟動，這裡是 network.target 和 sshd-keygen.service。

Wants：指明此服務希望其他服務也啟動，這裡是 sshd-keygen.service。

### [Service]

Type：指定服務的類型，這裡是 notify，表示服務啟動和停止時會發送通知。

EnvironmentFile：指定包含環境變數的文件，這裡是 /etc/sysconfig/sshd。

ExecStart：指定啟動服務的命令，這裡是 /usr/sbin/sshd -D $OPTIONS，其中 $OPTIONS 會被替換成設定檔中的選項。

ExecReload：指定重新載入服務配置的命令，這裡是 /bin/kill -HUP $MAINPID，向主程序發送一個 HUP 訊號。(HUP 是 Hangup 的縮寫，表示掛起。 它是一種訊號，可以用來通知進程關閉或重新開啟。)

KillMode：指定如何停止服務，這裡是 process，表示透過發送訊號殺死進程。

Restart：指定服務在崩潰後是否重啟，這裡是 on-failure，表示僅在失敗時重新啟動。

RestartSec：指定服務重啟的間隔時間，以下是 42s，即 42 秒。

### [Install]

WantedBy：指明此服務在哪些運行等級被啟動，這裡是 multi-user.target，即多用戶模式。