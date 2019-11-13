//
//  BaseViewController.m
//  BezierPathDemo
//
//  Created by 张琦 on 2017/3/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import "RootViewController.h"
#import "ProgressBarViewController.h"
#import "PopAnimationViewController.h"
#import "TakePhotoViewController.h"
#import "GCDUseViewController.h"
#import "PicScanViewController.h"
#import "AllAppsViewController.h"
#import "TextFieldPracticeViewController.h"
#import "Cicada-Swift.h"
#import "IJKCicadaLiveViewController.h"
#import "IJKCaptureViewController.h"
#import "TestRuntimeViewController.h"
#import "TestPieChartViewController.h"
#import "TestRadarViewController.h"
#import "TestLineChartViewController.h"
#import "MoveCellViewController.h"
#import "ColorGradientViewController.h"
#import "ZLChartViewController.h"
#import "FinancialCalendarViewController.h"
#import "LayerFightingViewController.h"



@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    [self customUI];
    
    
    _titleArr = [[NSMutableArray alloc]init];
    _titleArr = @[@"ProgressBar",@"PopAnimation",@"TakePhoto",@"GCD",@"PicScan",@"OperationTag",@"TextField",@"CicadaSwift",@"IJKLive",@"IJKCapture",@"TestRuntime",@"ZLChart",@"TestPieChart",@"TestRadarChart",@"TestLineChart",@"MoveCell",@"ColorGradient",@"FinancialCalendar",@"LayerFightingViewController"].mutableCopy;
    [self createTableView];
}

- (void)customUI {
    self.navigationItem.title = @"首页";
//    self.navigationController.navigationBar setBackgroundImage:[UIImage ] forBarMetrics:<#(UIBarMetrics)#>
}

- (void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = COLOR_BACK;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CicadaCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenHeight, 40)];
        label.textColor = [UIColor brownColor];
        label.tag = 100;
        [cell.contentView addSubview:label];
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    label.text = _titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController pushViewController:[NSClassFromString(self.titleArr[indexPath.row]) new] animated:YES];
//    return;
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[ProgressBarViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[PopAnimationViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[TakePhotoViewController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[GCDUseViewController new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[PicScanViewController new] animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:[AllAppsViewController new] animated:YES];
            break;
        case 6:
            [self.navigationController pushViewController:[TextFieldPracticeViewController new] animated:YES];
            break;
        case 7:
            [self.navigationController pushViewController:[CicadaViewController new] animated:YES];
            break;
        case 8:
            [self.navigationController pushViewController:[IJKCicadaLiveViewController new] animated:YES];
            break;
        case 9:
            [self.navigationController pushViewController:[IJKCaptureViewController new] animated:YES];
            break;
        case 10:
            [self.navigationController pushViewController:[TestRuntimeViewController new] animated:YES];
            break;
        case 11:
            [self.navigationController pushViewController:[ZLChartViewController new] animated:YES];
            break;
        case 12:
            [self.navigationController pushViewController:[TestPieChartViewController new] animated:YES];
            break;
        case 13:
            [self.navigationController pushViewController:[TestRadarViewController new] animated:YES];
            break;
        case 14:
            [self.navigationController pushViewController:[TestLineChartViewController new] animated:YES];
            break;
        case 15:
            [self.navigationController pushViewController:[MoveCellViewController new] animated:YES];
            break;
        case 16:
            [self.navigationController pushViewController:[ColorGradientViewController new] animated:YES];
            break;
        case 17:
            [self.navigationController pushViewController:[FinancialCalendarViewController new] animated:YES];
            break;
        case 18:
            [self.navigationController pushViewController:[LayerFightingViewController new] animated:YES];
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
