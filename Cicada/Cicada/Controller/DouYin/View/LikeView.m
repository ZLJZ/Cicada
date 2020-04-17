//
//  LikeView.m
//  JustDoIt
//
//  Created by 吴肖利 on 2020/4/15.
//  Copyright © 2020 com. All rights reserved.
//

#import "LikeView.h"

@implementation LikeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
#if 1
        [self addViews];
    
#else
        [self addViews2];
#endif
    }
    return self;
}


/**
 使用CAReplactorLayer赋值图层
 */
- (void)addViews2 {
    
    NSArray <CALayer *>*layerArr = self.layer.sublayers;
    NSArray <CALayer *>*removeLayerArr = [layerArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAReplicatorLayer class]];
    }]];
    [removeLayerArr enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    CGFloat length = 60.f;
    CGFloat duration = 0.5f;
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.fillColor = UIColor.redColor.CGColor;

    //还需设置path，path使用贝塞尔
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath moveToPoint:CGPointMake(-2, -length)];
    [startPath addLineToPoint:CGPointMake(2, -length)];
    [startPath addLineToPoint:CGPointMake(0, 0)];
    
    shapeLayer.path = startPath.CGPath;
    

    
    UIBezierPath *endPath = [UIBezierPath bezierPath];
    [endPath moveToPoint:CGPointMake(-2, -length)];
    [endPath addLineToPoint:CGPointMake(2, -length)];
    [endPath addLineToPoint:CGPointMake(0, -length)];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    /**
        以下两行代码让图层保持显示动画执行后的状态
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
     
     */
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.duration = duration;
    
    /**
        缩放动画：
        从0缩放到1，持续时间scaleAnimation.duration
     */
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0.0);
    scaleAnimation.toValue = @(1.0);
    scaleAnimation.duration = duration *0.2f;
    
    /**
        path动画：
        从startPath到endPath
        开始时间：pathAnimation.beginTime
        持续时间：pathAnimation.duration
     */
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    pathAnimation.beginTime = duration * 0.2;
    pathAnimation.duration = duration * 0.8;
    
    [group setAnimations:@[scaleAnimation,pathAnimation]];
    [shapeLayer addAnimation:group forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.position = self.frontLikeView.center;
    replicatorLayer.instanceCount = 6;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI/3, 0.0, 0.0, 1.0);
    [replicatorLayer addSublayer:shapeLayer];
    [self.layer addSublayer:replicatorLayer];
    
}


/**
 使用for循环创建图层
 */
- (void)addViews {

    NSArray <CALayer *>*layerArr = self.layer.sublayers;
    NSArray <CALayer *> *removeLayerArr = [layerArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
    }]];
    
    [removeLayerArr enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    CGFloat length = 60.f;
    CGFloat duration = 0.5f;
    
    for (NSInteger i = 0; i < 6; i ++) {
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
        shapeLayer.position = self.frontLikeView.center;
        shapeLayer.fillColor = UIColor.redColor.CGColor;

        //还需设置path，path使用贝塞尔
        
        UIBezierPath *startPath = [UIBezierPath bezierPath];
        [startPath moveToPoint:CGPointMake(-2, -length)];
        [startPath addLineToPoint:CGPointMake(2, -length)];
        [startPath addLineToPoint:CGPointMake(0, 0)];
        
        shapeLayer.path = startPath.CGPath;
        
        shapeLayer.transform = CATransform3DMakeRotation(M_PI / 3.f * i, 0, 0, 1.0);//x,y,z为0代表在该轴方向上不旋转，为1代表在该轴方向上顺时针旋转，为-1代表在该轴方向上逆时针旋转
        [self.layer addSublayer:shapeLayer];
        
        UIBezierPath *endPath = [UIBezierPath bezierPath];
        [endPath moveToPoint:CGPointMake(-2, -length)];
        [endPath addLineToPoint:CGPointMake(2, -length)];
        [endPath addLineToPoint:CGPointMake(0, -length)];
        
        CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
        /**
            以下两行代码让图层保持显示动画执行后的状态
            group.removedOnCompletion = NO;
            group.fillMode = kCAFillModeForwards;
         
         */
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.duration = duration;
        
        /**
            缩放动画：
            从0缩放到1，持续时间scaleAnimation.duration
         */
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @(0.0);
        scaleAnimation.toValue = @(1.0);
        scaleAnimation.duration = duration *0.2f;
        
        /**
            path动画：
            从startPath到endPath
            开始时间：pathAnimation.beginTime
            持续时间：pathAnimation.duration
         */
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
        pathAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
        pathAnimation.beginTime = duration * 0.2;
        pathAnimation.duration = duration * 0.8;
        
        [group setAnimations:@[scaleAnimation,pathAnimation]];
        [shapeLayer addAnimation:group forKey:nil];
    }
    
}

- (void)performAnimation {


}

- (UIImageView *)frontLikeView {
    if (!_frontLikeView) {
        CGFloat width = 60.f;
        _frontLikeView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - width)/2.0, (self.frame.size.height - width)/2.0, width, width)];
        _frontLikeView.backgroundColor = UIColor.orangeColor;
        _frontLikeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addViews)];
        [_frontLikeView addGestureRecognizer:tap];
        [self addSubview:_frontLikeView];
    }
    return _frontLikeView;
}

@end
