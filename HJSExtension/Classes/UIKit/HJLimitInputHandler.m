//
//  LimitInputDelegate.m
//  HJSExtension
//
//  Created by Jiashu Huang on 2021/4/22.
//
#import <UIKit/UIKit.h>
#import "HJLimitInputHandler.h"
#import <objc/runtime.h>

#pragma mark Catetory for input
/// 为输入控件增加扩展，将Handler作为属性，外界就不必强引用Handler了
@interface UIView (InputHelper)
@property (nonatomic, strong) HJLimitInputHandler *limitHandler;
@end


@implementation UIView (InputHelper)
- (void)setLimitHandler:(HJLimitInputHandler *)limitHandler {
    objc_setAssociatedObject(self, "limitHandler", limitHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HJLimitInputHandler *)limitHandler {
    return objc_getAssociatedObject(self, "limitHandler");
}
@end

#pragma mark - HJLimitInputHandler
@interface HJLimitInputHandler ()
@property (nonatomic, weak) UIView<UITextInput> *textInput;
@property (nonatomic, assign) int limitLength;
@end

@implementation HJLimitInputHandler
+ (instancetype)handlerLimit:(UIView<UITextInput> *)textInput withLength:(int)length {
    return [[self alloc] initWithHandlerLimit:textInput withLength:length];
}

- (instancetype)initWithHandlerLimit:(UIView<UITextInput> *)textInput withLength:(int)length {
    self = [super init];
    if (self) {
        _textInput = textInput;
        _limitLength = length;
        _textInput.limitHandler = self;
        [self setup];
    }
    return self;
}

- (void)setup{
    if ([self.textInput respondsToSelector:@selector(setDelegate:)]) {
        [self.textInput performSelector:@selector(setDelegate:) withObject:self];
    }
    // 英文状态滑行输入法时的兜底方案。使用通知处理文本已经改变的状态。英文状态滑行输入发，在文本中间插入光标并滑行输入时，系统会自动在光标左右补充空格，其中，在光标右边补充的空格，should代理方法拦截不到。此外，文本框右对齐时，末尾的空格无法显示，应在此处处理。在should方法中处理可能在redo时crash
    __weak typeof(self) weakSelf = self;
    void (^noticeBolck)(NSNotification *)  = ^(NSNotification * _Nonnull note){
        if (weakSelf == nil) {
            return;
        }
        UITextField *textFiled = note.object;// 运行时此类也可能是UITextView
        // 处理右对齐时在末尾添加空格不会显示的问题
        if (textFiled.textAlignment == NSTextAlignmentRight) {
            if ([textFiled.text hasSuffix:@" "]) {
                textFiled.text = [[textFiled.text substringToIndex:textFiled.text.length - 1] stringByAppendingString:@"\u00a0"];
            }
        }
        if (textFiled.markedTextRange) {
            return;
        }
        NSInteger offset = textFiled.text.length - weakSelf.limitLength;
        if (offset > 0) {
            UITextRange *oldRange = textFiled.selectedTextRange;
            if (offset == 1) {// 理论上只有这一种情况
                [textFiled deleteBackward];
            }else {
                textFiled.text = [textFiled.text substringToIndex:weakSelf.limitLength];
            }
            [textFiled setSelectedTextRange:oldRange];
        }
    };
    
    if ([weakSelf.textInput isKindOfClass:UITextField.class]) {
        [NSNotificationCenter.defaultCenter addObserverForName:UITextFieldTextDidChangeNotification object:weakSelf.textInput queue:NSOperationQueue.mainQueue usingBlock:noticeBolck];
    }else if ([weakSelf.textInput isKindOfClass:UITextView.class]) {
        [NSNotificationCenter.defaultCenter addObserverForName:UITextViewTextDidChangeNotification object:weakSelf.textInput queue:NSOperationQueue.mainQueue usingBlock:noticeBolck];
    }
    
}

- (void)dealloc
{
    if ([self.textInput isKindOfClass:UITextField.class]) {
        [NSNotificationCenter.defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:self.textInput];
    }else if([self.textInput isKindOfClass:UITextView.class]){
        [NSNotificationCenter.defaultCenter removeObserver:self name:UITextViewTextDidChangeNotification object:self.textInput];
    }
    NSLog(@"[dealloc],%@",self.classForCoder);
}

#pragma mark - Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [self shouldChangeTextInRange:range replacementText:string];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return [self shouldChangeTextInRange:range replacementText:text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}



#pragma mark - Private

- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 输入框中带有mark的文本
    //    NSLog(@"输入框中的内容:[%@]要变更的区域:[%@],要替换的文本:[%@]",textField.text, NSStringFromRange(range),string);
    UITextRange *selectedTextRange = [self.textInput selectedTextRange];
    UITextRange *markTextRange = [self.textInput markedTextRange];
    NSString *selectedText = [self.textInput textInRange:selectedTextRange];
    NSString *markedText = [self.textInput textInRange:markTextRange];
    //    NSLog(@"选择的文本：[%@]，标记的文本：[%@]",selectedText,markedText);
    if ([text isEqualToString:@""]) { //删除键
        return YES;
    }
    
    NSInteger totalLength = 0;
    NSInteger offset = 0;
    
    NSInteger currentTextLength = [[self.textInput valueForKeyPath:@"text.length"] intValue];
    // 如果没有标记
    if (selectedText.length == 0 && markedText.length == 0) {
        totalLength = currentTextLength + text.length;
    }
    // 如果有选择的文本，但没有标记的文本
    if (selectedText.length > 0  && markedText.length == 0) {
        // 计算长度
        totalLength = currentTextLength - selectedText.length + text.length;
    }
    // 如果有标记的文本，但没有选择的文本
    if (selectedText.length == 0  && markedText.length > 0) {
        // 计算长度
        totalLength = currentTextLength - markedText.length + text.length;
    }
    //    totalLength = currentTextLength - range.length + string.length;
    offset = totalLength - self.limitLength;
    //要保留的内容
    NSString *keepString = @"";
    
    if (offset >= 0) {//超出限制,需要裁剪
        if (self.didTriggerLimitBlock) {
            self.didTriggerLimitBlock(self.limitLength);
        }
        //要保留的内容
        NSInteger toIndex = text.length - offset;
        if (toIndex < 0) {//英文状态的滑行输入，会自动补充两个空格，计算结果有可能为负值，而且系统自动补齐右边空格时，此代理方法拦不住,需要在已经变更的方法中做兜底。
            return NO;
        }
        
        if (toIndex <= text.length) {
            keepString = [text substringToIndex:toIndex];
        }
        // 通过range计算textrange并进行替换是行不通的。
        //        UITextPosition *startPosition = [self.textInput positionFromPosition:self.textInput.beginningOfDocument offset: range.location];
        //        UITextPosition *endPosition = [self.textInput positionFromPosition:self.textInput.beginningOfDocument offset:range.length+range.location];
        //        UITextRange *replaceRange =  [self.textInput textRangeFromPosition:startPosition toPosition:endPosition];
        //        [self.textInput replaceRange:replaceRange withText:keepString];
        if (markedText.length > 0) {
            [self.textInput replaceRange:markTextRange withText:keepString];
        }else {
            [self.textInput replaceRange:selectedTextRange withText:keepString];
        }
        return NO;
    }
    
    return YES;
}


@end
