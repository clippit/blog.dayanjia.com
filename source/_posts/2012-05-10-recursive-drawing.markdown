---
layout: post
title: "有趣的递归画图板"
date: 2012-05-10 13:49
comments: true
categories: 
 - 侃侃而谈
---

[{% img right http://img.dayanjia.com/dt/DQT2/recursive_tree.jpg  Recursive Tree %}](http://img.dayanjia.com/di/DQT2/recursive_tree.jpg)

递归（Recursion）是编程里很有意思的一样东西，简单地讲就是自我调用、自我复制。主流的编程语言都支持函数的递归，在很多函数式语言中递归扮演着十分重要的作用。不过我今天不是来说这些枯燥的东西的，而是介绍一个很有意思的[递归画图板](http://recursivedrawing.com/)应用。题图便是用它画出来的一棵“二叉树”。

<!--more-->

## [Recursive Drawing](http://recursivedrawing.com/)

<embed src="http://player.youku.com/player.php/sid/XMzk0MTgyMzY0/v.swf" quality="high" width="480" height="400" align="middle" allowScriptAccess="sameDomain" allowFullscreen="true" type="application/x-shockwave-flash"></embed>

([HTML5播放](http://v.youku.com/v_show/id_XMzk0MTgyMzY0.html))

这个画图应用完全由JavaScript[写成](https://github.com/electronicwhisper/recursive-drawing on Github)，通过简单的圆形和矩形可以制造出千变万化的奇妙图案。作者在视频中演示了二叉树和Fibonacci树的制造过程，图形化的演示非常直观。

## 与 [Context Free](http://www.contextfreeart.org/)

Recursive Drawing 可以认为是 Context Free 的图形界面版。Context Free是一个通过代码生成递归图形的软件，而Recursive Drawing则是完全的所见即所得。

## 分形

使用Recursive Drawing我们可以创造一些好看的[分形](http://zh.wikipedia.org/zh-cn/%E5%88%86%E5%BD%A2)图案。例如我可以先画一个简单的水滴图案：

{% img http://img.dayanjia.com/di/SSCV/recursive_1.gif %}

然后把它拼成一个触手：

{% img http://img.dayanjia.com/di/IF2D/recursive_2.gif %}

最后可以拼成无数个张牙舞爪的触手：

{% img http://img.dayanjia.com/di/3522/recursive_3.gif %}

大家可以发挥自己的想象力，创造出更多有趣的图案。