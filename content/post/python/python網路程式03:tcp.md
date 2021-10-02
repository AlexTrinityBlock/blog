---
title: "python網路程式03:tcp"
date: 2021-04-29T23:15:44+08:00
draft: true
featured_image: "/python.jpg"
tags: ["python","network"]
---
本篇引用自Foundations of Python Network Programming一書 

# 1.tcp通訊

```python
import argparse, socket

#如果長度不符預期，則發出錯誤提示
def recvall(sock, length):
    data = b''
    while len(data) < length:
        more = sock.recv(length - len(data))
        if not more:
            raise EOFError('was expecting %d bytes but only received'
                           ' %d bytes before the socket closed'
                           % (length, len(data)))
        data += more
    return data

def server(interface, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind((interface, port))
    sock.listen(1)
    print('Listening at', sock.getsockname())
    while True:
        print('Waiting to accept a new connection')
        sc, sockname = sock.accept()#client的tcp同意了我們的連接
        print('We have accepted a connection from', sockname)
        print('  Socket name:', sc.getsockname())
        print('  Socket peer:', sc.getpeername())
        message = recvall(sc, 16)#接收傳輸內容16個bytes
        print('  Incoming sixteen-octet message:', repr(message))#顯示字串時同時顯示型態類別
        sc.sendall(b'Farewell, client')
        sc.close()#關閉連線
        print('  Reply sent, socket closed')

def client(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((host, port))
    print('Client has been assigned socket name', sock.getsockname())
    sock.sendall(b'Hi there, server')#寄送內容
    reply = recvall(sock, 16)#接收傳輸內容16個bytes
    print('The server said', repr(reply))#顯示字串時同時顯示型態類別
    sock.close()#關閉連線

if __name__ == '__main__':
    choices = {'client': client, 'server': server}
    parser = argparse.ArgumentParser(description='Send and receive over TCP')
    parser.add_argument('role', choices=choices, help='which role to play')
    parser.add_argument('host', help='interface the server listens at;'
                        ' host the client sends to')
    parser.add_argument('-p', metavar='PORT', type=int, default=1060,
                        help='TCP port (default 1060)')
    args = parser.parse_args()
    function = choices[args.role]
    function(args.host, args.p)
```