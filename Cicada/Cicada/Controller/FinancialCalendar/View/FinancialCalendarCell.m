//
//  FinancialCalendarCell.m
//  Cicada
//
//  Created by 吴肖利 on 2018/10/8.
//  Copyright © 2018 com. All rights reserved.
//

#import "FinancialCalendarCell.h"

@implementation FinancialCalendarCell

//-(instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
////        self.shapeLayer.frame = CGRectMake((self.width - 22)/2.0, 7, 22, 22);
////        self.shapeLayer.hidden = YES;
//    }
//    return self;
//}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.top = 0;
    self.shapeLayer.frame = CGRectMake((self.width - 22)/2.0, 7, 22, 22);
    self.titleLabel.frame = self.shapeLayer.frame;
    self.eventIndicator.top = self.titleLabel.bottom + 4;
}

//-(void)layoutSublayersOfLayer:(CALayer *)layer {
//    [super layoutSublayersOfLayer:layer];
//    self.shapeLayer.frame = CGRectMake((self.width - 22)/2.0, 7, 22, 22);
//}

@end
