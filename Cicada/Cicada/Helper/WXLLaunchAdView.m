//
//  WXLLaunchAdView.m
//  Cicada
//
//  Created by 张琦 on 2017/4/6.
//  Copyright © 2017年 com. All rights reserved.
//

#import "WXLLaunchAdView.h"

@implementation WXLLaunchAdView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        //
//    }
//    return self;
//}

- (void)createAdViewType:(AdType)type {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    if (type == LogoAdType) {
        //
    } else if (type == FullScreenAdType) {
        self.adImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipButton.frame = CGRectMake(kScreenWidth-10-60, 10, 60, 40);
    self.skipButton.backgroundColor = COLOR_YELLOW;
    [self.skipButton setTitle:@"跳过广告" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.skipButton addTarget:self action:@selector(clickSkipButton) forControlEvents:UIControlEventTouchUpInside];
    [self.adImageView addSubview:self.skipButton];
    [self addSubview:self.adImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAdView)];
    [self.adImageView addGestureRecognizer:tap];
    
    countdown = 6;
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timeRun {
    countdown -- ;
    if (countdown == 0) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)skipAdControl:(eventType)type {
    [timer invalidate];
    timer = nil;
    self.adImageView.hidden = YES;
}

#pragma mark  点击 跳过 按钮跳过
- (void)clickSkipButton {
    
}

#pragma mark  点击 广告
- (void)clickAdView {
    
}

/**
 点击 跳过 按钮跳过
 点击 广告
 倒计时结束 自动跳过
 */

@end
