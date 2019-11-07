//
//  ToolHelper.h
//  Cicada
//
//  Created by 张琦 on 2017/3/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolHelper : NSObject

+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha;

#pragma mark  颜色转换 -- 十六进制 转换为 UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

+ (BOOL)validateNumber:(NSString *)textString;

+ (BOOL)isNumText:(NSString *)str;

#pragma mark  计算字符串大小（宽 高）
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font;

//字符串判空
+(BOOL) isBlankString:(NSString *)string;

//yyyyMMdd格式字符串转为时间戳
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString;

@end
