//
//  BAnimaTableViewCell.m
//  Cicada
//
//  Created by 张琦 on 2017/4/5.
//  Copyright © 2017年 com. All rights reserved.
//

#import "BAnimaTableViewCell.h"

@implementation BAnimaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customCell];
    }
    return self;
}

- (void)customCell {
    _gradientLayer = [self createAnimationLayer];
    [self.layer addSublayer:_gradientLayer];
    _basicAnimation = [self creatBasicAnimationAndOffset:-60];
    [_gradientLayer addAnimation:_basicAnimation forKey:@"position"];
    _gradientLayer.hidden = YES;
    
    _riseFallLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 60)];
    _riseFallLabel.font = [UIFont systemFontOfSize:12];
    _riseFallLabel.textColor = COLOR_LIGHTGRAY;
    [self.contentView addSubview:_riseFallLabel];
}

- (void)refreshCell:(NSInteger)num {
//    _basicAnimation.removedOnCompletion = NO;
    if (num > 0) {
        _gradientLayer.hidden = NO;
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.1f].CGColor,     (__bridge id)[UIColor colorWithRed:247/255.f green:130/255.f blue:116/255.f alpha:0.2].CGColor,     (__bridge id)[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.1f].CGColor];
        _basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y)];

        _basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y - 60)];

    } else if (num < 0) {
        _gradientLayer.hidden = NO;

        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.1f].CGColor, (__bridge id)[UIColor colorWithRed:171/255.f green:207/255.f blue:180/255.f alpha:0.2].CGColor, (__bridge id)[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.1f].CGColor];
        _basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y)];

        _basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y + 60)];
    } else {
        _gradientLayer.hidden = YES;
    }

}

+ (id)bAnimationTableViewCell:(UITableView *)tableView {
    static NSString *cellId = @"bAnimationCellId";
    BAnimaTableViewCell *cell = (BAnimaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BAnimaTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}

- (CAGradientLayer *)createAnimationLayer {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    gradientLayer.frame = CGRectMake(20, 0, kScreenWidth, 60);
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.1f].CGColor,     (__bridge id)[UIColor colorWithRed:247/255.f green:130/255.f blue:116/255.f alpha:0.2].CGColor,     (__bridge id)[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.1f].CGColor];
    gradientLayer.locations = @[@(0.0),@(0.5),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    return gradientLayer;
}

-(CABasicAnimation *)creatBasicAnimationAndOffset:(float)offset{
    CABasicAnimation *animation;
    animation = [CABasicAnimation animation];
    animation.delegate = self;
    animation.keyPath = @"position";
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y + offset)];
    animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];//运转效果
    // 设置动画执行次数
    
    animation.repeatCount = 1;
    // 设置动画完成的时候移除动画
    // 这个属性默认为 YES,那意味着,在指定的时间段完成后,动画就自动的从层上移除了。这个一般不用。
    // 假如你想要再次用这个动画时,你需要设定这个属性为 NO
//    animation.removedOnCompletion = YES;
    _basicAnimation.removedOnCompletion = NO;
    // 设置动画执行完成要保持最新的效果
    animation.fillMode = kCAFillModeForwards;
    animation.duration =0.5f;
    return animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _gradientLayer.hidden = YES;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
