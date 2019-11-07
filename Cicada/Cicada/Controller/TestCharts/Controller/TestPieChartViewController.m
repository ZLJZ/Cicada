//
//  TestPieChartViewController.m
//  Cicada
//  饼状图
//  Created by 张琦 on 2017/6/12.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TestPieChartViewController.h"
#import "Cicada-Bridging-Header.h"
#import "Cicada-Swift.h"
@interface TestPieChartViewController ()

@property (nonatomic,strong) PieChartView *pieChartView;

@property (nonatomic, strong) PieChartData *data;

@end

@implementation TestPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACK;
    [self createBarChartView];
    [self setPieChartData];
}

- (void)setPieChartData {
    
    double mult = 100;
    int count = 5;
    
    NSMutableArray *xVals = [[NSMutableArray alloc]init];
    for (int i =  0; i < count ; i ++ ) {
        NSString *title = [NSString stringWithFormat:@"part%d",i + 1];
        [xVals addObject:title];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc]init];
    for (int i = 0; i < count; i ++ ) {
        double randomVals = arc4random_uniform(mult + 1);
        BarChartDataEntry *entry = [[BarChartDataEntry alloc]initWithX:i y:randomVals];
        [yVals addObject:entry];
        
    }
    
    
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc]initWithValues:yVals label:@""];
    dataSet.drawValuesEnabled = YES;
//    NSMutableArray *colors = [[NSMutableArray alloc]init];
//    [colors addObject:[UIColor redColor]];
    NSArray *colors = @[[UIColor redColor],[UIColor purpleColor],[UIColor greenColor],[UIColor lightGrayColor],[UIColor yellowColor]];
    dataSet.colors = colors;
    dataSet.sliceSpace = 0;
    dataSet.selectionShift = 8;
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
    dataSet.valueLinePart1OffsetPercentage = 0.85;
    dataSet.valueLinePart1Length = 0.5;
    dataSet.valueLinePart2Length = 0.4;
    dataSet.valueLineWidth = 1;
    dataSet.valueLineColor = [UIColor orangeColor];
    
    PieChartData *data = [[PieChartData alloc]initWithDataSet:dataSet];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 0;
    formatter.multiplier = @1.f;
//    [data setValueFormatter:[ChartDefaultValueFormatter alloc] initWithFormatter:formatter];
    [data setValueTextColor:[UIColor blueColor]];
    [data setValueFont:[UIFont systemFontOfSize:12]];

    _pieChartView.data = data;
}

- (void)createBarChartView {
    _pieChartView = [[PieChartView alloc]initWithFrame:CGRectMake((kScreenWidth - 300)/2, 100, 200, 300)];
    _pieChartView.backgroundColor = COLOR_LIGHTGRAY;
    [_pieChartView setExtraOffsetsWithLeft:20 top:20 right:20 bottom:20];
    _pieChartView.usePercentValuesEnabled = YES;
    _pieChartView.dragDecelerationEnabled = YES;
    _pieChartView.drawCenterTextEnabled = YES;
    _pieChartView.drawHoleEnabled = YES;
    _pieChartView.holeRadiusPercent = 0.5;
    _pieChartView.holeColor = [UIColor greenColor];
    _pieChartView.transparentCircleRadiusPercent = 0.52;
    _pieChartView.transparentCircleColor = [UIColor redColor];
    _pieChartView.drawCenterTextEnabled = YES;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:@"Cicada"];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, attributeStr.length - 1)];
    _pieChartView.centerAttributedText = attributeStr;
    
    
//    _pieChartView.descriptionText = @"描述。。。。。。";
//    _pieChartView.descriptionFont = [UIFont systemFontOfSize:13];
//    _pieChartView.descriptionTextColor = COLOR_YELLOW;
    
    _pieChartView.legend.maxSizePercent = 1;
    _pieChartView.legend.formToTextSpace = 5;
    _pieChartView.legend.font = [UIFont systemFontOfSize:15];
    _pieChartView.legend.textColor = COLOR_DARKGRAY;
//    _pieChartView.legend.position = ChartLegendPositionBelowChartCenter;
    _pieChartView.legend.form = ChartLegendFormLine;//为ChartLegendFormNone，表示不画
    _pieChartView.legend.formSize = 12;
    
    
    
    
    [self.view addSubview:_pieChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
