
//
//  LiveDetailViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/6/1.
//  Copyright © 2017年 com. All rights reserved.
//

#import "LiveDetailViewController.h"
#import "IJKLiveModel.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface LiveDetailViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACK;

    [self createUI];
}

- (void)createUI {
    NSURL *url = [NSURL URLWithString:_liveModel.stream_addr];
    IJKFFMoviePlayerController *playerVC = [[IJKFFMoviePlayerController alloc]initWithContentURL:url withOptions:nil];
    [playerVC prepareToPlay];
    _player = playerVC;
    playerVC.view.frame = CGRectMake(10, 64 + 10, kScreenWidth - 20, kScreenHeight - 20 - 64);
    [self.view addSubview:playerVC.view];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
