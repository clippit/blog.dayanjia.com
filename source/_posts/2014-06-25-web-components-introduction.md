---
layout: post
title: Web Components 初探
description: 介绍原生 Web Components 的四个部分
date: 2014-06-25 22:00
category: 雕虫小技
tags: []
comments: true
---

众所周知，Web 页面是由 HTML+CSS+JavaScript 三板斧配合而成的，这体现了一种结构、表现、交互分离的思想。但是随着 Web 应用不断丰富，过度分离的设计也会带来可重用性上的问题。于是各家显神通，各种 UI 组件工具库层出不穷，煞有八仙过海之势。于是 W3C 坐不住了，大手一挥，说道：不如让我们统一一个 Web Components 的标准吧怎么样。

Web Components 的核心思想就是把 UI 元素组件化，即将 HTML、CSS、JS 封装起来，使用的时候就不需要这里贴一段 HTML，那里贴一段样式，最后再贴一段 JS 了。一般来说，它其实是由四个部分的功能组成的：

1.  模板，`<template>` 标签
2.  自定义元素
3.  Shadow DOM（隐匿 DOM）
4.  Imports（导入）

<!--more-->

我们还是通过一个简单的例子看看这些新玩意儿都是些什么吧。

## 一段简单的 HTML

假设我们有一个提供 App 介绍的代码片段，为了不让事情变得更复杂，这里只有 HTML 和 CSS，不关 JS 什么事。

``` html
<div class="app-info">
  <div class="app-bar">
    <img class="app-icon" src="http://img.dayanjia.com/di/TOY7/6c2442a7d933c8950f39059ed31373f083020094.png" width="36" height="36"/>
    <div class="app-name">百度手机助手</div>
    <a class="app-downbtn" href="http://gdown.baidu.com/data/wisegame/de5074e4e28aecec/baidushoujizhushou_16783385.apk">下载</a>
  </div>
  <div class="app-description">
    <p>百度手机助手是Android手机的权威资源平台，拥有最全最好的应用、游戏、壁纸资源，帮助您在海量资源中精准搜索、高速下载、轻松管理，万千汇聚，一触即得。海量资源：免费获取数十万款应用和游戏，更有海量独家正版壁纸，任你挑选。</p>
  </div>
</div>
```

``` css
.app-info {
  padding: 0.2em;
  border-bottom: 1px dotted #ddd;
}
.app-bar {
  display: flex;
  align-items: center;
  font-size: 14px;
}
.app-name {
  flex-grow: 2;
  margin-left: 1em;
}
.app-downbtn {
  text-decoration: none;
  padding: 0.2em 1.1em;
  margin-right: 1em;
  color: #fff;
  background: #5573eb;
}
.app-description {
  font-size: 12px;
}
```

看上去就是这样的：

<p data-height="170" data-theme-id="0" data-slug-hash="kKvif" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/clippit/pen/kKvif/'>kKvif</a> by Letian Zhang (<a href='http://codepen.io/clippit'>@clippit</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

## 模板

HTML 模板这个东西已经存在很久了，模板的实现无非是这么几种。一种是直接写在 DOM 里，但是给它一个 `display: none` 的样式。使用这种模板，我们可以很方便地用 JavaScript 来操作 DOM 结构，但是如果你在模板里写了一个 `img` 元素之类，不好意思，即使你看不到，这个图片的网络请求还是要发一下的。此外，与模板相对应的 CSS 也是和页面其他部分平行的关系，你需要给模板加一个 ID 之类的选择器前缀来指定样式，以保证不和页面中的其他元素冲突。

第二种是使用 `<script>` 标签，但是给它指定一个非脚本的 `type` 属性，这样浏览器就不会把它当做 JS 来执行了：

``` html
<script id="template" type="x-tmpl-mustache">
Hello {{ name }}!
</script>
```

这种方法的好处在于，DOM 元素是不会预先渲染的，因为在被 JS 取得模板数据并插入 DOM 之前，它都是一堆死气沉沉的纯文本。同时这也是它的弊端，因为是纯文本，所以你要手动处理这些复杂的标签，需要格外小心 XSS 之类的问题。

