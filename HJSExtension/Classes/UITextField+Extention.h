//
//  UITextField+Extention.h
//  HJSExtension
//
//  Created by Jiashu Huang on 2021/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extention)
/// 限制字符串的长度，一般的，此方法最好是在textDidChange的时候调用，而不是在shouldChange时调用。
- (void)textFitToLimitLength:(NSInteger)limitLength completion:(void (^__nullable)(BOOL isTrigger))completion;
@end

NS_ASSUME_NONNULL_END
