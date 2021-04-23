//
//  UIView+EmptyView.m
//  BNClient
//
//  Created by Jiashu Huang on 2021/4/22.
//  Copyright © 2021 Jiashu Huang. All rights reserved.
//

#import "UIView+EmptyView.h"
static NSInteger kEmptyViewTag = 99899;


@implementation UIView (EmptyView)

- (void)showEmptyView:(UIView *)emptyView withConstraintBlock:(nullable void (^)(UIView *aView))constraintBlock {
    [self addSubview:emptyView];
    [self bringSubviewToFront:emptyView];
    emptyView.tag = kEmptyViewTag;
    if (constraintBlock) {
        constraintBlock(emptyView);
    }
}

- (void)showEmptyContentView:(UIView *)emptyContentView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = self.backgroundColor;
    if ([backgroundView.backgroundColor isEqual:UIColor.clearColor]) {
        backgroundView.backgroundColor = UIColor.whiteColor;
    }
    backgroundView.tag = kEmptyViewTag;
    [self addSubview:backgroundView];
    [backgroundView addSubview:emptyContentView];
    if (CGSizeEqualToSize(CGSizeZero, emptyContentView.bounds.size)) {
        [emptyContentView sizeToFit];
    }
    emptyContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [emptyContentView.centerYAnchor constraintEqualToAnchor:backgroundView.centerYAnchor].active = YES;
    [emptyContentView.centerXAnchor constraintEqualToAnchor:backgroundView.centerXAnchor].active = YES;
}


- (void)dismissEmptyView {
    UIView *emptyView = [self viewWithTag:kEmptyViewTag];
    [emptyView removeFromSuperview];
}

- (void)dismissEmptyView:(UIView *)emptyView {
    [emptyView removeFromSuperview];
}
@end
