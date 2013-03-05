---
layout: post
title: "iOS 6 中的中日韩字体"
date: 2013-02-23 17:25
comments: true
categories:
 - 侃侃而谈
---

细心的朋友一定会发现，在 iBooks 3 中，苹果为简体中文提供了除了系统自带黑体外的更多选择。当打开一本简体中文的 ePub 电子书时，选择字体的列表中会出现黑体、宋体、楷体、圆体这四种字体，除了黑体之外的三种并没有存在于系统中，需要通过网络额外下载。事实上，受惠的不光是中文，日文和韩文都可以利用 iOS 6 新增的字体管理功能下载额外的字体供 iBooks 3 使用。今天就让我们来看看这些字体的来龙去脉（友情提醒：本文图片较大，建议单击右侧竖条隐藏侧边栏后阅读）。

<!--more-->

## 如何确定 ePub 的语言？

ePub 其实是一堆文件用 ZIP 压缩打包后的成品。在这些文件中有一个`content.odf`的文件包含了电子书的元数据。这是一个 XML 格式的文件，其中有一个`<dc:language>`的标签便是用来确定电子书的语言的，这个标签位于`<metadata>`下。因此简体中文的标识便是这样：

``` xml
<dc:language>zh_CN</dc:language>
```

## 简体中文字体

### 黑体

