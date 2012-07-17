---
layout: post
title: "解决景德镇局域网显示网站右侧推文的问题"
date: 2012-04-19 21:41
comments: true
categories: 
 - 雕虫小技
---

问题的大背景就不介绍了。因为Octopress是纯静态的，所以不可能像Wordpress插件那样在数据库里缓存推文，而需要客户端每次打开页面时使用AJAX去调用Twitter API。于是在大多数情况下就显示不了了。其实这个问题我本不想修复的，正如[互联网鄙视食物链](http://tech.sina.com.cn/i/2012-04-07/04486923463.shtml)所说，玩Twitter的都是一副鄙视众生高高在上的模样，『你们不配看到我写的东西』。呵呵，这样未免也太激进了些，秉持人人平等的原则，我们还是解决一下这个问题吧。

<!--more-->

## 解决问题

由于网站是放在自己的VPS上，所以操作起来限制是最少的。而现在只要是个主机就能跑PHP，那就写一个简单粗糙的脚本吧：

{% gist 2412067 %}

很明显，这就是做了一个代理。原本客户端要调用http://api.twitter.com自然不会成功，而当我们代用户获取了这一资源后，就只需要调用http://dayanjia.com来得到某个用户的推文了。因为只需要在网站的侧边栏上使用，所以代理只能完成一个特定的API操作。同时为了防止滥用，在脚本的开头限制了访问来源Referer。

将这个脚本放在服务器的Web目录下，接着打开source/javascripts/twitter.js文件，里面有一个getTwitterFeed的方法：

{% codeblock twitter.js https://github.com/imathis/octopress/blob/898b149dda088ef18832f04bd005acf7efc995d3/.themes/classic/source/javascripts/twitter.js on Octopress’s repo %}
function getTwitterFeed(user, count, replies) {
  count = parseInt(count, 10);
  $.ajax({
      url: "http://api.twitter.com/1/statuses/user_timeline/" + user + ".json?trim_user=true&count=" + (count + 20) + "&include_entities=1&exclude_replies=" + (replies ? "0" : "1") + "&callback=?"
    , type: 'jsonp'
    , error: function (err) { $('#tweets li.loading').addClass('error').text("Twitter's busted"); }
    , success: function(data) { showTwitterFeed(data.slice(0, count), user); }
  })
}
{% endcodeblock %}

把传递给ajax函数对象中的url修改为：

``` js
url: "http://your-domain.com/your-script-filename.php?user=" + user + "&count=" + (count + 20) + "&exclude_replies=" + (replies ? "0" : "1") + "&callback=?"
```

世界便被修复了。It just works, huh?

##JSONP

JavaScript中的XMLHttpRequest是不能跨域提交请求的，因为这是一项非常危险的操作。但是为什么这里可以呢？这便是JSONP的作用了。在进行JSONP调用时，必须要提交给服务器一个回调函数的名字，服务器实际返回的内容不是JSON数据本身，而是callback(jsonData)这样的形式。在实际操作时，会在HTML DOM中创建一个`<script>`标签，因为src属性的值是没有限制的，所以加载完后实际上是执行了回调函数。这些操作在$.ajax()中已经封装好，只需要给出参数`type: 'jsonp'`，并且在url中加入`&callback=?`就行了。不过Octopress默认主题并不是用的jQuery，貌似是一个语法非常接近的JS库。

##其他问题

显示最新推文的问题解决了，其实还有一个问题。那就是网站还用到了http://platform.twitter.com/widgets.js中提供的诸如显示“关注我”按钮，分享到Tiwtter等功能。由于这几个地方都有较好的Fallback，在这个js加载失败的时候尚能显示，那就不强求它了吧。