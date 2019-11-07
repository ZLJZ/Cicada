//
//  CircleProgressBarView.h
//  Cicada
//
//  Created by 张琦 on 2017/3/8.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressBarView : UIView

//设置线宽
@property (nonatomic ,assign) CGFloat  lineWidth;

//设置线的颜色
@property (nonatomic ,strong) UIColor * _Nonnull strokeColor;

//设置填充颜色
@property (nonatomic ,strong) UIColor * _Nonnull fillColor;

@property (nonatomic, assign) BOOL animated;

/**
 * @method  。。。。。。      初始化进度条
 * @param   lineWidth       线宽
 * @param   strokeColor     线条颜色
 * @param   fillColor       填充色
 * @param   startAngle      开始角
 * @param   endAngle        终止角
 * @param   lineCapType     端点类型
 * @return  id
 */
- (instancetype _Nonnull)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth strokeColor:(UIColor * _Nonnull)strokeColor fillColor:(UIColor * _Nonnull)fillColor startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineCapType:(NSString * _Nonnull)lineCapType;

//没有动画
- (void)setStrokeEnd:(CGFloat)strokeEnd;

@end