于是新的 `<template>` 标签就被提出了，它可以看做是结合了上面两种方法的优势。我们将上面的 HTML 模版化后：

``` html
<template id="appTmpl">
... 和之前一样的内容 ...
</template>
```

使用下面的 JS 就可以访问到模板，并将其插入 DOM 中。

``` js
var tmpl = document.querySelector('#appTmpl');
// 取到 t 以后，可以像操作 DOM 一样随意修改其中的内容
// 然后需要从模板创建一个深拷贝（Deep Copy），将其插入 DOM
var clone = document.importNode(tmpl.content, true);
// 创建深拷贝还可以使用下面的方法：
// var clone = tmpl.content.cloneNode(true);
document.body.appendChild(clone);
```

最后的效果和之前看到的其实是一样的。

<p data-height="170" data-theme-id="0" data-slug-hash="wglFf" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/clippit/pen/wglFf/'>wglFf</a> by Letian Zhang (<a href='http://codepen.io/clippit'>@clippit</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

当然了，这个模板的实现其实还是很原始的，并没有像 Mustache、Handlebars 等模板库的占位符替换的功能。

## Shadow DOM

这个 Shadow 不太好翻译，反正理解成「隐藏在黑暗中的 DOM」就差不多了。所以说，Shadow DOM 其实是在文档的主 DOM 中生成了一块子 DOM，这个子 DOM 的 CSS 环境是和主文档隔离的。可以说，使用 Shadow DOM，我们就拥有了一个组件封装的原始模型。从外面看，它只是一个 DOM 节点，但是这其实是一个黑盒，里面还可以包含复杂的结构。这种抽象其实在大自然中随处可见，例如当我们谈论太阳系的时候，我们会把地球作为一个节点，但是当我们深入地球这个节点时，会发现还存在地月系这个结构。

使用 Shadow DOM，我们需要在一个元素上创建一个根（Root），然后将模板内文档添加到这个根上即可。

``` html
<template id="appTmpl">
  <style>
  /* ... 将 CSS 移动到模板内 ... */
  </style>
  ... 原来的模板内容 ...
</template>

<div class="app"></div>
```

``` js
var tmpl = document.querySelector('#appTmpl');
var host = document.querySelector('.app');
var root = host.createShadowRoot();
root.appendChild(document.importNode(tmpl.content, true));
```

最终的效果看上去是一样的，但是我们已经将这个 App 信息组件封装了一层 DOM。

<p data-height="202" data-theme-id="0" data-slug-hash="xBpqn" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/clippit/pen/xBpqn/'>xBpqn</a> by Letian Zhang (<a href='http://codepen.io/clippit'>@clippit</a>) on <a href='http://codepen.io'>CodePen</a>.</p>


## 自定义元素

现在我们已经能够使用一句 `<div class="app"></div>` 外加一些 JS 来显示这个 App 信息的组件了（如果它够的上被称作是一个「组件」的话）。但是，我们能不能再给力一点，使用一个自己命名的元素呢？答案当然是肯定的。通过自定义元素的功能，就可以实现通过 `<app-info></app-info>` 这样的方式来调用它了。

HTML 除了上文的那些模板以外，只需要一个简单的容器。同时，接下来的例子中，我们还可以看到如何使用属性来替换模版中的变量，因此模板中也要做出一些修改。

``` html
<template id="appTmpl">
  <style>
    /* ... CSS 省略 ... */
  </style>
  <div class="app-info">
    <div class="app-bar">
      <img class="app-icon" src="" width="36" height="36"/>
      <div class="app-name"></div>
      <a class="app-downbtn" href="">下载</a>
    </div>
    <div class="app-description">
      <content selector=".description"></content>
    </div>
  </div>
</template>

<app-info name="百度手机助手" downurl="http://gdown.baidu.com/data/wisegame/de5074e4e28aecec/baidushoujizhushou_16783385.apk" iconurl="http://img.dayanjia.com/di/TOY7/6c2442a7d933c8950f39059ed31373f083020094.png">
   <p class="description">百度手机助手是Android手机的权威资源平台，拥有最全最好的应用、游戏、壁纸资源，帮助您在海量资源中精准搜索、高速下载、轻松管理，万千汇聚，一触即得。海量资源：免费获取数十万款应用和游戏，更有海量独家正版壁纸，任你挑选。</p>
</app-info>
```

