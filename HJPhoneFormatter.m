//
//  PhoneFormatter.m
//  Formater
//
//  Created by Jiashu Huang on 2021/5/12.
//

#import "HJPhoneFormatter.h"


@interface HJPhoneFormatter ()
@property (nonatomic, assign) PhoneFormatterType type;
@end


@implementation HJPhoneFormatter

- (instancetype)initWithType:(PhoneFormatterType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

+ (NSString *)stringForNumber:(NSNumber *)number type:(PhoneFormatterType)type {
    HJPhoneFormatter *phoneFormatter = [[HJPhoneFormatter alloc] initWithType:type];
    return [phoneFormatter stringForObjectValue:number];
}

+ (NSNumber *)numberForString:(NSString *)text {
    NSNumber *number = nil;
    [[[self alloc] init] getObjectValue:&number forString:text errorDescription:nil];
    return number;
}

- (NSString *)stringForObjectValue:(NSNumber *)obj {
    if (![obj isKindOfClass:NSNumber.class]) {
        return @"";
    }
    NSMutableString *result = @"".mutableCopy;
    // 移除空格
    result = [obj.stringValue stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
    // 移除多余的内容
    if (result.length > 11) {
        [result deleteCharactersInRange:NSMakeRange(11, result.length - 11)];
    }

    switch (self.type) {
        case PhoneFormatterTypeInsert: {
            // 根据规则插入空格 xxx xxxx xxxx
            if (result.length >= 3) {
                [result insertString:@" " atIndex:3];
            }
            if (result.length >= 8) {
                [result insertString:@" " atIndex:8];
            }
            break;
        }
        // xxx xxxx xxxx
        case PhoneFormatterTypeDelete: {
            if (result.length >= 4) {
                [result insertString:@" " atIndex:3];
            }

            if (result.length >= 9) {
                [result insertString:@" " atIndex:8];
            }

            break;
        }
    }


    return result.copy;
}


- (BOOL)getObjectValue:(out id _Nullable __autoreleasing *)obj forString:(NSString *)string errorDescription:(out NSString *_Nullable __autoreleasing *)error {
    *obj = @([[string stringByReplacingOccurrencesOfString:@" " withString:@""] integerValue]);
    return YES;
}


@end
