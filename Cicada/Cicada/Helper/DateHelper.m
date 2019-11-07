//
//  DateHelper.m
//  PanGu
//
//  Created by 陈伟平 on 16/6/20.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "DateHelper.h"

#define NSSTRING_FROM_INT(aIntNumber) [NSString stringWithFormat:@"%d",aIntNumber]
#define INT_FROM_NSSTRING(aNSString)  [aNSString intValue]

#define YEAR_RANGE NSMakeRange(0, 4)
#define MONTH_RANGE NSMakeRange(5, 2)
#define DAY_RANGE NSMakeRange(8, 2)
#define HOUR_RANGE NSMakeRange(11, 2)
#define MINITE_RANGE NSMakeRange(14, 2)
#define YEAR_MONTH_DAY_RANGE NSMakeRange(0, 10)
#define HOUR_MINITE_RANGE NSMakeRange(11, 5)

@implementation DateHelper


/***************/

//获取当前时间 yyyy-MM-dd HH:mm:ss
+ (NSString *)currentTime {
    NSDate *cuttentDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *currentDateStr=[dateformatter stringFromDate:cuttentDate];
    return currentDateStr;
}
//yyyyMMdd 转 yyyy.MM.dd
+ (NSString *)dateStrDotWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}

//yyyyMMdd 转 yyyy-MM-dd
+ (NSString *)dateStrDashWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}

//yyyyMMdd 转MM.dd
+ (NSString *)dateMDStrDashWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"MM.dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}
//yyyyMMdd 转 yyyy/MM/dd
+ (NSString *)dateStrObliqueLineWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"yyyy/MM/dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}

//HHmmss 转 HH:mm:ss
//+ (NSString *)timeStrColonWithString:(NSString *)timeString {
//    NSString *orderTimeString;
//    if (![timeString isKindOfClass:[NSString class]] || [timeString isEqualToString:@""] || [timeString isEqualToString:@"0"]) {
//        orderTimeString = @"--";
//    } else {
//        NSMutableString *str = [timeString mutableCopy];
//        if ([timeString length] != 6) {
//            [str insertString:@"0" atIndex:0];
//        }
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        dateFormatter.dateFormat = @"HHmmss";
//        NSDate *orderTime = [dateFormatter dateFromString:str];
//        dateFormatter.dateFormat = @"HH:mm:ss";
//        orderTimeString = [dateFormatter stringFromDate:orderTime];
//    }
//    return orderTimeString;
//    
//}


//HHmmss 转 HH:mm:ss
+ (NSString *)timeStrColonWithString:(NSString *)timeString {
    NSString *orderTimeString;
    if (![timeString isKindOfClass:[NSString class]] || [timeString isEqualToString:@""]) {
        orderTimeString = @"--";
    } else {
        NSMutableString *str = [timeString mutableCopy];
        if ([timeString length] != 6) {
            
            for (NSInteger i = 0; i < 6-timeString.length; i ++ ) {
                [str insertString:@"0" atIndex:0];
            }
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"HHmmss";
        NSDate *orderTime = [dateFormatter dateFromString:str];
        dateFormatter.dateFormat = @"HH:mm:ss";
        orderTimeString = [dateFormatter stringFromDate:orderTime];
    }
    return orderTimeString;
    
}

//yyyy-MM-dd 转 MM.dd
+ (NSString *)dateMDStrDashWithMinusString:(NSString *)dateString {
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"MM.dd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}

//yyyyMMdd 转 MM-dd
+ (NSString *)dateMDStrHengDashWithMinusString:(NSString *)dateString {
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"MM-dd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}

+ (NSDate *)timeString:(NSString *)timeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString:timeString];
}

@end
