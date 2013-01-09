---
layout: post
title: "Atlassian JIRA 授权许可证机制分析"
date: 2012-12-27 21:50
comments: true
categories:
 - 雕虫小技
---

[JIRA](http://www.atlassian.com/software/jira/overview)在Atlassian开发的各种产品中算是最著名的一个，它主要是用来做产品缺陷跟踪和项目管理的。JIRA是商业软件，它的授权是按使用用户数划分的，最便宜的10用户版本只要10美元，这极大地方便了小型团队的开发，不过25个用户的授权版本就高达1200美元了。今天来讲一讲JIRA的软件许可证是如何授权的。事实上Atlassian的诸多产品例如协作和内容共享应用Confluence、版本控制解决方案Stash等都是采用的类似的授权机制。

<!--more-->

## 从一条Lincense谈起

在Atlassian网站上，用户可以申请JIRA的一个月试用许可证。授权信息的生成需要用户提供一个Server ID，它是在安装完JIRA第一次启动时由客户端生成的。随后便可以得到一个完整的许可证字符串：

    AAABDg0ODAoPeNptUNtKxDAQfc9XBHyOpKlttZCH2gas9LK0VRF8idlRI91akrS4f293q4iyMAPDn
    Msc5uwBtjgDhVmI6VXsRbEf4rTtMKMeQxlYZfTo9MfAb/MmeYqxmGU/ycMGpQaOQyYd8AOfLMUi9
    K6NPC+0gsGC2OqjWlSdaDZN3gr068CdmeAPvduPUMkd8LQuS9GkeVKsuFROz7AK+pV7D8YeTBgqp
    R4cDHJQID5HbfY/iXxCPcJCVJtXOWi7Hk17PY7a4Q6sW82rafcMpn65s4slJx5qwcxg8oxf06AgN
    7TzSZFEAWkuxCNqRcWXJgXzaHQZROg7+0Iv8uwUcjrUZjLqTVr4/74vnyt/nTAsAhR8v6Zm5YfvZ
    WVBnwouY7xhT+jwUgIUbRhGVaC8P9JCvDPT1MXIwnCgGqA=X02dp

明眼人一看这显然是经过Base64编码的，不过在补齐长度的结尾`=`后面还有五个字符。其中第一个`X`是一个固定的分隔符；紧接着的`02`代表许可证版本，即第二版；最后的`dp`是长度校验码，它是由31进制转换而来。dp转成十进制就是428，可以看到去掉最后五个字符和所有换行符后，许可证真正的字符串长度的确是428。

## 解码Base64

以下的内容用Python演示，首先将其解码。

``` pycon
>>> license = 'AAABDg0ODAoPeNptUNtKxDAQfc9XBHyOpKlttZCH2gas9LK0VRF8idlRI91akrS4f
293q4iyMAPDnMsc5uwBtjgDhVmI6VXsRbEf4rTtMKMeQxlYZfTo9MfAb/MmeYqxmGU/ycMGpQaOQyYd8
AOfLMUi9K6NPC+0gsGC2OqjWlSdaDZN3gr068CdmeAPvduPUMkd8LQuS9GkeVKsuFROz7AK+pV7D8YeT
BgqpR4cDHJQID5HbfY/iXxCPcJCVJtXOWi7Hk17PY7a4Q6sW82rafcMpn65s4slJx5qwcxg8oxf06AgN
7TzSZFEAWkuxCNqRcWXJgXzaHQZROg7+0Iv8uwUcjrUZjLqTVr4/74vnyt/nTAsAhR8v6Zm5YfvZWVBn
wouY7xhT+jwUgIUbRhGVaC8P9JCvDPT1MXIwnCgGqA='
>>> len(license)
428
>>> import base64
>>> s = base64.b64decode(license)
>>> s
'\x00\x00\x01\x0e\r\x0e\x0c\n\x0fx\xdamP\xdbJ\xc40\x10}\xcfW\x04|\x8e\xa4\xa9m\x
b5\x90\x87\xda\x06\xac\xf4\xb2\xb4U\x11|\x89\xd9Q#\xddZ\x92\xb4\xb8\x7fow\xab\x8
8\xb20\x03\xc3\x9c\xcb\x1c\xe6\xec\x01\xb68\x03\x85Y\x88\xe9U\xecE\xb1\x1f\xe2\x
b4\xed0\xa3\x1eC\x19Xe\xf4\xe8\xf4\xc7\xc0o\xf3&y\x8a\xb1\x98e?\xc9\xc3\x06\xa5\
x06\x8eC&\x1d\xf0\x03\x9f,\xc5"\xf4\xae\x8d</\xb4\x82\xc1\x82\xd8\xea\xa3ZT\x9dh
6M\xde\n\xf4\xeb\xc0\x9d\x99\xe0\x0f\xbd\xdb\x8fP\xc9\x1d\xf0\xb4.K\xd1\xa4yR\xa
c\xb8TN\xcf\xb0\n\xfa\x95{\x0f\xc6\x1eL\x18*\xa5\x1e\x1c\x0crP >Gm\xf6?\x89|B=\x
c2BT\x9bW9h\xbb\x1eM{=\x8e\xda\xe1\x0e\xac[\xcd\xabi\xf7\x0c\xa6~\xb9\xb3\x8b%\'
\x1ej\xc1\xcc`\xf2\x8c_\xd3\xa0 7\xb4\xf3I\x91D\x01i.\xc4#jE\xc5\x97&\x05\xf3ht\
x19D\xe8;\xfbB/\xf2\xec\x14r:\xd4f2\xeaMZ\xf8\xff\xbe/\x9f+\x7f\x9d0,\x02\x14|\x
bf\xa6f\xe5\x87\xefeeA\x9f\n.c\xbcaO\xe8\xf0R\x02\x14m\x18FU\xa0\xbc?\xd2B\xbc3\
xd3\xd4\xc5\xc8\xc2p\xa0\x1a\xa0'
```

解码出来的内容，由三部分组成。第一部分是前四个字节，代表着第二部分的长度，因此根据第一部分的值便可以切割出后面两个部分。

在上面的例子中，一个部分的值是`\x00\x00\x01\x0e`。JIRA的主要实现语言是Java，这里的四个字节是使用`DataInput`接口中的`readInt()`方法读取的。若将四个字节代表的8位整数分别称作a, b, c, d，则它表示的整数可以通过如下方法得出：

    (((a & 0xff) << 24) | ((b & 0xff) << 16) | ((c & 0xff) << 8) | (d & 0xff))

Java的内部编码基本遵循UTF-32BE，即将Unicode全部字符用四字节固定长度编码，并且字节序为Big Endian。在Python端，我们可以这样解码：

``` pycon
>>> ord(s[:4].decode('UTF-32BE'))
270
```

得到了这个长度，便可以将上面的内容分割成两部分了，称前一部分为`licenseText`，后一部分为`licenseSig`。

``` pycon
>>> licenseText, licenseSig = s[4:4 + 270], s[4 + 270:]
>>> licenseText
'\r\x0e\x0c\n\x0fx\xdamP\xdbJ\xc40\x10}\xcfW\x04|\x8e\xa4\xa9m\xb5\x90\x87\xda\x
06\xac\xf4\xb2\xb4U\x11|\x89\xd9Q#\xddZ\x92\xb4\xb8\x7fow\xab\x88\xb20\x03\xc3\x
9c\xcb\x1c\xe6\xec\x01\xb68\x03\x85Y\x88\xe9U\xecE\xb1\x1f\xe2\xb4\xed0\xa3\x1eC
\x19Xe\xf4\xe8\xf4\xc7\xc0o\xf3&y\x8a\xb1\x98e?\xc9\xc3\x06\xa5\x06\x8eC&\x1d\xf
0\x03\x9f,\xc5"\xf4\xae\x8d</\xb4\x82\xc1\x82\xd8\xea\xa3ZT\x9dh6M\xde\n\xf4\xeb
\xc0\x9d\x99\xe0\x0f\xbd\xdb\x8fP\xc9\x1d\xf0\xb4.K\xd1\xa4yR\xac\xb8TN\xcf\xb0\
n\xfa\x95{\x0f\xc6\x1eL\x18*\xa5\x1e\x1c\x0crP >Gm\xf6?\x89|B=\xc2BT\x9bW9h\xbb\
x1eM{=\x8e\xda\xe1\x0e\xac[\xcd\xabi\xf7\x0c\xa6~\xb9\xb3\x8b%\'\x1ej\xc1\xcc`\x
f2\x8c_\xd3\xa0 7\xb4\xf3I\x91D\x01i.\xc4#jE\xc5\x97&\x05\xf3ht\x19D\xe8;\xfbB/\
xf2\xec\x14r:\xd4f2\xeaMZ\xf8\xff\xbe/\x9f+\x7f\x9d'
>>> licenseSig
'0,\x02\x14|\xbf\xa6f\xe5\x87\xefeeA\x9f\n.c\xbcaO\xe8\xf0R\x02\x14m\x18FU\xa0\x
bc?\xd2B\xbc3\xd3\xd4\xc5\xc8\xc2p\xa0\x1a\xa0'
```

## zlib 解压缩

`licenseText`的前五个字节是一个识别字串，由五个固定的ASCII码组成。

``` pycon
>>> map(ord, '\r\x0e\x0c\n\x0f')
[13, 14, 12, 10, 15]
```

去掉这个前缀后的内容是经过[zlib](http://zlib.net/)压缩的，我们将其解压后便得到了原始的许可证内容。

``` pycon
>>> import zlib
>>> licenseTextOriginal = zlib.decompress(licenseText[5:])
>>> print licenseTextOriginal
#Wed Dec 26 09:17:36 CST 2012
Description=JIRA\: Evaluation
CreationDate=2012-12-27
jira.LicenseEdition=ENTERPRISE
Evaluation=true
jira.LicenseTypeName=COMMERCIAL
jira.active=true
licenseVersion=2
MaintenanceExpiryDate=2013-01-26
Organisation=Clippit Test
jira.NumberOfUsers=-1
ServerID=ABCD-1234-EFGH-5678
SEN=SEN-L2107857
LicenseID=LIDSEN-L2107857
LicenseExpiryDate=2013-01-26
PurchaseDate=2012-12-27
```

上面的`ServerID`已被隐去。可以看出这个许可证的内容是非常明确的，在这里就不多解释了。

## DSA with SHA-1 数字签名

可以看到上面的各种方法至多可以保证许可证内容的正确性，却没有办法保证鉴别性和不可否认性。JIRA采用了数字签名的方法来确保软件许可证的安全，具体而言，便是DSA算法。

DSA（Digital Signature Algorithm）和更为普遍的RSA算法一样都是基于公钥私钥的加密系统（DSA和RSA的比较可以[参考这里](http://stackoverflow.com/questions/2841094/what-is-the-difference-between-dsa-and-rsa)）。

JIRA客户端中存储的公钥在atlassian-extras-2.2.2.jar文件的`com.atlassian.extras.decoder.v2.Version2LicenseDecoder`类中。为了使其能够正确被Python的OpenSSL库M2Crypto识别，需要把它提取出来并在首尾加上`-----BEGIN PUBLIC KEY-----`和`-----END PUBLIC KEY-----`的标记。接着来尝试一下验证的过程：

``` pycon
>>> from M2Crypto import DSA
>>> import hashlib
>>> pk = DSA.load_pub_key('./official_pubkey.pem')
>>> pk.verify_asn1(hashlib.sha1(licenseText).digest(), licenseSig)
1
```

## 伪造数字签名

数字签名的安全性还是极高的，通过公钥推导出私钥，以现有的计算能力是几乎不可能的事。所以一般针对数字签名的破解方法便是设法替换掉预设的公钥，使用自己的密钥对。创建密钥对也是很简单的事：

``` pycon
>>> dsa = DSA.gen_params(1024)
..+.....+.......+.+.........+............+.+........+.......++++++++++++++++++++
+++++++++++++++++++++++++++++++*
.......+.......+....+..+.............+...................+...+........+........+
....+.......+......+..........+....+.+....+............+..+....+.......+...+.+..
+.........+...+..+................+.........+..+.......+..................+....+
....+.................+.............+...........++++++++++++++++++++++++++++++++
+++++++++++++++++++*
>>> dsa.gen_key()
>>> dsa.save_key('./private.pem', cipher=None)
1
>>> dsa.save_pub_key('./public.pem')
1
```

接下来的问题便是如何修改编译好的`.class`文件。Java反编译器可以将它还原成`.java`文件，修改后再重新编译成`.class`文件即可。不过这里只需要修改一个静态的字符串，所以也无需大动干戈，使用一个叫做[dirtyJOE](http://dirty-joe.com/)的软件，便可以直接修改`.class`文件中的常量池。把伪造出来的公钥内容去掉首尾标记和换行符，改写原来的公钥，最后保存文件并替换掉atlassian-extras-2.2.2.jar里原先的那个。

## 许可证生成器

既然全部的过程都已经还原，那么反推一下便可以生成自己的许可证了。

{% gist 4388272 %}

## 额外的修改

事实上，在JIRA中还有其他地方保存了这个公钥，具体来说是它的Universal Plugin Manager的相关代码。如果仅仅修改了上面提到的文件，是没有办法使用JIRA的插件功能的。只有将所有有关的地方全部替换成自己伪造的公钥，才能保证整个软件全部可用。
