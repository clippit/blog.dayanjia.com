---
layout: post
title: Debugging Android Webpage Like a Ninja
date: 2013-12-09 08:00
comments: true
categories:
 - 雕虫小技
---

曾几何时，调试 Android 上的网页是一件很麻烦的事情，但是随着 Android 版本的更迭和 Chrome 的不断进化，现在已经变得越来越简单了。让我们一起来看一下吧。

<!--more-->

## 准备工作

目前只有最新版的 [Chrome for Android](http://shouji.baidu.com/soft/item?docid=4877294) 和电脑上的 Chrome 才能配合得天衣无缝。此外，如果是在 Windows 下工作的话，还需要给手机安装一下 USB 驱动。一般来说，用[百度手机助手](http://as.baidu.com/a/bdsuite)连接一下手机，就会自动装上了。

## 小试牛刀

如果电脑上安装的是稳定版的 Chrome，首先需要去开启一项名为「启用通过 USB 远程调试」([chrome://flags/#remote-debugging-raw-usb](chrome://flags/#remote-debugging-raw-usb)) 的实验性功能，然后重启浏览器。如果是 Beta 或者 Dev 版的，这项功能已经默认开启了。

接着将手机使用 USB 连接电脑，并确保驱动已经安装了。在电脑上的 Chrome 打开 [chrome://inspect/#devices](chrome://inspect/#devices) 这个地址（如果是 Beta 或 Dev 版浏览器，可以直接在菜单→工具→检查设备中打开），勾选 *Discover USB devices*，这时应该就能看到连接的手机了。打开手机上的 Chrome，可以直接被电脑上的 Chrome 上认出。

{% img http://img.dayanjia.com/di/QOX5/chrome-inspect-devices.png Chrome检查设备页 %}

在地址栏上，我们可以直接输入网址，远程操控手机上的 Chrome 打开新标签页，打开的标签页也可以直接在电脑上控制它刷新或者关闭。

## 打开开发面板

你可能已经发现了每个打开了的标签页下都有一个小小的 inspect 链接——没错，就是它了，毫不犹豫地点开之。当你满怀期待等待了好久，可能会发现只有一个空白的页面孤零零地躺在屏幕上……事实上，因为打开这个开发面板需要访问 chrome-devtools-frontend.appspot.com 下的资源，而这个部署在 GAE 上的东西，由于 **你懂的** 原因，在天朝打开会比较困难，请开启穿墙模式。

{% img http://img.dayanjia.com/di/WOVN/android-developer-tools.png Developer Tools %}

整个开发面板和平常见到的无异，你可以在这里检查元素、动态修改CSS、监控网络传输、调试Javascript、测量页面性能……酷就酷在，这一切都是发生在真机上的！举例来说，在 Timeline 面板中的 JS 脚本执行时间、页面重绘时间等等，都是依照手机的计算性能来的，这无疑可以获得比电脑上更加真实的结果。


## Let’s Rock &apos;n&apos; Roll!

到这里，我们已经可以把手机屏幕当作网页调试的第二显示器了。但是总有人会得寸进尺地问：能不能再给力一点？好吧，请往下看。

在浏览器的实验中开启「启用开发者工具实验」([chrome://flags/#enable-devtools-experiments](chrome://flags/#enable-devtools-experiments))，然后重启浏览器，打开刚开的开发面板，在设置窗口中打开 *Enable Screencast* 这个选项。

{% img http://img.dayanjia.com/di/QWL4/screencast-experiments.png Enable Screencast %}

重新点一下 inspect，这时你会发现多出来一个小图标，电脑上瞬间出现了手机屏幕的实时投影。此时你可以完完全全在电脑上对手机上的网页进行远程调试了，甚至连手机屏幕都不用再看一眼，只需要保持 USB 连在手机上就行了。

{% img http://img.dayanjia.com/di/8AP1/screencast-debug.png Screencast Debug %}


有时候，我们必须在真机上才能调试到特定的功能，所以这种方法相比于电脑上模拟有着无法替代的优势。怎么样，是不是有一种高大上的感觉？

[{% img http://img.dayanjia.com/di/0QNZ/feel_like_a_ninja_by_rober_raik-d4clw3n.png FEEL LIKE A NINJA %}](http://rober-raik.deviantart.com/art/Feel-like-a-ninja-263041475)
