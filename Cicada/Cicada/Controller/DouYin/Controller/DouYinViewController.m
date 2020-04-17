//
//  DouYinViewController.m
//  Cicada
//
//  Created by 吴肖利 on 2020/4/17.
//  Copyright © 2020 com. All rights reserved.
//

#import "DouYinViewController.h"
#import "LikeView.h"


@interface DouYinViewController ()

@property (nonatomic,strong) LikeView *likeView;

@end

@implementation DouYinViewController

- (LikeView *)likeView {
    if (!_likeView) {
        _likeView = [[LikeView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
        _likeView.backgroundColor = UIColor.lightGrayColor;
        [self.view addSubview:_likeView];
    }
    return _likeView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self likeView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
