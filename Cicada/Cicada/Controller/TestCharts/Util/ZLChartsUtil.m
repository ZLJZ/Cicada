//
//  ZLChartsUtil.m
//  Cicada
//
//  Created by 吴肖利 on 2019/7/5.
//  Copyright © 2019 com. All rights reserved.
//

#import "ZLChartsUtil.h"

@implementation ZLChartsUtil

//X轴点数
+ (CGFloat)getXAxisMaxValueByLineType:(ZLLineType)lineType {
    CGFloat lineCount = 0;
    switch (lineType) {
        case 0:
            lineCount = 241;
            break;
        case 1:
            lineCount = 250;
            break;
        case 2:
            lineCount = 80;
            break;
        case 3:
            lineCount = 80;
            break;
        case 4:
            lineCount = 80;
            break;
        default:
            break;
    }
    return lineCount;
}

//颜色处理
+ (UIColor *)colorWithValue:(double)value {
    if (value > 0) {
        return COLOR_RED;
    } else if (value < 0) {
        return COLOR_GREEN;
    } else {
        return COLOR_LIGHTGRAY;
    }
}

@end
