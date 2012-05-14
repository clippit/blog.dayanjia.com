---
layout: post
title: "Dropquest 2012 详尽完全攻略"
date: 2012-05-14 13:05
comments: true
categories: 
 - 一家之言
---

一年一度的Dropbox解密游戏又开始了，这次的解密活动从5月13日开始，到6月2日结束。在此期间完成整个解密游戏的用户都将获得至少1GB的存储空间，最先完成的玩家还有特别的奖品。当然，截止此时，完成者已经有很多了。不过，享受解密的乐趣才是最重要的。本次DropQuest 2012的[参加入口在这里](https://www.dropbox.com/dropquest2012)。需要注意的是，有些解密的具体内容不同，但是方法都是类似的。

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

这个很简单，其实就是一个多元方程组，相信上过初中的都知道。如果你不愿意自己算的话，可以交给数学软件去解。WolframAlpha是一个很棒的在线服务，[输入方程后可以得到结果](http://www.wolframalpha.com/input/?i=a*b%3D24%2Cd%3Db%2F2%2Cd%2Be%3Da%2Bc%2Ca%2Bb%2Bc%2Bd%2Be%3D26%2Cb%3Ee)。这虽然是个不定方程，但是符合剧情的整数解只有一个。密码是*38645*，填入页面后提交即可。

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

鼠标移向ChenLi Wang的介绍，他说如果需要修复时间机器，你需要把“Knight”放在合适的位置移动。这里的Knight是国际象棋的“马♞”。根据国际象棋的规则，马是走“日”字的。把团队列表想象成一个国际象棋棋盘后，从ChenLi Wang开始，找到各个符合条件的人名，路径为ChenLi, Ramsey, Allison, Naveen, Emily。最后，将鼠标放在Emily Zhao的介绍上，她说把之前路径的人名首字母连起来作为password，然后进入`dropbox.com/dropquest2012/password`。如法炮制后打开https://www.dropbox.com/dropquest2012/crane即可。

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

我可以想象这些未来的事情让你很震惊，但是所有一切很快就会变得有意义。有人在监视我们，所以我只能告诉你密码。我知道你需要哪些部件，而且能告诉你第一块。相信我。

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

```
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
```

连起来便是`your next destination is the last page of the tour...`。后面的内容看不懂，但是前面一些单词还是组成了一句话的。来到[Dropbox的功能浏览页面](https://www.dropbox.com/tour)，翻到最后一页：

{% blockquote %}
嘿，又是我。我有个主意。<a href="https://www.dropbox.com/referrals">邀请我到 Dropbox</a>，这样我们的交流会变得更加方便。我的电子邮件是 savior@dropbox.com。
{% endblockquote %}

顺水推舟，给savior@dropbox.com发一封邀请。

## 第十关

把帮助者邀请进Dropbox后，他却再次杳无音讯了。你建议我做更多的探索，于是我们又回到了城市中。看着那些曾经天天经过的地方在时间的洗礼下变成了什么样——家园、公司、超市，一切都还是原先的样子，但却被我们不认识的奇怪东西填满了。但我注意到一点，所有的汽车都不见了。我没有看到一辆交通工具。这意味着人们都离开这里的吗？或者已经有一种更先进的旅行方式了？

侦查了一会儿后，我们来到了一家我儿时经常来的博物馆前。40年过去了，这里有一场关于2010年代的展览。这多方便啊！然而我却没有找到任何可用的部件。在展览的中央，有一个奇怪而熟悉的箱子，它被锁上了，表面依稀可见已被腐蚀的字刻。

{% img http://img.dayanjia.com/di/T8VP/23nm34k.png %}

似乎有什么东西放在不应该放在的地方……

上面的剧情其实给出了一些提示，不过这一关还是非常令人费解的。首先，你应当认出上图中的这些缩写都是股票代码。Google提供了[财经搜索](https://www.google.com/finance)的服务，可以用来搜索股票代码。

然后就需要做一些联想了——“Something doesn't seem to belong though...”。注意其中有一些通信公司，分别是[TMX](http://www.nyse.com/about/listed/tmx.html)（Teléfonos de México）、[TI](http://www.nyse.com/about/listed/ti.html)（Telecom Italia S.P.A.）、[TKAGY](http://www.google.com/finance?cid=665536)（Telekom Austria AG (ADR)）、[FTE](http://www.nyse.com/about/listed/fte.html)（France Telecom）。而这其中又只有墨西哥不是欧洲，所以输入密码*Mexico*。好吧，我承认这有点牵强，但这的确就是答案。

## 第十一关

幸运的是，盒子里放着一个光谱介电放大器（谁把这玩意儿放这儿的？）而且，我们的帮助者（暂且叫他Benny吧）也回来联系我们了！

{% blockquote Benny %}
嘿，我得到了你们下一步的方向（也是最后一件需要的部件）。但是你们仍需要做一些解码。

我使用了在Dropbox发布之前Drew Houston和Arash Ferdowsi试过的一种早期文件加密协议。使用这种方法，文件被相同大小的“块”分割开，每一块使用凯撒密码加密。这种加密方法不是非常安全，你肯定能够破解它！

UEHVDQADRZWGJXFVFIWEJTWKSRBESAQADRZNXAOWGQTHP
{% endblockquote %}

啊，我想Benny在说我们的超特级量子器，天蓝色的Dropbox核心，这将要寻找的下一个目标。

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

于是踏上了前往南极旅程，降落到恶劣的环境下，极目四望尽是冰川。我们尝试着寻找企鹅的踪迹。跟随Benny的引导，我们径直来到一块空荡荡的冰面上，四周充满了可怕的寂静。在一块大石头的顶端，超特级量子器，那个天蓝色的Dropbox核心赫然在目！诡异的是，似乎已经有人来过这里，积雪上存有清晰的脚印。我并没有想太多，因为核心就在那里。我将它插入时间机器里，机器似乎重新开始工作了。终于可以回家了！漫长而曲折的旅程终于结束了。再见了，未来！

P.S. 我一直在做[船长记录](https://www.dropbox.com/home/Dropquest%202012/Captain's%20Logs)，如果你想看看过去的经历的话。

游戏看上去到这里似乎结束了，但是这根本不像是要通关的样子啊。打开船长记录中的`Chapter 12.txt`文件：

{% blockquote Chapter 12.txt %}
好像出了点问题……但是幸运的是，我太激动了以至于忘了把你带上飞船了！你能帮我把这个文件的跟踪日志设置回我们上次遇见的时候吗？只能指望你了……你是我唯一的希望！
{% endblockquote %}

在Dropbox网页版上选择查看这个文件之前的版本，并恢复成老版本。

## 第十三关

