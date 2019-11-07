//
//  PicScanView.h
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PicScanViewDelegate <NSObject>

@optional

//滚动代理方法
-(void)picScanViewDidSelectedAt:(NSInteger)index;

@end

@interface PicScanView : UIView

@property (nonatomic, strong) NSArray *modelArray;

@property (weak,nonatomic) id<PicScanViewDelegate>delegate;


@end
