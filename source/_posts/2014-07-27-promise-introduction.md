---
layout: post
title: Promise 初探
date: 2014-07-27 00:00
description: 介绍 ECMAScript 6 中的 Promise，分析协议然后实现自己的版本
category: 雕虫小技
tags: []
comments: true
---

其实 Promise 这个东西提出来也挺久时间了，它是一种解决复杂异步回调逻辑的方法。大部分人类的正常思维方式都是线性连贯的，但是在 JavaScript 中，异步却是主流。所以，在遇到复杂逻辑时，我们往往会[写成这样](http://tritarget.org/blog/2012/11/28/the-pyramid-of-doom-a-javascript-style-trap/)：

``` js
// Code uses jQuery to illustrate the Pyramid of Doom
(function($) {
  $(function(){
    $("button").click(function(e) {
      $.get("/test.json", function(data, textStatus, jqXHR) {
        $(".list").each(function() {
          $(this).click(function(e) {
            setTimeout(function() {
              alert("Hello World!");
            }, 1000);
          });
        });
      });
    });
  });
})(jQuery);
```

这就是所谓的「回调金字塔」，每当看到这样的代码，我就会不由自主地唱起一首歌：

> 如果你愿意一层一层一层地剥开我的心……

解决这个方法最简单的方法，就是把匿名函数取个名字，单独提取出来定义。但是当遇到多变的业务场景时，具名函数的方法也不太管用，于是便有了各种高级的碾平异步回调的解决方案，Promise 就是其中一种。

在 ECMAScript 6 中，Promise 模式得到了原生的支持。我们就从原生模型说起。

<!--more-->

## ECMAScript 6 Promise

为了简化各种各样的异步逻辑，我们先假设有一个会花一些时间来完成的 JS 函数。它的功能很简单，就是过一段时间以后调用传入的回调函数。

```js
var wait = function(callback, param) {
  setTimeout(function() {
    callback(param)
  }, 2000 + (Math.random() - 0.5) * 1000);
}
wait(console.log.bind(console), 'test');
```

你可以想象多层嵌套的时候大概是什么样子：

``` js
wait(function() {
  console.log('如果你愿意');
  wait(function() {
    console.log('一层');
    wait(function() {
      console.log('一层');
      wait(function() {
        console.log('一层地');
        wait(console.log.bind(console), '剥开我的心');
      });
    });
  });
});
```

那么，在 Promise 的世界里是什么样的呢？这就不得不先枯燥地解释一些东西了。首先，什么叫做一个「promise」？一个 promise 可以是一个对象或者函数，它包含一个 `then` 接口并且符合相应的规范。使用一个 promise 的方法就是这样：

``` js
promise.then(function(response) {
    // onFulfilled 时执行
}, function(error) {
    // onRejected 时执行
});
```

于是问题又来了，什么叫做 fulfilled 和 rejected 呢？一个 promise 会有三种状态，大致可以理解为执行成功（fulfilled）、执行失败（rejected）和正在执行中（pending）。Promise 包含一个状态机，它内部的状态转换，只允许从 pending 到 fulfilled 或者 rejected 一次，不允许更多了。如果用大家喜闻乐见的薛定谔的猫来解释，就是打开盒子的时候，我们的猫要么死了，要么没死，要么不确定死没死，死的的猫无法复活，活猫也一定不会死:D

新建一个 promise 的时候，我们需要在代码中定义什么时候算成功了，什么时候算失败了。于是上面 wait 的例子便可以改写这样了：

``` js
function waitPromise(param) {
  return new Promise(function(resolve, reject) {
    setTimeout(function() {
      resolve(param);
    }, 2000 + (Math.random() - 0.5) * 1000);
  });
}

waitPromise('如果你愿意').then(function(response) {
  console.log(response);
  return waitPromise('一层');
}).then(function(response) {
  console.log(response);
  return waitPromise('一层');
}).then(function(response) {
  console.log(response);
  return waitPromise('一层地');
}).then(function(response) {
  console.log(response);
  return waitPromise('剥开我的心');
}).then(console.log.bind(console));
```

从上面的例子中，我们可以看出几点：

1. 一个 promise 它 resolve（或者 reject）的东西就是 `then` 的两个回调接受的参数。
2. `then` 可以链式调用，调用的顺序就是你定义的顺序。
3. 在 `onFulfilled`（或者 `onRejected`）中，你可以返回一个 promise，此时 `then` 会返回这个 promise 的一个代理，并响应它的状态变化（即给下一个 `then` 使用）。

`onFulfilled` 和 `onRejected` 中，除了可以返回一个 promise 以外，还可以返回一个对象，其中包含一个 `then` 方法——这样的对象称作 *thenable*。当 thenable 被返回时，代理的 promise 就会去调用该方法，并传入 `resolvePromise` 和 `rejectPromise` 两个参数，于是这个 promise 也就链式地传递下去了。除此之外，返回一个不是 thenable 的值也是可以的，这相当于一个简化，该返回值会被链式的 promise 立即 fulfill。

上面的例子比较一根筋，所有的 `then` 只定义了第一个参数（即成功的回调），其实我们还可以通过调用 `onRejected` 或者抛出一个异常来表示 Promise 执行失败，从而进入 `then` 的第二个函数中（`then(func1, func2)` 必定会调用且仅调用其中一个）。听上去是不是有点 try/catch 的味道，事实上，Promise 还真提供了一个语法糖，就是 `catch(func)`，它其实相当于 `then(undefined, func)`。链条中加入的 `catch` 可以管上它之前所有的 promise 中的失败情况。

听上去好像很绕口的样子，而且这个 Promise 也不过是把回调拉平了而已嘛，至于这么复杂么？其实，依赖这些，我们可以方便地实现更多异步逻辑。在 ECMAScript 6中，Promise 还定义了两个接口：

* `Promise.all`：接受一堆 promise 的数组（任何可迭代的对象都可以），只有当他们都解决了以后，才会解决
* `Promise.race`：也是接受一堆 promise，但是只要有一个成功或者失败了，就会立即解决或驳回它本身

怎么样，是不是突显出 JavaScript 的函数式风格了。就[目前的形势](http://kangax.github.io/compat-table/es6/#Promise)而言，Chrome 33 和 Firefox 30 以上的浏览器都已经实现了原生 Promise。

## Promises/A+

之前说了那么多关于 Promise 的这个规定，那个规定，其实它是有一个统一的名称的，就叫做 Promises/A+。在[它的网站](http://promisesaplus.com/)上，你可以阅读到完整的规范文档。

基于这个标准，除了 ECMAScript 6 中比较简易的 Promise 以外，还有很多实现各不相同，功能各有千秋的实现，比较有名的有（按现有 Github Star 数排列）：

* [Q](https://github.com/kriskowal/q)
* [Bluebird](https://github.com/petkaantonov/bluebird)
* [when](https://github.com/cujojs/when)
* [rsvp.js](https://github.com/tildeio/rsvp.js/)

例如，Q 支持进度查询功能，执行时间较长的异步操作（例如文件上传）可以即时获取进度信息：

``` js
return uploadFile()
.then(function () {
    // Success uploading the file
}, function (err) {
    // There was an error, and we get the reason for error
}, function (progress) {
    // We get notified of the upload's progress as it is executed
});
```

## 重新发明轮子

尽管 Promise 的实现有很多，但是它们的核心都是一样的，就是围绕着 `then` 方法展开。既然有了标准规范，其实我们可以自己实现一个简单的 Promise。

首先当然要创建一个 Promise 对象的构造函数，它接受一个函数作为参数，调用这个函数的时候，会传入 `resolve` 和 `reject` 方法。

``` js
function MyPromise(resolver) {
    // 简单起见就不做类型检查了，假定 resolver 一定为函数

    this.status = 0;  // 0: pending, 1: fulfilled, 2: rejected
    this.value = null;
    this.handlers = [];

    doResolve.call(this, resolver);
}

function doResolve(resolver) {
    var called = false;
    function resolvePromise(value) {
        if (called) {
            return;
        } else {
            called = true;
            resolve.call(this, value);
        }
    }

    function rejectPromise(reason) {
        if (called) {
            return;
        } else {
            called = true;
            reject.call(this, reason);
        }
    }

    try {
        resolver(resolvePromise.bind(this), rejectPromise.bind(this));
    } catch(e) {
        rejectPromise(e);
    }
}
```

这样，当使用 `new Promise(function(resolve, reject) {...});` 构造时，就会进入 `doResolve`，这时会执行传入给 `new Promise` 的参数，并给出 `resolve` 和 `reject` 的实现。可以看到为了保证 `resolve` 或 `reject` 总共只能被调用一次，这里用到了一个闭包。接下来来看具体的 `resolve` 和 `reject` 是怎么实现的。

``` js
function resolve(value) {
    try {
        if (this === value) {
            throw new TypeError('A promise cannot be resolved with itself.');
        }
        if (value && (typeof value === 'object' || typeof value === 'function')) {
            var then = value.then;
            if (typeof then === 'function') {
                doResolve.call(this, then.bind(value));
                return;
            }
        }
        this.status = 1;
        this.value = value;
        dequeue.call(this);
    } catch(e) {
        reject(e);
    }
}

function reject(reason) {
    this.status = 2;
    this.value = reason;
    dequeue.call(this);
}
```

具体的 `resolve` 实现中，我们会判断解决的值是否是一个 thenable，如果是的话，就会去执行这个 `then` 函数，并且接受它的状态和返回值。如果不是，就直接使用该值解决这个 promise。

可以想象，当我们执行 promise 的 `then` 方法时，其实是完成了一个类似[观察者模式](http://zh.wikipedia.org/zh/%E8%A7%82%E5%AF%9F%E8%80%85%E6%A8%A1%E5%BC%8F)的注册过程。当 promise 还处于 pending 状态时，回调函数会被暂时存储起来，待到解决或失败时再执行，但是当 `then` 发现这个 promise 已经完成了状态转换，便可以根据状态立即执行回调了。

在这里，我们使用了 `this.handlers` 数组来暂存 `then` 的回调函数，当状态改变时，会调用 `dequeue` 方法来处理队列。

``` js
function dequeue() {
    var handler;
    while (this.handlers.length) {
        handler = this.handlers.shift();
        handle.call(this, handler.thenPromise, handler.onFulfilled, handler.onRejected);
    }
}
```

最后便是核心方法 `then` 的实现了。根据规范，它必须返回一个 promise，并根据 `onFulfilled` 或 `onRejected` 回调的返回值来决定是将它标记为完成还是失败。

``` js
MyPromise.prototype.then = function(onFulfilled, onRejected) {
    var self = this;
    var thenPromise = new MyPromise(function() {});

    if (!self.status) {
        self.handlers.push({
            thenPromise: thenPromise,
            onFulfilled: onFulfilled,
            onRejected: onRejected
        });
    } else {
        handle.call(self, thenPromise, onFulfilled, onRejected);
    }

    return thenPromise;
};

function handle(thenPromise, onFulfilled, onRejected) {
    var self = this;

    setTimeout(function() {
        var callback, ret;
        if (self.status == 1) {
            callback = onFulfilled;
        } else {
            callback = onRejected;
        }
        if (typeof callback === 'function') {
            try {
                ret = callback(self.value);
                resolve.call(thenPromise, ret);
            } catch(e) {
                reject.call(thenPromise, e);
            }
            return;
        }
        if (self.status == 1) {
            resolve.call(thenPromise, self.value);
        } else {
            reject.call(thenPromise, self.value);
        }
    }, 1);
}
```

在上面的 `handle` 函数中，我们立即调用回调函数，并且根据回调函数的类型来改变 `then` 方法返回的 promise 的状态，这样就形成了一个 promise 链条。

大约 100 多行代码，我们就实现了一个粗糙的 Promise 库。当然，上面的代码可能还有很多 Bug，并且也不是严格符合 Promises/A+ 的。如果读者发现问题，请不吝指出。

有了这个核心的基础，实现外围的 API 例如 `Promise.all`、`Promise.race` 就比较简单了，这里就不给出了。其实，Promise 看似用起来很简单，想要自己严格实现一个，还是有不少难点的，其中最容易被绕晕的就是对 `then`
的实现，以及如何处理 `then` 的回调中又返回新的 promise 的逻辑。

我们回到文章开头的例子，使用我们自己的 MyPromise 试验一下。简单起见，就不写那么多层了。

``` js
function waitPromise(param) {
  return new Promise(function(resolve, reject) {
    setTimeout(function() {
      resolve(param);
    }, 2000 + (Math.random() - 0.5) * 1000);
  });
}

waitPromise('如果你愿意').then(function(response) {
  console.log(response);
  return waitPromise('一层');
}).then(console.log.bind(console));
```

可以看到我们可以成功输出两行文字。你能根据上面的实现，看出这次调用事实上一共产生了多少个 promise 对象吗？

答案是五个：

* P0：第一次 `waitPromise('如果你愿意')` 返回的
* P1：第一个 `then` 返回的
* P2：第二个 `then` 返回的
* P3：第一个 `then` 里，通过 `return waitPromise('一层')` 返回的
* P4：在处理 P1 时，会调用 P3 的 `then` 方法，这时候又会返回一个 promise

## 参考资料

* [JavaScript Promises - There and back again](http://www.html5rocks.com/zh/tutorials/es6/promises/)
* [Promises/A+](http://promisesaplus.com/)
* [Promises Implementing](https://www.promisejs.org/implementing/)
