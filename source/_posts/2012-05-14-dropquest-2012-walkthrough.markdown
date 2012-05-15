---
layout: post
title: "Dropquest 2012 详尽完全攻略解析"
date: 2012-05-14 13:05
comments: true
categories: 
 - 一家之言
---

[{% img right http://img.dayanjia.com/dt/QUA5/dropquestbox%20%282%29.png %}](http://img.dayanjia.com/di/QUA5/dropquestbox%20%282%29.png)

一年一度的Dropbox解密游戏又开始了，这次的解密活动从5月13日开始，到6月2日结束。在此期间完成整个解密游戏的用户都将获得至少1GB的存储空间，最先完成的玩家还有特别的奖品。当然，截止此时，完成者已经有很多了。不过，享受解谜、挑战智商的乐趣才是最重要的。越到后期，你会越感到谜题设计之精巧，令人不得不叹服，因此完整这份攻略也不是一件容易的事。本次DropQuest 2012的[参加入口在这里](https://www.dropbox.com/dropquest2012)。需要注意的是，有些解密的具体内容不同，但是方法都是类似的。

<!--more-->

## 序

说实话，建造一台时光机器是一个很冲动的想法，但我发誓这一切都仅仅源自好奇心。当我今天早上带上你的时候，我绝非想拯救恐龙世界或是知晓彩票中奖号码什么的。我只是想在历史的进程中做一个置身事外的观察者而已——是的，就是那些我们在教科书上读到的故事。至于访问未来，我想我会控制住自己不去做这样的冒险……

好吧，我的自控能力真的很糟糕。这一切都发生的那么突然！在跟爱因斯坦进行了一次发人深思的交谈后（他的确是个闹腾的家伙），我的脑中充满了对未来科学的幻想，于是我将年份拨到了未来（是的，我知道你警告过我）。我对接下来会发生的事完全没有准备。最终，在机器能量即将耗尽的时候，我们坠毁在一片不毛之地，眼前根本没有未来飞行的汽车或是宇宙飞船。

我们搁浅在了2054年，时间机器也坏了。唯一让我感到欣慰的是，我们还在一起！

## 第一关

首先我需要找到机载电脑的诊断记录。许多部分都被烧毁了，不过我相信它们是可以被修复的。这里是未来，不是吗？找到一个量子陀螺仪能有多困难？它们可能已经能长在树上了！

这些都还简单，除了我忘记了我那5位数字的密码。我应该用1Password这样的软件的，不过我还是想到了一些线索。

{% blockquote %}

1. 前两个数字的乘积是24
2. 第四个数字是第二个数字的一半
3. 最后两个数字的和与第1、3个数字的和相同
4. 所有数字的和是26
5. 第二个数字比最后一个数字大

{% endblockquote %}

这个很简单，其实就是一个多元方程组，相信上过初中的都知道。如果你不愿意自己算的话，可以交给数学软件去解。WolframAlpha是一个很棒的在线服务，[输入方程后可以得到结果](http://www.wolframalpha.com/input/?i=a*b%3D24%2Cd%3Db%2F2%2Cd%2Be%3Da%2Bc%2Ca%2Bb%2Bc%2Bd%2Be%3D26%2Cb%3Ee)。这虽然是个不定方程，但是符合剧情的整数解只有一个。密码是*38645*，填入页面后提交即可。这一关可能会出现多种不同的条件，所得答案也不一样。

## 第二关

随后，诊断记录会添加进Dropbox文件夹下。整个Dropquest需要的文件都会放在`Dropquest 2012`这个目录下。打开`38645.txt`文件，其中包含了损坏部件的列表。

{% blockquote 38645.txt %}
如需替换核心部件，请联系工程团队(<a href="http://www.dropbox.com/about">http://www.dropbox.com/about</a>)获取更多信息。

1. 某个名字为6个字母，其中有两个大写的人
2. 某个姓仅仅用首字母标出的人
3. 某个招聘人员
4. 某个戴眼镜的人
5. 某个隔壁是个动物的人

{% endblockquote %}


我们可以在Dropbox的团队人员列表中找到符合条件的人：

1. ChenLi Wang
2. Ryan M., Gautam J., Todd E., Chris V., Lars Fjeldsoe-N., Ramsey H
3. Alison Davis, Donald James, Karen Sperling, V, Allison Louie
4. Michael Nagy, Will Stockwell, Martin Baker, Ben Darnell, David Stein, Marcus Colins, Alicia Chen, Sean Li, Naveen Agrawal
5. Emily Zhao

[{% img right http://img.dayanjia.com/dm/4OIJ/About%20Dropbox.jpg %}](http://img.dayanjia.com/di/4OIJ/About Dropbox.jpg)

鼠标移向ChenLi Wang的介绍，他说如果需要修复时间机器，你需要把“Knight”放在合适的位置移动。这里的Knight是国际象棋的“马♞”。根据国际象棋的规则，马是走“日”字的。把团队列表想象成一个国际象棋棋盘后，从ChenLi Wang开始，找到各个符合条件的人名，路径为ChenLi, Ramsey, Allison, Naveen, Emily（如右图）。最后，将鼠标放在Emily Zhao的介绍上，她说把之前路径的人名首字母连起来作为password，然后进入`dropbox.com/dropquest2012/password`。如法炮制后打开https://www.dropbox.com/dropquest2012/crane即可。

## 第三关

哇，Emily果然给我们回应了！

{% blockquote Emily %}
你可以开始自动修复了，但是你需要一个密码来启动。

我把密码加密过了——我不能告诉你太多，否则你会很危险的。小心。
{% endblockquote %}

打开Dropquest 2012下的`Instructions from Emily`目录，里面是7个图标。说的真可怕，不过这些图标似乎似曾相识。

事实上这是Dropbox网页版上的图标，根据这些图标的文字说明：

1. Sharing
2. Move
3. Upload
4. Download
5. Get Started
6. Show Deleted Files

再次将首字母连起来，将密码*smudges*输入。

## 第四关

看上去已经开始修复了，希望这意味着只要找到缺失的部件，就可以修好它，然后把我们带到过去（不就是“现在”吗？）。我们环顾四周，不知道发生了什么，也没有找到遗失的部件。在地平线的尽头，无数摩天大楼若隐若现，这一切就像泛滥成灾的植物一样。

在我们周围，高塔林立，让人觉得这里的夜晚就像白天一样明亮。奇怪的是，如此一个大都市却非常安静。我不知道这意味着什么，不过至少不会有炸弹或机器人军队把我们赶尽杀绝，也许吧。这里还有幸存者吗？Emily的信息如此神秘，或许这里还有其他人……

在一个角落里，我发现了一个闪着光的东西。哦那是……我上个月的备忘录？也许这是个诡异的玩笑，但是既然毫无头绪，那就看看到底去过哪里。

使用Google Maps来看看每日的行程都在什么地方。

### 星期一

1. 在Lafayette公园网球场打网球
2. 到California Pacific Medical Center体检
3. 到Park Branch的公共图书馆还书
4. 去The Mint唱卡拉OK
5. 在24街的Happy Donuts吃夜宵
6. 回Midtown Terrace

<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bff99638f4f5615ba&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;iwloc=0004bff9c82c29205dff9&amp;ll=37.770787,-122.440526&amp;spn=0.0411,0.027123&amp;output=embed"></iframe><br /><small>在较大的地图中查看<a href="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bff99638f4f5615ba&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;iwloc=0004bff9c82c29205dff9&amp;ll=37.770787,-122.440526&amp;spn=0.0411,0.027123&amp;source=embed" style="color:#0000FF;text-align:left">Dropquest 2012 Chapter 4 Monday</a></small>

### 星期二

1. 从24街BART车站出发
2. 徒步到Twin Peaks
3. 去Geary的百思买买点东西
4. 去宾利的店里看看车
5. 去24街的El Farolito Taqueria吃东西

<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bff9d2905675da9c6&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;ll=37.768005,-122.428968&amp;spn=0.031736,0.035674&amp;output=embed"></iframe><br /><small>在较大的地图中查看<a href="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bff9d2905675da9c6&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;ll=37.768005,-122.428968&amp;spn=0.031736,0.035674&amp;source=embed" style="color:#0000FF;text-align:left">Dropquest 2012 Chapter 4 Tuesday</a></small>

### 星期四

1. 从旧金山动物园出发
2. 在Great Highway旅馆小憩
3. 骑自行车去37大道
4. 在加州莎士比亚剧场夏季音乐学院看哈姆雷特
5. 在Sunset水库散步
6. 去Irving街的Sunset超市买点水果
7. 在Sigmund Stern Grove散步

<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bff9eeef2a305feb9&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;ll=37.748594,-122.493784&amp;spn=0.02984,0.031805&amp;output=embed"></iframe><br /><small>在较大的地图中查看<a href="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bff9eeef2a305feb9&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;ll=37.748594,-122.493784&amp;spn=0.02984,0.031805&amp;source=embed" style="color:#0000FF;text-align:left">Dropquest 2012 Chapter 4 Thursday</a></small>

### 星期六

1. 在Thai Thai Noodle吃点东西
2. 去Fiddler's Green见朋友
3. 去Glamour Closet买衣服
4. 去Piazza Pelligrini订餐
5. 去Searchlight市场买饮料

<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bffa172875dffe829&amp;hl=zh_CN&amp;ie=UTF8&amp;ll=37.798778,-122.412012&amp;spn=0.015605,0.014931&amp;t=v&amp;output=embed"></iframe><br /><small>在较大的地图中查看<a href="http://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004bffa172875dffe829&amp;hl=zh_CN&amp;ie=UTF8&amp;ll=37.798778,-122.412012&amp;spn=0.015605,0.014931&amp;t=v&amp;source=embed" style="color:#0000FF;text-align:left">Dropquest 2012 Chapter 4 Saturday</a></small>

可以看出，每天的轨迹都是一个英文字母。因为Dropbox的总部在旧金山，所以所有的行程都在那个城市里。最后把四个字母组合起来*SOMA*便是本关的密码。

## 第五关

在追踪了我的路线后，我得到了SOMA（市场南街区），那里正是当时Dropbox的总部所在。许多全息显示屏点缀着街道，但是许多没电了。或许我可以用时间机器里的电力重新让它们恢复工作，说不定能有更多线索，就像刚才的行程表一样。我只需要把线缆和电源插座对应起来，但是这些符号是什么意思呢？

{% img http://img.dayanjia.com/di/V73N/symbols.png %}

这些符号都是电源插座的形象，大家应该对倒数第二个比较熟悉，这个是中国使用的插座。在[ElectricalOutlet.org](http://electricaloutlet.org/electricaloutlettable)可以查到这些插座的类型，图示中的插座分别是[M型](http://electricaloutlet.org/type-m)、[A型](http://electricaloutlet.org/type-a)、[D型](http://electricaloutlet.org/type-d)、[L型](http://electricaloutlet.org/type-l)、[I型](http://electricaloutlet.org/type-i)、[B型](http://electricaloutlet.org/type-b)。

## 第六关

哇！果然是这样！全息显示屏开始显示一些看上去像是日历或者事件的东西。为什么颜色如此混乱？难道电线有问题？


这一关是和Dropbox事件日志有关，不同人可能会得到不同的图片。我的图片是这样的：

{% img http://img.dayanjia.com/di/VINZ/f84h732.png %}

可以看到色块的颜色和上面的文字描述并不相符，看上去很诡异。我们需要将图片的颜色反相，大多数图像处理软件都有这个功能。当然也可以用在线工具，例如[ConvertHub](http://www.converthub.com/invert-colors/)，只需要输入图片URL就可以了。上图反相后的结果是这样的：

{% img http://img.dayanjia.com/di/BQH0/f84h732-inverted.png %}

此时，便有正确的描述和色块了，但是依然有三个色块不正确，他们是ORANGE、RED和BLUE。这下面的Y01、M11、D28代表了一个日期，进入[Dropbox日志](https://www.dropbox.com/events)页并跳转到2001年11月28日。可以看到一条信息：

{% blockquote %}

Here is your <a href="http://soundcloud.com/reasonable/for-sure">next clue</a>, but you may also need <a href="https://www.dropbox.com/sh/hfuiyjr0g369r6t/FLRZ9t-7Bq/legend.png">this</a>.

{% endblockquote %}

## 第七关

第一个链接指向SoundCloud上面的一段音乐，第二个链接的内容是一些数学符号。

SoundCloud上的那首歌貌似没什么关系，但是在实时评论中出现了一个叫做@dropquest2012的帐号。当然，现在那段音轨的评论实在太多了，不容易直接发现，可以进入[@dropquest2012的页面](http://soundcloud.com/dropquest2012)来看它发表过的评论。

{% img http://img.dayanjia.com/di/QMJL/legend.png %}

这里又会出现不同的情形，需要根据给出的图片得到答案。显然图片中的值对应了评论的时间。在上图中，这些值写成保留两位小数的形式便是1.57、3.14、1.14、2.30、0.37、0.32，最后一个不知道是什么意思，不过不妨碍解谜。这些值可以简单地按计算器得到，也可以在Google搜索框中计算。再去看@dropquest2012的评论，得到对应的字母为*LEADING*。于是`dropbox.com/dropquest2012/LEADING`便是结果链接。

## 第八关

修复完这些全息电脑，获得了一些线索后，我们听到一些声音……来自于不知名的某人。

{% blockquote %}
你们好，

我可以想象这些未来的事情让你很震惊，但是所有一切很快就会变得有意义。有人在监视我们，所以我只能告诉你密码。我知道你需要哪些部件，而且能告诉你第一块在哪里。相信我。

这条线索只有来自你们时间的人才能理解。

{% img http://img.dayanjia.com/di/4Y42/mashup.png %}

{% endblockquote %}

我甚至不知道这个家伙怎么会知道我们所处的困境的。但是他既然愿意免费给我一块部件，那应该是个好人……是吧？

这一关的谜题具有很强的地域文化性。图片中的第一行文字说道“Silly Costume”，第二行看似是无关的字母，不过仔细观察可以发现是美国一些著名大学的缩写。这些大学都有所谓的“吉祥物”，往往由一个人穿着相应形象的衣服扮演，会出现在诸如体育比赛等活动中，所以被称作“愚蠢的服装”。这一特有的文化现象是国内的高校所没有的。

* MIT - 麻省理工学院 - Tim the Beaver
* URI - 罗德岛大学 - Rhody the Ram
* LMU - 洛约拉马利蒙特大学 - Iggy the Lion
* UGA - 乔治亚大学 - Uga
* LSU - 路易斯安那州立大学 - Mike the Tiger
* GSU - 乔治亚州立大学 - Pounce
* UNLV - 内华达大学拉斯维加斯校区 - Hey Reb
* UF - 佛罗里达大学 - Albert and Alberta
* UNCC - 北卡罗来纳州立大学夏洛特分校 - Norm the Niner
* MIT - 麻省理工学院 - Tim the Beaver

同样，把所有吉祥物的首字母串起来，得到答案*triumphant*。

## 第九关

好吧，看上去我们可以相信那个神秘的赞助者……我们的一个超适应电浆坏了，还有一些其他部件需要修复。但是那个帮助者没有了消息。幸运的是，当我们回到机载电脑放入现有的部件后，系统得到了更新。这让我们有了更多的时间。检查一下Dropquest文件夹，我们需要重新把数据排列以进行下一步操作。

在`Onboard Computer Update`目录中，有很多杂七杂八的文件。我们需要把这些文件按文件扩展名来排序。可惜的是，Windows的资源管理器并没有提供这个功能。在类Unix系统下我们可以使用`ls -1X`来得到排序后的结果：

    your.ini
    next.iso
    destination.jpg
    is.jpg
    the.jpg
    last.lnk
    page.m3u
    of.mid
    the.pages
    tour.pdf
    crane.png
    but.ppt
    might.psd
    sixth.rar
    tomorrow.rtf
    background.tar
    sanity.wav
    sound.wav
    it.wpd
    origin.wps
    persistence.xls
    referral.xml
    crazy.z01
    cats.zip

连起来便是`your next destination is the last page of the tour...`。后面的内容看不懂，但是前面一些单词还是组成了一句话的。来到[Dropbox的功能浏览页面](https://www.dropbox.com/tour)，翻到最后一页：

{% blockquote %}
嘿，又是我。我有个主意。<a href="https://www.dropbox.com/referrals">邀请我到 Dropbox</a>，这样我们的交流会变得更加方便。我的电子邮件是 savior@dropbox.com。
{% endblockquote %}

顺水推舟，给savior@dropbox.com发一封邀请。不同人可能会看到不同的邮箱地址。

## 第十关

把帮助者邀请进Dropbox后，他却再次杳无音讯了。你建议我做更多的探索，于是我们又回到了城市中。看着那些曾经天天经过的地方在时间的洗礼下变成了什么样——家园、公司、超市，一切都还是原先的样子，但却被我们不认识的奇怪东西填满了。但我注意到一点，所有的汽车都不见了。我没有看到一辆交通工具。这意味着人们都离开这里的吗？或者已经有一种更先进的旅行方式了？

侦查了一会儿后，我们来到了一家我儿时经常来的博物馆前。40年过去了，这里有一场关于2010年代的展览。这多方便啊！然而我却没有找到任何可用的部件。在展览的中央，有一个奇怪而熟悉的箱子，它被锁上了，表面依稀可见已被腐蚀的字刻。

{% img http://img.dayanjia.com/di/T8VP/23nm34k.png %}

似乎有什么东西放在不应该放在的地方……

上面的剧情其实给出了一些提示，不过这一关还是非常令人费解的，而且不同人可能会得到不同的图片，所以答案也会不同。首先，你应当认出上图中的这些缩写都是股票代码。Google提供了[财经搜索](https://www.google.com/finance)的服务，可以用来搜索股票代码。

然后就需要做一些联想了——“Something doesn't seem to belong though...”。注意其中有一些通信公司，分别是[TMX](http://www.nyse.com/about/listed/tmx.html)（Teléfonos de México）、[TI](http://www.nyse.com/about/listed/ti.html)（Telecom Italia S.P.A.）、[TKAGY](http://www.google.com/finance?cid=665536)（Telekom Austria AG (ADR)）、[FTE](http://www.nyse.com/about/listed/fte.html)（France Telecom）。而这其中又只有墨西哥不是欧洲，所以输入密码*Mexico*。好吧，我承认这有点牵强，但这的确就是答案。

如果是其他几种图片，会出现TEO（Telecom Argentina S.A.）或是KF（The Korea Fund Inc.），答案就是Argentina或 Korea。

## 第十一关

幸运的是，盒子里放着一个光谱介电放大器（谁把这玩意儿放这儿的？）而且，我们的帮助者（暂且叫他Benny吧）也回来联系我们了！

{% blockquote Benny %}
嘿，我得到了你们下一步的方向（也是最后一件需要的部件）。但是你们仍需要做一些解码。

我使用了在Dropbox发布之前Drew Houston和Arash Ferdowsi试过的一种早期文件加密协议。使用这种方法，文件被相同大小的“块”分割开，每一块使用凯撒密码加密。这种加密方法不是非常安全，你肯定能够破解它！

UEHVDQADRZWGJXFVFIWEJTWKSRBESAQADRZNXAOWGQTHP
{% endblockquote %}

啊，我想Benny在说我们的超特级量子器，蓝宝石Dropbox核心，这将要寻找的下一个目标。

[凯撒密码](http://zh.wikipedia.org/zh-cn/%E5%87%B1%E6%92%92%E5%AF%86%E7%A2%BC)是一种简单的加密技术，它采用替换加密的方法，明文中的所有字母都按照字母表顺序偏移一定数目就得到了密文。

剧情中说到把密文分成大小相同的块，那么这个45个字符的字符串很可能被分成了5×9块。就这么看字母很难发现什么，写一段小程序来看看每组五个字母之间的相互关系：

``` python
cipher = "UEHVD QADRZ WGJXF VFIWE JTWKS RBESA QADRZ NXAOW GQTHP"


def distance(x, y):
    return (ord(y) - ord(x) + 26) % 26


def print_distance(a, b):
    print distance(a, b),
    return b


map(lambda s: reduce(print_distance, s), cipher.split())
```

可以看到输出是`10 3 14 8`的循环，也就是说，这样的分块是正确的，并且每个分块的都是同一段明文的凯撒密码。原文中提到了“块（Block）”，而恰巧`BLOCK`这五个字母相互的“距离”也是10、3、14、8。于是便可以猜测真正的明文是`BLOCK`了。如果没有联想到也没关系，可以把26种可能性全列出来，你会发现只有`BLOCK`是有意义的单词。那么，每段的凯撒密码偏移值就可以轻松地算出来，分别是：19, 15, 21, 20, 8, 16, 15, 12, 5。将这些数字理解为字母表的索引，得到答案*SOUTHPOLE*。

## 第十二关

于是踏上了前往南极旅程，降落到恶劣的环境下，极目四望尽是冰川。我们尝试着寻找企鹅的踪迹。跟随Benny的引导，我们径直来到一块空荡荡的冰面上，四周充满了可怕的寂静。在一块大石头的顶端，超特级量子器，蓝宝石Dropbox核心赫然在目！诡异的是，似乎已经有人来过这里，积雪上存有清晰的脚印。我并没有想太多，因为核心就在那里。我将它插入时间机器里，机器似乎重新开始工作了。终于可以回家了！漫长而曲折的旅程终于结束了。再见了，未来！

P.S. 我一直在做[船长记录](https://www.dropbox.com/home/Dropquest%202012/Captain's%20Logs)，如果你想看看过去的经历的话。

游戏看上去到这里似乎结束了，但是这根本不像是要通关的样子啊。打开船长记录中的`Chapter 12.txt`文件：

{% blockquote Chapter 12.txt %}
好像出了点问题……但是幸运的是，我太激动了以至于忘了把你带上飞船了！你能帮我把这个文件的跟踪日志设置回我们上次遇见的时候吗？只能指望你了……你是我唯一的希望！
{% endblockquote %}

在Dropbox网页版上选择查看这个文件之前的版本，并恢复成老版本。

## 第十三关

重新打开`Chapter 12.txt`：

{% blockquote Chapter 12.txt %}
原来核心被污染了。幸亏还有你这样的好哥们儿。我突然被卷进了一个时空交织的虚无之地。时间机器的通信模块探索不到边界了，没有这个模块，我就只能呆在迷失域里永远回不去了。我感觉Benny其实是在阻止我们回家，但是他为什么要那么做呢？为什么他会把超特级量子器，蓝宝石Dropbox核心放在那么容易得到的地方？我觉得一定有什么地方出了问题，想要走出困境只能靠我们自己了。

我通过核心的参考手册中一个来自于古老电子游戏中的盾牌重新联系了工程团队。这是我们回到过去的唯一办法。
{% endblockquote %}

打开[Dropbox帮助页面](https://www.dropbox.com/help)，那里果然有一个盾牌图标。这个盾牌是著名游戏《塞尔达传说》的主角林克[所持](http://www.amazon.com/Full-Hylian-Zelda-Shield-Handle/dp/B001ECV764)。

{% img http://img.dayanjia.com/di/IB1D/51h-CtwrVUL.jpg %}

点击那个图标。

## 第十四关

听取了Emily的建议，我们来到了艾尔斯巨石附近，或许能找到下一个线索。她说那里的温度让人感觉特级量子器，蓝宝石Dropbox核心似乎曾出现过，我们应该去找找有没有有价值的东西。我们走过一片废墟，看到墙上出现了一些清晰的石刻，和一些可以移动的石块。嗯，我想知道这该如何匹配起来……

{% img http://img.dayanjia.com/di/KV5W/sudoku0.png %}

这是一个数独题，如果你对数独很感兴趣当然可以自己解决，不过现成的工具也是很丰富的。我使用的是[Google Goggles](http://www.google.com/mobile/goggles/)，只需要把题目拍下来，Google就能解答出来了。解答出来后，拼出题目蓝色框中的部分即可。

{% img http://img.dayanjia.com/di/FCI7/sudoku.png %}

## 第十五关

解决了这个谜题，巨石突然开始移动了。眼前出现了……我的时间机器？哦不，有些不同……好像变新了，各个部件也变得更加精致。这时，电脑上弹出了一条信息，是来自Benny的。

{% blockquote Benny %}
如果你收到了这条信息，那意味着出了点问题。我来帮你应付，因为时间已经不多了。

我就是你。

好吧，是过去的你的未来形象，准确地说。你的时间线有点与众不同（这正是你现在身处窘境的原因），因为那超特级量子器，蓝宝石Dropbox核心事实上把未来的时间带走了，也就是我的时间。其实，我在许多年前制造了时间机器（2038年），但是在研究完成后，一个邪恶的人希望能使用Dropbox核心的能量来改变历史。与其把核心拱手让人，我还不如乘坐时间机器回到你的2006年，把核心交给你保管。没有了核心，我就只能看着你建造你自己的时间机器。我根本没有想到你会愚蠢到来到未来;)。

没有Dropbox核心，整个世界都变得一团糟。在2050年发生了一场大灾难，我幸存了下来。同时，我发现你会毫无征兆地跳跃到未来（变异的电离层是发生降落事故的原因）。但是你还是可以回家的。使用我自己的时间机器，我已经完成了你需要的关键部件，并设置了固定的程序确保你能每一步都在我的引导之下。我没有足够的原始材料制作另一个Dropbox核心了，但是如果能把你我的部件整合起来，就足够使用了。

不过，把你引到这里来的原因是，核心被偷走了。邪恶的敌人总是不出不再，他们可能再次将核心用在危险的地方。我有一段脚本能跟踪核心位置，不过我们得快点了。给我（savior@dropbox.com）共享一个新的文件夹，我们赶快动身。
{% endblockquote %}

根据指示，在Dropbox新建一个文件夹，并把它共享给对应邮箱。接着共享文件夹里就会出现一些新文件。

## 第十六关

共享文件夹里有一个`Notes.txt`和7个数字命名的文件。

{% blockquote Notes.txt %}
你需要赶紧动身去图书馆，我给了你留了一些文章，但是你会注意到它们会有些不同。你把它当作一个疯狂填词游戏就好。句子里的许多单词并不正确，一旦你找到了这些单词，你必须知道这些单词都没有头。待你想出结果后，下一个目的地是dropbox.com上同时满足两个条件的地方。
{% endblockquote %}

Google一下可以很快找到如下结果：

* 第一篇文章来自[PC Mag杂志对Dropbox iPad版的评测](http://www.pcmag.com/article2/0,2817,2371504,00.asp)，不同的单词是`evokes`<=>`complements`。
* 第二篇文章来自[Dropbox的的一则新闻](https://www.dropbox.com/news/20120423)，不同的单词是`lives`<=>`life`。
* 第三篇文章中不同的单词是`ourselves`<=>`users`。
* 第四篇文章中不同的单词是`astronomical`<=>`hulking`。
* 第五篇文章中不同的单词是`lasting`<=>`encrypted`。
* 第六篇文章中不同的单词是`deal`<=>`rate`。
* 第七篇文章中不同的单词是`iridescent`<=>`neon`。

接下来就要发挥联想给那些单词加上“头”并且使其仍然是一个单词了：

* __R__evokes
* __O__lives
* __Y__ourselves
* __G__astronomical
* __B__lasting
* __I__deal
* __V__iridescent

这些“头”连起来便是[Roy G. Biv](http://en.wikipedia.org/wiki/Roy_G._Biv)，彩虹的七种颜色。

于是接下来要在dropbox.com上找到同时满足两个条件的地方，也就是同时有两个彩虹的地方。只有[共享页面](https://www.dropbox.com/share)上有两个彩虹，点击大的那一个。

## 第十七关

发现了双彩虹的秘密后，我们来到了维多利亚瀑布。感谢大自然，如此壮丽的景观没有被大灾变毁坏，跟我在照片中看到的一样震撼。刚到那里，我们就遇到了那难以捉摸的时光大盗！他们知道我们是来找他的，于是立即乘车逃跑了。他们逃跑的是如此匆忙以至于掉了一部手机！捡起手机，发现那上面似乎有些加密的内容：

    DNMOYASUYDEATNSDEEYDAWUHDRYASTRAFYIDTRUSYADA
    
    LUSHBAFDCOODEPYYPGRUMPLEESYNESEZY
    
    STAUURIMEINGANCCREELOGRIVOBRAILSCRPOIOTARGISTUSAIPRICRNOCAARQAUISUSPEICS
    
    CERMRYUEVSUNTHEARMRASPUJTIERTSAURNRUUNAS
    
    NEVYLUGTONYTUSLTPIDERTHOLSARTHW
    
    TRAXOGRIETBRATIBDGRAONKNASETAOGKONMEYOROSTREGDOIPG
    
    LIHEMUENONPYKORTNONXENRDAON
    
    DRERANGEOLOWEYLRGENELBUELIVOTE

正当我们研究这些内容时，又收到了Benny的新信息。

{% blockquote Benny %}
啊，看来那些时光大盗对Dropbox的历史非常熟悉！他们使用了一种Dropbox早期就放弃使用的加密方法。使用这种加密方法，文件被分割成不均匀的块，每块内容都被混淆过。这种加密方法也不是很安全，所以你应该能够解开它！
{% endblockquote %}

因为字母的顺序都被搞乱了，而且中间没有空格，所以看起来还是有点头晕的，还原结果如下：

* 第一行，是每周日期的名称，缺失__S__UNDAY。

      DNMOYA SUYDEAT NSDEEYDAW UHDRYAST RAFYID TRUSYADA
      MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY SATURDAY

* 第二行，是《白雪公主和七个小矮人》中七个小矮人的名字，缺失__H__APPY

      LUSHBAF DCO ODEPY YPGRUM PLEESY NESEZY
      BASHFUL DOC DOPEY GRUMPY SLEEPY SNEEZY

* 第三行，是十二星座，缺失__A__RIES

      STAUUR IMEING ANCCRE ELO GRIVO BRAIL SCRPOIO TARGISTUSAI PRICRNOCA ARQAUISU SPEICS
      TAURUS GEMINI CANCER LEO VIRGO LIBRA SCORPIO SAGITTARIUS CAPRICORN AQUARIUS PISCES

* 第四行，是八大行星，缺失__N__EPTUNE

      CERMRYU EVSUN THEAR MRAS PUJTIER TSAURN RUUNAS
      MERCURY VENUS EARTH MARS JUPITER SATURN URANUS

* 第五行，是七宗罪，缺失__G__REED

      NEVY LUGTONYT USLT PIDER THOLS ARTHW
      ENVY GLUTTONY LUST PRIDE SLOTH WRATH

* 第六行，是十二生肖，缺失__H__ORSE

      TRA XO GRIET BRATIB DGRAON KNASE TAOG KONMEY OROSTRE GDO IPG
      RAT OX TIGER RABBIT DRAGON SNAKE GOAT MONKEY ROOSTER DOG PIG

* 第七行，是惰性气体，缺失__A__RGON

      LIHEMU ENON PYKORTN ONXEN RDAON
      HELIUM NEON KRYPTON XENON RADON

* 第八行，是彩虹颜色，缺失__I__NDIGO

      DRE RANGEO LOWEYL RGENE LBUE LIVOTE
      RED ORANGE YELLOW GREEN BLUG VIOLET

所有缺失的单词的首字母连起来得到答案*SHANGHAI*。
    
## 第十八关

我们需要到他们在上海的基地去一趟。基地隐藏在一家购物中心的地下室中，空间十分狭小。电路图铺满了地面，跟我时间机器内的结构非常类似。墙上也钉满了各种零件。此外，桌上还放着一个不知名的巨大物体。为什么他们会把这么一大块垃圾放在这里呢？我觉得他们即使是我的敌人，这么脏乱差的房间我也看不下去，帮他们打扫一下吧。我开始把[物品](https://www.dropbox.com/home/Dropquest%202012/Spring%20Cleaning)一一归类。我需要到Dropbox的网站里操作，这样会方便一些。

Dropquest 2012下多了一个 `Spring Cleaning`文件夹，里面有10张图片，此外还有`Category 1`和`Category 2`两个文件夹，里面分别是一张水滴和箱子的图片，暗指了两个分类。在Dropbox网页版上将10张图片移动到这两个分类文件夹里即可过关。

第一个带有水滴的分类暗指“Drop”，10张图片中能和Drop组成词组的有：

* 1 Drop ship（直接发货）
* 3 Drop shadow（投影）
* 6 Drop dead（去死吧）
* 8 Drop off（下降）
* 9 Drop shot（扣球）

而第二个箱子的分类则暗指“Box”，剩下的图片都能和Box搭配：

* 2 Fuse box（保险丝盒）
* 4 Ballot box（投票箱）
* 5 Match box（火柴盒）
* 7 Juice box（果汁盒）
* 10 Cereal box（谷类食品盒）

## 第十九关

大清理效果不错！当所有物品都被归类后，基地的电力突然激活了。但是没有出现什么计算机，却出现了一道光。一些聚光灯照亮了一堵特别的墙……感觉就像一块画满了照片、图表和时间机器电路图的公告板。图案中间是这样的：

{% img http://img.dayanjia.com/di/RPQV/shmodel2.png %}

显然这个谜题是想让我们想出1、2、3代表的内容，然后构成`1.2/3`的格式。

1. 一个汉字和朝鲜文，他们分别发D和B的音
2. 一辆汽车，[奥迪TT](http://en.wikipedia.org/wiki/Audi_TT)
3. 一组扑克牌谜题。将J、Q、K、A分别看作11、12、13、14后，最后一行的牌应当是相应列前两张大数减去小数的结果。因此框出的最后一行应该为Q2J9J4。不同人可能会看到不同的扑克牌，但是计算方法是一样的。

接着，访问`db.tt/Q2J9J4`，将出现的`Rejected Dropbox Movie Ideas`添加到自己的Dropbox中。

## 第二十关

添加进来的7个文本文件中，有一个说明文件，还有6个数字编号的文件。

{% blockquote Notes.txt %}
回到我最初的时间中，他们给Dropbox拍了一些特色电影。这些电影中，有一些在最终制作中被否决的想法。我整理了一些档案供你查看。

你需要从这些文档中找到密码，找到后打开`dropbox.com/dropquest2012/[password]`（不带空格）。
{% endblockquote %}

当然，不存在什么关于Dropbox的电影，那六份文档中的剧情都是模仿一些有名电影的。

{% blockquote 1.txt %}
刚从MIT毕业，Drew Houston就发现他的高中同学从父亲那里继承了拉斯维加斯的三家赌场。于是他伙同自己的老朋友Arash Ferdowsi和一帮精英软件工程师，假借Dropbox为名，入侵了赌场系统，盗取金钱。
{% endblockquote %}

此剧情山寨自《十一罗汉》（Ocean's Eleven）。

{% blockquote 2.txt %}
Drew和Arash招募了世界上一群富有非凡才能的软件工程师加入了Dropbox。在那里，他们互相帮助对方驾驭自己的软件超能力。Drew尽力使Arash和其他人相信他们可以和普通人和平共处，但是Arash觉得他们就是不同于一般人。最终，Arash带着支持自己的一部分人和Dropbox的其他成员分道扬镳。
{% endblockquote %}

没错，这是《X战警：第一战》（X-Men: First Class）的剧情。

{% blockquote 3.txt %}
Drew和Arash在开发Dropbox的早期，发现资金不够了。他们没有潜在的投资者，于是他们决定去拉斯维加斯靠玩21点赚钱。
{% endblockquote %}

这是一部坑爹的名为《决胜21点》（21）的电影。

{% blockquote 4.txt %}
早在孩童时期，Drew和Arash目击了一场发生在俄亥俄乡间的火车脱轨事故。经过一番调查，他们发现这辆火车装着一个在地球上紧急迫降的外星人。他们利用外星人的先进技术发明了Dropbox文件同步系统。
{% endblockquote %}

后面的内容真是越来越扯，不过根据火车和外星人还是能猜出这是《超级8》（Super 8）。

{% blockquote 5.txt %}
英国的一次病毒爆发引起了暴乱。Drew和Arash创造了Dropbox，因此被感染的人群依然能够恢复自己的文件。唯一的问题是，被感染的人会在安装Dropbox客户端之前就狂暴地摧毁自己的电脑。
{% endblockquote %}

狂怒地杀人成了砸电脑，剧情取自《惊变28天》（28 Days Later...）。

{% blockquote 6.txt %}
在电影的开始，Arash因为自己的心理问题而找到了Drew。Arash会幻觉看到死去的软件公司。Drew认识到，想要治愈Arash，就得从过去的公司中吸取教训，让Dropbox变成一家成功的企业。
{% endblockquote %}

这灵异的故事源自于《第六感》（The Sixth Sense）。

当我们找到这六部电影后，会发现他们的片名中都带有数字。在毫无头绪之际，让我们再次审视着六段文本。

* 第一篇的第11个单词：Houston
* 第二篇的第1个单词：We
* 第三篇的第21个单词：have
* 第四篇的第8个单词：a
* 第五篇的第28个单词：problem
* 第六篇的第6个单词：movie

前五个单词连成一句话：Houston, we have a problem。这正是一部著名电影《阿波罗13号》中的经典台词。所以答案是*apollo13*。

## 第二十一关

大声说出了密码，一块秘密的面板滑出，随之一台电脑出现在眼前，屏幕上显示着不可思议的文字……嗯……也许这可以知道那些家伙到底是干嘛的。

    THE QUICK WN F JUMS VE THE LAZY G
    
    THA QOECK BRIWN FIX JOMPS IVAR THA LUZY DIG
    
    THA QECK IWN FI JMS IVA THA LUZY IG
    
    QUICK JUMS LAZY
    
    QUICK BROWN JUMPS OVER LAZY
    
    THU QIACK BREWN FEX JIMPS EVUR THU LOZY DEG
    
    EHT KCIUQ BROWN FOX JUMPS REVO EHT LAZY DOG
    
    THA QOECK WN F JOMS VA THA LUZY G
    
    AHT KCEOQ BRIWN FIX JOMPS IVAR AHT LUZY DIG

正当我们阅读屏幕上的文字时，Benny又来信息了。

{% blockquote Benny %}
看上去这是用了Dropbox放弃使用的另一种加密方法。这个比之前的要复杂些，所以仔细听好了。

Drew和Arash觉得把文件分块并没有什么用，于是他们放弃了那个想法，寻找更加复杂的加密方法。他们头脑风暴了许多想法，最终他们认为组合使用多个加密函数会让数据更加安全。他们通过头脑风暴，决定使用四个函数：

函数1：移除在DROPBOX中出现的字母
函数2：将每个元音用它前一个来替代（a→u, e→a, i→e, o→i, u→o）
函数5：对于每个由字母表后半部分字母开头的单词，反转它的顺序
函数9：移除所有只有3个字母或更少的单词

看上去时光大盗将同一句话加密了数次，使用了一个或两种上面的函数（或者是同一个函数两次）。如果你能得出他们使用了哪些函数，你应该就能解锁他们的电脑。
{% endblockquote %}

仔细观察那些密文，可以发现都来自一句著名句子“The quick brown fox jumps over the lazy dog.”，这句话是一个比较简短但是使用了全部26个字母的句子，经常出现在计算机文字排印中。我们先来实现这些函数，省得之后手动进行加密的工作。

``` python
def f1(s):
    return filter(lambda x: x not in "DROPBOX", s)


def f2(s):
    shift = {'A': 'U', 'E': 'A', 'I': 'E', 'O': 'I', 'U': 'O'}
    return ''.join(map(lambda x: shift[x] if x in "AEIOU" else x, s))


def f5(s):
    return ' '.join(map(lambda x: x[::-1] if x[0] >= 'N' else x, s.split()))


def f9(s):
    return ' '.join(filter(lambda x: len(x) > 3, s.split()))
```

接着我们便可以将这四个函数单独使用和两两组合，看看得到的密文都是什么样的。

``` python
sentence = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"
func = [f1, f2, f5, f9]

for f in func:
    print f.__name__
    print f(sentence)
    print '-' * 40

for f1 in func:
    for f2 in func:
        print "%s then %s" % (f1.__name__, f2.__name__)
        print f2(f1(sentence))
        print '-' * 40
```

    f1
    THE QUICK WN F JUMS VE THE LAZY G
    ----------------------------------------
    f2
    THA QOECK BRIWN FIX JOMPS IVAR THA LUZY DIG
    ----------------------------------------
    f5
    EHT KCIUQ BROWN FOX JUMPS REVO EHT LAZY DOG
    ----------------------------------------
    f9
    QUICK BROWN JUMPS OVER LAZY
    ----------------------------------------
    f1 then f1
    THE QUICK WN F JUMS VE THE LAZY G
    ----------------------------------------
    f1 then f2
    THA QOECK WN F JOMS VA THA LUZY G
    ----------------------------------------
    f1 then f5
    EHT KCIUQ NW F JUMS EV EHT LAZY G
    ----------------------------------------
    f1 then f9
    QUICK JUMS LAZY
    ----------------------------------------
    f2 then f1
    THA QECK IWN FI JMS IVA THA LUZY IG
    ----------------------------------------
    f2 then f2
    THU QIACK BREWN FEX JIMPS EVUR THU LOZY DEG
    ----------------------------------------
    f2 then f5
    AHT KCEOQ BRIWN FIX JOMPS IVAR AHT LUZY DIG
    ----------------------------------------
    f2 then f9
    QOECK BRIWN JOMPS IVAR LUZY
    ----------------------------------------
    f5 then f1
    EHT KCIUQ WN F JUMS EV EHT LAZY G
    ----------------------------------------
    f5 then f2
    AHT KCEOQ BRIWN FIX JOMPS RAVI AHT LUZY DIG
    ----------------------------------------
    f5 then f5
    EHT KCIUQ BROWN FOX JUMPS OVER EHT LAZY DOG
    ----------------------------------------
    f5 then f9
    KCIUQ BROWN JUMPS REVO LAZY
    ----------------------------------------
    f9 then f1
    QUICK WN JUMS VE LAZY
    ----------------------------------------
    f9 then f2
    QOECK BRIWN JOMPS IVAR LUZY
    ----------------------------------------
    f9 then f5
    KCIUQ BROWN JUMPS REVO LAZY
    ----------------------------------------
    f9 then f9
    QUICK BROWN JUMPS OVER LAZY
    ----------------------------------------

和前面的密文对比，可以发现他们分别使用的是：

* f1
* f2
* f2 then f1
* f1 then f9
* f9
* f2 then f2
* f5
* f1 then f2
* f2 then f5

去字母表中找到第1, 2, 21, 19, 9, 22, 5, 12, 25个字母，组成答案*ABUSIVELY*。

## 第二十二关

于是我们终于得到了进入电脑的密码，或许我们可以定位他们真正的基地位置了。突然间，屏幕上显示出一张大地图，看上去像是一些数学问题，但是那些数字都是……国旗吗？屏幕上还有一些网站列表，一张元素周期表，还有[一些音乐](https://www.dropbox.com/home/Dropquest%202012/Time%20Bandits'%20Greatest%20Hits)……？这到底是要闹哪样？

{% img http://img.dayanjia.com/di/MTSS/Dropquest2012Chapter22.png %}

解密进行到这里越来越有挑战性了。这一关的线索比较多，很容易迷失方向。注意本关不同人显示的表达式可能不一样。

先从旗帜下手，首先你需要认得这些旗帜对应的国家（地区），然后想办法将其转换成数字，以算出每个表达式的值。

ISO 3166-1定义了大部分国家（地区）的两位字母代码，可以在[维基百科页面](http://en.wikipedia.org/wiki/ISO_3166-1)上查到图中出现的各个旗帜对应的字母代码。

* [(古巴CU * 纳米比亚NA) + 马达加斯加MG] mod 163
* [(密克罗尼西亚联邦FM / 塞内加尔SN) * 格鲁吉亚GE] mod 23
* [葡萄牙PT - 俄罗斯RU - 列支敦士登LI] mod 18
* [(阿根廷AR * 塞舌尔SC) / 澳门MO] mod 5
* [(波黑BA + 印度IN) / 巴西BR] mod 2

注意到[元素周期表](http://zh.wikipedia.org/wiki/%E5%85%83%E7%B4%A0%E5%91%A8%E6%9C%9F%E8%A1%A8)，上面中的两位字母代码都能在元素周期表中找到相应的元素，于是表达式被转换。

* [(铜Cu * 钠Na) + 镁Mg] mod 163
* [(镄Fm / 锡Sn) * 锗Ge] mod 23
* [铂Pt - 钌Ru - 锂Li] mod 18
* [(氩Ar * 钪Sc) / 钼Mo] mod 5
* [(钡Ba + 铟In) / 溴Br] mod 2

最后用相应元素的原子量（即编号）带入表达式中，便可以算出它们的值了。

* [(29 * 11) + 12] mod 163 = 5
* [(100 / 50) * 32] mod 23 = 18
* [78 - 44 - 3] mod 18 = 13
* [(18 * 21) / 42] mod 5 = 4
* [(56 + 49) / 35] mod 2 = 1

这时候就该轮到那些音乐文件了，每个MIDI音乐的内容都是几个钢琴和鼓的音。在Dropquest 2012下的`Time Bandits' Greatest Hits`文件夹下分别打开5, 18, 13, 4, 1这五个mid文件，仔细听其中的音，分别用C, D, E, F, G, A, B来表示音符。

* 5.mid: (鼓) E G
* 18.mid: D E (鼓) F
* 13.mid: (鼓) E A F
* 4.mid: E G (鼓)
* 1.mid: C E D (鼓)

每段音乐都有一个鼓声，代表一个空缺的音符（字母）。寻找一个A-G范围内的字母填入空缺处使其能组合成一个单词，将这些空缺的字母连起来，便是答案。本例中的答案便是*BADGE*。

完整起见，这里给出不同的表达式文件名对应最终的mid文件和空缺部分列出来：

* flags0.png - 11.mid - (F) A C E
* flags1.png - 18.mid - D E (A) F
* flags2.png - 01.mid - C E D (E)
* flags3.png - 14.mid - (C) A B B A G E
* flags4.png - 19.mid - D E C (A) D E
* flags5.png - 05.mid - (B) E G
* flags6.png - 04.mid - E G (G)
* flags7.png - 13.mid - (D) E A F

## 第二十三关

我有一种强烈的预感，快要接近事实真相了。在提交了密码后，我看到了一个充满了各种诡异符号的数据库。我唯一能看出的只有这个：[http://www.twitter.com/dropquestalpha](http://www.twitter.com/dropquestalpha)。

打开这个Twitter用户的页面，可以看到他在自己的个人资料地区项中写下了“18.836043, -72.545993”这个坐标。同时可以看到他关注了Dropquest Beta、Dropquest Mu、Dropquest Kappa、Dropquest Delta这几个用户。顺藤摸瓜，可以将所有希腊字母的用户资料中的坐标获取到。

* @DropquestAlpha: 18.836043, -72.545993
* @DropquestBeta: 30.836043, -60.545993
* @DropquestGamma: 14.836043, -36.545993
* @DropquestDelta 2.836043, -48.545993
* @DropquestEpsi: -9.163957, -36.545993
* @DropquestZeta: -25.163957, -60.545993
* @DropquestEta: ???
* @DropquestTheta: -25.163957, -84.545993
* @DropquestIota: -9.163957, -108.545993
* @DropquestKappa: 2.836043, -96.545993
* @DropquestLambda: 14.836043, -108.545993
* @DropquestMu: 30.836043, -84.545993
* @DropquestNu: -25.163957, -96.545993
* @DropquestXi: -41.163957, -72.545993
* @DropquestOmi: -25.163957, -48.545993
* @DropquestPi: 49.156113, 9.714661
* @DropquestRho: 52.359405, 5.221231
* @DropquestSigma: 51.778936, -1.268085
* @DropquestTau: 账户被停用
* @DropquestUpsilo: 14.836043, -36.545993（和@DropquestGamma相同）
* @DropquestPhi: 不存在
* @DropquestChi: 不存在
* @DropquestPsi: The Bootylicious Brothel
* @DropquestOmega: 名叫“Hans Wurst”，无位置信息

去Google Map中将这些坐标标出来。

<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004c014d2983c70600b8&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;ll=5.597724,-49.415666&amp;spn=93.523362,118.260654&amp;output=embed"></iframe><br /><small>在较大的地图中查看<a href="https://maps.google.com/maps/ms?msa=0&amp;msid=211054947841122726328.0004c014d2983c70600b8&amp;hl=zh_CN&amp;ie=UTF8&amp;t=v&amp;ll=5.597724,-49.415666&amp;spn=93.523362,118.260654&amp;source=embed" style="color:#0000FF;text-align:left">Dropquest 2012 Chapter 23</a></small>

可以发现大多数集中在南美地区，而且这些点连起来酷似一个Dropbox的图标。如果把Dropbox的图标叠上去的话会看得更清楚，而且会发现还少了一个点。在地图上标出这个点后，放大一看，原来在秘鲁的马丘比丘。

{% img http://img.dayanjia.com/di/SVHE/dropbox-map.png %}

所以答案便是马丘比丘，*MACHUPICCHU*。

## 终章

我们最终来到了基地，在马丘比丘的中心地带。这里的废墟依然跟我在照片中看到的一样，但是在中央区域却多出了一座大型建筑。周围没有多少人——最多10个人。我很惊讶，因为这是我第一次有机会看到未来人的日常生活是怎样的……不过看上去依然很普通。我猜这个基地可能是个大型工厂什么的。应该到处是大型机械，这里的人都非常熟悉使用这些机械。幸运的是，他们正在吃晚饭！我闻到了通心粉和奶酪的味道，但是我更感兴趣的是我发现了……他们制造的时间机器没有人看管！略微施展一下忍者轻功，我从一块阴影跳到另一块阴影，于是我和这些机器近在咫尺了。我认识这些电路图……它们一定使用我或者Benny处偷来的。我小心翼翼地准备把超特级量子器，蓝宝石Dropbox核心从机器上拆下来。突然间，警报响了！

我立刻跳进我的时间机器里，不能让他们抓到。这时候，我的通讯器响了，一条消息传来：

{% blockquote %}
根据时间电流，你只能从固定地方回到过去——所谓的时间之门。你需要想清楚你要去的地方是哪里！
{% endblockquote %}

通讯突然中断了，但是一张图出现在屏幕上。我们正要去穿越世界，但是到底该去哪里呢？我们如何在逃跑的时候搞定这一切？

{% img http://img.dayanjia.com/di/983Q/crossword.png %}

这是一张巨大的填字游戏，其中第20和61号的横行将给出两条提示。做完填字结果是这样的：

{% img http://img.dayanjia.com/di/NEYV/crossword.png %}

两条提示分别是`ORDERLOGSBYSIZE`和`NINELETTERWORDS`，即“按大小排列”和“9个字母的单词”。那究竟是把什么按大小排列呢？

你可以想到了，便是每关都会留下的船长日志。将这些文本文件按大小升序排列，然后找到每个文件中的9个字母的单词。

* Chapter 6.txt   - nominally
* Chapter 10.txt  - timepiece 
* Chapter 8.txt   - histories
* Chapter 7.txt   - weirdness 
* Chapter 1.txt   - obnoxious
* Chapter 13.txt  - rebounded
* Chapter 2.txt   - dominated
* Chapter 18.txt  - seemingly
* Chapter 9.txt   - objective
* Chapter 5.txt   - fastening 
* Chapter 23.txt  - Literally 
* Chapter 21.txt  - operation 
* Chapter 11.txt  - generated
* Chapter 3.txt   - somewhere 
* Chapter 20.txt  - beguiling
* Chapter 4.txt   - yesterday
* Chapter 19.txt  - continent
* Chapter 14.txt  - headaches
* Chapter 15.txt  - acquiring
* Chapter 17.txt  - pertained
* Chapter 16.txt  - tediously
* Chapter 22.txt  - educative
* Chapter 12.txt  - reference

将首字母连起来，看上去是“NTH WORDS OF LOGS BY CHAPTER”。离最后的成功只有一步之遥了。我们需要将第N章日志中的第N个字母提取出来，是这样一段文字：

     The time gate is the Only the of The new seven wonders Of the world in the only continent you haven't visited yet

时间之门是世界新七大奇迹之一，它在你还没有访问过的一个大洲内。世界新七大奇迹分别是：

* 长城（中国，亚洲）
* 佩特拉古城（约旦，亚洲）
* 里约热内卢基督像（巴西，南美洲）
* 马丘比丘（秘鲁，南美洲）
* 奇琴伊察玛雅城邦遗址（墨西哥，北美洲）
* 罗马斗兽场（意大利，欧洲）
* 泰姬玛哈陵（印度，亚洲）

看来我们的终点便是罗马斗兽场（*Colosseum*）了。

## 结语

罗马，一片废墟。让人感到奇怪的是，许多摩天大楼倒塌了，而远古遗迹却依然完整。我们以最快的速度降落在罗马斗兽场的中心。在广阔的竞技场上，我正为时间跳跃做着最后的准备。时光大盗就在眼前——我们只有几秒钟的时间来完成这一切。倒计时开始了。“五……”时光大盗就在我们几步开外的地方，马上就会跳上我的机器。“四……三……”他们开始拼命地奔向我，挥舞着武器。“二……”他们开始瞄准。“一……”

刹那间，一道爆炸的亮光刺破在他们跟前，瞬间将他们打翻在地。机器突然向后颠簸了一下，准备将我们重新带回了属于自己的时光。我的眼前一片模糊，微笑着。现实飞快地在我们身边扭曲，机器把我带回了我的工作室，一切就像我刚离开时的那样。我们呆坐了好几分钟，好不容易才回过神来。

那个神秘的人究竟是谁？真是Benny吗？不管怎样，我总算是知道了时间是多么地脆弱，Dropbox核心也不应当被滥用。这次时间旅行教会了我许多东西……我现在有了比见证历史更重要的事情，那就是去阻止多年后将会发生的大灾难。我用防水布将时间机器盖住，缓缓地离开了。真是荒诞的一天啊！

{% img http://img.dayanjia.com/di/9HRQ/delorean.png %}

