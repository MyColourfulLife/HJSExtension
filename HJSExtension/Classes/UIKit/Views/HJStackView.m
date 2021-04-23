//
//  HJStackView.m
//  HJSExtension
//
//  Created by Jiashu Huang on 2021/4/22.
//

#import "HJStackView.h"

@implementation HJStackView

+ (Class)layerClass {
    return [CALayer class];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.layer.backgroundColor = backgroundColor.CGColor;
}

@end
