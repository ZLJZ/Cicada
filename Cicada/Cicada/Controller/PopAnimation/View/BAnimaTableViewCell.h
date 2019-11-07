//
//  BAnimaTableViewCell.h
//  Cicada
//
//  Created by 张琦 on 2017/4/5.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAnimaTableViewCell : UITableViewCell<CAAnimationDelegate>

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CABasicAnimation *basicAnimation;
@property (nonatomic, strong) UILabel *riseFallLabel;

+ (id)bAnimationTableViewCell:(UITableView *)tableView;

- (void)refreshCell:(NSInteger)num;

@end
