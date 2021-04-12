//
//  HJSViewController.m
//  HJSExtension
//
//  Created by huangjiashu1 on 04/10/2021.
//  Copyright (c) 2021 huangjiashu1. All rights reserved.
//

#import "HJSViewController.h"
#import <HJSExtension/HJSExtention.h>
@interface HJSViewController ()

@end

@implementation HJSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:({
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 200, 200, 100)];
        textView.text = @"请输入一些内容";
        [NSNotificationCenter.defaultCenter addObserverForName:UITextViewTextDidChangeNotification object:textView queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
            [textView textFitToLimitLength:10 completion:^(BOOL isTrigger) {
                if (isTrigger){
                    NSLog(@"textView 超过了限制，已被截取");
                }
            }];
        }];
        textView;
    })];
    
    
    [self.view addSubview:({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
//        [imageView makeConerWithRadius:20 byRoundingCorners:UIRectCornerAllCorners masksToBounds:YES];
//        [imageView roundedRadius:imageView.width/2 byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight];
        [imageView cicled];
        imageView.image = [UIImage imageWithColor:UIColor.redColor];
        imageView;
    })];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
