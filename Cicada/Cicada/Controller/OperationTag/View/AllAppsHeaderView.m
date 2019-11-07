//
//  AllAppsHeaderView.m
//  OperationTag
//
//  Created by 张琦 on 2017/1/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import "AllAppsHeaderView.h"

@implementation AllAppsHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headLabel];
    }
    return self;
}

- (UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [UILabel new];
        _headLabel.font = [UIFont systemFontOfSize:16];
        _headLabel.frame = CGRectMake(16, 15, 150, 20);
    }
    return _headLabel;
}


@end
