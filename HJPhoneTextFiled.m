//
//  HJPhoneTextFiled.m
//  Formater
//
//  Created by Jiashu Huang on 2021/5/12.
//

#import "HJPhoneTextFiled.h"


@implementation HJPhoneTextFiled

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

/// 从xib或storyboard载入时使用
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 获取替换后的字符串
    NSString *text = textField.text;
    //兼容iOS11，移除非数字内容，iOS11通讯录粘贴会有不可见字符，
    if (string.length > 0) {
        string = [string stringByReplacingOccurrencesOfString:@"\\p{Cf}" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    if ([string isEqualToString:@""]) { // 删除
        //删除前的光标位置
        UITextRange *oldSelectedRange = textField.selectedTextRange;
        BOOL isCursorAtEnd = range.location + range.length >= textField.text.length;
        NSInteger offsetCursor = -1;
        if (text.length > 0) {
            // 如果要删除的是空格
            if ([[textField.text substringWithRange:range] isEqualToString:@" "]) { //要多删一位
                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location - 1, 1) withString:@""];
                offsetCursor = -2;
            }
            textField.text = [HJPhoneFormatter stringForNumber:[HJPhoneFormatter numberForString:text] type:PhoneFormatterTypeDelete];
        } else {
            textField.text = @"";
        }

        // 重置光标位置
        UITextRange *selectedRange = oldSelectedRange;
        //当有选中内容或者光标在末尾
        if (!oldSelectedRange.isEmpty || isCursorAtEnd) {
            selectedRange = [textField textRangeFromPosition:oldSelectedRange.start toPosition:oldSelectedRange.start];
        } else { // 当光标在中间且无选中内容
            // 光标应向前移动1或2格
            UITextPosition *cursorPositon = [textField positionFromPosition:oldSelectedRange.start offset:offsetCursor];
            selectedRange = [textField textRangeFromPosition:cursorPositon toPosition:cursorPositon];
        }
        [textField setSelectedTextRange:selectedRange];

    } else { //增加
        if (text.length > 13) {
            return NO;
        }
        // 数字有效性校验
        if (string.length > 0) {
            if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]*"] evaluateWithObject:[string stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                return NO;
            }
        }

        textField.text = [HJPhoneFormatter stringForNumber:[HJPhoneFormatter numberForString:text] type:PhoneFormatterTypeInsert];

        // 重置光标位置
        UITextPosition *cursorPositon = [textField positionFromPosition:textField.beginningOfDocument offset:(range.location + range.length + string.length + textField.text.length - text.length)];
        UITextRange *selectedRange = [textField textRangeFromPosition:cursorPositon toPosition:cursorPositon];
        [textField setSelectedTextRange:selectedRange];
    }


    return NO;
}
@end
