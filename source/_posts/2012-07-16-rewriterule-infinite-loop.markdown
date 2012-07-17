---
layout: post
title: "一条RewriteRule引发的血案"
date: 2012-07-17 21:41
comments: true
categories: 
 - 雕虫小技
---

这是一则拖了将近两个月的问题。事情的起因是我从某天开始发现服务器上的Apache进程`httpd`经常会莫名其妙地吃光所有的内存和Swap，然后因为内存占用过多被Kernel杀死。由于系统内存在多个httpd进程，于是这个现象便周而复始地发生，把整个服务器系统弄得很慢很卡。

由于以前没有相关经验，而这个问题的发生也存在一定的随机性，再加上服务器上跑着好几个虚拟主机，因此一直没有办法查出原因所在。在翻遍了Google，造访了[ServerFault](http://serverfault.com/questions/383291/apache-out-of-memory)后，仍然无解，于是这个问题就毫无头绪地搁置了许久。直到最近利用迁移服务器的机会，终于发现了线索。

<!--more-->

## [OOM Killer](http://linux-mm.org/OOM_Killer)

OOM Killer是Linux的一项保护机制，旨在内存不够用的时候杀掉一些进程，以保证系统能够稳定运行。OOM Killer在选择杀掉哪个进程的时候，会应用一个算法，一般来说消耗内存最大的那个进程是难以幸免的。在OOM Killer发生作用时，会向系统日志写入相关的信息。在我原先的一台2.6内核的系统上，会出现[类似这样的日志](http://pastebin.com/bszy9ahq)，而在最近的3.4内核中，会出现[如这样的日志信息](http://pastebin.com/bAK9rQye)。虽然信息量不尽相同，但是结果都是一样的，那就是一个httpd进程消耗了几乎所有的内存，然后被杀死。如果使用`top`命令实时监控的话，也会看到相同的现象。

## 如何排查？

可以获得的信息基本就是一段段OOM Killer的日志，和莫名其妙突然小宇宙爆发的httpd。翻阅了Apache、PHP、MySQL的各项日志后，也依然没有任何可疑的迹象。服务器上运行的虚拟主机有好几个，也无法定位到底是哪个和问题有关。何况问题的发生完全是随机的（应该跟访问有关），无法知道到底什么时候会内存泄漏，也就难以对比排除因素。万年小学生说，真相只有一个，那么真相呢？

前段时间正好入手了一台Linode，准备把原先的数据都迁移过去。这是一个解决问题的好时机。当范围缩小后，排查应该会容易许多。

## 目标锁定

因为不知道问题是如何触发的，每做一项操作就要等待一段时间，检查是否有内存泄漏的问题发生。在排除了MySQL和PHP的问题后，终于把目光锁定在了Apache本身上。注意到上次[迁移Octopress](http://blog.dayanjia.com/2012/04/migration-to-octopress-from-wordpress/)时留下的用作跳转的Rewrite规则，内容是这样的：

{% codeblock .htaccess lang:apache %}
RewriteEngine On

RewriteCond %{HTTP_HOST} ^www.dayanjia.com$ [NC]
RewriteRule ^(.*)$ http://dayanjia.com/$1 [R=301,N]

RewriteBase /
RewriteRule "^(|index.php)$" http://blog.dayanjia.com/ [R=301,L,NC]
RewriteRule "^20(.*)\.html$" http://blog.dayanjia.com/20$1/ [R=301,L,NC]
RewriteRule "^page/(.*)$" http://blog.dayanjia.com/page/$1/ [R=301,L,NC]
RewriteRule ^category/technical-articles$ "http://blog.dayanjia.com/category/雕虫小技/" [R=301,L,NE,NC]
RewriteRule ^category/released-works$ "http://blog.dayanjia.com/category/自娱自乐/" [R=301,L,NE,NC]
RewriteRule ^category/comments$ "http://blog.dayanjia.com/category/一家之言/" [R=301,L,NE,NC]
RewriteRule ^category/(miscellaneous|school-life)$ "http://blog.dayanjia.com/category/侃侃而谈/" [R=301,L,NE,NC]
RewriteRule ^sitemap.xml$ "http://blog.dayanjia.com/sitemap.xml" [R=301,L,NE,NC]
{% endcodeblock %}

一开始认为是规则中的非拉丁字符造成了什么奇怪的问题，事实上网上也的确有过[类似的报告](http://lists.debian.org/debian-apache/2012/03/msg00036.html)。阅读了邮件列表中的相关内容后也没有太大的收获，做出了一些小的修改，甚至把那几行带有中文的指令删除后，依然会零星发生内存问题。

这不得不让我让我重新审视这段配置，并仔细研究起[mod_rewrite的文档](http://httpd.apache.org/docs/2.2/mod/mod_rewrite.html)来。突然第四行中的标志`N`引起了注意，[手册](http://httpd.apache.org/docs/2.2/rewrite/flags.html#flag_n)中是这么解释该标志的：

{% blockquote %}
The [N] flag causes the ruleset to start over again from the top, using the result of the ruleset so far as a starting point. Use with extreme caution, as it may result in loop.
{% endblockquote %}

{% pullquote %}
仔细读了三遍后，我大脑如五雷轰顶天打雷劈一般恍然大悟——这句指令很可能造成了死循环！这条指令原本的目的是将带有www的访问重定向到不带www的URL中去。打开SSH开启top监控，然后在浏览器中输入`http://www.dayanjia.com`，果然httpd瞬间用尽了所有内存！将N标志去掉后，一切恢复正常了！{" 找到了！睡梦中的编程办法，就是这个编写程序的切入点！没错！ "} 想到这一点，我当时恨不得[立马拿来纸笔一口气写下20页代码然后昏睡三天](http://news.qq.com/a/20120705/000377.htm)。
{% endpullquote %}

## 循环陷阱

我原本以为在那条指令中执行了跳转，再从头执行规则的时候，`HTTP_HOST`就已经不是原来的值了，所以不会造成死循环。但是事实并非如此，将Rewrite日志开启后，可以清楚地看到这条指令不断地执行而无法跳出，RewriteLogLevel 2配置下瞬间就生成了300多MB的日志信息，也难怪内存会用尽吧。

找来[Apache的源码](http://archive.apache.org/dist/httpd/)大概浏览了一下，发现文档中“ruleset”的使用还是很精准的。事实是，循环的范围仅仅是一条或几条相关的指令本身，在循环执行时不会再去判断RewriteCond是否满足了。源码中使用的不是类似`while`循环的结构，而是直接`goto`跳转的。

## 内存你甘心嘛！

可以看出，Apache在这里将风险的识别交给了配置者，程序本身并没有做任何检查。这似乎也不是一个好方法，最起码可以说表现的不太完善。既然可以做到各种内存使用限制，那么检查一下潜在的死循环也不是什么难事吧。

{% img http://img.dayanjia.com/di/D17E/pointers.png %}