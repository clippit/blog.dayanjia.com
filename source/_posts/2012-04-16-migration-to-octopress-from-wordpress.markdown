---
layout: post
title: "从Wordpress迁移到Octopress"
date: 2012-04-16 20:07
comments: true
categories: 
- 雕虫小技
---

这里自从去年5月以来发表了最后一篇文章后，已经停止更新将近一年了。其实这期间一直有再写点文章的欲望，但是每每登录到WordPress的后台，看到那愈发杂乱得不可收拾的网站配置时，就瞬间没有了热情。于是这次终于下了决心，是时候抛弃WordPress拥抱新时代了。

新时代属于自由开放的社群。正所谓，**对于计算机和一切能被用来改造这个世界的事物的使用都不应受到任何限制，任何试图隐藏系统的复杂性的行为都只会得到一个更为复杂的系统**。在WordPress让写日记（博客）这件事变得越来越复杂的时代，不如让我们回归原始吧。抛弃动态网页和数据库的组合，重新拾起静态网页和纯文本的组织，世间一切瞬间变得如此简洁而美丽。

这篇文章是一个新的开始，也顺便说说我在迁移时遇到的一些问题。

<!--more-->

## [Octopress](http://octopress.org/)

提到Octopress就不得不提到[jekyll](http://jekyllrb.com/)。jekyll是一个用ruby写的静态网页生成器，作者是mojombo，Github的创始人之一。事实上，我已经关注jekyll和Octopress很久了，今年帮院里制作的[十周年院庆网站](http://218.94.159.105)便用到了jekyll。Octopress基于jekyll，此外提供了一系列开箱即用的插件，外带一套还算不错的主题。

个人觉得，这两个工具还有很大的发展潜力，目前的版本在功能上还是有不少的欠缺的。但是这并不妨碍迁移到这个平台上，况且它们的纯粹性也使得增加新特性或者做Hack更加容易。

## 备份

### 备份评论内容

{% img right http://img.dayanjia.com/di/KLYQ/logo.png %}

Octopress由于是纯静态，所以没有办法存储用户评论了，我们可以使用[DISQUS](http://disqus.com/)提供的“云评论”服务。首先安装[DISQUS的WordPress插件](http://wordpress.org/extend/plugins/disqus-comment-system/)，在插件设置中我们可以将现有的评论内容导入到DISQUS中。DISQUS处理导入数据的时间比较长，往往需要24小时甚至以上的时间。

### 备份文章内容

在WordPress后台我们可以将整站数据备份成一个`.xml`文件下载下来。同时，我原先文章中的图片都是直接在Wordpress后台上传的，所以要把服务器上`wp-content/uploads`下的所有文件备份下来。

## 切换新站

大家可能注意到了，现在大眼夹的鸟巢已经换到了新的子域名blog.dayanjia.com上面。感觉这样似乎更加容易管理吧。至于安装和部署Octopress，[官方文档](http://octopress.org/docs/)里写的很详细，不再重复了。

原先网站用到的图片，就不麻烦了，还是留在原来的位置吧。之所以上面说要备份，是因为我顺便换了一台VPS（又是一笔迁移的成本啊），好在有`scp`可以将原先主机上的文件传输到新的主机。

Octopress没有办法上传图片，因此我建立了一个[图床](http://img.dayanjia.com)。像我这种写文章喜欢贴图的，今后就要先上传图片到那里，然后链接过来。那个图床似乎任何人都可以上传，如果大家有需要可以借用，不过千万别把我的VPS流量用光了:)

目前的新站我在主机上建立了一个私有Git版本库管理，今后可能会公开到GitHub上面去。

## 迁移

### 迁移文章

jekyll本身提供了一个从WordPress迁移文章的工具，不过对中文实在是不太友好。这里我使用了[YORKXIN](http://blog.yorkxin.org/2011/11/26/import-from-wpcom-to-octopress/)的[修改版本](https://gist.github.com/1394128)。将上面备份的`wordpress.xml`放到Octopress根目录，把脚本放到新建的`utils`目录中，然后运行：

```
ruby -r "./utils/wordpressdotcom.rb" -e "Jekyll::WordpressDotCom.process"
```

于是转换好的文章都放进`source`目录了。

虽然有自动转换工具，但是我之前在用到了很多Wordpress的Short Code，这些东西没办法还是得手工修改。我只修改了最近的十篇文章，更老的内容还没有去检查。毕竟这是一项体力活，或许今后有时间可以慢慢弄。

这次迁移，顺便把文章的分类名字也修改了一下，就是现在导航栏上的那几个成语了。修改文章分类很简单，在`source/_posts`目录里面批量替换一下就行。

### 迁移URL

虽然以前写了不少中二文章，不过再怎么样也是自己手打出来的，所以还是不忍心抛弃。迁移URL，便是要保证以前的文章链接能够自动重定向到新的链接上。这样既能保证搜索引擎的索引不受影响，也是一项对读者负责任的行为是吧。不过这是一项挺麻烦的事情。

幸好我当初建立WordPress的时候就留下了后路。原先网站的链接是这样的：

```
http://dayanjia.com/[year]/[month]/[the-long-long-title].html
http://dayanjia.com/page/xx/
http://dayanjia.com/category/[category-name]/
```

这样的格式是比较容易迁移的。如果原先的文章URL是带有数字ID的话，只能说声抱歉了。到`_config.yml`里面设置一下新站点的文章链接格式，跟原先的格式保持一致：

``` yaml
permalink: /:year/:month/:title/
category_dir: category
pagination_dir:  # 留空
```

这里我把文章URL最后的`.html`去掉了，而且由于改变了分类名称，这里面还需要再做一些工作。

新主机依然使用的Apache，于是到http://dayanjia.com根目录下新建`.htaccess`文件，加入重写规则，将原先的网址使用301重定向到新的位置：

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

稍微解释一下，一开始的两行是为了将带`www`的请求重定向到不带`www`上，接下来才是正式的重写。第7行是重定向首页的请求，今后如果要做一个`http://dayanjia.com`的bio页的话，就需要去掉重定向。第8行是重定向具体文章页面，因为它们都是以`20`开头的，所以取巧如此匹配了。然后便是重定向分类索引、分类索引和最后的站点地图了。

最后还有一项工作，便是重定向RSS Feed的地址。好在当年我又留了一手，用的是独立的`feed.dayanjia.com`域名，所以暂时把这个域名的解析301到`http://blog.dayanjia.com/atom.xml`就行了。

不管怎么说，当年的我还算有点高瞻远瞩吧，留得青山在不怕没柴烧，哈哈哈。

### 迁移评论

既然做好了301，那么迁移评论就显得非常简单了。登录DISQUS后台，进入站点管理后台的“Migrate Threads”栏目，那里有一个“Redirect Crawler”的功能，便是自动跟随301重定向，将评论指向新的网址。点一下那个按钮就大功告成。

## 接下来的工作

{% pullquote %}

默认的Octopress主题看上去很大气，不过千篇一律的东西总归会审美疲劳。所以修改甚至换一套主题还是很有必要的。

Ruby平台的工具在Windows下的表现很不尽如人意，我需要在Windows下和Linux下同时自如地使用这套平台，在中文处理和跨脚本语言交互（Octopress使用了Python下的Pygments进行代码高亮）上还需要做一些调整。今后可能单独开一篇文章讲讲这些。

前面说到，Octopress的功能还比较简单，比如标签云没有自带，这一点网上似乎已有解决方案。此外，我还想保持贴图的精神，给每篇文章加一个题头图片，就跟原来在Wordpress的那样。

{" 探索之路还很长。生命不息，折腾不止。"}

{% endpullquote %}