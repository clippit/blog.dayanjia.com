---
layout: post
title: 在PPTP VPN服务器上配置FreeRADIUS+daloRADIUS实现用户跟踪管理
categories:
- 雕虫小技
tags:
- daloradius
- freeradius
- Internet
- Linux
- php
- 教程
- 运维
published: true
comments: true
---
现在很多拥有国外VPS的朋友都纷纷安装了VPN服务来方便自己上网，有时候我们还会共享出一些帐号给自己的同学、朋友使用。使用VPN来上网、玩网游等能够有效地解决某些线路上的问题，但是用的人一多难免会出现资源分配不均的情况，这时合理的管理手段就显得很有必要了。不过拿常见的PPTP VPN来说，最简单的配置就是使用PPP的`chap-secrets`文件来静态地保存用户名和密码，这样我们没有办法知道各个用户连接VPN的时间，上传下载的数据量等信息，所谓用户跟踪管理完全就是一笔糊涂账。我们将目光转向一种更加高级的用户验证手段——RADIUS服务，用它就能实现完善的用户跟踪管理功能。

本文以CentOS 5.5操作系统上的PoPToP VPN服务为例讲述**配置FreeRADIUS服务，使用MySQL数据库管理用户验证信息，安装Web管理界面daloRADIUS**的方法，其他VPN例如L2TP、OpenVPN等类似。本文内容参考了诸多资料，恕不一一列出。

<!--more-->

## 前置条件

