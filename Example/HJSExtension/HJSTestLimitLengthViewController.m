//
//  HJSTestLimitLengthViewController.m
//  HJSExtension_Example
//
//  Created by Jiashu Huang on 2021/4/23.
//  Copyright © 2021 huangjiashu1. All rights reserved.
//

#import "HJSTestLimitLengthViewController.h"


@interface HJSTestLimitLengthViewController ()

@end

@implementation HJSTestLimitLengthViewController

- (void)dealloc
{
    NSLog(@"[dealloc]:%@",self.classForCoder);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:({
        UITextField *textView = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 100)];
        textView.placeholder = @"请输入一些内容";
        textView.textAlignment = NSTextAlignmentRight;
        _limitHandler = [HJLimitInputHandler handlerLimit:textView withLength:6];
        _limitHandler.didTriggerLimitBlock = ^(int limitLength) {
            NSLog(@"已经触发了长度限制:%d",limitLength);
        };
        textView;
    })];
    
    
    [self.view addSubview:({
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 400, 200, 100)];
        textView.backgroundColor = UIColor.cyanColor;
        textView.textAlignment = NSTextAlignmentRight;
        _textViewLimitHandler = [HJLimitInputHandler handlerLimit:textView withLength:6];
        _textViewLimitHandler.didTriggerLimitBlock = ^(int limitLength) {
            NSLog(@"已经触发了长度限制:%d",limitLength);
        };
        textView;
    })];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@interface HJLimitInputHandler (textFiledDelegate)
@end

@implementation HJLimitInputHandler (textFiledDelegate)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
