//
//  WXLLaunchAdView.h
//  Cicada
//
//  Created by 张琦 on 2017/4/6.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    LogoAdType = 0,
    FullScreenAdType = 1
}AdType;

typedef enum : NSInteger {
    skipEventType = 0,
    clickSkipButtonType = 1,
    clickAdType = 2,
}eventType;


@interface WXLLaunchAdView : UIView
{
    NSInteger    countdown;
    NSTimer     *timer;
}

@property (nonatomic, strong) UIImageView           *adImageView;

@property (nonatomic, strong) UIButton              *skipButton;

@end
