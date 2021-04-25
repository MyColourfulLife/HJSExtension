//
//  LimitInputHandler.h
//  HJSExtension
//作为文本长度输入控制类的辅助工具使用。
//  主要实现了以下功能：
//  1. 处理了系统输入控件在右对齐模式下，末尾添加的空格无法显示的问题。
//  2. 对输入的限制不限制中英文，用户在任意位置输入，超出字数时会在超出部分进行截取。不会直接取几位。光标不会有明显变化。
//  3. 用户在可输入时，对于候选字词不会影响用户输入，但是否最终能作为最终输入，会根据位数进行判断。
//  4. 超出字符限制时，通过block传递出去。可以在此时进行toast提示。
//  Created by Jiashu Huang on 2021/4/22.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class UITextInput,UITextFieldDelegate,UITextViewDelegate;
@interface HJLimitInputHandler : NSObject<UITextFieldDelegate,UITextViewDelegate>

/**
 *@Summary 文本控件辅助类
 *@Discussion 请强引用此类。
 *1.此类已经作为输入控件的代理。此类对输入控件的引用为弱引用。
 *2.如果您需要实现其他代理方法，请将代理方法收敛到此类的子类或者分类。
 *是的，虽然在OC中不能像Swift那样直接使用Extension实现其他的协议方法，但您仍然可以使用的类末尾，采用分类category实现。
 */
+(instancetype)handlerLimit:(id<UITextInput>)textInput withLength:(int)length;
- (instancetype)initWithHandlerLimit:(id<UITextInput>)textInput withLength:(int)length;
@property (nonatomic, copy) void (^didTriggerLimitBlock)(int);
@end

NS_ASSUME_NONNULL_END
