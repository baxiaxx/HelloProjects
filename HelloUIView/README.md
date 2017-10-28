# UIView

---

### 1. Transparent, Transluncent and Opaque 

* transparent，指的是完全透明的，光穿过物体没有多少损失。
* translucent，指的是部分透明，光穿过物体有一部分损失，而且看起来像毛玻璃的效果
* opaque，指的是完全不透明，光无法穿过物体。

### 2. UIView指定某个圆角

基本原理：UIView的CALayer有mask属性，支持指定一个mask layer用于对CALayer进行遮罩。mask layer的形状、大小和alpha决定CALayer如何显示。

以只有左上角和右上角的圆角的UIView为例，基本步骤，如下

第一步，使用UIBezierPath确定一个封闭矩形，而且左上角和右上角是圆角。

```
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(30, 30)];
```
>
矩形大小应该和对应的UIView大小一致。

第二步，使用CAShapeLayer创建mask layer

```
CAShapeLayer *maskLayer = [CAShapeLayer layer];
maskLayer.frame = view.bounds;
maskLayer.path = maskPath.CGPath;
maskLayer.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2].CGColor;
```
>
mask layer虽然指定path，但是这个path不会截取layer的矩形形状，因此CAShapeLayer分为了两个区域：path区域和非path区域（path以外的部分）。
>
* path区域（opaque部分）没有指定颜色，所以是黑色不透明alpha=0
* 非path区域（translucent部分）则指定了backgroundColor而且alpha=0.2，这里指定red颜色没有关系，但是一定要指定alpha（0<= alpha < 1）

第三步，将mask layer赋值到mask属性

```
UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
view.backgroundColor = [UIColor greenColor];
view.layer.mask = maskLayer;
```

mask属性决定如何将layer和mask layer进行合成

1. mask layer在layer中的位置和大小，如果超过layer部分，则被截取掉
2. mask layer中opaque部分（即上面的path区域），layer使用自己的backgroundColor填充；mask layer中translucent部分（即上面的非path区域），layer使用mask layer的alpha值，结合自己backgroundColor，进行填充。如果alpha值是0，则这部分是透明的

参考代码：`ViewWithTwoCornersViewController`