首先要保证使用`chap-secrets`验证的PPTP服务能够正常使用。关于配置简单PPTP VPN的方法不在本文的范围之内，请参考[这篇文章](http://www.black-xstar.com/blog/691.html "在CentOS下安装PPTP的VPN")或其他相关教程。

其次，你需要在服务器上安装好HTTP+PHP+MySQL环境，本例中使用Apache作为HTTP服务器。此外PHP需要安装PEAR。

## 科普时间

**PPP**：Point-to-Point Protocol，[点对点协议]("http://zh.wikipedia.org/wiki/%E7%82%B9%E5%AF%B9%E7%82%B9%E5%8D%8F%E8%AE%AE)，是工作在数据链路层的连接协议。常见的ADSL连接时使用的PPPoE便是指的以太网上的点对点协议（Point-to-Point Protocol over Ethernet）。而我们创建连接VPN时也会通过PPP来进行，*nix操作系统上的pppd能够完成这一任务，其进行用户验证的默认方法便是`chap-secrets`文件。配置完FreeRADIUS后，我们需要把用户验证这一环节交给RADIUS服务器来完成。

**RADIUS**：Remote Authentication Dial In User Service，远程用户拨号验证服务，基于[RFC2865](http://www.ietf.org/rfc/rfc2865.txt "RFC2865 - Internet Engineering Task Force")和[RFC2866](http://www.ietf.org/rfc/rfc2866.txt "RFC2866 - Internet Engineering Task Force")。具体的工作原理挺复杂的，仔细阅读这两个RFC标准应该可以搞明白。简单的说，它是一个兼顾验证（authentication）、授权（authorization）及记账（accounting）三种服务的协议，即[AAA协议](http://en.wikipedia.org/wiki/AAA_protocol)。RADIUS运行在应用层，使用UDP进行传输，它被广泛用于ISP和企业用来控制Internet或内部网络、无线网络的访问。

[{% img right http://freeradius.org/css/freeradius.png 188 39 'FreeRADIUS Logo' %}](http://freeradius.org/)

[**FreeRADIUS**](http://freeradius.org/)：是一个实现RADIUS协议的软件，基于GPLv2开源。它是目前部署最广泛的开源RADIUS软件。

[**daloRADIUS**](http://daloradius.com/)：是一个FreeRADIUS的Web挂历程序，使用PHP编写。

## 安装配置流程

### 配置FreeRADIUS

[1] 登入终端后，首先安装FreeRAIUS，一般源里两个版本，其中FreeRADIUS 1.x已经不被支持了，我们安装的是freeradius2。

{% codeblock lang:bash %}
yum install freeradius2 freeradius2-mysql freeradius2-utils
{% endcodeblock %}

[2] 安装完后，我们编辑`/etc/raddb/users`，在文件开头加上：`testing Cleartext-Password := "password"`。

{% blockquote %}
Tips：你需要了解如何使用SSH终端，和终端里文本编辑的方法，例如Vim的使用。
{% endblockquote %}

[3] 启动radiusd，第一次启动会生成密钥，稍等片刻即可。使用`-X`参数可以让调试信息直接输出屏幕：

{% codeblock lang:bash %}
radiusd -X
{% endcodeblock %}

[4] 新打开一个SSH终端，测试服务器是否连通：

{% codeblock lang:bash %}
radtest testing password 127.0.0.1 0 testing123
{% endcodeblock %}

如果看到Access-Accept就说明连接成功了。如果看到类似“Ignoring request to authentication address * port 1812 from     unknownclient”的文字，可能需要去修改`/etc/raddb/clients.conf`，将`client localhost`段下的`ipaddr`改为服务器的IP，而不是127.0.0.1。

测试连接成功后，我们可以把`users`里临时加上去的第一行删除。

[5] 下载ppp源码，因为要用到其中的配置文件：

{% codeblock lang:bash %}
wget ftp://ftp.samba.org/pub/ppp/ppp-2.4.5.tar.gz
tar zxvf ppp-2.4.5.tar.gz
cp -R /root/ppp-2.4.5/pppd/plugins/radius/etc/ /usr/local/etc/radiusclient
{% endcodeblock %}

[6] 编辑`/usr/local/etc/radiusclient/servers`，加上一组服务器和密钥，本例中为“MyVPN”：

{% codeblock %}
localhost MyVPN
{% endcodeblock %}

[7] 编辑`/usr/local/etc/radiusclient/dictionary`，将最后一行改为：

{% codeblock %}
INCLUDE /usr/local/etc/radiusclient/dictionary.microsoft
{% endcodeblock %}

可以再添加一行：

{% codeblock %}
INCLUDE /usr/local/etc/radiusclient/dictionary.merit
{% endcodeblock %}

[8] 编辑`/etc/raddb/clients.conf`，把`client localhost`段下的`secret`改成刚才指定的密钥。

[9] 编辑`/etc/raddb/radiusd.conf`，找到`$INCLUDE sql.conf`，去掉前面的`#`；找到`$INCLUDE sql/mysql/counter.conf`，去掉前面的`#`。

[10] 添加MySQL用户及数据库，你可以使用现成的phpMyAdmin等工具，也可以在终端下操作。本例中，创建了radius的用户和同名的数据库：

{% codeblock lang:sql %}
CREATE USER 'radius'@'localhost' IDENTIFIED BY '***';
CREATE DATABASE IF NOT EXISTS `radius` ;
GRANT ALL PRIVILEGES ON `radius` . * TO 'radius'@'localhost';
{% endcodeblock %}

[11] 编辑`/etc/raddb/sql.conf`，配置`login`（用户名），`password`（密码），`radius_db`（数据库名）等字段，并找到`readclients`一行，设为`yes`并去掉注释符号`#`。

[12] 编辑`/etc/raddb/sites-enabled/default`，根据下面的说明注释或取消注释相应的行：

  * `authorize`段，关掉`files`，打开`sql`，也可以把`unix`关掉
  * `preacct`段，关掉`files`
  * `accounting`段，打开`sql`，也可以把`unix`关掉
  * `session`段，打开`sql`
  * `post-auth`段，打开`sql`
  * `pre-proxy`段，关掉`files`

到这一步，我们的FreeRADIUS就算配置好了，用户信息都将保存在MySQL数据库中。至于数据库中的表，我们在后面统一导入。

### 配置daloRADIUS

[13] 首先下载并安装daloRADIUS，其中需要安装一个Pear-DB的包：

{% codeblock lang:bash %}
wget http://sourceforge.net/projects/daloradius/files/daloradius/daloradius-0.9-8/daloradius-0.9-8.tar.gz
pear install DB
mkdir /usr/share/daloRadius
tar zxvf daloradius-0.9-8.tar.gz
mv daloradius-0.9-8/* /usr/share/daloRadius/
rm -r daloradius-0.9-8
{% endcodeblock %}

[14] 这时我们将daloRADIUS中附带的sql文件导入MySQL数据库，别忘了输入密码：

{% codeblock lang:bash %}
mysql -uroot -p radius < /usr/share/daloRadius/contrib/db/fr2-mysql-daloradius-and-freeradius.sql
{% endcodeblock %}

[15] 编辑`/usr/share/daloRadius/library/daloradius.conf.php`，这是daloRADIUS的配置文件。首先是MySQL登录信息：

{% codeblock lang:php %}
$configValues['CONFIG_DB_HOST'] = 'localhost';
$configValues['CONFIG_DB_USER'] = 'radius';
$configValues['CONFIG_DB_PASS'] = '***';  // 设为自己的密码
$configValues['CONFIG_DB_NAME'] = 'radius';
{% endcodeblock %}

下面有一个daloRADIUS的bug，默认配置中有一个表名和我们导入的不一样，把它改过来：

{% codeblock lang:php %}
$configValues['CONFIG_DB_TBL_RADUSERGROUP'] = 'radusergroup';
{% endcodeblock %}

然后修改daloRADIUS的路径：

{% codeblock lang:php %}
$configValues['CONFIG_PATH_DALO_VARIABLE_DATA'] = '/usr/share/daloRadius/var';
{% endcodeblock %}

[16] 添加Apache虚拟主机，如果有Web控制面板什么的自然就方便多了，不然就编辑`/etc/httpd/conf/httpd.conf`，加入：

{% codeblock lang:apache %}
Alias /vpn "/usr/share/daloRadius/"
<Directory "/usr/share/daloRADIUS">
</Directory>
{% endcodeblock %}

[17] 重启重启Apache和MySQL：

{% codeblock lang:bash %}
service httpd restart
service mysqld restart
{% endcodeblock %}

[18] 打开浏览器，进入daloRADIUS的管理页面（本例中为`http://your.domain/vpn`），使用默认用户名`administrator`和密码`radius`登录。

daloRADIUS似乎写的不怎么样，最新稳定版已经是三年之前的了，不过作者直到现在还在更新SVN，下次有机会可以用最新的SVN版本试试看。在Management中添加一个新用户，注意密码类型选择Cleartext-Password。

[19] 在终端里再次启动`radius -X`，同时在另一个终端中用`radtest username password localhost 0 MyVPN`测试一下，看看现在是不是还能正常接通，如果没问题就OK，让我们把这套系统接驳到PPP上。

### 配置pppd

[20] 编辑`/etc/ppp/options.pptpd`，里面已经有许多配置选项了，我们要保证有下面的几行，如果没有就添加上去，为了保障用户登录的安全我们限制只使用MS-CHAPv2：

{% codeblock %}
refuse-pap
refuse-chap
refuse-mschap
require-mppe-128
require-mschap-v2
{% endcodeblock %}

在配置文件最后加上3行：

{% codeblock %}
plugin radius.so
plugin radattr.so
radius-config-file /usr/local/etc/radiusclient/radiusclient.conf
{% endcodeblock %}

### 启动服务

[21] 一切完成后我们不需要使用debug模式启动radiusd了：

{% codeblock lang:bash %}
service radiusd start
{% endcodeblock %}

[22] 当然，我们可以把radiusd和pptpd设为开机启动服务：

{% codeblock lang:bash %}
chkconfig radiusd on
chkconfig pptpd on
{% endcodeblock %}

至此，PPTP+FreeRADIUS+MySQL+daloRADIUS全部配置完毕，我们在本机上使用添加的用户名和密码拨入VPN，可以正常使用。在daloRADIUS中，还可以看到各个用户每次连接的时长，上传和下载的数据量统计等。daloRADIUS其他的使用方法，本文不再叙述。
