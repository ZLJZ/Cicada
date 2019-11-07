//
//  ChartsUtils.m
//  Cicada
//
//  Created by 张琦 on 2018/4/25.
//  Copyright © 2018年 com. All rights reserved.
//

#import "ChartsUtils.h"

@implementation ChartsUtils

//返回包含X轴每一点的时间值数组
+(NSArray *)xAxisTimeArr {
    NSInteger h = 9;
    NSInteger m = 30;
    NSMutableArray *timeArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 241; i ++ ) {
        [timeArr addObject:(m < 10) ? kString_Format(@"%ld:0%ld",h,m) : kString_Format(@"%ld:%ld",h,m)];
        m++;
        if (m == 60) {
            h++;
            m = 0;
        }
        if (h == 11 && m == 31) {
            h = 13;
            m = 0;
        }
    }
    return timeArr;
}

@end
