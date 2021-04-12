//
//  UITextField+Extention.m
//  HJSExtension
//
//  Created by Jiashu Huang on 2021/4/10.
//

#import "UITextField+Extention.h"

@implementation UITextField (Extention)
- (void)textFitToLimitLength:(NSInteger)limitLength completion:(void (^__nullable)(BOOL isTrigger))completion {
    NSString *toBeString = self.text;
    NSString *lang = self.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang hasPrefix:@"zh"]) {                                          // 中文输入法主要包含简体中文和繁体中文,zh表示中国的国家代码,简体和繁体均已zh开头。简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > limitLength) {
                self.text = [toBeString substringToIndex:limitLength];
                if (completion) {
                    completion(YES);
                    return;
                }
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else {
        }
        if (completion) {
            completion(NO);
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else {
        if (completion) {
            completion(toBeString.length > limitLength);
        }
        
        if (toBeString.length > limitLength) {
            self.text = [toBeString substringToIndex:limitLength];
        }
    }
}
@end
