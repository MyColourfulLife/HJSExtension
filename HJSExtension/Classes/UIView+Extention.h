//
//  UIView+Extention.h
//  HJSExtension
//
//  Created by Jiashu Huang on 2021/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extention)

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (CGFloat)minX;
- (CGFloat)maxX;
- (CGFloat)minY;
- (CGFloat)maxY;

/// 圆形化，需要frame确定后调用
/// @Discussion
/// 使用maskview遮罩实现，会遮盖阴影
- (void)cicled;

/// 圆角化，需要frame确定后调用
/// @param radius 圆角半径
/// @param corners 圆角位置
/// @Discussion
/// 使用maskview遮罩实现，会遮盖阴影
- (void)roundedRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;

/// 制作圆角（含部分圆角）
/// @param radius 圆角半径 只会影响背景色和边界，不会影响layer image content，如需裁切内容，需要设置为YES
/// @param corners 圆角位置
/// @param masksToBounds 子layer是否剪切到layer的边界，为YES时会影响阴影的设置。
/// @Discussion
/// ⚠️低于iOS11的版本且为设置部分圆角的情况下，请在frame确认之后调用此方法。
///尤其是自动布局，可能需要先调用layoutIfNeeded确定frame之后再调用。低于iOS11的版本，设置圆角会影响阴影的设置，您可以使用额外的view来辅助显示阴影
- (void)makeConerWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners masksToBounds:(BOOL)masksToBounds;


/// 添加Sketch阴影
/// @param color 颜色
/// @param alpha 透明度
/// @param x Sketch X值
/// @param y Sketch Y值
/// @param blur Sketch Blur值
/// @param spread Sketch Spread值
/// @param cornerRadius 圆角
- (void)makeShadowInSketchWithColor:(UIColor *)color
                           alpha:(float)alpha
                               x:(CGFloat)x
                               y:(CGFloat)y
                            blur:(CGFloat)blur
                          spread:(CGFloat)spread
                    cornerRadius:(CGFloat)cornerRadius;


/// 背景渐变色
/// @param colors 颜色数组
/// @param frame 渐变区域
- (void)setGradientColors:(NSArray *)colors frame:(CGRect)frame horizontal:(BOOL)horizontal;

@end

NS_ASSUME_NONNULL_END
