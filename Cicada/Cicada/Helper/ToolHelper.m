//
//  ToolHelper.m
//  Cicada
//
//  Created by 张琦 on 2017/3/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import "ToolHelper.h"

@implementation ToolHelper

+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha{
    //删除空格
    NSString *colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([colorStr length] < 6||[colorStr length]>7)
    {
        return [UIColor clearColor];
    }
    //
    if ([colorStr hasPrefix:@"#"])
    {
        colorStr = [colorStr substringFromIndex:1];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //red
    NSString *redString = [colorStr substringWithRange:range];
    //green
    range.location = 2;
    NSString *greenString = [colorStr substringWithRange:range];
    //blue
    range.location = 4;
    NSString *blueString= [colorStr substringWithRange:range];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    return [UIColor colorWithRed:((float)red/ 255.0f) green:((float)green/ 255.0f) blue:((float)blue/ 255.0f) alpha:alpha];
}


#pragma mark  颜色转换 -- 十六进制 转换为 UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (BOOL)validateNumber:(NSString *) textString{
    NSString* number=@"^[0-9]{6}$";//@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

+ (BOOL)isNumText:(NSString *)str {
    NSString * regex  = @"[0-9]*";
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch   = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark  计算字符串大小（宽 高）
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
        textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return textSize;
}

//字符串判空
+(BOOL) isBlankString:(NSString *)string {
    
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    //    if (string.length==0) {
    //        return YES;
    //    }
    return NO;
}

//yyyyMMdd格式字符串转为时间戳
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    NSDate *orderDate = [dateFormatter dateFromString:dateString];
    NSTimeInterval timeInterval = [orderDate timeIntervalSince1970];
    return timeInterval;
}

@end
