//
//  UINavigationController+WXLNavigationController.h
//  Cicada
//
//  Created by 张琦 on 2017/4/17.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (WXLNavigationController)

@property (nonatomic, copy) NSString *alphaStr;

- (void)setNeedsNavigationBackground:(CGFloat)alpha;

@end
