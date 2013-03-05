---
layout: post
title: "给华为HG232家用路由器“越狱”"
date: 2013-02-10 20:03
comments: true
categories:
 - 雕虫小技
---

前言：这篇文章本来应该在去年的这个时候就写成的，不过一拖就拖了一年。趁着蛇年新年的大好时光，我来谈谈这部已经在家里服役了一年多时间却一直没有得到充分利用的路由器。

路由器的型号是华为HG232，是在办理宽带和iTV（一种IPTV设备）时由电信配备的。它的硬件接口和普通家用路由器别无二样，支持802.11n无线，拥有4个LAN口和1个WAN口，其中一个LAN口标记了“iTV”的特殊字样。不过令人失望的是，它不能自动PPPoE拨号，也就是说无论是通过有线还是无线连接到设备，都必须手动进行宽带拨号设置——在电脑上这尽管有些繁琐，但毕竟能用，可是在手机、平板上就麻烦了。同时路由器的系统配置页面仅仅提供了低权限用户的登录信息。为了获取对它的完全控制权，在这里借用一下iOS社区的称呼，我们就需要对它“越狱”。

<!--more-->

## 导出配置文件

首先查看设备背后的贴纸，可以获取连接的参数和登录信息。当然，这个`useradmin`显然是低权限账户。

{% img http://img.dayanjia.com/di/UJ6Y/hg232.jpg %}

登录后进入设备管理页面，别看这里只有一个重启的选项，其实背后大有玄机。更高级的功能都被隐藏起来了。

{% img http://img.dayanjia.com/di/NP4F/useradmin.png %}

事实上被隐藏的管理选项仅仅是简单地通过CSS隐藏了起来，功能一切正常。把USB备份配置相关的`display:none`样式删掉，在设备上插一个U盘，就可以把路由器的配置文件保存下来了。

## 解密配置文件

打开U盘里`e8_Config_backup/ctce8_HG232.cfg`文件，发现它居然是被加密的。

那就让我们来猜猜。一般来说，使用XML格式保存配置是很常见的，而基于字符的[替换加密](http://zh.wikipedia.org/wiki/%E6%9B%BF%E6%8D%A2%E5%BC%8F%E5%AF%86%E7%A0%81)也是非常常见的。替换加密的弱点就是可以通过词频统计找到替换表的突破口，那么基于这两点假设，我们认为配置文件中的`<`, `/`, `>`这三个字符的特征应该是非常明显的。不难发现这三个字符在密文中对应的是`x`, `^`, `|`，基于此我们就可以进一步肯定前面的假设了。最终我们便可以得到它加密的算法是：将字符ASCII码乘以2再对127取余。

既然方法已得到，那么自己编写一个解密工具就非常简单了。我[用Python写了一个脚本](https://github.com/clippit/huawei-hg)（毕竟是蛇年嘛）。使用方法很简单，在命令行下：

    translate.py < ctce8_HG232.cfg > ctce8_HG232.cfg.xml

便可以得到解密后的文件。

## 修改设备配置

在解密了的XML文件中，搜索`X_ATP_UserInfoInstance`便可以找到管理员用户名`telecomadmin`和它的密码了。登录后我们就可以看到完整的设置页面，接下去的操作便简单许多。

首先可以关闭路由器的TR-069远程管理功能，这就切断了电信从上游远程操控家里路由器的潜在通道。在“网络→宽带设置”中将TR069的连接禁用即可。

接下来便是打开PPPoE自动拨号。选择带有“INTERNET”字样的连接名称，将模式由Bridge改为Route，选择PPPoE后，便可以填写上网帐号和密码了。今后只要是连接到该路由器的电脑、手机、平板，就可以直接连上网了。

## 进一步获取控制权

如果仔细阅读配置文件，就会发现很多设置并没有在网页中出现，例如很让人感兴趣的Telnet功能：

```xml
<X_CT-COM_ServiceManage FtpEnable="0" FtpUserName="ftp" FtpPassword="ftp" FtpPort="21" FtpPath="/mnt" TelnetEnable="0" TelnetUserName="!!Huawei" TelnetPassword="@HuaweiHgw" TelnetPort="23" WebWanAccessEnable="0"/>
```

将其中的`TelnetEnable`设为`1`后，用上面的工具重新把它加密：

    translate.py < ctce8_HG232.cfg.xml > ctce8_HG232.cfg

在管理页面中有一个“启用USB自动恢复配置文件”的功能，将其打开。然后把上面的文件放入U盘原先的位置，连接到路由器上。它会每隔一段时间自动读取U盘中的配置文件并应用。所以等待三五分钟之后便可以确定我们的配置已经写入到设备了。接下来便可以尝试Telnet连接上去了，使用用户名!!Huawei和密码@HuaweiHgw登录。

    Welcome Visiting Huawei  Home Gateway
    Copyright by Huawei Technologies Co., Ltd.
    Login:!!Huawei
    Password:
    ATP>

输入`help`可以获取一些帮助信息，从中可以看出输入问号可以自动补全，不过经过我尝试问号却无法输入到控制台中。不过输入`shell`命令后，我们可以进入Busybox。

    BusyBox v1.9.1 (2011-03-21 20:21:24 CST) built-in shell (ash)
    Enter 'help' for a list of built-in commands.
    
    #

Busybox的环境很简单，甚至连个编辑器都没有，如果想要编辑文件就需要使用TFTP将文件传输到电脑上。不过有了Telnet我们就可以获取路由器更大的控制权了。例如可以先查看一下CPU信息：

    # cat /proc/cpuinfo
    system type             : Ralink SoC
    processor               : 0
    cpu model               : MIPS 24K V4.12
    BogoMIPS                : 212.99
    wait instruction        : yes
    microsecond timers      : yes
    tlb_entries             : 32
    extra interrupt vector  : yes
    hardware watchpoint     : yes
    ASEs implemented        : mips16 dsp
    VCED exceptions         : not available
    VCEI exceptions         : not available

类似地，我们可以查看到这台路由器的内存是32MB。

接下来的故事随大家自由发挥了，理论上来说[OpenWrt](https://openwrt.org/)这类的开源固件也是可以刷进这台设备的，不过我也还没有尝试。
