//
//  HJStackView.h
//  HJSExtension
//  目前(iOS14之后),UIStackView 的实现已经从原来的CATransformLayer 变更到了CALayer。CATransformLayer 这个东西 不像CALlayer那样，backgroundColor, contents, border style等很多东西都用不了。这个子类做了同样的事情，为了方便使用背景色，圆角等一些特性，主要是为了兼容iOS14之前的系统
//  Created by Jiashu Huang on 2021/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJStackView : UIStackView

@end

NS_ASSUME_NONNULL_END
