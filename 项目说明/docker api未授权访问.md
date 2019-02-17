参考链接：
https://docs.docker.com/engine/security/https/?spm=5176.100239.blogcont48689.6.hMeNeP
https://www.ghostcloud.cn/home/mdShow?id=d519d2b4-2613-11e6-920b-0242c0a80002

漏洞原因：

`docker daemon -H unix:///var/run/docker.sock -H 0.0.0.0:2375`

漏洞利用：

`Zoomeye docker port:2375`

修复步骤：

    mkdir docker

1.生成CA私钥yao，ca-key.pem，使用该私钥对CA证书签名
ca-key.pem是一个临时文件，最后可以删除

    openssl genrsa -out ~/docker/ca-key.pem 4096

2.使用CA私钥生成自签名CA证书ca.pem。生成证书时，通过-days 365设置证书的有效期，单位为天，默认30天

    openssl req -new -x509 -days 365 -key ~/docker/ca-key.pem -sha256 -out ~/docker/ca.pem

3.生成服务器私钥server-key.pem和CSR server-csr.pem，CN为DockerDaemon。
server-csr.pem是临时文件，生成server-cert.pem以后可以删除。

    openssl genrsa -out ~/docker/server-key.pem 4096
    openssl req -subj '/CN=DockerDaemon' -sha256 -new -key ~/docker/server-key.pem -out ~/docker/server-csr.pem

4.使用CA证书生成服务器证书server-cert.pem。TLS连接时，需要限制客户端的IP列表或者域名列表。只有在列表中的客户端才能通过客户端证书访问Docker Daemon。在本例中，只允许127.0.0.1和192.168.1.100的客户端访问。如果添加0.0.0.0，则所有客户端都可以通过证书访问Docker Daemon。

    echo subjectAltName = IP:127.0.0.1,IP:192.168.1.100 > ~/docker/allow.list
    openssl x509 -req -days 365 -sha256 -in ~/docker/server-csr.pem -CA ~/docker/ca.pem -CAkey ~/docker/ca-key.pem -CAcreateserial -out ~/docker/server-cert.pem -extfile ~/docker/allow.list

5.生成客户端私钥client-key.pem和CSRclient-csr.pem。CN为DockerClient。
client-csr.pem是一个临时文件，生成client-cert.pem以后，可以删除。

    openssl genrsa -out ~/docker/client-key.pem 4096
    openssl req -subj '/CN=DockerClient' -new -key ~/docker/client-key.pem -out ~/docker/client-csr.pem

6.使用CA证书生成客户端证书client-cert.pem。需要加入extendedKeyUsage选项。

    echo extendedKeyUsage = clientAuth > ~/docker/options.list
    openssl x509 -req -days 365 -sha256 -in ~/docker/client-csr.pem -CA ~/docker/ca.pem -CAkey ~/docker/ca-key.pem -CAcreateserial -out ~/docker/client-cert.pem -extfile ~/docker/options.list

7.成功生成了需要的证书和密钥，可以删除临时文件

    rm -f ~/docker/server-csr.pem ~/docker/client-csr.pem ~/docker/allow.list ~/docker/options.list

8.为了保证证书和密钥安全，需要修改文件访问权限644

    cd docker
    chmod -v 0404 ca-key.pem client-key.pem server-key.pem
    chmod -v 0444 ca.pem server-cert.pem client-cert.pem

9.重启Docker Daemon

    service docker stop
    docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem \
      -H=0.0.0.0:4243 -H unix:///var/run/docker.sock

10.在客户端，运行docker命令时，加入ca.pem、client-cert.pem和client-key.pem。

    docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem \
      -H=$HOST:4243 version