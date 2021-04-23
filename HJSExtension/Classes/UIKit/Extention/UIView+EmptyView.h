//
//  UIView+EmptyView.h
//  BNClient
//
//  Created by Jiashu Huang on 2021/4/22.
//  Copyright © 2021 Jiashu Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIView (EmptyView)

/// 显示空视图并设置约束
/// @Discussion 空视图的长相及位置完全取决于使用者 constraintBlock 目的是用来设置约束，但不限于此。对于在tableview上添加空视图，使用frame可能更方便。一般的，show和dismiss应当成对使用
- (void)showEmptyView:(UIView *)emptyView withConstraintBlock:(nullable void (^)(UIView *aView))constraintBlock;

/// 在当前view的中央显示空的内容视图
/// @Discussion 使用此方法显示的空视图看上去会显示在当前视图中央。其背后有一个与当前视图同大同色的背景视图承载内容，如果背景色为clear，则模式使用白色的背景色。比如内容视图为一个button，此button将显示在当前view中间。
- (void)showEmptyContentView:(UIView *)emptyContentView;

/// 移除空视图
- (void)dismissEmptyView;

/// 移除指定的空视图
- (void)dismissEmptyView:(UIView *)emptyView;
@end

NS_ASSUME_NONNULL_END
