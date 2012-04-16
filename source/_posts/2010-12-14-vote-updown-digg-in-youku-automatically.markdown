---
layout: post
title: 给优酷视频的“顶”“踩”自动刷票
categories:
- 雕虫小技
tags:
- Python
- 教程
published: true
comments: true
---
最近一个高中同学说他们学校正在搞一个DV比赛，参赛者把自己的作品上传到优酷，然后其他人在浏览的时候点击“顶”按钮来投票。最终每个DV作品的“顶”的数量将会成为视频评奖的一个依据。于是，某人就心生歹念了，这个“顶”的数量是不是可以刷出来呢？来源于国外著名分享站点Digg的这一创意，实现起来其实很简单，优酷是怎样进行视频的“顶”和“踩”的操作的呢？其实这个所谓比赛没什么大不了的，技术无罪嘛！于是某人的好奇心涌上心头，手一抖就打开了某个优酷视频页面……

<!--more-->

## 手动刷票

{%img http://dayanjia.com/wp-content/uploads/2010/12/2010-12-14-19-56-46.png 329 254 %}

在给一个视频进行“顶”或“踩”的操作后，默认就不能再进行操作了。当然，这点小技俩多半是通过cookies来控制的（在中国ADSL盛行的环境下，根据IP来控制实在是荒唐）。我们顶过一个视频后，将浏览器的cookies清空，再刷新一下页面，果然又可以操作了。

## “顶”“踩”背后的HTTP操作

很显然，这个操作是通过JavaScript进行后台Ajax操作实现的。具体来说，多半是向一个URL发送一个请求，包含了一些参数。想要知道浏览器在访问网页时在背后干了些什么，我们就需要一些抓包工具了。在这里我们使用的是[Fiddler](http://www.fiddler2.com/)，一款专门的HTTP debug工具，它仅会抓取HTTP请求的内容，像视频流下载的数据就看不到了，因此抓取结果会清晰很多。

我们打开视频网页，开启Fiddler捕捉，点一下“顶”，我们便可以发现Fiddler中出现了两个结果，其中一个方法为POST，另一个为GET。根据经验，我们自然是更加关注POST方法的请求啦～

[{% img http://dayanjia.com/wp-content/uploads/2010/12/2010-12-14-22-01-36-580x371.png 580 371 %}](http://dayanjia.com/wp-content/uploads/2010/12/2010-12-14-22-01-36.png)

让我们看看Request的内容：

```
POST http://v.youku.com/QVideo/~ajax/updown HTTP/1.1
Host: v.youku.com
Connection: keep-alive
Referer: http://v.youku.com/v_playlist/f5376248o1p0.html
Content-Length: 73
Origin: http://v.youku.com
X-Prototype-Version: 1.5.0
X-Requested-With: XMLHttpRequest
Content-type: application/x-www-form-urlencoded; charset=UTF-8
Accept: text/javascript, text/html, application/xml, text/xml, */*
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Chrome/9.0.597.19 Safari/534.13
Accept-Encoding: gzip,deflate,sdch
Accept-Language: zh-CN,zh;q=0.8
Accept-Charset: GBK,utf-8;q=0.7,*;q=0.3
Cookie: isRemoveOnPlayComplete=true; YOUKUSESSID=csrinf00hpfb4u42k7hsfmk7k4; updown_XMjI5NTg4OTM2=1; updown_XMjI5NTc2Nzcy=1; updown_XMjI5NTc1ODQ0=1; PlayListTag=[{"videoid":"57393961","sec":18,"folderid":"5332617","order":"1","pos":"7"}]; wi={ ico_first: 'n5.gif', ico_secend: 'd5.gif', title_first: '%E5%A4%9C%E9%97%B4%3A%E5%B0%8F%E9%9B%AA', title_secend: '%E7%99%BD%E5%A4%A9%3A%E4%B8%AD%E9%9B%AA', phenomenon: '%E5%B0%8F%E9%9B%AA%E8%BD%AC%E4%B8%AD%E9%9B%AA', temperature: '-1%E2%84%83%2F2%E2%84%83', city: '%E5%8D%97%E4%BA%AC' }; __utmarea=103128-20383-3-1; __ysuid=12916513607349bb
 
__ap=%7B%22videoId%22%3A%22XMjI5NjIwNDgw%22%2C%22type%22%3A%22up%22%7D&_=
```

于是一切都一目了然了，POST的Entry中是经过URL Encode的字符串，我们把它解码后便可以得到`__ap={"videoId":"XMjI5NjIwNDgw","type":"up"}&amp;_=`。很明显吧，我们在点击“顶”的时候，浏览器后台向`http://v.youku.com/QVideo/~ajax/updown`发送了一个POST请求，请求内容为视频ID和类型（up还是down）。知道了这些，实现脚本自动刷票便不再是难事。

但是我们还有一个疑问，发送请求时cookies是一起发给浏览器的，服务端会不会用这个来判断是否是真实用户投票呢？看来我们还是得从JavaScript下手。

## 投票的JavaScript简单分析

通过简单的查找，我们可以发现优酷实现相关功能的代码在[v4.js](http://static.youku.com/v1.0.0627/v/js/v4/v4.js)这个脚本中，不过这个脚本是混淆过的。这个简单，网上有很多JS解混淆的工具（例如[这个](http://jscompress.sinaapp.com/ "JavaScript(JS) 压缩 / 混淆 / 格式化(美化)")）。搞定后，我们可以找到一个updown函数：

{% codeblock lang:js %}
updown: function(type) {
    if ((act = Nova.Cookie.get("updown_" + videoId2)) !== false && act != null) {
        return Interact.showUpDowned(act)
    }
    Interact.updownType = type;
    Nova.QVideo.updown({
        videoId: videoId2,
        type: type
    },
    this.updownCallback)
},
{% endcodeblock %}

可以发现，这个函数其实是调用了`Nova.QVideo.updown`，囧。这个QVideo的JS是直接写在HTML页面中的：

{% codeblock lang:js %}
Nova.QVideo = {
_name : 'QVideo',
 ........................
 updown : function(param, callback, id) { return nova_call('/QVideo/~ajax/updown', param, callback, id); }
};
{% endcodeblock %}

于是再找到[nova.js](http://static.youku.com/v1.0.0627/js/nova.js)，这个`nova_call`其实是一个辅助函数，它创建一个`NovaCall`对象，这似乎继承了[Prototype](http://www.prototypejs.org/ "Prototype JavaScript framework")这个JS框架中关于Ajax请求的内容。

{% codeblock NovaCall相关代码 lang:js %}
NovaCall = Class.create();
Object.extend(Object.extend(NovaCall.prototype, Ajax.Request.prototype), {
    initialize: function(url, param, callback, id, remote) {
        this.id = id;
        if(param===undefined){
            param = new Object;
        }
        param = JSON.stringify(param);
        if(remote!=undefined){
            //跨域名版本
            //callback 必须是字符串
            var method = 'get';
            this.url = url + '?__ap=' +encodeURIComponent(param) + '&__ai=' + id + '&__callback=' + callback;
            Nova.addScript(this.url);
        }else{
            var method = 'post';
            this.url = url;
            this.callback = callback;
            this.transport = Ajax.getTransport(url);
            this.setOptions({method: method, parameters: '__ap='+encodeURIComponent(param)});
            this.options.onComplete = this.recv.bind(this);
            this.options.onFailure = this.error.bind(this);
            this.request(this.url);
        }
 
    },
    recv: function(trans, obj) {
        if (!obj) {
            try { obj = eval('('+trans.responseText+')'); } catch(e) {}
        }
        this.callback(obj, this.id);
    },
    error: function() {
        if (window.nova_error_hook) window.nova_error_hook();
    else Nova.log('Error in transport.');
    }
});
{% endcodeblock %}

仔细看看，它竟然没有主动发送有关cookies的信息，看来我多虑了。绕了半天，我们也总算看出了“顶”和“踩”的内部实现方式，也加深了我们对其的理解。

## Python实现自动刷票
于是我们便可以使用Python中的`urllib2`来自动刷票了，模拟HTTP请求即可。为了增加“真实性”，我们在请求头部加了诸如User-Agent这几个参数。友情提醒：以下代码仅供参考。

{% codeblock vote.py %}
#!/usr/bin/python
# -*- coding:utf-8 -*-
 
import urllib2, time
 
url = 'http://v.youku.com/QVideo/~ajax/updown'
param = '__ap=%7B%22videoId%22%3A%22XMjI5NjIwNDgw%22%2C%22type%22%3A%22up%22%7D&_='
headers = {'Referer': 'http://v.youku.com/v_playlist/f5376248o1p0.html',
           'x-prototype-version': '1.5.0',
           'x-requested-with': 'XMLHttpRequest',
           'User-Agent': 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C)',
           'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}
 
request = urllib2.Request(url, param, headers)
i = 1
while i<300:
    response = urllib2.urlopen(request)
    print '%s Count: %s' % (response.read(), i,)
    time.sleep(2)
    i += 1
{% endcodeblock %}

{% img http://dayanjia.com/wp-content/uploads/2010/12/2010-12-14-22-32-40.png 357 363 %}

最后声明一下，本文仅供学习研究，请不要用于恶意用途哦～以上Python代码基于GPL v3发布。
