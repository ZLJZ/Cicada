//
//  LayerFightingViewController.m
//  Cicada
//
//  Created by 吴肖利 on 2019/11/13.
//  Copyright © 2019 com. All rights reserved.
//

#import "LayerFightingViewController.h"

@interface LayerFightingViewController ()

@end

@implementation LayerFightingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 100, 180, 45)];
//    label.layer.borderWidth = 1;
//    label.layer.borderColor = COLOR_YELLOW.CGColor;
//    label.layer.cornerRadius = 5;
//    label.layer.shadowColor = COLOR_GREEN.CGColor;
//    label.layer.shadowOpacity = 1;
//    label.layer.shadowRadius = 3;
//    label.layer.shadowOffset = CGSizeMake(10, -10);
//    [self.view addSubview:label];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 100, 180, 45)];
    label.layer.borderWidth = 1;
    label.layer.borderColor = COLOR_YELLOW.CGColor;
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    [self.view addSubview:label];
    
    CALayer *layer = [CALayer layer];
    //    layer.frame = CGRectMake(0, 0, label.width, label.height);//颜色超好看虽然是填充的，当然不是阴影yeah
    layer.frame = CGRectMake(0, 1, 180, 1);//只设置顶部的阴影
    layer.shadowColor = COLOR_GREEN.CGColor;
    layer.shadowOffset = CGSizeMake(3, 3);
    layer.shadowOpacity = 1;
    layer.shadowPath = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    [label.layer addSublayer:layer];
    
    
}

@end
