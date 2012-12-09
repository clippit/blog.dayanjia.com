---
layout: post
title: "Seedbox配置实例"
date: 2012-12-09 20:51
comments: true
categories:
 - 雕虫小技
---

前两天买了一台很便宜的独服，准备用作BT下载服务器，一般做这种用途的服务器被称作Seedbox。市面上有一些拿服务器配置好的Seedbox出售，基本可以做到开箱即用，包含了BT软件，用于客户同服务器交换文件的HTTP、FTP软件，甚至有些还提供了VNC或Windows远程桌面，方便小白用户。不过这些现成的Seedbox售价一般会比纯粹的独立服务器贵一些，同时也不符合我们「爱折腾」的特性。所以购买便宜的独服后自己架设各项服务才是使用Seedbox的不二选择。

<!--more-->

## 服务器提供商的选择

和一般的跑Web App的服务器或VPS不太一样，Seedbox有着它的特殊性。首先是网络带宽要保证，否则上传下载速度跟家用宽带差不多，就没有什么意义了。用作Seedbox的网络带宽最起码要保证100Mbit/s，如果有1Gbit/s甚至10GBits的当然更好。作为配合的每月流量限制也是越大越好，不限流量带宽又大的Seedbox简直是神器。其次是硬盘容量越大越好，高速Raid甚至大容量SSD硬盘配合高速网络可以发挥非常好的作用。而数据备份往往就不像那些跑Web应用和服务的机器那么重要了，反正都是从网上下载来的东西。

