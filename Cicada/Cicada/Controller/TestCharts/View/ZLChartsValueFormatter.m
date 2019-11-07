//
//  ZLChartsValueFormatter.m
//  Cicada
//
//  Created by 张琦 on 2018/4/25.
//  Copyright © 2018年 com. All rights reserved.
//

#import "ZLChartsValueFormatter.h"

@implementation ZLChartsValueFormatter

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    //0 60 120 180 240
    NSArray *arr = axis.entries;
    __block NSString *resStr = @"";
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@(value) isEqual:obj]) {
            resStr = idx % 2 != 0 ? @"" : ((idx == 0) ? @"9:30" : ((idx == 2) ? @"11:30/13:00" : ((idx == 4) ? @"15:00" : @"")));
        }
    }];
    return resStr;
}

@end

@implementation ZLChartsYLeftAxisValueFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSArray *arr = axis.entries;
    __block NSString *resStr = @"";
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@(value) isEqual:obj]) {
            resStr = idx % 2 != 0 ? @"" : [[[NSNumber numberWithDouble:value] stringValue] CicadaCaculateKeepFiguresByRoundingMode:NSRoundPlain scale:2];
        }
    }];
    return resStr;
}

@end

@implementation ZLChartsYRightAxisValueFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSArray *arr = axis.entries;
    __block NSString *resStr = @"";
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@(value) isEqual:obj]) {
            resStr = idx % 2 != 0 ? @"" : kString_Format(@"%.2f%%",value);
        }
    }];
    return resStr;
}

@end


@implementation ZLBarChartsYAxisValueFormatter

//- (instancetype)initWithYAxisArr:(NSArray *)arr {
//    if (self = [super init]) {
//        yAxisArr = arr;
//    }
//    return self;
//}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return kString_Format(@"%f",value);
}


-(NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler {
    return kString_Format(@"%f",value);
}



@end
