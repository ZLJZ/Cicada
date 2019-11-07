//
//  UINavigationController+WXLNavigationController.m
//  Cicada
//
//  Created by 张琦 on 2017/4/17.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UINavigationController+WXLNavigationController.h"
#import <objc/runtime.h>

@implementation UINavigationController (WXLNavigationController)

static NSString *alphaKey = @"WXLAlphaKey";

- (NSString *)alphaStr {
    return objc_getAssociatedObject(self, &alphaKey);
}

- (void)setAlphaStr:(NSString *)alphaStr {
    objc_setAssociatedObject(self, &alphaKey, alphaStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    UIView *barBackgroundView = [self.navigationBar.subviews objectAtIndex:0];
    UIImageView *barImageView = [barBackgroundView.subviews objectAtIndex:0];
    if (self.navigationBar.translucent) {
        if (barBackgroundView != nil && barImageView.image != nil) {
            self.navigationBar.alpha = alpha;
        } else {
            UIView *backgroundEffectView = [barBackgroundView.subviews objectAtIndex:1];
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    } else {
    
        barBackgroundView.alpha = alpha;
    }
    //当我们对导航栏的透明度设置为0时就会隐藏下面的细线
    self.navigationBar.clipsToBounds = alpha = 0.0;
}



@end
