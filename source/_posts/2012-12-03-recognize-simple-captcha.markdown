---
layout: post
title: "简单的验证码识别"
date: 2012-12-03 00:26
comments: true
categories:
 - 雕虫小技
---
前段时间在写[pNJU](http://pnju.dayanjia.com/)的时候，需要对一个验证码图像进行识别并自动填写。验证码这个东西的学名叫做全自动区分计算机和人类的图灵测试（Completely Automated Public Turing test to tell Computers and Humans Apart，简称CAPTCHA），它原本是区分人类和机器的一种方式，但是其复杂度直接决定了区分的效果。太简单的验证码用机器也能轻易识别，而太复杂的验证码可能连人类也看不懂。而pNJU要解决的验证码正是那种比较简单的，事实证明这种验证码完全无法满足区别人类和机器的要求。

<!--more-->

{% img http://img.dayanjia.com/di/5V20/img.png %}

可以看到这个验证码主要的特征有：

 * 只由数字构成
 * 颜色单一
 * 只存在背景的噪点干扰
 * 整体只有微小的旋转变形

我们使用著名的，由PythonWare开发的[PIL](http://www.pythonware.com/products/pil/)来操作图像文件。

## 预处理

我们需要做的第一步就是把背景噪声去掉，获取纯净的图像。前面已经说过这个验证码图像很简单，简单到去除噪点只需要把图像[二值化](http://zh.wikipedia.org/wiki/%E4%BA%8C%E5%80%BC%E5%8C%96)就行了。首先把图像转换成8位灰度，此时每个像素点可以通过0-255的整数来表示其灰色，0是黑色，255是白色。通过设定一个阈值，小于它的全部变成0，大于它的全部变成255，我们就得到了二值化以后的图像，噪点一扫而尽。

``` python
import Image


def pre_process(img_stream):
    """
    Pre-process contains convertion from IO Stream to Image object and binarization
    """
    threshold = 175
    img = Image.open(img_stream)
    return img.convert('L').point(lambda p: 0 if p < threshold else 255, '1')
```

{% img http://img.dayanjia.com/di/CPPG/img2.png %}


## 分割

为了方便一个字符一个字符地识别，我们需要把四个数字切割开。为了得到更加精确的结果，我采用了比较严格的切割方法，即找到刚好包裹整个字符的最小外边界。这样对于每一个字符，会得到左上角和右下角的坐标，一共四个切割参数。具体查找边界的方法很简单，先做垂直分割，再做水平分割。

{% img http://img.dayanjia.com/di/PWGO/boundary.png %}

``` python
def split(img):
    """
    This method return the boundary of every digit in captcha image
    in format (left, upper, right, lower) which can be used for cropping.
    """
    pix = img.load()

    # vertical cut
    vertical = []
    found_letter = False
    for x in range(img.size[0]):
        in_letter = False
        for y in range(img.size[1]):
            if pix[x, y] == 0:
                in_letter = True
                break
        if not found_letter and in_letter:
            found_letter = True
            start = x
        if found_letter and not in_letter:
            found_letter = False
            end = x
            vertical.append((start, end))

    # horizontal cut
    # 为了避免跳出多重循环，这里创建了一个内部函数，
    # 用于横向扫描垂直分割过的区块，返回第一次出现黑色像素点的Y坐标
    def _find_first_line(pix, y_range, x_start, x_end):
        for y in y_range:
            for x in range(x_start, x_end):
                if pix[x, y] == 0:
                    return y

    horizontal = []
    for i in vertical:
        start = _find_first_line(pix, range(img.size[1]), *i)
        end = _find_first_line(pix, reversed(range(img.size[1])), *i)
        horizontal.append((start, end))

    return [(vertical[i][0], horizontal[i][0], vertical[i][1], horizontal[i][1] + 1) for i in range(len(vertical))]
```

得到了左上角和右下角的坐标后，便可以使用PIL中自带的`crop`方法裁剪图像，得到四个独立的数字。

## 猜数字

经过一番处理，我们终于可以进行实质的识别了。图像的识别方法有很多种，往往需要具体问题具体分析。针对这里的验证码，由于没有出现较大的旋转变形，更没有倾斜、透视等变换，识别的方法非常原始，也非常直接。

对这种验证码图像进行一定数量的采样，并使用上述方法进行处理后，我们可以发现裁剪后的图像尺寸(px)只有寥寥数种，并且对应的数字都是相对固定的。同一个数字可能会有不同尺寸的原因是整个验证码图像会有随机的轻微旋转处理。

 图像尺寸 | 出现概率 | 可能出现的数字
--------- | -------- | ----------------
  12×17   |  13.97%  | 1 2 5
  12×18   |  5.65%   | 1 2 3 7
  13×17   |  24.80%  | 1 2 3 5 6 7 8 9
  13×18   |  24.32%  | 1 2 3 5 6 7 8 9
  14×17   |  7.84%   | 0 4 6
  14×18   |  15.46%  | 0 4 6 8 9
  15×17   |  5.84%   | 0 4
  15×18   |  2.15%   | 0

有了这样的统计数据，识别起来就容易多了。我们先把每个数字在所有可能出现的尺寸上的图像保存下来，建立一个“标准数据”。遇到需要识别的图像，只需要先根据尺寸进行分类，然后在较少的可能性中进行进一步的判断和识别即可。

而第二步的识别，经过一系列尝试和探索后，可以发现，直接比对待识别图像和“标准数据”出现差异的像素点数，结果最小的必定是正确的数字。即便是13×17和13×18这两个包含数字较多的分类，用此方法也能轻易地得到预期的结果。

对于“标准数据”的保存，我采用了字符串的形式，因为觉得使用0和1的数组太过于松散了。使用字符串的话，一个字符便可以包含8个像素的信息，对比差异也方便一些。

``` python
def guess_digit(img):
    """Recognize one digit"""
    if img.size not in training_set:
        raise KeyError()
    img_string = img.tostring()
    candidates = training_set[img.size]
    guesses = dict.fromkeys(candidates.keys())
    for digit, eigen in candidates.iteritems():
        guesses[digit] = different_bits(img_string, eigen)
    return min(guesses, key=guesses.get)

def different_bits(img_string1, img_string2):
    """Tell how many bits are different between two strings"""
    return sum([bin(ord(v1) ^ ord(v2)).count('1') for v1, v2 in zip(img_string1, img_string2)])

```

## 结语

采用最原始的识别方法，写上短短几段代码，便把这个验证码的识别问题轻松解决了。经过数万样本的测试，这个方法针对该验证码的识别率是100%。总之你可以拍拍胸脯说，这个验证码「弱爆了」。

那么什么样的验证码才是好的验证码呢？我觉得可以从干扰和变形两方面入手。仅有背景噪点是不够的，使用多种颜色、和验证码字符有交叉的细线条作为干扰是个不错的选择。而在变形方面可以做的文章就多了。验证码的各个字符可以不在同一个基线上，各自有不同的平面变换，甚至粘连在一起（这样分割就会很难做）；有时再加上一些非线性的变换，让字符“扭动”起来，就更加难以识别了。

当然，这些都不能做的太过，否则连人类也无法搞懂，这时就该轮到电脑对屏幕前的我们说，「你们弱爆了」。

{% img http://img.dayanjia.com/di/UCTR/hard-math.png %}
<br /><small>From http://random.irb.hr/signup.php</small>