{% img http://img.dayanjia.com/di/HCM7/IMG_0080.png %}

黑体是 iOS 系统自带唯一一款简体中文字体，包含细体和粗体两个字重，制造商是常州华文（SinoType）科技有限公司。作为系统使用的主字体，它包含了五万余个字形（Glyph），带有中日韩的不同字形样式。

{% img http://img.dayanjia.com/di/R3VA/hu.png %}

### 宋体

{% img http://img.dayanjia.com/di/MUBW/IMG_0081.png %}

这款宋体同样是华文生产，包含了四个字重，由细到粗分别是细体、常规体、粗体、黑体。其中除了黑体之外的三个字重都有三万余个字形，包含了CJK及其扩展A区（U+3400–U+4DB5）的文字。而黑体就仅仅只有8000多个字形了。粗体（基本就是微软 Office 中的华文中宋）和常规体合并成`Songti.ttc`文件，黑体和细体则合并为`SongtiExtra.ttc`文件。

但是这款字体在 iBooks 中的展现似乎有些问题。从上面的截图中可以看出默认的字重是“常规体”，但是应该显示成“粗体”的地方却没有采用相应的字体文件，而是使用“细体”进行仿粗处理。同时斜体的显示使用的是“细体”，而斜粗体居然变成了“黑体”字重。

### 楷体

{% img http://img.dayanjia.com/di/GEO6/IMG_0082.png %}

这款楷体依然来自于华文。其中`Kaiti.ttc`包含了粗体和常规体，`KaitiExtra.ttc`专门打包了黑体，一共是三个字重。其中以常规体支持的字符最多，另两个仅包含8000余字形。

### 圆体

{% img http://img.dayanjia.com/di/9VJT/IMG_0083.png %}

最后的圆体还是华文的字体，文件名为`Yuanti.ttc`的合集中包含了细体、常规体和粗体三个字重。其中细体支持的字符最多，另两个仅包含8000余字形。

从上面的截图中我们可以看到 iBooks 在处理这款字体的时候同样出现了问题，和宋体的错误表现一模一样。本该显示粗体的地方成了细体仿粗的效果，而斜体变成了细体自重，斜粗体倒是正确的粗体效果。

## 繁体中文字体

### 黑體

{% img http://img.dayanjia.com/di/UP8E/IMG_0084.png %}

相比于简体中文，繁体中文就可怜多了，只有一个系统默认的黑体可以选择。刚才已经说过，这款黑体跟简体中文的黑体来自于同一个字体文件。

## 日文字体

### <span lang="ja" xml:lang="ja">游ゴシック体</span>

{% img http://img.dayanjia.com/di/K7H4/IMG_0090.png %}

这是日本[字游工房](http://www.jiyu-kobo.co.jp/)制作的字体，英文名叫做 YuGothic，Gothic 的所谓“哥特体”便是对应汉字里“黑体”的非衬线样式。这款字体有 Medium 和 Bold 两种字重。

### <span lang="ja" xml:lang="ja">游明朝体</span>

{% img http://img.dayanjia.com/di/3384/IMG_0091.png %}

这是和上面一款字体为一个系列的“明朝体”，即“宋体”样式，对应英文名称叫做 YuMincho。这款字体有 Medium 和 Demibold 两种字重。

### <span lang="ja" xml:lang="ja">ヒラギノ角ゴ</span>

{% img http://img.dayanjia.com/di/VYRM/IMG_0089.png %}

这款字体英文名称为 Hiragino Kaku Gothic ProN，是 iOS 系统自带的两款日文专用字体之一，同样来自于字游工房。Hiragino是一个非常著名的字体系列，它对应简体中文字形的字体便是大家熟知的“冬青黑体简体中文”。<span lang="ja" xml:lang="ja">ヒラギノ</span>这个名字源自于<span lang="ja" xml:lang="ja">柊野（ひらぎの）</span>——日本京都市的一个地名。这款字体有W3和W6两个字重。

### <span lang="ja" xml:lang="ja">ヒラギノ明朝</span>

{% img http://img.dayanjia.com/di/I2CD/IMG_0088.png %}

这是和上面一个字体同系列的明朝体，英文名称为 Hiragino Mincho ProN，一样是 iOS 系统自带，一样有W3和W6字重。

### <span lang="ja" xml:lang="ja">ヒラギノ丸ゴ W4</span>

{% img http://img.dayanjia.com/di/Q3VY/IMG_0092.png %}

依然是一个系列的字体，不过它是需要另外下载的。这款字体的英文名称为 Hiragino Maru Gothic ProN，可以看出也是哥特体，不过和上面那一款不同，它的风格更类似于圆体。这款字体仅有W4一种字重，没有对应的独立粗体，因此可以看出上图中是仿粗效果。

## 韩文字体

### <span lang="ko" xml:lang="ko">산돌고딕 Neo</span>

{% img http://img.dayanjia.com/di/TJCM/IMG_0085.png %}

这款字体是 iOS 系统内置的，英文名称为 Apple SD Gothic Neo，系统自带 Medium 和 Bold 两个字重。这款字体是由[Sandoll Communications Inc.](http://www.sandoll.co.kr/)开发的，拥有18000多个字形。

### <span lang="ko" xml:lang="ko">나눔고딕</span>

{% img http://img.dayanjia.com/di/ALZZ/IMG_0086.png %}

这款字体英文名称做 NanumGothic，是由[NHN公司](http://www.nhncorp.com)开发的，它带有 Regular、Bold、ExtraBold 三个字重。相对于系统自带的韩文黑体，这款字体在边缘转角处的处理要圆滑一些。

### <span lang="ko" xml:lang="ko">나눔명조</span>

{% img http://img.dayanjia.com/di/0A8I/IMG_0087.png %}

这款字体英文名称叫做 NanumMyeongjo，可以看出和上面一款属于同一系列，是一款衬线字体（明朝体）。看上图的风格和中文里的仿宋字体比较类似，同样也有三个字重。

## 资源下载

上面截图中用到的 ePub 电子书可以在[这里](https://www.dropbox.com/s/8ysz8qkmk03g3mp/multilingual_epub_test.zip)下载到。需要说明的是，其中千字文的简体中文版是我用 Word 从繁体中文转换而来的，结果“九州禹跡”意外地变成了“九州岛禹迹”，莫名其妙多出来一个字。

## 更多 CJK 字体？

事实上，Apple 的支持网站上有一份 [iOS 字体的列表](http://support.apple.com/kb/HT5484?viewlocale=zh_CN)。其中除了上文中提到的字体外，还出现了 OS X 中新增中文字体诸如报隶、兰亭黑、隶变、华文仿宋、娃娃体、魏碑、行楷、雅痞、標楷體、儷黑、儷宋等。支持页中说，“App 也可以根据需要安装”这些字体。但是我们却没有在任何地方看到这些字体的影子。既然 iBooks 中可以有宋体、楷体、圆体等字体，那么是否也可以下载并使用这些额外的字体呢？请期待今后的文章。