综合考虑以上条件和价格因素，我选择了[Kimsufi](http://www.kimsufi.com/)的KS 2G独立服务器。Kimsufi是欧洲著名提供商OVH旗下的廉价系列。KS 2G的价格是17.93欧元每月，这个价格包含了19.6%的增值税。作为海外消费者，我们可以向客服发取消征税的支持单，一般会被要求提供身份证复印件和近期账单等内容（不过这都是后话了，首次付费的增值税是没有办法报销的）。此外，OVH在英国使用的是另一套计费系统，货币单位是英镑，折算成人民币会比欧元贵一些，如果有朋友想购买需要注意这点。

{% blockquote %}
PS：如果有人看到这篇文章也想购买OVH的话，可以用我的Referral：zl5425-ovh
{% endblockquote %}

购买和启用的过程我就不详述了，OVH会让你选择一个操作系统，后期也可以在后台换系统重装。我选择的操作系统是Arch Linux，好像用来做服务器有点奇怪，不过不影响使用。

## 网络配置

OVH提供的Arch Linux镜像不是最新的，并没有使用[`systemd`](https://wiki.archlinux.org/index.php/Systemd)管理Daemons，不过这并无大碍。

不过在网络方面就不那么尽如人意了，默认只配置好了IPv4。事实上OVH早已支持IPv6，给Seedbox加上IPv6的支持可以进一步提升连接性。OVH提供的[IPv6配置指南](http://help.ovh.com/Ipv4Ipv6)有些语焉不详，在这里简单说明一下。OVH给每台服务器分配了一个/64的IPv6地址池，前缀可以在后台里看到，例如`2001:41d0:xxxx:xxxx::/64`。SSH进入系统打开`/etc/network.d/ovh_net_eth0`文件，在最后加上以下内容：

```
## For IPv6 static address configuration
IP6='static'
ADDR6=('2001:41d0:xxxx:xxxx::1/56')
GATEWAY6='2001:41d0:xxxx:xxff:ff:ff:ff:ff'
```

地址可以随便从那浩如烟海的范围里随便选择一个，需要注意的是默认网关的配置，本质就是把前缀的最后两位改成`ff`，后面的四段全部为`ff`。配置好以后重启网络，用`ip addr`便可以看到自己的IPv6地址了，用`ping6 ipv6.google.com`可以进一步测试是否配置正确。

此外，我们可以安装一个统计网络流量的小工具[`vnStat`](https://wiki.archlinux.org/index.php/Vnstat)，可以通过它了解到网卡的上传下载流量。使用`pacman -S vnstat`安装它，然后将其放到`/etc/rc.conf`文件的`DAEMONS`段中，启动服务后便可以记录流量了。

## 安装BT软件

Linux下的BitTorrent软件也有[很多种选择](http://en.wikipedia.org/wiki/Category:Linux_BitTorrent_clients)，用作Seedbox的主要是[rTorrent](http://libtorrent.rakshasa.no/)和[Deluge](http://deluge-torrent.org/)。这两款软件的共同点是都可以以Daemon模式运行在系统后台，图形界面并不是强制的（rTorrent甚至只有字符界面），软件操作可以通过Web UI来进行。rTorrent并没有自带Web UI，但是有功能非常强大的第三方软件[ruTorrent](https://code.google.com/p/rutorrent/)提供支持。Deluge是自带Web UI的，而且它还有一个优点是支持IPv6网络。rTorrent的IPv6支持[迟迟没有被作者提上开发日程](https://github.com/rakshasa/rtorrent/issues/59)，不得不让人感到遗憾。

因为我们决定在Seedbox上安装Deluge。安装过程很简单，直接通过官方源`pacman -S deluge`即可。安装完毕后可以将`deluged`和`deluge-web`加入系统DAEMONS中，以实现开机启动。

官方源中的Deluge安装脚本会创建一个新用户及组`deluge`来运行相关的守护程序，并且它的Home目录在`/srv/deluge/`。这有点不符合我们的系统（OVH的系统镜像给`/home`单独划分了一个分区，分配了很大的空间），可以将它改成`/home/deluge/`，今后下载的目录便可以设置为`/home/deluge/downloads/`。

    # usermod --home /home/deluge deluge

当启动了上面两个服务后（`rc.d start deluged`和`rc.d start deluge-web`），我们可以在浏览器中打开`http://host-name:8112`，便可以看到Deluge的Web UI了，默认的登录密码是`deluge`。为了安全起见，可以在设置面板更改密码，也可以更改监听的端口，甚至启用HTTPS等。

Deluge的使用和配置比较简单，在这里就不详述了。

## 用户下载服务

我们用Seedbox加入了BT种子，服务器下载完毕后，我们需要将文件传输到本地来。当然，使用SSH传文件也是可以的，不过速度一般不太理想。速度快，并且能很好支持多线程下载和断点续传的，自然是HTTP服务。

HTTP服务器我选择了[Nginx](http://nginx.org/)，这是一个很轻量的HTTP服务器，性能卓越，此外支持很好的反向代理功能，这使我可以将Deluge Web UI通过反向代理轻松地接入80端口，同下载服务并存。在实际使用时，我安装的是[OpenResty](http://openresty.org/)，可以顺便利用Seedbox的服务器环境学习一下这个平台，这也是我第一次接触Nginx。Nginx有一个很大的缺点是不能动态加载库，第三方库必须静态编译进主程序内，而OpenResty提供了许多强大好用的第三方库，是个搭建在Nginx上的高性能平台。同时可以将它当作一个Web开发框架来使用，可以直接在Nginx配置文件里使用Lua语言编程，甚至直接连接后端的数据库和缓存服务，构建支持超大并发的Web服务。OpenResty项目的主要维护者是[章亦春](http://agentzh.org/)，曾经的阿里系牛人，如今在知名CDN服务商CloudFlare供职。

既然选择了OpenResty，那就得手动从源码编译了。AUR中虽然有用户维护的包，但是稳定版已经许久没有更新了，而且安装脚本也不尽如人意。此外，Nginx中自带的[`autoindex`](http://nginx.org/en/docs/http/ngx_http_autoindex_module.html)模块有些简陋——这是一个把目录文件列表输出成Web页面的模块——但这个功能对于Seedbox来说很有用，于是我们还将把第三方模块[FancyIndex](http://wiki.nginx.org/NgxFancyIndex)编译进Nginx中。

``` bash
wget http://agentzh.org/misc/nginx/ngx_openresty-1.2.3.8.tar.gz
tar xzvf ngx_openresty-1.2.3.8.tar.gz
git clone git://gitorious.org/ngx-fancyindex/ngx-fancyindex.git ngx-fancyindex
cd ngx_openresty-1.2.3.8
./configure \
  --with-luajit \
  --with-http_iconv_module \
  --add-module=../ngx-fancyindex \
  --sbin-path=/usr/sbin/nginx \
  --conf-path=/etc/nginx/nginx.conf \
  --http-log-path=/var/log/nginx/access.log \
  --error-log-path=/var/log/nginx/error.log \
  --pid-path=/var/run/nginx.pid \
  --lock-path=/var/lock/nginx.lock \
  --user=http \
  --group=http \
  --with-ipv6
make
make install
# 把http用户加入deluge组，这样便可以直接访问下载回来的文件了
usermod -a -G deluge http
```

这样便装好了OpenResty。在`configure`结束后，可以看到几个关键路径的位置。

> nginx path prefix: "/usr/local/openresty/nginx" <br />
> nginx binary file: "/usr/sbin/nginx" <br />
> nginx configuration prefix: "/etc/nginx" <br />
> nginx configuration file: "/etc/nginx/nginx.conf" <br />
> nginx pid file: "/var/run/nginx.pid" <br />
> nginx error log file: "/var/log/nginx/error.log" <br />
> nginx http access log file: "/var/log/nginx/access.log"

同样地，把`nginx`放入`/etc/rc.conf`的`DAEMONS`中以便开机启动。

打开`/etc/nginx/nginx.conf`，可以看到Nginx的配置文件还是很简单的。我们的主要配置都是在`http`→`server`段中，在其中加入：

``` nginx
location /downloads {
    # 配置目录
    alias /home/deluge/downloads;
    charset utf-8;

    # 文件索引
    fancyindex on;
    fancyindex_exact_size off;  # 显示友好的文件大小

    # 密码访问
    auth_basic "Restricted";
    auth_basic_user_file htpasswd;

    # 限制IP，国内上网的IP一般都是动态的，
    # 所以可能需要经常修改这里，或者加上
    # 多个IP段
    allow 61.171.0.0/16;
    deny all;

    # 给NFO文件转换编码
    location ~* \.nfo$ {
        iconv_filter from=cp437 to=utf-8;
    }
}
```

首先我们将`http://host-name/downloads`的根目录设置成`/home/deluge/downloads`，然后打开文件索引的功能，这样便可以直接在浏览器中浏览下载目录中的文件了。为了限制只有客户机能访问到这些资源，我们可以给它加上密码和IP限制已确保私密性（以及防止迅雷等神器盗链）。限制密码访问需要创建一个`/etc/nginx/htpasswd`文件，可以使用以下命令：

``` bash
printf "USERNAME:$(openssl passwd -crypt PASSWORD)\n" > htpasswd
```

这样便创建了以`USERNAME`为用户名，`PASSWORD`为密码的用户。

最后一点，给NFO文件转换编码显示，是一个很有意思的小功能。大家知道Scene Release都会带有[`.nfo`文件](http://en.wikipedia.org/wiki/.nfo)来介绍资源的一些信息，同时这个文件也是个[ASCII Art](http://en.wikipedia.org/wiki/ASCII_art)，不过它们的编码往往使用的是ASCII的一种超集[Code Page 437](http://en.wikipedia.org/wiki/Code_page_437)。所以这里就用到了OpenResty中包含的[`iconv-nginx-module`](https://github.com/calio/iconv-nginx-module)，调用`libiconv`进行编码转换。要在浏览器中直接显示NFO文件的内容，还需要编辑`/etc/nginx/mime.types`文件，在`text/plain`类型的后面加入`nfo`这种扩展名。

{% img http://img.dayanjia.com/di/HU28/seedbox.png %}

## Nginx到Deluge的反向代理

默认情况下，我们可以通过访问`http://host-name:8112`来管理Deluge。不过既然安装了Nginx，那么不妨将其转移到`http://host-name/deluge`来进行，这样便可以避免使用一个奇怪的端口，同时还能享受到Nginx的其他便利。

在Nginx配置文件中继续加上下面的内容配置反向代理：

``` nginx
location /deluge {
    proxy_pass http://127.0.0.1:8112/;
    proxy_redirect  off;
    proxy_set_header  Host            $host;
    proxy_set_header  X-Real-IP       $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X-Deluge-Base   /deluge/;
}
```

同时我们注意到Deluge Web UI使用的是[Twisted](http://twistedmatrix.com/)作为网络服务器的，它本身是很强大，但是Web UI的代码中并没有很好地设置静态文件的缓存，导致每次打开Web UI都要加载很久（主要是其中用到的Ext JS库文件很大）。既然我们已经使用Nginx作为前端，那么便可以代Twisted设置一下浏览器缓存了。

``` nginx
location ~* /deluge/(.+)\.(ico|css|js|gif|jpe?g|png)$ {
    expires max;  # 设置永不超时的浏览器缓存
    proxy_pass http://127.0.0.1:8222/$1.$2;
    proxy_redirect  off;
    proxy_set_header  Host            $host;
    proxy_set_header  X-Real-IP       $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X-Deluge-Base   /deluge/;
}
```

重启Nginx服务器后，一切配置生效。

## 自动下载

有了Seedbox，却要每次手动去上传种子文件给它去下载显然是一件很糟糕的事情。而自动监控PT站点更新，迅速开始下载，不但免去了人工，还可以在第一时间开始上传，获取更大的上传量。[Flexget](http://flexget.com/)便是一个很好的自动下载管理工具。它的主要工作流程有三步，首先是输入，从原始来源获取下载列表，其次是过滤，即根据规则去掉不需要下载的文件，最终是输出，将文件下载完毕后进行的操作。每一个步骤都是由数量众多的插件支撑的，因此Flexget的配置非常灵活。事实上我曾经一直想写一个这样的工具，没想到开源社区里已经有这样的实现了，真是让人感慨。

和Deluge一样，Flexget也是用Pyhon写成的，不过它可以轻松地使用`pip`来安装：

    # pip install flexget

我们想以deluge用户的身份去运行Flexget，所以最好切换到相应的用户去进行操作。不过Arch Linux官方源里Deluge安装时生成的deluge用户是没有Shell的，所以还需要先给他指定一下Shell，然后再切换过去。

    # usermod -s /bin/bash deluge
    # su deluge

Flexget可以被Cron守护进程定时启动，所以我们需要使用`crontab -e`打开deluge用户的Crontab进行编辑，在其中加上：

``` bash
# 前三行是为了指定一些Cron执行时的环境变量
LANG=en_US.UTF-8
LANGUAGE=en
LC_CTYPE=en_US.UTF-8
# 每30分钟执行一次，时间可以调整，不过不需要太贪心每一分钟运行
*/30 * * * * /usr/bin/flexget --cron
```

我们可以首先手动运行一下`flexget`，它会在`/home/deluge/.flexget`下创建一个合适的目录结构。其中`config.yml`便是其主配置文件了。前面有说过Flexget的配置相当丰富，所以这里也不详细展开了，只给一个例子吧。

``` yaml
tasks:
  hdchina:
    rss: http://hdchina.org/rssdd.php?xxxxxxxxxxxxxxxxxxxxxxxx
    accept_all: yes
    quality: 720p+ !webdl
    download: /home/deluge/autoload
```

在这个例子中，我们创建了一个名为“hdchina”的任务，该任务的三个步骤分别是：

* 输入：从RSS读入更新，这个RSS地址可以在HDChina的网页上生成。
* 过滤：首先使用`accept_all: yes`表示全部接受，然后再用第二条指令去过滤掉不要的部分。[`quality`插件](http://flexget.com/wiki/Plugins/quality)可以根据资源的质量进行过滤。上面指令的含义便是分辨率至少为720p（包含了720p，1080i和1080p）并且排除WEB-DL资源。
* 输出：这里将种子文件下载到`/home/deluge/autoload`目录下。这个目录在Deluge中配置了自动加载，即Deluge会自动监控该目录下的.torrent文件，一旦出现便会立即加载进Deluge开始下载。事实上Flexget也有[Deluge插件](http://flexget.com/wiki/Plugins/deluge)，可以将种子文件直接传送到Deluge，这里为了简单起见没有做过多处理。

配置好了自动下载，每次Cron执行Flexget，它便会去执行我们指定的操作，实现了无人值守的Seedbox管理。当然，由于硬盘限制，我们不能无节制地下载，需要定期删除老的内容。这个操作可以手动去筛选，也可以交给Deluge的[自动删除插件](http://forum.deluge-torrent.org/viewtopic.php?f=9&t=36443)来完成。不过要小心自己想要取回本地的资源不要被误删除哦。
