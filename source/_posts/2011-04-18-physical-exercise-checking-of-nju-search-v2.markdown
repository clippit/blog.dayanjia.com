---
layout: post
title: 南京大学体育锻炼刷卡查询 2.0 上线
categories:
- 自娱自乐
tags:
- CSS3
- HTML5
- jQuery
- php
- Web开发
- 南京大学
published: true
comments: true
---
自从上学期搞了这个<a title="体育刷卡次数查询：一次歪打正着的“社会化营销”" href="http://dayanjia.com/2011/01/a-lucky-hit-o.html" target="_blank">查询网站</a>后，似乎有种名声在外的感觉，以至于这个学期一开始就有许多人问我什么时候可以查到刷卡次数。有趣的是，自从上个学期的“拓荒”之后，各路有志者纷纷对体育部的网站提起兴趣，各类刷卡查询网站如雨后春笋一般出现。就我目前知道的，就有<a title="课外锻炼刷卡查询" href="http://usbuild.sinaapp.com/gym/index.php" target="_blank">这个</a>，<a title="南京大学体育锻炼刷卡次数查询 - 开心南大网" href="http://www.happynju.com/plugin.php?id=swipecard:card" target="_blank">这个</a>，还有<a title="体育课外锻炼打卡查询 @ 舍舍网" href="http://gym.sheshewang.com/" target="_blank">这个</a>。于是我就在想，是不是应该弄一个“正统续作”出来呢？好吧，现在续作来了，2.0版也已经上线了。当然，网址还是原来那个：<a title="南京大学体育锻炼刷卡查询 v2.0" href="http://dayanjia.com/gym/" target="_blank">http://dayanjia.com/gym/</a>

<!--more-->

其实查询的核心方法还是一样的，这次的2.0版主要加强了前端方面的工作。总是听到有人喊HTML5啊，CSS3啊，其实自己都没有怎么真正接触过，于是这次就稍微使用了一些HTML5的新特性，也玩了玩CSS3。当然，像<a title=" THE PAST, PRESENT &amp; FUTURE OF LOCAL STORAGE FOR WEB APPLICATIONS" href="http://diveintohtml5.org/storage.html" target="_blank">本地存储</a>、<a title=" LET’S CALL IT A DRAW(ING SURFACE)" href="http://diveintohtml5.org/canvas.html" target="_blank">Canvas绘画</a>这些比较高级的特性没有用到，只是尝试了一些新的标签和属性而已。至于CSS3，好玩的特效倒是挺多的，总的来说HTML5+CSS3大大减轻了JavaScript的负担，以前需要用JS写的很多功能，直接就给搞定了，的确很方便。今后倒是可以再开一新帖来讲讲心得体会吧。当然，像AJAX这些东西果断还是需要JS来做的，这次更新我把全站都AJSX化了，其实没几个需要AJAX的地方的。如此一来，所有的操作都不需要重新刷新页面了，是不是有点Web App的感觉呀？

现在HTML5、CSS3最大的问题就是浏览器支持不统一，相信时间可以解决这一切。不妨让我们看看不同的浏览器访问这个网站都是个什么效果吧。

<a rel="attachment wp-att-1234" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/chrome_gym"><img class="size-large wp-image-1234" title="Chrome下，效果很不错，标题是CSS3动画+jQuery动画的结果" src="http://dayanjia.com/wp-content/uploads/2011/04/Chrome_gym-580x496.png" alt="" width="580" height="496" /></a>

<a rel="attachment wp-att-1237" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/opera11-10"><img class="size-large wp-image-1237" title="Opera的渲染效果也是不错的，不过没有CSS渐变" src="http://dayanjia.com/wp-content/uploads/2011/04/opera11.10-580x510.png" alt="" width="580" height="510" /></a>

<a rel="attachment wp-att-1236" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/ie9_gym"><img class="size-large wp-image-1236" title="IE9不支持文本阴影，也不支持CSS动画，也没有渐变" src="http://dayanjia.com/wp-content/uploads/2011/04/IE9_gym-580x593.png" alt="" width="580" height="593" /></a>

<a rel="attachment wp-att-1235" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/firefox_gym"><img class="size-large wp-image-1235" title="Firefox支持的特性很多，不过文字旋转以后渲染效果就有些差了" src="http://dayanjia.com/wp-content/uploads/2011/04/firefox_gym-580x495.png" alt="" width="580" height="495" /></a>

<a rel="attachment wp-att-1241" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/cap201104172217"><img class="size-large wp-image-1241" title="Android的浏览器，基于Webkit的，效果尚可" src="http://dayanjia.com/wp-content/uploads/2011/04/CAP201104172217-e1303061912358-580x325.png" alt="" width="580" height="325" /></a>

<a rel="attachment wp-att-1240" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/cap201104172213"><img class="size-large wp-image-1240" title="Android下的Opera Mobile，效果比原生浏览器好很多，但是同样没有渐变了" src="http://dayanjia.com/wp-content/uploads/2011/04/CAP201104172213-e1303061783549-580x325.png" alt="" width="580" height="325" /></a>

<a rel="attachment wp-att-1242" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/img_0003-2"><img class="size-large wp-image-1242" title="iPad上的Safari，平板就是舒服" src="http://dayanjia.com/wp-content/uploads/2011/04/IMG_0003-450x600.png" alt="" width="450" height="600" /></a>

<a rel="attachment wp-att-1243" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/img_0263"><img class="size-large wp-image-1243" title="iPod Touch自然也不会差" src="http://dayanjia.com/wp-content/uploads/2011/04/IMG_0263-400x600.png" alt="" width="400" height="600" /></a>

<a rel="attachment wp-att-1244" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/img_0262"><img class="size-large wp-image-1244" title="iPod Touch/iPhone的输入框都是经过特别优化的，只有数字键盘" src="http://dayanjia.com/wp-content/uploads/2011/04/IMG_0262-400x600.png" alt="" width="400" height="600" /></a>

<a rel="attachment wp-att-1245" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/cap201104180125"><img class="size-large wp-image-1245" title="Opera Mini浏览其手机版，普通手机的浏览器都会自动跳转到所谓“手机版”，其实就是上个学期的版本的简朴界面" src="http://dayanjia.com/wp-content/uploads/2011/04/CAP201104180125-337x600.png" alt="" width="337" height="600" /></a>

<a rel="attachment wp-att-1246" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/screen_shot-1184"><img class="size-large wp-image-1246" title="用Kindle也会自动跳到手机版，这样看似乎页面还行" src="http://dayanjia.com/wp-content/uploads/2011/04/screen_shot-1184-450x600.gif" alt="" width="450" height="600" /></a>

<a rel="attachment wp-att-1247" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/screen_shot-1186"><img class="size-large wp-image-1247" title="但是用Kindle的人你真的伤不起呀！！" src="http://dayanjia.com/wp-content/uploads/2011/04/screen_shot-1186-450x600.gif" alt="" width="450" height="600" /></a>

<a rel="attachment wp-att-1238" href="http://dayanjia.com/2011/04/physical-exercise-checking-of-nju-search-v2.html/ie6_gym"><img class="size-large wp-image-1238" title="最后一张是IE6，没错，你被降级为手机版了！" src="http://dayanjia.com/wp-content/uploads/2011/04/IE6_gym-580x462.png" alt="" width="580" height="462" /></a>
