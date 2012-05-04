---
layout: post
title: "Introducing NanjingAir"
date: 2012-05-04 14:15
comments: true
categories: 
 - 自娱自乐
 - 雕虫小技
---
2012年3月30日，江苏省开始[公布省内的17个监测点的PM2.5数据](http://218.94.78.75/airwebsite/)，同时SO<sub>2</sub>、NO<sub>2</sub>、PM10等实时数据也得以公布。从去年开始炒得沸沸扬扬的“PM 2.5”也终于有了一个半透明的官方公开渠道。至于我为什么说它是半透明，一是因为只有原始数据，没有以此换算而来的空气质量指数（AQI）数据；二是民众对这些数据的获取是被动的，说白了就是一副“数据放在那儿你爱看不看”的姿态。

于是便有了[NanjingAir](https://github.com/clippit/NanjingAir)这个小项目，它的职责就是将网站公布的数据转换为清晰易懂的质量指数，然后发送到社交平台上。目前它有两个帐号，一个在新浪微博（[@南京空气质量播报](http://weibo.com/nanjingair)），另一个在Twitter（[@theNanjingAir](https://twitter.com/theNanjingAir)）——毕竟最早吸引公众对PM2.5的关注的，便是美使馆在推特上的[@BeijingAir](http://twitter.com/beijingair)帐号。

<!--more-->

# 官方数据平台协议

江苏省环境监测中心的发布网站使用了Flex作为前端，使用[ArcGIS API for Flex](http://help.arcgis.com/en/webapi/flex/)构建，地图资源来自于[天地图](http://www.tianditu.cn/)。Flex跟服务器进行交互最常见的便是WSDL了，经过简单抓包后这一猜想得到了验证。

每一个测控站都有一个唯一的`scode`，Flex使用Web Service中的`getSurvyValue("PM25", scode)`来获取相应测控站的PM2.5数据，返回的结果是`最近1小时均值：xx微克/立方米;最近24小时均值：xx微克/立方米;xx`这样的格式，最后一个`xx`指的是该条数据的时间，24小时制的小时数。

# 空气质量指数（AQI）

解决了获取数据的问题，当然还需要将其换算成AQI。各个国家有各自的换算方法，不过都大同小异。我国的国标《[环境空气质量指数（AQI）技术规定（试行）](http://kjs.mep.gov.cn/pv_obj_cache/pv_obj_id_0D685D84B394517881A5E84FA090CC274B870400/filename/W020120410332725219541.pdf)》（HJ 633—2012）是今年刚发布的，定于2016年1月1日正式实施。在上面的文档中，详细描述了AQI换算的方法，其实AQI是关于监测数据（单位μg/m<sup>3</sup>）的分段线性函数。

准确地说，AQI是将各个检测值的空气质量分指数（IAQI）取最大值得到的，但是本项目中只涉及到了PM 2.5的数据，就暂且以AQI代指PM 2.5的IAQI吧。而且在国标中PM 2.5的1小时实时报是不测算IAQI的，只测算24小时内滑动平均值的指数。不过为了体现实时性，我们可以用同样的方法来计算出1小时的实时指数。

## IAQI计算公式

<div>
\[ IAQI_P  = \frac {IAQI_{Hi} - IAQI_{Lo}}{ BP_{Hi} - BP_{Lo} }(C_P - BP_{Lo}) + IAQI_{Lo} \]
</div>

## 参数含义

* `\( C_P \)`：浓度值
* `\( BP_{Hi} \)`：分段表中与<script type="math/tex">C_P</script>相近的浓度限值的高位值
* `\( BP_{Lo} \)`：分段表中与<script type="math/tex">C_P</script>相近的浓度限值的低位值
* `\( IAQI_{Hi} \)`：分段表中与<script type="math/tex">BP_{Hi}</script>对应的指数
* `\( IAQI_{Lo} \)`：分段表中与<script type="math/tex">BP_{Lo}</script>对应的指数

## 分段表

```
IAQI | PM2.5浓度值(μg/m³)
----:|:------------------
  0  |0
 50  |35
100  |75
150  |115
200  |150
300  |250
400  |350
500  |500
```

## 计算AQI

根据上面的公式，我们便可以计算出相应浓度值对应的AQI指数。具体代码就不在文中给出了，项目版本库里都有。

## 美标AQI

有趣的是，国家标准计算AQI的公式跟美国标准的公式是一模一样的，唯一的不同只在分段表中。最初推特上的@BeijingAir计算AQI便是采用的美国标准，这也招来了国内不少人的非议，称国情不同，计算方法也应该不同。

美国国家环境保护局的文件《[Technical Assistance Document for the Reporting of Daily Air Quality – the Air Quality Index (AQI)](http://www.epa.gov/airnow/aqi_tech_assistance.pdf) 》(EPA-454/B-09-001)给出了计算AQI的详细方法。他们采用的分段表是这样的：

```
AQI      | PM2.5浓度值(μg/m³)
--------:|:------------------
  0-50   |0.0-15.4
 51-100  |15.5-40.4
101-150  |40.5-65.4
151-200  |65.5-150.4
201-300  |150.5-250.4
301-400  |250.5-350.4
401-500  |350.5-500.4
```

聪明的你是不是已经发现区别了？{% pullquote %}在高浓度值的区域，国标和美标采用的是相同的分段方式，但是在低浓度的区域，美标明显比国标要严格不少。也就是说，采用{" 国标计算的AQI在大多数情况下会比美标来的低 "}（AQI越低代表空气质量越好）。很显然，**浓度值是非常客观的数据，但是转化成AQI后，一切都变得主观而有趣起来。**

如果还不够明白的话，相信下面这张函数图能够说明一切了，呵呵。{% endpullquote %}

{% img http://img.dayanjia.com/di/FNI9/aqi.png Concentration to AQI %}

# 空气质量指数级别

有了AQI数据后，我们可以将它进一步模糊化，使用大家都可以理解的文字来大概描述一下空气质量到底怎样。国标采用的是“优”、“良”、“轻度污染”、“中度污染”、“重度污染”、“严重污染”这几个描述，事实上如果出现轻度污染，说明空气质量已经比较糟糕了。

类似的，美标使用的描述有“优秀”、“中等”、“敏感人群有害”、“不健康”、“非常不健康”和“有毒害危险”这六个等级，一一对应。当然，前面说到，美国标准要严格不少，因此有时候国标级别是“良”，而美标级别可能已经达到“不健康”了。

# 发布到社交网络

这个可以算驾轻就熟了，在新浪微博和Twitter上分别申请一个新号，再申请一个API，接着手动OAuth授权一下，拿到Access Token以后就可以用程序发布更新了。

# 小插曲：源数据被加密

这套脚本在官方发布网站的3月30日当天就基本搞定并上线运行了，每隔半个小时更新一次。刚开始官方的数据总是会出现问题，过了一阵子后就正常许多了。不过4月中旬的一天，我突然发现脚本更新不能了。于是手动跑了遍WSDL，发现`getSurvyValue`的返回变成了Base64编码后的字符串，而且解码后的内容不可读。看来是官方的数据平台进行了升级，对数据做了加密。

这无异于给了我一把锁，而我拿到锁的第一反应便是研究如何打开它。幸运的是，它采用加密算法很快被识破，是基于对称密钥的[DES算法](http://zh.wikipedia.org/wiki/%E8%B3%87%E6%96%99%E5%8A%A0%E5%AF%86%E6%A8%99%E6%BA%96)。只要拿到相应的密钥，就能很方便地解开加密的字符串了。



<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML">
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
    tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'] // removed 'code' entry
    }
});
</script>