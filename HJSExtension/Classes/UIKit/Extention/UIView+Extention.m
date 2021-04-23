//
//  UIView+Extention.m
//  HJSExtension
//
//  Created by Jiashu Huang on 2021/4/10.
//

#import "UIView+Extention.h"

@implementation UIView (Extention)
- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)maxY{
    return CGRectGetMaxX(self.frame);
}

- (void)cicled{
    UIView *maskView = [[UIView alloc]initWithFrame:self.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CGFloat radius = MIN(maskView.width, maskView.height)/2;
    maskLayer.path = [UIBezierPath bezierPathWithArcCenter:maskView.center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    [maskView.layer addSublayer:maskLayer];
    self.maskView = maskView;
}

- (void)roundedRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners{
    UIView *maskView = [[UIView alloc]initWithFrame:self.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    [maskView.layer addSublayer:maskLayer];
    self.maskView = maskView;
}

- (void)makeConerWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners masksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
    // 设置所有圆角
    // 直接使用与约束无关的属性，可以自动适应自动布局
    if (corners == UIRectCornerAllCorners) { // 匹配所有 要用== 不能用 &
        self.layer.cornerRadius = radius;
        return;
    }
    // 设置部分圆角
    
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corners; //bit位一致
    } else {
        // 此方法需要在frame已经确定后才有效果，如果使用自动布局，则使用者可以需要在必要的时候调用 layoutIfNeeded 计算frame之后才有效果.
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)makeShadowInSketchWithColor:(UIColor *)color
                              alpha:(float)alpha
                                  x:(CGFloat)x
                                  y:(CGFloat)y
                               blur:(CGFloat)blur
                             spread:(CGFloat)spread
                       cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = alpha;
    self.layer.shadowOffset = CGSizeMake(x, y);
    self.layer.shadowRadius = blur;
    CGRect rect = CGRectInset(self.layer.bounds, -spread, -spread);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius].CGPath;
}

- (void)setGradientColors:(NSArray *)colors frame:(CGRect)frame horizontal:(BOOL)horizontal{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.frame = frame;
    if (horizontal) {
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
}
@end
