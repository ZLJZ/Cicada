//
//  TestRadarViewController.m
//  Cicada
//  雷达图
//  Created by 张琦 on 2017/6/13.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TestRadarViewController.h"
#import "Cicada-Bridging-Header.h"
#import "Cicada-Swift.h"
@interface TestRadarViewController ()

@property (nonatomic,strong) RadarChartView *radarChartView;

@end

@implementation TestRadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACK;
    // Do any additional setup after loading the view.
    [self createRadarChartView];
    [self setRadarChartData];
    
}

- (void)setRadarChartData {
    double mult = 100;
    int count = 12;
    NSMutableArray *xAxis = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < count ; i ++ ) {
        [xAxis addObject:[NSString stringWithFormat:@"%ld",i + 1]];
    }
    
    NSMutableArray *yAxis = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < count ; i ++) {
        double randomVal = arc4random_uniform(mult) + mult / 2;
        ChartDataEntry *entry = [[ChartDataEntry alloc]initWithX:i y:randomVal];
        [yAxis addObject:entry];
    }
    
    RadarChartDataSet *dataSet = [[RadarChartDataSet alloc]initWithValues:yAxis label:@"radar-1"];
    dataSet.lineWidth = 0.5;
    [dataSet setColor:[UIColor purpleColor]];
    dataSet.drawFilledEnabled = YES;
    dataSet.fillColor = [UIColor blueColor];
    dataSet.fillAlpha = 0.5;
    dataSet.valueFont = [UIFont systemFontOfSize:12];
    dataSet.valueTextColor = [UIColor orangeColor];
    
    RadarChartData *data = [[RadarChartData alloc]initWithDataSet:dataSet];
    _radarChartView.data = data;

}

- (void)createRadarChartView {
    _radarChartView = [[RadarChartView alloc]initWithFrame:CGRectMake((kScreenWidth - 300)/2, 100, 300, 350)];
    _radarChartView.backgroundColor = COLOR_LIGHTGRAY;
    _radarChartView.rotationEnabled = YES;
    _radarChartView.highlightPerTapEnabled = YES;
    
    _radarChartView.webLineWidth = 0.5;
    _radarChartView.webColor = COLOR_DARKGRAY;
    _radarChartView.innerWebLineWidth = 0.3;
    _radarChartView.innerWebColor = COLOR_DARKGRAY;
//    _radarChartView.descriptionText = @"Cicada-雷达";
//    _radarChartView.descriptionFont = [UIFont systemFontOfSize:11];
//    _radarChartView.descriptionTextColor = COLOR_YELLOW;


    ChartXAxis *xAxis = _radarChartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:13];
    xAxis.labelTextColor = COLOR_YELLOW;
    
    ChartYAxis *yAxis = _radarChartView.yAxis;
    yAxis.axisMinimum = 0;
    yAxis.axisMaximum = 150;
    yAxis.drawLabelsEnabled = NO;//
    yAxis.labelCount = 6;
    yAxis.labelFont = [UIFont systemFontOfSize:13];
    yAxis.labelTextColor = COLOR_DARKGRAY;
    
    
    
    [self.view addSubview:_radarChartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
