---
layout: post
title: "解决Rubypython在Arch Linux下的问题"
date: 2012-04-18 01:06
comments: true
categories: 
- 雕虫小技
---
Octopress使用了Pygments来处理代码高亮。不过从它的名字中我们就能看出，它是Python环境下的项目，本不属于Ruby。好在动态语言具有良好的“粘合性”，在Ruby里面调用Python代码也不是一件难事。Ruby下便有一个名叫[rubypython](http://rubypython.rubyforge.org/)的扩展库，它使用了另一个更加底层的，用于将Ruby和其他各种语言进行绑定的[FFI](https://github.com/ffi/ffi)库，建立起了Ruby和Python之间的桥梁。

然而，我在Arch Linux下使用Octopress生成高亮代码时，却遇到了意想不到的问题。由于各种扩展库（称为_gem_）之间依赖关系复杂，加上我对Ruby几乎毫不了解，解决起来绕了不少弯路。

<!--more-->

## 问题初现

当使用`rake generate`生成站点时，发现报错：

```
Building site: source -> public
  File "<string>", line 1
    import sys; print sys.executable
                        ^
SyntaxError: invalid syntax
sh: - : 无效的选项
```

第一反应便是Arch Linux中Python版本的冲突问题，果然被我猜中。

## Arch Linux中的两代Python

众所周知，Python现在的发展道路是2.x和3.x齐头并进。在Arch的官方源中，自然也同时提供了这两个版本。不过与大多数发行版不同的是，`python`命令指向的是3.x版本，而要使用2.x版本时就必须用`python2`命令。事实上，这两个命令都是以符号链接的形式指向了具体版本号的Python：

``` bash
$ ls -l /usr/bin | grep python 
-rwxr-xr-x 1 root root           150 12月 25 00:37 ipython2
lrwxrwxrwx 1 root root             7 11月 22 01:05 python -> python3
lrwxrwxrwx 1 root root             9  1月 31 21:21 python2 -> python2.7
-rwxr-xr-x 1 root root          6200  1月 31 21:21 python2.7
-rwxr-xr-x 1 root root          1618  1月 31 21:21 python2.7-config
lrwxrwxrwx 1 root root            16  1月 31 21:21 python2-config -> python2.7-config
-rwxr-xr-x 3 root root          6272 11月 22 01:05 python3
-rwxr-xr-x 3 root root          6272 11月 22 01:05 python3.2
lrwxrwxrwx 1 root root            18 11月 22 01:05 python3.2-config -> python3.2mu-config
-rwxr-xr-x 3 root root          6272 11月 22 01:05 python3.2mu
-rwxr-xr-x 1 root root          1821 11月 22 01:05 python3.2mu-config
lrwxrwxrwx 1 root root            16 11月 22 01:05 python3-config -> python3.2-config
lrwxrwxrwx 1 root root            14 11月 22 01:05 python-config -> python3-config
```

显然Octopress在调用Pygments的时候不会想到这一点，我们需要强制其使用`python2.7`。

## 给Pygments显式指定Python命令行

在Octopress的`plugins`目录下，新建一个如下文件：

{% gist 2407686 %}

## 一波未平一波又起

解决了这个问题以后，谁知又出现了新问题。`rake generate`报出的另一个错误：

```
Building site: source -> public
/home/clippit/.rvm/gems/ruby-1.9.2-p290/gems/rubypython-0.5.3/lib/rubypython.rb:107:in `start': undefined method `Py_IsInitialized' for RubyPython::Python:Module (NoMethodError)
	from /home/clippit/.rvm/gems/ruby-1.9.2-p290/gems/pygments.rb-0.2.11/lib/pygments/ffi.rb:8:in `start'
	from /home/clippit/.rvm/gems/ruby-1.9.2-p290/gems/pygments.rb-0.2.11/lib/pygments/ffi.rb:82:in `highlight'
	from /home/clippit/blog/plugins/pygments_code.rb:29:in `pygments'
	from /home/clippit/blog/plugins/pygments_code.rb:19:in `highlight'

# (以下 trace 省略)
```

Google无果后，我决定去看看rubypython的源码，看看到底是什么地方出了问题。

打开到`rubypython.rb`的107行，的确是`RubyPython::Python.Py_IsInitialized`这里出现了问题。于是跟踪到`python.rb`文件，这里便是使用`ffi`进行语言绑定的核心地带了。看到这样一句话：

``` ruby
EXEC = RubyPython::PythonExec.new(RubyPython.options[:python_exe])
```

于是再转到[`pythonexec.rb`](https://bitbucket.org/raineszm/rubypython/src/b82963530f97/lib/rubypython/pythonexec.rb)中。`PythonExec`类主要是由两个方法构成的，`initialize`负责寻找系统中python的执行文件路径，而`find_python_lib`会搜寻相应python的动态库的位置，以便稍候使用`ffi`进行Python C API的绑定。
{% pullquote %}
Ruby语言的可读性还是很强的，尝试在`initialize`中插入一句`puts @realname`，然后再运行一次`rake generate`，果然看到了打印出来的结果。

但是让人不解的是，输出竟然是`/usr/bin/python2.727`！作为Ruby小白，通过多次尝试`puts`和稍微猜测语法含义后，我竟然断定{" 这是rubypython的bug "}了。想必那段代码是想跟据`python`找到`/usr/bin/python27`，不过由于发行版的差异，这在Arch Linux上是错误的。
{% endpullquote %}

于是我打算“喂给他”一个`python2.727`，手动建立一个新的符号链接：

``` bash
sudo ln -s /usr/bin/python2.7 /usr/bin/python2.727
```

再次`rake generate`，竟然还是报错！

那就继续阅读源码吧，进一步跟踪后发现代码会卡在`ffi_lib EXEC.library`这里，于是把`EXEC.library`打印出来，竟然是空的。看来`find_python_lib`也有问题。毫无头绪之际，在`irb`中随意输入了几行，竟然发现了问题所在：

``` ruby
1.9.2p290 :015 > module My
1.9.2p290 :016?>   extend FFI::Library
1.9.2p290 :017?>   EXEC = RubyPython::PythonExec.new("python2.7")
1.9.2p290 :018?>   ffi_lib EXEC.library
1.9.2p290 :019?>   end
LoadError: Could not open library 'lib.so': lib.so: cannot open shared object file: No such file or directory
	from /home/clippit/.rvm/gems/ruby-1.9.2-p290/gems/ffi-1.0.11/lib/ffi/library.rb:121:in `block in ffi_lib'
	from /home/clippit/.rvm/gems/ruby-1.9.2-p290/gems/ffi-1.0.11/lib/ffi/library.rb:88:in `map'
	from /home/clippit/.rvm/gems/ruby-1.9.2-p290/gems/ffi-1.0.11/lib/ffi/library.rb:88:in `ffi_lib'
	from (irb):18:in `<module:My>'
	from (irb):15
	from /home/clippit/.rvm/rubies/ruby-1.9.2-p290/bin/irb:16:in `<main>'
```
这回的报错让人眼前一亮，恍然大悟——既然我给它`python2.727`这个文件名，那他就会去找`libpython2.727.so`，自然还是找不到啊！于是硬着头皮再给系统加一个符号链接

``` bash
sudo ln -s /usr/lib/libpython2.7.so.1.0 /usr/lib/libpython2.727.so
```

这下世界终于太平了。

奇怪的是，`rake generate`时却不会显示这个直中要害的信息，而给出了一个很迂回的错误提示，以致于让我绕了很多弯子。这其中究竟是什么原因，实在是不得而知了。

## 另一个解决方法

除了在系统中添加符号链接，还有一个方法，就是Hack掉rubypython的源码。在`pythonexec.rb`中修改：

``` diff
@@ -19,7 +19,9 @@
 
     @dirname = File.dirname(@python)
     @realname = @python.dup
-    if (@realname !~ /#{@version}$/ and @realname !~ /\.exe$/)
+    if (@realname.include? 'python2.7')
+        # Do nothing
+    elsif (@realname !~ /#{@version}$/ and @realname !~ /\.exe$/)
       @realname = "#{@python}#{@version}"
     else
       basename = File.basename(@python, '.exe')

```

当然，这个方法非常丑陋。

## 参考资料

后来经过一番搜索，还是有一些相关的资料的，在此列出。

  * [How to Fix Octopress Pygments Error on Arch Linux](http://blog.gonzih.org/blog/2011/09/21/fix-octopress-pygments-error-on-arch-linux/)
  * [Py_IsInitialized error](https://github.com/github/gollum/issues/225)
  * [解决pygments.rb (RubyPython) 找不到libpython的问题](http://ruby-china.org/topics/289)

## 编后

就在我这这篇文章的时候，rubypython竟然发布新版本([0.6.0](http://rubygems.org/gems/rubypython))了，真是太巧了。不过暂时还不知道是否修复了这个问题，新版本的代码似乎进行了较大的重构，`pythonexec.rb`文件被删除，本文所描述的代码转到`interpreter.rb`中去了。


