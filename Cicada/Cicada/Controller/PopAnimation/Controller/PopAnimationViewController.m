//
//  PopAnimationViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/3/8.
//  Copyright © 2017年 com. All rights reserved.
//

#import "PopAnimationViewController.h"
#import "BAnimaTableViewCell.h"

@interface PopAnimationViewController ()<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PopAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc]init];
    _dataSource = @[@"2",@"4",@"-1",@"-4",@"6",@"-5",@"-2"].mutableCopy;
    
    [self createTableView];
    [self customUI];
}

- (void)customUI {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(clickRefresh)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickRefresh {
    [_tableView reloadData];
}

- (void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = YES;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BAnimaTableViewCell *cell = [BAnimaTableViewCell bAnimationTableViewCell:tableView];
    cell.riseFallLabel.text = _dataSource[indexPath.row];
    [cell refreshCell:[cell.riseFallLabel.text integerValue]];
//    if ([cell.riseFallLabel.text integerValue] > 0) {
//        cell.gradientLayer.hidden = NO;
//    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
