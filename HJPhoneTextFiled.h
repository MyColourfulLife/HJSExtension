//
//  HJPhoneTextFiled.h
//  手机号输入框控件
// 1. 处理了手机显示数字时的空格
// 2. 处理了粘贴时的数字有效性校验
// 3. 处理了光标在任意位置时的输入
// 4. 处理了光标在任意位置时的删除
//  Created by Jiashu Huang on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "HJPhoneFormatter.h"
NS_ASSUME_NONNULL_BEGIN


@interface HJPhoneTextFiled : UITextField <UITextFieldDelegate>

@end

NS_ASSUME_NONNULL_END
