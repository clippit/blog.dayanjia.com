---
layout: post
title: "在iBooks中启用隐藏的中日韩字体"
date: 2013-03-07 08:00
comments: true
categories:
 - 侃侃而谈
---

[上回](http://blog.dayanjia.com/2013/02/cjk-fonts-in-ios-6/)说到了 iOS 6 中新增了许多中日韩字体供 iBooks 使用，但是 Apple 支持页上的[一份 iOS 字体列表](http://support.apple.com/kb/HT5484?viewlocale=zh_CN)却显示，系统中应当有更多的字体可以被调用。大部分 Mac OS X 上的字体，诸如报隶、兰亭黑、隶变、华文仿宋、娃娃体、魏碑、行楷、雅痞、標楷體、儷黑、儷宋……都在那份列表中。今天就来说说如何在 iBooks 中使用这些额外的隐藏字体。

<!--more-->

## 字体列表的配置文件

细心的朋友如果进入到 iOS 的 `/var/mobile/Library/Assets/com_apple_MobileAsset_Font/` 目录中查看随 iBooks 下载回来的字体，一定会发现一个 XML 文件。这个文件也可以在 Apple 网站上[下载](http://mesu.apple.com/assets/com_apple_MobileAsset_Font/com_apple_MobileAsset_Font.xml)到。这个 XML 文件中详细定义了 iOS 6 中额外字体的各种信息和对应的下载 URL。文件格式是很典型的纯文本 [Plist](http://zh.wikipedia.org/wiki/Plist)，在这里就不详述了。

## iBooks 的字体配置文件

进入到 iBooks.app 的应用目录后，可以看到大量以 `FontPresets` 开头的 Plist 文件，这些文件便是定义了不同语言环境下 iBooks 显示字体列表的奥秘所在。截取一段内容如下：

``` xml
<dict>
	<key>default</key>
	<true/>
	<key>displayName</key>
	<string>黑体</string>
	<key>fontFamily</key>
	<string>Heiti SC</string>
	<key>postscriptBoldName</key>
	<string>STHeitiSC-Medium</string>
	<key>postscriptName</key>
	<string>STHeitiSC-Light</string>
	<key>settings</key>
	<array>
		<dict>
			<key>fontSize</key>
			<real>0.95999999999999996</real>
			<key>lineHeight</key>
			<real>1.6499999999999999</real>
		</dict>
		<dict>
			<key>fontSize</key>
			<real>1.05</real>
			<key>lineHeight</key>
			<real>1.6100000000000001</real>
		</dict>
		<dict>
			<key>fontSize</key>
			<real>1.2</real>
			<key>lineHeight</key>
			<real>1.6399999999999999</real>
		</dict>
		<!-- 此处省略类似配置 -->
		<dict>
			<key>fontSize</key>
			<real>6.2000000000000002</real>
			<key>lineHeight</key>
			<real>1.4199999999999999</real>
		</dict>
	</array>
</dict>
```

可以看到对于一个字体，这里设置了在 iBooks 中显示的名称、字体族名字、常规和粗体的 PostScript 字体名，以及一系列字号和行高的关系（在放大缩小文字时起作用）。于是启用额外字体的方法就很明了了，即手动将这些字体的配置写入这些 Plist 文件中。字体的各种名字可以在上面提到的 XML 中找到，至于字号和行高的配置，我暂时没有找到什么好方法，于是直接就复制了黑体中的配置信息。我修改好的文件可以在文章最后下载到。

另外需要提出的一点是，这些 Plist 文件默认是二进制编码过的，可以使用 `plutil` 命令行程序将其和 XML 格式进行互相转换。在 Mac OS X 中编辑 Plist 文件非常方便，在 Windows 中的 iTunes 自带了这个工具（`C:\Program Files (x86)\Common Files\Apple\Apple Application Support\plutil.exe`），另外也可以使用图形化的程序 [plist Editor](http://www.icopybot.com/plist-editor.htm)。

## 效果

从下面一些图片中便可以看到新增的可下载的字体了。

{% img http://img.dayanjia.com/di/LF16/IMG_0363.png %}

{% img http://img.dayanjia.com/di/ILON/IMG_0366.png %}

{% img http://img.dayanjia.com/di/2HCC/IMG_0369.png %}

{% img http://img.dayanjia.com/di/G2JJ/IMG_0368.png %}

## 下载

首先很抱歉地要说明的是，本文所描述的更改只适用于越狱过的 iOS 6 系统。虽然要修改的文件存在于 mobile 用户空间，不属于系统文件，但是 iOS 6 对于应用程序的 .app 目录增加了额外的只读限制。只有在越狱后，这些目录才是可写的。

iOS 6.1.2 + iBooks 3.1 测试通过。修改过的 XML 文件在 [GitHub 上](https://github.com/clippit/iBooks-FontPresets)，欢迎提出意见。

### [&raquo;点击下载](https://github.com/clippit/iBooks-FontPresets/raw/binary/download/FontPresets.zip)
