//
//  PhoneFormatter.h
//  自定义手机号格式
//
//  Created by Jiashu Huang on 2021/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PhoneFormatterType) {
    PhoneFormatterTypeInsert,
    PhoneFormatterTypeDelete,
};


@interface HJPhoneFormatter : NSFormatter
+ (NSString *)stringForNumber:(NSNumber *)number type:(PhoneFormatterType)type;
+ (NSNumber *)numberForString:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
