//
//  ZLCTView.m
//  Cicada
//
//  Created by 吴肖利 on 2019/8/8.
//  Copyright © 2019 com. All rights reserved.
//

#import "ZLCTView.h"

@implementation ZLCTView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置文本矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
}

@end
