---
layout: post
title: "使用Joomla! Platform开发Web应用程序"
date: 2012-08-09 22:06
comments: true
categories: 
 - 自娱自乐
---

众所周知Joomla!是一款用PHP开发的CMS程序，使用非常广泛。今天的主题虽然名字和它非常类似，但却不是一样东西。[Joomla! Platform](https://github.com/joomla/joomla-platform)脱胎自Joomla! CMS，它剔除了CMS相关内容，将功能抽象化后成为了一款通用的PHP程序开发框架。所以你可以认为CMS也是使用该Platform开发的一个Web应用。光从这点上来说，Joomla! Platform的诞生倒是[和Django有几分相似](http://www.djangobook.com/en/2.0/chapter01/#s-django-s-history)，后者也是由新闻网站发展而来的通用框架。

J!Platform在2011年从Joomla!项目中和CMS分离开。由于它还很年轻，再加上Joomla!社区一贯不喜欢写文档的“光荣传统”，Joomla! Platform除了API文档以外就没有像样的指南了，[官方的示例](https://github.com/joomla/joomla-platform-examples)也是简单得可怜。而且在最新的12.1版本中，MVC模式做出了大幅度精简和修改，这也增加了它上手的困难度。鉴于此，我编写了一个[基于新版MVC的Web应用程序示例](https://github.com/clippit/joomla-platform-mvc-example)。

<!--more-->

## 12.1中的MVC

J!Platform的版本号看上去比较吓人，其实它采用的是类似Ubuntu的命名方法，12.1的意思便是2012年发布的第一个稳定版本（话说12.2也该快出来了）。在这个版本中，MVC框架做出了大幅度精简，变得非常轻量化。

### Controller

J!Platform中的控制器职责是非常单一的，一个Controller仅负责一个具体的执行逻辑，不像某些PHP框架有着Controller/Action的两层执行路径。接口`JController`中指定了三个方法，其中`execute`便是具体的执行动作，而其他两个则是辅助用。

{% codeblock controller.php https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/controller/controller.php %}
<?php
interface JController extends Serializable
{
	public function execute();

	public function getApplication();

	public function getInput();
}
{% endcodeblock %}

一般使用时我们可以继承[`JControllerBase`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/controller/base.php)这个类，它提供了后两个接口方法和序列化相关方法的基本处理。

### Model

模型层的基本接口`JModel`也是相当简单，它只要求维护一个表示Model状态的对象。

{% codeblock model.php https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/model/model.php %}
<?php
interface JModel
{
	public function getState();

	public function setState(JRegistry $state);
}
{% endcodeblock %}

而提供的[`JModelDatabase`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/model/database.php)类也只是在实现这两个接口方法的基础上维护了一个数据库相关的对象而已。这个Model层是我见过最简单的Model层，没有绑定ORM，其数据源可以非常灵活。

事实上，在J!Platform中提供了一个名叫[`JTable`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/table/table.php)的类，它提供了一个对数据库中表操作的简单接口，比仅提供对SQL的简单封装的`[JDatabaseDriver`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/database/driver.php)要高级一些，早某些场合下也许会方便一些。这个`JTable`实现了[Active Record](http://en.wikipedia.org/wiki/Active_record_pattern)——这个被Ruby on Rails发扬光大的模式。但是很明显，它的实现非常粗糙，而且还带有浓厚的CMS气味，希望今后能够继续发展。在我的实例中，我简单地为Model集成了这个类，又顺便写了一个在J!Platform中没有实现却非常用的`findAll`方法。

### View

视图基本接口`JView`依旧延续极简的风格，只有两个方法，一个负责转义内容，另一个负责渲染输出。

{% codeblock view.php https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/view/view.php %}
<?php
interface JView
{
	public function escape($output);

	public function render();
}
{% endcodeblock %}

对于Web应用（J!Platform不光着眼于Web应用，还可以实现命令行程序和守护程序），其提供的[`JViewHtml`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/view/html.php)维护了一个Model的实例，而在渲染输出时将会根据提供的路径找到一个Layout文件并将其输出。在Layout文件中，你可以混合使用HTML和PHP代码，其中的`$this`指的便是与其关联的JViewHtml实例。

## 自动加载类

J!Platform使用了PHP的autoload特性，只要按照一定的方式命名类并将其存入恰当的目录中，就不需要手动`require`任何东西了。想要将自己应用中的类纳入自动加载的范围内，你需要统一类的前缀，并将基本目录注册到J!Platform中：

{% codeblock lang:phpinline %}
JLoader::registerPrefix('Foo', '/custom/path');
{% endcodeblock %}

此后的约定是这样的：

* `FooClassname` 存放在 `/custom/path/classname/classname.php`
* `JPathtoClassname` 存放在 `/custom/path/pathto/classname.php`

J!Platform并没有使用到PHP 5.3的命名空间特性，而是使用了传统的前缀区分法。

## Web应用请求的一生

跟众多框架一样，J!Platform也是单一入口的，因此除了`index.php`需要暴露给HTTP服务器，剩余的代码都不需要直接被用户访问。在编写的示例中，我模仿[Yii](http://yiiframework.com)的实现将除了`index.php`以外的文件放在了`protected`目录中。

### `index.php`

在入口和引导代码中，我们首先需要定义一些必须的常量：

``` php
<?php
// We are a valid Joomla entry point.
define('_JEXEC', 1);

// Setup the base path related constant.
define('JPATH_SITE', dirname(__FILE__) . '/protected');
define('JPATH_BASE', JPATH_SITE);
define('JPATH_PLATFORM', dirname(dirname(__FILE__)) . '/joomla/libraries');
```

接着加载整个框架：

{% codeblock lang:phpinline %}
require_once JPATH_PLATFORM.'/import.php';
{% endcodeblock %}

这个`impport.php`文件加载了`platform.php`和`loader.php`，前者包含了Platform的版本信息，后者则是提供前面提到的自动加载类的功能。接着他会加载[`factory.php`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/factory.php)，这个`JFactory`类全部由静态成员和静态方法组成，包含了一些整个应用程序全局的重要组件的访问。

然后我们注册自己的前缀类以启用自动加载类的功能：

{% codeblock lang:phpinline %}
JLoader::registerPrefix('LH', JPATH_BASE);
{% endcodeblock %}

接下来便可以实例化Web应用了，这是一个继承了[`JApplicationWeb`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/application/web.php)的实例，是整个Web应用的基础对象。随后我们将实例化的`$app`保存到`JFactory`中以便全局访问，然后将其初始化并开始执行过程。至此Web应用的引导过程结束。

{% codeblock lang:phpinline %}
// Instantiate the application.
$app = JApplicationWeb::getInstance('LHApplicationWeb');

// Store the application.
JFactory::$application = $app;

// Execute the application.
$app->init()->execute();
{% endcodeblock %}

### Web应用的基础对象

我们继承了`JApplicationWeb`后主要要实现其中的`doExecute`方法，它是被`execute`执行过程中调用的。除此之外`execute`还进行了事件触发、文档渲染等动作。

在真正开始执行之前，这个基础对象还需要初始化，`JApplicationWeb`提供的`initialise`方法初始化了文档（负责最终输出的内容）、Session、多语言支持和事件分派模块。在我的实例中，还另外初始化了数据库（`JDatabaseDriver`）和URL路由（`JApplicationWebRouterBase`）。

### 路由分配

所谓路由就是将特定格式的URL和Controller关联起来，这些配置可以硬编码，也可以从配置文件中读取。在我的实例中，通过重写`JApplicationWeb`中的`fetchConfigurationData`方法，程序可以读取外部`json`格式的配置文件。

{% codeblock main.dist.json %}
{
	/* .... */
	"url_router":
		{
			"default_controller": "site",
			"routes":
			[
				{
					"route": "index",
					"controller": "site"
				},
				{
					"route": "user",
					"controller": "view"
				},
				{
					"route": "user/:user_id",
					"controller": "view"
				}
			]
		},
	/* .... */
}
{% endcodeblock %}

其中以冒号开头的部分是可变的参数。

前面说到Web应用的执行，其实就是将执行权交给了路由，让它根据来源URL来确定应该调用哪个Controller。

### 从Controller到`JDocument`

到了Controller这边，它也是定义`execute`方法来完成具体动作的。前面说到一个Controller只完成一个操作，因此如果你准备对某个数据进行CRUD的话，恐怕就得使用四个不同的Controller了，这点看上去比较诡异。

Controller的一大职责便是调取需要的Model对象发送给View进行渲染。View渲染的内容仅仅是一个页面的一部分，一个页面可能会由若干个View各自渲染自己的部分，最后由Controller统一获取后设置到`JDocument`中。`JDocument`控制整个页面的显示，它的最终渲染和发送到客户端是由`JApplicationWeb`完成的。完整的`execute`代码是这样的：

{% codeblock web.php https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/application/web.php %}
<?php
class JApplicationWeb extends JApplicationBase
{
	/* .... */

	public function execute()
		{
			// Trigger the onBeforeExecute event.
			$this->triggerEvent('onBeforeExecute');

			// Perform application routines.
			$this->doExecute();

			// Trigger the onAfterExecute event.
			$this->triggerEvent('onAfterExecute');

			// If we have an application document object, render it.
			if ($this->document instanceof JDocument)
			{
				// Trigger the onBeforeRender event.
				$this->triggerEvent('onBeforeRender');

				// Render the application output.
				$this->render();

				// Trigger the onAfterRender event.
				$this->triggerEvent('onAfterRender');
			}

			// If gzip compression is enabled in configuration and the server is compliant, compress the output.
			if ($this->get('gzip') && !ini_get('zlib.output_compression') && (ini_get('output_handler') != 'ob_gzhandler'))
			{
				$this->compress();
			}

			// Trigger the onBeforeRespond event.
			$this->triggerEvent('onBeforeRespond');

			// Send the application response.
			$this->respond();

			// Trigger the onAfterRespond event.
			$this->triggerEvent('onAfterRespond');
		}

	/* .... */
}
{% endcodeblock %}

在具体的Web应用中，实际上使用的是[`JDocumentHTML`](https://github.com/joomla/joomla-platform/blob/master/libraries/joomla/document/html/html.php)这个类的实例，你需要在模板文件中定义一些`<jdoc>`标签来标定渲染的位置。

随着将渲染完毕的内容发回浏览器，一次Web请求也到此为止了。

## Joomla! Platform的忧与爱

Joomla!是一块响当当的牌子。我之所以接触到它完全是因为最近工作的原因，在一个项目小组里能遇见Joomla!项目的核心领导者，虽然未曾谋面，具体工作也没有什么交集，但是这已经足够让人感到惊喜了。所以在这里我是不可能黑Joomla!的XD。不过该客观的还是要客观，Joomla! Platform从CMS中分离出来作为更基础的一个平台，是一个非常棒的决定，但是要让Joomla!跻身一流的PHP框架，还有很长的路要走。

就目前来说，J!Platform还有一些不成熟的地方：

* 和CMS的剥离还没有完全彻底地搞定
* 框架内部的命名规范还有待加强，例如“HTML”和“Html”得不到统一，获取数据库对象的方法有时候是`getDb`有时候是`getDbo`
* 静态方法显得有些混乱。包括纯静态的`JFactory`，它其实并不是一个“工厂”，仅仅是一个“仓库”而已。此外随处可见的`getInstance`也容易让人摸不着头脑
* Model层过于薄弱，在ORM、Active Record大行其道的今天，J!Platform应该有所动作。的确，有人喜欢纯粹的SQL交互，但是这样的“装备”却是Full-stack框架标配的。
* View层显得不太灵活，你不能在模板中方便地传递任何想要的参数，一切内容都需要放在关联的Model中，或者需要继承默认的View类

路漫漫而修远兮，吾将上下而求索。