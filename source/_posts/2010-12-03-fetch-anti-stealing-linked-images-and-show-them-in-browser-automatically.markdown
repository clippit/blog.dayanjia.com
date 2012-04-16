---
layout: post
title: 自动获取带有防盗链保护的图片并在浏览器中显示
categories:
- 雕虫小技
tags:
- cURL
- GD
- php
- Python
published: true
comments: true
---
许多网站或者处于保护资源的目的，或者处于节省服务器资源的考虑，将其下的图片等多媒体资源设置了防盗链保护，只有从原始网站访问时才会正确显示。若是有人将这些图片外链到其他地方，就会无法显示，或者显示一个开发者预先指定好的防盗链替代图片。当我们想要真正获取这些图片的时候，就会遇到一些麻烦。当然，麻烦总是能被解决的，今天就来结合最近的一个项目来看看如何做到自动获取这些图片，并在本地进行缓存，同时发送给浏览器显示。

<!--more-->

以南京大学小百合BBS为例，我们已经使用脚本实现了获取某帖子中楼主贴的所有信息并且转换成了干净的HTML。这时候所有的图片都是以这样的形式呈现的：

{% codeblock lang:html %}
<img src="http://bbs.nju.edu.cn/XXXXXXXXXXXX" alt="" />
{% endcodeblock %}

这时我们将这些HTML发布到其他网站时，图片全部显示为一张带有来源说明的防盗链图片，浏览效果很差。

## Referer：防盗链的关键

