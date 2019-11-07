//
//  TestView.m
//  Cicada
//
//  Created by 吴肖利 on 2019/8/13.
//  Copyright © 2019 com. All rights reserved.
//

#import "TestView.h"

@interface TestView ()

@property (nonatomic, strong) UIView *tView;

@end
@implementation TestView

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"init");
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame");
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    NSLog(@"打印createUI");
    for (NSInteger i = 0; i < 10; i ++) {
        [self addSubview:self.tView];
    }
    NSLog(@"%ld",self.subviews.count);
    for (UIView *subView in self.subviews) {
        NSLog(@"%@",subView);
    }
//    [self addSubview:self.tView];
}

- (UIView *)tView {
    if (!_tView) {
        _tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _tView.backgroundColor = COLOR_YELLOW;
    }
    return _tView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layout:%ld",self.subviews.count);
}

@end
