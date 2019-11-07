//
//  TestLineChartViewController.m
//  Cicada
//  折线图
//  Created by 张琦 on 2017/6/15.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TestLineChartViewController.h"
#import "Cicada-Bridging-Header.h"
#import "Cicada-Swift.h"
#import "SymbolsValueFormatter.h"
#import "LineChartModel.h"

@interface XValueFormatter : NSObject <IChartAxisValueFormatter>

@end

@implementation XValueFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:value]];
}

@end

@interface YValueFormatter : NSObject <IChartAxisValueFormatter>

@end

@implementation YValueFormatter

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return [NSString stringWithFormat:@"%.2f",value];
}

@end

@interface TestLineChartViewController ()<ChartViewDelegate>

@property (nonatomic, strong) LineChartView *lineChartView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TestLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc]init];
    [self createLineChartView];
    [self requestData];
}

- (void)createLineChartView {
    _lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
    _lineChartView.delegate = self;
    _lineChartView.backgroundColor = COLOR_WHITE;//背景颜色
//    _lineChartView.noDataText = @"Cicada-暂无数据";
    _lineChartView.noDataText = @"";//设置没数据时提示信息
    _lineChartView.chartDescription.enabled = YES;
    
    _lineChartView.scaleYEnabled = NO;//取消Y轴缩放
    _lineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    _lineChartView.dragEnabled = YES;//启用拖拽
    _lineChartView.dragDecelerationEnabled = YES;//拖拽后有惯性效果
    _lineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数（0~1），数值越大，惯性越明显
    //描述及图例样式
//    _lineChartView.descriptionText = @"";
    _lineChartView.legend.enabled = NO;
    
    [_lineChartView animateWithXAxisDuration:1.0];
    
    ChartYAxis *leftYAxis = _lineChartView.leftAxis;
    leftYAxis.forceLabelsEnabled = NO;
    leftYAxis.inverted = NO;
    leftYAxis.axisLineColor = COLOR_CLEAR;//y轴轴线的颜色
    leftYAxis.labelPosition = YAxisLabelPositionOutsideChart;//坐标在轴内还是轴外
    leftYAxis.labelTextColor = COLOR_DARKGRAY;
    leftYAxis.labelFont = [UIFont systemFontOfSize:12];
    leftYAxis.gridColor = COLOR_LIGHTGRAY;//y轴网格颜色（垂直于y轴）
    leftYAxis.gridAntialiasEnabled = NO;
    leftYAxis.valueFormatter = [[YValueFormatter alloc]init];
    [leftYAxis setLabelCount:5 force:YES];//坐标轴上显示坐标点的个数
    
    ChartYAxis *rightYAxis = _lineChartView.rightAxis;
    rightYAxis.axisLineColor = COLOR_CLEAR;
    rightYAxis.labelPosition = YAxisLabelPositionOutsideChart;
    rightYAxis.gridColor = COLOR_WHITE;
    rightYAxis.valueFormatter = [[YValueFormatter alloc]init];
    [rightYAxis setLabelCount:5 force:YES];
    
    ChartXAxis *xAxis = _lineChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelTextColor = COLOR_DARKGRAY;
    xAxis.axisLineColor = COLOR_CLEAR;//x轴轴线的颜色
    xAxis.gridColor = COLOR_CLEAR;//x轴网格颜色（垂直于X轴）
//    xAxis.axisLineWidth = 0.5;//轴线宽
    xAxis.granularityEnabled = YES;
    [xAxis setLabelCount:3 force:YES];
    xAxis.valueFormatter = [[XValueFormatter alloc]init];
    _lineChartView.maxVisibleCount = 999;
    
    [self.view addSubview:_lineChartView];
    
    BalloonMarker *marker = [[BalloonMarker alloc]initWithColor:COLOR_LIGHTGRAY font:[UIFont systemFontOfSize:11] textColor:COLOR_WHITE insets:UIEdgeInsetsMake(2, 5, 2, 5) xAxisValueFormatter:_lineChartView.xAxis.valueFormatter];
    marker.chartView = _lineChartView;
    marker.minimumSize = CGSizeMake(80, 40);
    _lineChartView.marker = marker;
}

+ (NSDate *)getDateByAddingMonths:(NSInteger)months fromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}


