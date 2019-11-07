//
//  DotView.m
//  Cicada
//
//  Created by 张琦 on 2017/4/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import "DotView.h"

@implementation DotView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddArc(ctx, 200/2 , 200/2, 90, 2*M_PI/3, M_PI/3, 0);
    
    //    CGContextDrawImage(ctx, CGRectMake(200/2 + ((CGRectGetWidth(self.bounds)-3)/2.f-1)*cosf(0.7)-3/2.0, 200/2 + ((CGRectGetWidth(self.bounds)-3)/2.f-1)*sinf(0.7)-3/2.0, 3, 3), [UIImage imageNamed:@"dot"].CGImage);
    CGContextDrawImage(ctx, CGRectMake(0, 0, 12, 13), [UIImage imageNamed:@"ReverseRepoBg"].CGImage);
    CGContextStrokePath(ctx);
    
}

@end
