//
//  DialView.m
//  Cicada
//
//  Created by 张琦 on 2017/4/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import "DialView.h"

@implementation DialView

- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线1虚线8
    CGFloat length[] = {1,8};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor blackColor] set];
    //2.设置路径
    CGContextAddArc(ctx, 200/2 , 200/2, 90, 2*M_PI/3, M_PI/3, 0);
    
    //3.绘制
    CGContextStrokePath(ctx);
}

@end