- (void)requestData {
    NSDictionary *dict = @{
                           @"secucode":@"11601099",
                           @"startdate":@"2018-01-25",
                           @"enddate":@"2018-04-24",
                           @"pageindex":@"",
                           @"pagesize":@"",
                           @"ispaged":@""
                           };
    [NetworkRequest postRequestUrlString:@"http://test-tnhq.tpyzq.com:8082/HTTPServer/servlet" params:dict interfaceID:@"100242" token:@"" success:^(id responseObject) {
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        if ([resDict[@"code"] isEqualToString:@"0"]) {
            _dataSource = [[LineChartModel mj_objectArrayWithKeyValuesArray:resDict[@"data"]] mutableCopy];
            [self dealWithData];
            
        }else {//code错误
        }
    } failure:^(NSError *error) {
    }];
}

- (void)dealWithData {
    NSMutableArray *yAxis1 = [[NSMutableArray alloc] init];
    NSMutableArray *yAxis2 = [[NSMutableArray alloc] init];
    
    for (NSInteger i = (self.dataSource.count - 1); i >= 0; i--)
    {
        LineChartModel *model = self.dataSource[i];
        if (![ToolHelper isBlankString:model.TRADINGDAY] && ![ToolHelper isBlankString:model.FINANCEVALUE]) {
            ChartDataEntry *entry1 = [[ChartDataEntry alloc]initWithX:[ToolHelper timeIntervalWithString:model.TRADINGDAY] y:[model.FINANCEVALUE doubleValue]];
            [yAxis1 addObject:entry1];
            ChartDataEntry *entry2 = [[ChartDataEntry alloc]initWithX:[ToolHelper timeIntervalWithString:model.TRADINGDAY] y:[model.SECURITYVALUE doubleValue]];
            [yAxis2 addObject:entry2];
        }
    }
    
    LineChartDataSet *set1 = nil, *set2 = nil;
    if (_lineChartView.data.dataSetCount > 0) {
        
    } else {
        set1 = [[LineChartDataSet alloc]initWithValues:yAxis1 label:@"知了"];
        [set1 setColor:COLOR_BLUE];
        set1.lineWidth = 1.0;
//        set1.drawCircleHoleEnabled = NO;
        set1.drawCirclesEnabled = NO;
        set1.axisDependency = AxisDependencyLeft;//以左边坐标轴为准
        set1.drawValuesEnabled = NO;//是否在图上显示数值
        
        set2 = [[LineChartDataSet alloc]initWithValues:yAxis2 label:@"哈士奇"];
        [set2 setColor:COLOR_RED];
        set2.lineWidth = 1.0;
        set2.drawCirclesEnabled = NO;
        set2.axisDependency = AxisDependencyRight;//以右边坐标轴为准
        set2.drawValuesEnabled = NO;
        
        NSArray *setArr = @[set1,set2];
        LineChartData *data = [[LineChartData alloc]initWithDataSets:setArr];
        _lineChartView.data = data;
//        ChartXAxis *
    }
    
    
    /*
    if (_lineChartView.data.dataSetCount > 0)
    {
//        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
//        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
//        set1.values = yVals1;
//        set2.values = yVals2;
//        [_chartView.data notifyDataChanged];
//        [_chartView notifyDataSetChanged];
    }else {
        set1 = [[LineChartDataSet alloc] initWithValues:yAxis1 label:@"啊啊啊( ⊙ o ⊙ )啊！"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:COLOR_BLUE];
        [set1 setCircleColor:UIColor.whiteColor];
        set1.lineWidth = 1.0;
        set1.drawCircleHoleEnabled = NO;
        set1.drawValuesEnabled = NO;
        set1.drawCirclesEnabled = NO;
        set1.drawFilledEnabled = NO;//与X轴之间是否填充
        set1.highlightColor = COLOR_LIGHTGRAY;
        
        set2 = [[LineChartDataSet alloc] initWithValues:yAxis2 label:@"呃呃呃😓"];
        set2.axisDependency = AxisDependencyRight;
        [set2 setColor:COLOR_YELLOW];
        set2.lineWidth = 1.0;
        set2.drawCircleHoleEnabled = NO;
        set2.drawValuesEnabled = NO;
        set2.drawCirclesEnabled = NO;
        set2.drawFilledEnabled = NO;//与X轴之间是否填充
        set2.highlightColor = COLOR_LIGHTGRAY;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _chartView.data = data;
    }
    ChartXAxis *xaxis = _chartView.xAxis;
    xaxis.avoidFirstLastClippingEnabled = YES;
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