可以看到，Shadow DOM 也可以拥有子元素，而这些子元素在模板中将会使用 `<content>` 标签进行定位并替换。接下来，我们使用 JavaScript 创建这个名叫 app-info 的自定义元素。

``` js
var tmpl = document.querySelector('#appTmpl');

// 创建新元素的 Prototype
var appInfoProto = Object.create(HTMLElement.prototype);

// 自定义元素在不同的生命周期有不同的 Callback 可以使用。
// createdCallback 是在创建时调用的，此外还有
// attachedCallback（插入 DOM 时的回调）、
// detachedCallback（从 DOM 中移除时的回调）、
// attributeChangedCallback（属性改变时的回调）
appInfoProto.createdCallback = function() {
  var root = this.createShadowRoot();
  var name = this.getAttribute('name') || '';
  var downUrl = this.getAttribute('downurl') || '';
  var iconurl = this.getAttribute('iconurl') || '';
  tmpl.content.querySelector('.app-name').textContent = name;
  tmpl.content.querySelector('.app-downbtn').href = downUrl;
  tmpl.content.querySelector('.app-icon').src = iconurl;
  // 将模板插入 Shadow DOM
  root.appendChild(document.importNode(tmpl.content, true));
};

// 注册自定义元素
var appInfo = document.registerElement('app-info', {
    prototype: appInfoProto
});
```

最后看到的效果，其实和之前的没什么不同，但是我们很清楚，一个简单的 Web Component 雏形已经诞生了。

<p data-height="170" data-theme-id="6588" data-slug-hash="wdkgo" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/clippit/pen/wdkgo/'>wdkgo</a> by Letian Zhang (<a href='http://codepen.io/clippit'>@clippit</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

通过 Chrome 的开发工具我们可以很清楚地看到 `<template>` 中的文档片段和我们自定义的 `<app-info>` 元素中存在的 Shadow DOM。

{% img http://img.dayanjia.com/di/ZVXL/shadow-dom.png %}


## 导入

Web Components 的最后一部分是导入，这就比较容易理解了，就是提供了一个可复用的途径。我们可以像导入 CSS 一样，导入外部文件中的 HTML 代码。

``` html
<link rel="import" href="app-info.html">
```

## 小结

Web Components 这个东西还非常新，但是它代表了 Web 前端今后的一个发展方向。包括比较火的  AngularJS 等框架，其中的一些功能也或多或少地在使用 Web Components 的思想，并且推动其标准化（见 [the future of AngularJS](https://docs.google.com/presentation/d/1Gv-dvU-yy6WY7SiNJ9QRo9XayPS6N2jtgWezdRpoI04/present)）。

同时，也是因为它太新了，所以可能还会有非常大的改变，也许过几个月再来看这篇文章，部分内容就已经过时了:D 此外，当前浏览器对 Web Components 的支持也很有限，在 Chrome 35+ 中，本文中的全部例子都可以正常展现，其他浏览器就基本上悲剧了。对于这样一个新生状态，还处于快速变化期的事物，我也仅仅是浅尝辄止，本文更多在于抛砖引玉，若有疏漏还请读者多多指正。

针对 Web Components 的功能，Google 出了一个叫做 [polymer](http://www.polymer-project.org/) 的项目，用于填补目前浏览器尚不能实现的部分，此外还内建了许多做好的组件。下次如果有机会，会介绍一下它。

参考资料：

* [Introduction to Web Components - W3C Editor's Draft 9 June 2014](http://w3c.github.io/webcomponents/explainer)
* [A Guide to Web Components](http://css-tricks.com/modular-future-web-components/)
* [HTML's New Template Tag - standardizing client-side templating](http://www.html5rocks.com/en/tutorials/webcomponents/template/)
* [Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)

<script async src="//codepen.io/assets/embed/ei.js"></script>
