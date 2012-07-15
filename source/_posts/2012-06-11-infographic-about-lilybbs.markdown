---
layout: post
title: "关于小百合BBS的信息图"
date: 2012-06-11 20:32
comments: true
categories: 
 - 自娱自乐
---

前段时间南京大学小百合BBS迎来了15周年站庆的各项活动。为了应景，我就做了一个关于小百合BBS的信息图。信息图（Infographics）广义地讲就是将复杂的数据、信息等内容用图的形式表现出来，例如大家熟悉的地铁运行示意图便是一种传统的信息图。随着近些年数据可视化、数据挖掘等技术的发展，科技媒体也开始喜欢使用信息图来表达了。好的设计能让粗燥的数据更容易被读者接受，读图总是比读字要省脑细胞。

<!--more-->

{% img http://img.dayanjia.com/di/WCC0/infographic.jpg LilyBBS Infographic %}

这张信息图主要用Photoshop和Illustrator制作。说实话，用这些画图的软件制作数据精度较高的图形还是要费一些周折的。

## 访问量面积图

虽然面积图很常见，但是由于访问量的数据只有几个点，横轴要按时间划分间隔，而传统的面积图只能按照横轴的数据个数等比例划分，这显然是不能接受的。

最后我使用了[matplotlib](http://matplotlib.sourceforge.net/)。将日期转换为基于原点的偏移值后，使用matplotlib可以在X轴和Y轴上描点画出符合要求的面积图。将该图贴制Photoshop中后再使用钢笔模拟出起伏不定的效果，最后填充颜色，补上XY轴标尺和说明。

## 十大的统计

关于十大的统计要归功于那个跑了一年半的机器人。在2010年11月28日至2012年5月29日的548天内，机器人一共抓取到有效记录10412条。期间有几次由于Bug和虚拟机磁盘限额用尽的原因，机器人停止工作了一段时间，不过这些时间并不长。总的来说那一万多条数据还是挺有代表性的。

机器人抓取的数据都保存在一个SQLite数据库中，因为原始的格式不太利于统计，因此我用脚本重新遍历了一遍数据，调整了格式后存成一个新的表。

{% img http://img.dayanjia.com/di/JKXD/nju-robot-sqlite.png %}

接下来的统计就简单多了，只要查询一下就能得到想要的数据。

``` sql
SELECT count(board) AS c, board FROM "lilybbs_top10_copy" GROUP BY board ORDER BY c DESC;
SELECT count(author) AS c, author FROM "lilybbs_top10_copy" GROUP BY author ORDER BY c DESC;
```

至于发布时间的分段汇总，就不去劳烦SQL了，直接跑一遍数据吧、

``` python
import sqlite3
from datetime import datetime


conn = sqlite3.connect('db.sqlite')
timetable = [0] * 24

for row in conn.execute('SELECT * FROM "lilybbs_top10_copy"'):
    pub_time = datetime.strptime(row[4], "%Y-%m-%d %H:%M:%S")
    timetable[pub_time.hour] += 1

print timetable
```

## 标签云

获得了十大贴的版面排名和ID排名后，如何才能让它以最好的形式呈现给读者呢？我第一时间想到了标签云（Tag Cloud），文字的大小直接反映了出现的频数。

最终我使用了[Tagxedo](http://www.tagxedo.com/)来制作标签云，这是一个很赞的Silverlight应用。把词频统计输入后，可以生成各种形状的图形。大家可以自己尝试[版面排名](http://www.tagxedo.com/app.html?url=https%3A//dl.dropbox.com/u/3926237/top10_boards.txt)和[ID排名](http://www.tagxedo.com/app.html?url=https%3A//dl.dropbox.com/u/3926237/top10_id.txt)的标签云效果。

## 时间分布柱状图

传统的柱状图显得过于呆板，在流行的信息图设计中经常会使用圆形这一元素。例如多层嵌套的圆环，在圆上表示节点连接图等。

{% img http://img.dayanjia.com/di/HR0G/24hours.png 原始柱状图 %}

上面便是原始的柱状图，从左至右的横轴依次是0点到23点。当我们把这张图通过极坐标变换成下面这样，画面顿时变得有趣起来。

{% img http://img.dayanjia.com/di/D5V8/24hours-circle.png 极坐标柱状图 %}