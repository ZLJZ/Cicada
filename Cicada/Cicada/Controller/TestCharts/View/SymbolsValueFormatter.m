//
//  SymbolsValueFormatter.m
//  Cicada
//
//  Created by 张琦 on 2017/6/17.
//  Copyright © 2017年 com. All rights reserved.
//

#import "SymbolsValueFormatter.h"

@implementation SymbolsValueFormatter

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return [NSString stringWithFormat:@"%ld%%",(NSInteger)value];
}

@end
