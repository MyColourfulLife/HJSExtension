//
//  HJSTestLimitLengthViewController.h
//  HJSExtension_Example
//
//  Created by Jiashu Huang on 2021/4/23.
//  Copyright © 2021 huangjiashu1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HJSExtension/HJLimitInputHandler.h>
NS_ASSUME_NONNULL_BEGIN

@interface HJSTestLimitLengthViewController : UIViewController
@property (nonatomic, strong)HJLimitInputHandler *limitHandler;
@property (nonatomic, strong)HJLimitInputHandler *textViewLimitHandler;
@end

NS_ASSUME_NONNULL_END
