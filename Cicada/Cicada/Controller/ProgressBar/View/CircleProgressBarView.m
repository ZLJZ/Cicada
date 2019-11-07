//
//  CircleProgressBarView.m
//  Cicada
//
//  Created by 张琦 on 2017/3/8.
//  Copyright © 2017年 com. All rights reserved.
//

#import "CircleProgressBarView.h"

@interface CircleProgressBarView ()

@property (nonatomic ,strong) CAShapeLayer *shapeLayer;

@property (nonatomic ,assign) CGFloat       startAngle; //开始角

@property (nonatomic ,assign) CGFloat       endAngle; //终止角

@property (nonatomic, strong) UIImageView *dotView;

@property (nonatomic, strong) CABasicAnimation *animation;

@property (nonatomic, assign) BOOL isPause;

@property (nonatomic, assign) BOOL isFirst;

/**
 端点类型：
 kCALineCapRound,
 kCALineCapSquare,
 kCALineCapButt
 */
@property (nonatomic ,copy) NSString * _Nonnull  lineCapType;//端点类型

@end

@implementation CircleProgressBarView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineCapType:(NSString * _Nonnull)lineCapType {
    self = [super initWithFrame:frame];
    if (self) {
        self.isFirst = YES;
        self.lineWidth = lineWidth;
        self.strokeColor = strokeColor;
        self.fillColor = fillColor;
        self.startAngle = startAngle;
        self.endAngle = endAngle;
        self.lineCapType = lineCapType;
        [self.layer addSublayer:self.shapeLayer];
    }
    return self;
}

- (void)setAnimated:(BOOL)animated {
    if (self.isFirst) {
        [self.shapeLayer addAnimation:self.animation forKey:@"transformZAnimation"];
        self.isFirst = NO;
    }
    if (animated) {
        CFTimeInterval pauseTime = self.shapeLayer.timeOffset;
        //计算暂停时间
        CFTimeInterval timeSinePause = CACurrentMediaTime() - pauseTime;
        self.shapeLayer.timeOffset = 0;
        self.shapeLayer.beginTime = timeSinePause;
        self.shapeLayer.speed = 1;
    } else {
        CFTimeInterval pauseTime = [self.shapeLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.shapeLayer.timeOffset = pauseTime;
        self.shapeLayer.speed = 0;
    }
}

- (void)setStrokeEnd:(CGFloat)strokeEnd {
    self.shapeLayer.strokeEnd = strokeEnd;
}

- (CABasicAnimation *)animation {
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _animation.fromValue = @(0);
        _animation.toValue = @(2 * M_PI);
        _animation.repeatCount = HUGE_VALF;
        _animation.duration = 1.f;
        _animation.removedOnCompletion = NO;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    return _animation;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.frame;
        _shapeLayer.lineWidth = self.lineWidth;//设置线宽
        _shapeLayer.strokeColor = self.strokeColor.CGColor;//设置线的颜色
        _shapeLayer.fillColor = self.fillColor.CGColor;//设置填充颜色
        _shapeLayer.lineCap = self.lineCapType;
        CGFloat radius = self.frame.size.width / 2;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
        _shapeLayer.path = circlePath.CGPath;
    }
    return _shapeLayer;
}

@end
