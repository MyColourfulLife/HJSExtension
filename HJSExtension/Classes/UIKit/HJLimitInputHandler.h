//
//  LimitInputHandler.h
//  HJSExtension
//
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