事实上，大多数网站判断访问来源是通过HTTP Request Header中的Referer判断的。浏览器访问资源时，会自动附带上这个Referer字段表示用户是从那个网址访问到该资源的。在[RFC 2616 超文本传输协议 HTTP/1.1](http://www.ietf.org/rfc/rfc2616.txt "Hypertext Transfer Protocol -- HTTP/1.1")中，有对它的详细描述。

当我们从外站访问这些图片时，浏览器自动在Header中Referer字段提供了当前的网址，那么对方服务器一判断，不是从自己网站访问的，自然就拒绝显示了。

## curl：自由获取任意资源

为了破解这种限制，自然要请来强大的curl。这里我们使用的是PHP自带的curl库。在PHP中使用curl，基本上分为三步，首先`curl_init`初始化一个连接，然后用`curl_setopt`指定连接的各种操作和属性，最后用`curl_exec`执行。让我们来看具体代码：

{% codeblock lang:php %}
function fetch_bbs_image($url) {
    $curl = curl_init($url); //初始化
    curl_setopt($curl, CURLOPT_HEADER, FALSE);
    //将结果输出到一个字符串中，而不是直接输出到浏览器
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
    //最重要的一步，手动指定Referer
    curl_setopt($curl, CURLOPT_REFERER, 'http://bbs.nju.edu.cn');
    $re = curl_exec($curl); //执行
    if (curl_errno($curl)) {
        return NULL;
    }
    return $re;
}
{% endcodeblock %}

相信大家都很明白了吧，设置CURLOPT_REFERER这个属性是最关键的一步。

## 转发图片

一般情况下，我们在PHP中`echo 'hello'`是将字符串作为纯文本输出到浏览器中的。至于为什么是纯文本，这就又要扯到Response Header中的Content-Type了，这便是用来指定内容类型的。这个Content-Type实际上是MIME（Multipurpose Internet Mail Extensions，多用途互联网邮件扩展）标准中的一部分，是通过好几个RFC定义的。大多数网页都是“`text/html`”。如果要用来显示图片，就需要修改这个字段，对应不同的图片格式，有`image/jpeg`、`image/png`、`image/gif`等等。

为了在PHP中使用echo命令输出图片信息，我们就需要修改header信息。根据源图片URL中的后缀名，我们可以相应地使用诸如`header("Content-Type: image/jpeg");`来修改header信息。接下来，`echo fetch_bbs_image($url);`即可。

## 本地缓存

如果每次访问图片我们都需要在服务器上使用curl远程下载一个下来，是比较消耗资源的，我们可以做一个简单的本地缓存，第一次调用时进行下载的操作，今后就可以直接从本地缓存调取图片了。这时候我们需要保证下载回来的图片的文件名都是唯一的。这个好办，通过分析小百合BBS的文件路径，我们可以发现文件路径都是类似`http://bbs.nju.edu.cn/file/xxx/xxxx.jpg`的。所以我们只要把`xxx/xxxx.jpg`保存作为文件名即可，当然需要把其中的斜杠替换成其他字符。

{% codeblock lang:php %}
define(CACHE_DIR, './lily_images/');
 
function get_filename($url) {
    return CACHE_DIR . str_replace('/', '-', substr($url, 27));
}
 
if (file_exists(get_filename($url))) { // cache hit!
    echo file_get_contents(get_filename($url));
    exit();
} else { // save cache
    $filename = get_filename($url);
    file_put_contents( $filename, fetch_bbs_image($url) );
    echo file_get_contents($filename);
}
{% endcodeblock %}

## 图片二次处理

实际应用时，我们发现有时候小百合BBS中的图片都是几百万像素的照片原图，在校园网内访问这些图片自然是毫无压力的，而且Web版BBS中有JavaScript来自动将过大的图片强制缩小显示，以免撑破版面。但是到了外站，如此大的图片就显得有些夸张了，利用PHP中的GD图形库，我们可以方便地进行图片的二次处理，首要的需求自然是将过大的图片缩小。GD库并没有直接按比例缩小图片的功能（如果有也太高级了），好在网上早已有许多现成的代码片段，我们便无需再次发明轮子了。参考了[Maxim Chernyak](http://mediumexposure.com/smart-image-resizing-while-preserving-transparency-php-and-gd-library/ "Smart Image Resizing while Preserving Transparency With PHP and GD Library")的代码片段，我们可以很轻松地实现这一功能。需要说明的是，原始的代码片段中对于小图片也会进行放大处理，而且它对GIF动画的处理会让它变成静止图片，因此需要对其进行小小的修改来满足我们的需要。

{% codeblock 修改后的主脚本和图片缩小函数 lang:php %}
switch (strtolower(substr($url, - 3))) {
    case 'jpg' :
    case 'pge' :
        $type = 'image/jpeg';
        break;
    case 'png' :
        $type = 'image/png';
        break;
    case 'gif' :
        $type = 'image/gif';
        break;
    default :
        $type = '';
}
header("Content-Type: $type");
 
if (file_exists(get_filename($url))) { // cache hit!
    echo file_get_contents(get_filename($url));
    exit();
} else { // resize it and save cache
    $filename = get_filename($url);
    $img_content = fetch_bbs_image($url);
    file_put_contents($filename, $img_content);
    if ($type == 'image/png' || $type == 'image/jpeg') {
        smart_resize_image($filename, 550, 550, true);
    }
    echo file_get_contents($filename);
}
 
/**
 * Smart Image Resizing while Preserving Transparency With PHP and GD Library
 * tinily modified by @author clippit
 *
 * @author Maxim Chernyak
 * @link http://mediumexposure.com/smart-image-resizing-while-preserving-transparency-php-and-gd-library/
 */
function smart_resize_image($file, $width = 0, $height = 0, $proportional = false, $output = 'file', $delete_original = true, $use_linux_commands = false) {
    if ($height <= 0 && $width <= 0) {
        return false;
    }
 
    $info = getimagesize($file);
    $image = '';
 
    if ($info [0] <= $width || $info [1] <= $height) {
        // if the original image is too small to the target width and height, then do not zoom in
        return false;
    }
 
    $final_width = 0;
    $final_height = 0;
    list ( $width_old, $height_old ) = $info;
 
    if ($proportional) {
        if ($width == 0)
            $factor = $height / $height_old;
        elseif ($height == 0)
            $factor = $width / $width_old;
        else
            $factor = min($width / $width_old, $height / $height_old);
 
        $final_width = round($width_old * $factor);
        $final_height = round($height_old * $factor);
 
    } else {
        $final_width = ($width <= 0) ? $width_old : $width;
        $final_height = ($height <= 0) ? $height_old : $height;
    }
 
    switch ($info [2]) {
        case IMAGETYPE_GIF :
            $image = imagecreatefromgif($file);
            break;
        case IMAGETYPE_JPEG :
            $image = imagecreatefromjpeg($file);
            break;
        case IMAGETYPE_PNG :
            $image = imagecreatefrompng($file);
            break;
        default :
            return false;
    }
 
    $image_resized = imagecreatetruecolor($final_width, $final_height);
 
    if (($info [2] == IMAGETYPE_GIF) || ($info [2] == IMAGETYPE_PNG)) {
        $trnprt_indx = imagecolortransparent($image);
 
        // If we have a specific transparent color
        if ($trnprt_indx >= 0) {
 
            // Get the original image's transparent color's RGB values
            $trnprt_color = imagecolorsforindex($image, $trnprt_indx);
 
            // Allocate the same color in the new image resource
            $trnprt_indx = imagecolorallocate($image_resized, $trnprt_color ['red'], $trnprt_color ['green'], $trnprt_color ['blue']);
 
            // Completely fill the background of the new image with allocated color.
            imagefill($image_resized, 0, 0, $trnprt_indx);
 
            // Set the background color for new image to transparent
            imagecolortransparent($image_resized, $trnprt_indx);
 
        } // Always make a transparent background color for PNGs that don't have one allocated already
elseif ($info [2] == IMAGETYPE_PNG) {
 
            // Turn off transparency blending (temporarily)
            imagealphablending($image_resized, false);
 
            // Create a new transparent color for image
            $color = imagecolorallocatealpha($image_resized, 0, 0, 0, 127);
 
            // Completely fill the background of the new image with allocated color.
            imagefill($image_resized, 0, 0, $color);
 
            // Restore transparency blending
            imagesavealpha($image_resized, true);
        }
    }
 
    imagecopyresampled($image_resized, $image, 0, 0, 0, 0, $final_width, $final_height, $width_old, $height_old);
 
    if ($delete_original) {
        if ($use_linux_commands)
            exec('rm ' . $file);
        else
            @unlink($file);
    }
 
    switch (strtolower($output)) {
        case 'browser' :
            $mime = image_type_to_mime_type($info [2]);
            header("Content-type: $mime");
            $output = NULL;
            break;
        case 'file' :
            $output = $file;
            break;
        case 'return' :
            return $image_resized;
            break;
        default :
            break;
    }
 
    switch ($info [2]) {
        case IMAGETYPE_GIF :
            imagegif($image_resized, $output);
            break;
        case IMAGETYPE_JPEG :
            imagejpeg($image_resized, $output);
            break;
        case IMAGETYPE_PNG :
            imagepng($image_resized, $output);
            break;
        default :
            return false;
    }
 
    return true;
}
{% endcodeblock %}

## 调用该PHP脚本

我们将这个脚本放在可以访问到的Web目录中，并且建立一个`CACHE_DIR`中指定的目录，给它赋予775权限。URL参数我们通过GET参数来获得。为了防止一些莫名其妙的编码问题，并且掩耳盗铃一下，这个参数我们采用Base64编码后再进行URL转义。

同时，如果传入的URL参数不是来自`http://bbs.nju.edu.cn`的，就直接用`header("Location: $url")`重定向到目标网址，不处理该图片文件。

## 修改图片引用地址
最开始我们说到，图片都是`<img src="http://bbs.nju.edu.cn/XXXXXXXXXXXX" alt="" />`这样的，在发布的时候就需要把其中的src全部改掉了。使用强大的正则表达式，我们可以轻松地在大量HTML中替换这些，以Python脚本为例，我们只需两个函数：

{% codeblock lang:python %}
import base64, re, urllib
 
def encode_url(match):
    url = urllib.pathname2url( base64.b64encode(match.group(1)) )
    return ''.join( ('<img alt="" src="', GET_IMAGE, url, '"') )
 
def image_proxy(text):
    return re.sub(r'<img alt="" src="([^"]+)"', encode_url, text)
{% endcodeblock %}

在需要的时候，将HTML代码字符串传入`image_proxy`即可。
