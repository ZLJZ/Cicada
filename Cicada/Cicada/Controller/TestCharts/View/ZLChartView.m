//
//  ZLChartView.m
//  Cicada
//
//  Created by 吴肖利 on 2018/9/11.
//  Copyright © 2018 com. All rights reserved.
//

#import "ZLChartView.h"
#import "MultiTabView.h"
#import "Cicada-Swift.h"
#import "DataEmit.h"
#import "GetPriceToListModel.h"
#import "ZLChartsValueFormatter.h"
#import "ZLChartsFillFormatter.h"
#import <AFNetworking/AFNetworking.h>
#import "NSTimer+ZLTimerControl.h"

@interface ZLChartView ()<ChartViewDelegate>

//自定义多页签view
@property (nonatomic, strong) MultiTabView *multiTabView;
//k线backView
@property (nonatomic, strong) UIView *kLineBackView;
//分时图
@property (nonatomic, strong) CombinedChartView *combinedChartView;
//柱状图
@property (nonatomic, strong) ZLBarChartView *barChartView;
//成交量label
@property (nonatomic, strong) UILabel *volLabel;
//最大成交量label
@property (nonatomic, strong) UILabel *maxVolLabel;
//计时器
@property (nonatomic, strong) NSTimer *timer;
//
@property (nonatomic, strong) NSString *lastTime;

@property (nonatomic, assign) ZLLineType lineType;

@end
@implementation ZLChartView

//
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_BACK;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        [self addSubview:self.multiTabView];
        [self addSubview:self.kLineBackView];
    }
    return self;
}



#pragma mark  多页签view
-(MultiTabView *)multiTabView {
    if (!_multiTabView) {
        uWeakSelf
        _multiTabView = [[MultiTabView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titleArr:@[@"分时",@"五日",@"日K",@"周K",@"月K",@"分钟"] defaultIdx:0 selectedTabBlock:^(NSInteger selectedIdx, UIButton * _Nonnull selectedButton) {
            weakSelf.lineType = selectedIdx;
            switch (selectedIdx) {
                case 0:
                    [weakSelf requestTimeDivisionData];
                    break;
                case 1:
                    [weakSelf requestFiveDaysData];
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                case 4:
                    
                    break;
                case 5:
                    
                    break;
                    
                default:
                    break;
            }
        }];
    }
    return _multiTabView;
}

#pragma mark  ChartViewDelegate
#pragma mark  图表联动
-(void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    CGAffineTransform srcMatrix = chartView.viewPortHandler.touchMatrix;
    [self.combinedChartView.viewPortHandler refreshWithNewMatrix:srcMatrix chart:self.combinedChartView invalidate:YES];
    [self.barChartView.viewPortHandler refreshWithNewMatrix:srcMatrix chart:self.barChartView invalidate:YES];
}

-(void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    CGAffineTransform srcMatrix = chartView.viewPortHandler.touchMatrix;
    [self.combinedChartView.viewPortHandler refreshWithNewMatrix:srcMatrix chart:self.combinedChartView invalidate:YES];
    [self.barChartView.viewPortHandler refreshWithNewMatrix:srcMatrix chart:self.barChartView invalidate:YES];
}

-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if ([chartView isKindOfClass:[CombinedChartView class]]) {
        //lineChartView显示十字线时选中对应的barChartView
        [self.barChartView highlightValueWithX:highlight.x dataSetIndex:highlight.dataSetIndex stackIndex:highlight.stackIndex];
        
        //获取柱状图entry.y，设置成交量
        id<IBarChartDataSet> set = (id<IBarChartDataSet>)self.barChartView.barData.dataSets[0];
        BarChartDataEntry *resEntry = (BarChartDataEntry *)[set entriesForXValue:highlight.x].lastObject;
        self.volLabel.text = kString_Format(@"成交量：%.f",resEntry.y);
        ChartHighlight *high = [[ChartHighlight alloc]initWithX:highlight.x y:4506 dataSetIndex:highlight.dataSetIndex];
        [self.barChartView highlightValue:high];
        
    }
    
    if ([chartView isKindOfClass:[ZLBarChartView class]]) {
        self.volLabel.text = kString_Format(@"成交量：%.f",entry.y);
        
        id<ILineChartDataSet> set = (id<ILineChartDataSet>)self.combinedChartView.lineData.dataSets[0];
        ChartDataEntry *resEntry = (ChartDataEntry *)[set entriesForXValue:highlight.x].lastObject;
        ChartHighlight *high = [[ChartHighlight alloc]initWithX:resEntry.x y:resEntry.y dataSetIndex:highlight.dataSetIndex];
        high.dataIndex = 0;//数据对象的索引，默认为-1，可能会引用多个对象(目前怀疑应该是当有多条时不知道以哪个为基准吧)
        [self.combinedChartView highlightValue:high];
        
    }
    
    /*
     控制两秒不进行操作，十字自动消失（貌似使用GCD的话不能取消正在执行的任务，所以就用了以下方法，在每次获取焦点前取消之前的任务）
     - (void)performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay;
     该方法为异步执行 只能在主线程中执行，在子线程中不会调用aSelector方法
     */
    
    [self performSelector:@selector(delayOper) withObject:nil afterDelay:2.0];
}

- (void)delayOper {
    [self.barChartView highlightValue:nil];
    [self.combinedChartView highlightValue:nil];
    id<IBarChartDataSet> set = (id<IBarChartDataSet>)self.barChartView.barData.dataSets[0];
    BarChartDataEntry *resEntry = (BarChartDataEntry *)[set entriesForXValue:set.entryCount - 1].lastObject;
    self.volLabel.text = kString_Format(@"成交量：%.f",resEntry.y);
}

#pragma mark  lazy
#pragma mark  柱状图
-(ZLBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[ZLBarChartView alloc]initWithFrame:CGRectMake(_combinedChartView.left, _combinedChartView.bottom + 7, LineViewWidth, BarViewHeight)];
        _barChartView.delegate = self;
        _barChartView.backgroundColor = COLOR_WHITE;
        _barChartView.noDataText = @"";//没有数据时的提示信息
        _barChartView.chartDescription.enabled = NO;
        _barChartView.legend.enabled = NO;
        _barChartView.scaleXEnabled = NO;
        _barChartView.scaleYEnabled = NO;
        
        ChartXAxis *xAxis = _barChartView.xAxis;
        xAxis.drawAxisLineEnabled = NO;
        xAxis.drawLabelsEnabled = NO;//不绘制label
        xAxis.drawGridLinesEnabled = NO;//设置X轴不绘制网格线
        
        //
        ChartYAxis *leftYAxis = _barChartView.leftAxis;
        leftYAxis.axisLineWidth = KSINGLELINE_WIDTH;
        leftYAxis.axisLineColor = COLOR_LINE_GRAY;
        [leftYAxis setLabelCount:2 force:YES];
        leftYAxis.drawLabelsEnabled = NO;
        
        ChartYAxis *rightYAxis = _barChartView.rightAxis;
        rightYAxis.axisLineWidth = KSINGLELINE_WIDTH;
        rightYAxis.axisLineColor = COLOR_LINE_GRAY;
        rightYAxis.drawGridLinesEnabled = NO;
        rightYAxis.drawLabelsEnabled = NO;
        [_barChartView addSubview:self.volLabel];
        [_barChartView addSubview:self.maxVolLabel];
    }
    return _barChartView;
}

#pragma mark  混合图表
-(CombinedChartView *)combinedChartView {
    if (!_combinedChartView) {
        _combinedChartView = [[CombinedChartView alloc]initWithFrame:CGRectMake(0, 2, LineViewWidth, LineViewHeight)];
        _combinedChartView.delegate = self;
        _combinedChartView.noDataText = @"";//设置没数据时的提示信息
        _combinedChartView.backgroundColor = COLOR_WHITE;//设置LineChartView的背景色
        _combinedChartView.legend.enabled = NO;//不显示图例说明
        _combinedChartView.chartDescription.enabled = NO;//不显示描述label
        _combinedChartView.scaleXEnabled = NO;
        _combinedChartView.scaleYEnabled = NO;

        ZLMarkerView *markerView = [[ZLMarkerView alloc]initWithColor:[ToolHelper colorWithHex:@"#368DE7" alpha:0.6] textColor:COLOR_WHITE font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter insets:UIEdgeInsetsZero];
        _combinedChartView.marker = markerView;
        
        ChartYAxis *leftYAxis = _combinedChartView.leftAxis;
        //    leftYAxis.spaceTop = 0;//设置左Y轴最大值距离顶部的间隔为0
        leftYAxis.spaceBottom = 0;//设置左Y轴最小值距离底部的间隔为0
        leftYAxis.gridColor = COLOR_LINE_GRAY;//垂直于左Y轴的网格线颜色
        leftYAxis.gridLineWidth = KSINGLELINE_WIDTH;//垂直于左Y轴的网格线宽
        leftYAxis.axisLineColor = COLOR_LINE_GRAY;//左Y轴的轴线颜色
        leftYAxis.axisLineWidth = KSINGLELINE_WIDTH;//左Y轴的轴线宽
        leftYAxis.labelPosition = YAxisLabelPositionInsideChart;//左边Y轴label的位置
        leftYAxis.labelTextColor = COLOR_DARKGRAY;//左边Y轴label的字体颜色
        [leftYAxis setLabelCount:5 force:YES];//设置坐标轴显示坐标点的个数
        leftYAxis.valueFormatter = [[ZLChartsYLeftAxisValueFormatter alloc]init];
        [leftYAxis setXOffset:0];//设置label在X轴上的偏移量，默认是5
        [leftYAxis setYOffset:-4];//设置label在Y轴上的偏移量，默认是0
        
        
        ChartYAxis *rightYAxis = _combinedChartView.rightAxis;
        rightYAxis.drawGridLinesEnabled = NO;//设置Y轴不绘制网格线
        rightYAxis.axisLineColor = COLOR_LINE_GRAY;//右Y轴的轴线颜色
        rightYAxis.axisLineWidth = KSINGLELINE_WIDTH;//右Y轴的轴线宽
        rightYAxis.labelPosition = YAxisLabelPositionInsideChart;
        rightYAxis.labelTextColor = COLOR_DARKGRAY;
        [rightYAxis setLabelCount:5 force:YES];
        rightYAxis.valueFormatter = [[ZLChartsYRightAxisValueFormatter alloc]init];
        [rightYAxis setXOffset:0];
        [rightYAxis setYOffset:-4];
        
        ChartXAxis *xAxis = _combinedChartView.xAxis;
        xAxis.gridColor = COLOR_LINE_GRAY;//垂直于X轴的网格线颜色
        xAxis.gridLineWidth = KSINGLELINE_WIDTH;//垂直于X轴的网格线宽
        xAxis.axisLineColor = COLOR_LINE_GRAY;//X轴的轴线颜色
        xAxis.axisLineWidth = KSINGLELINE_WIDTH;//X轴的轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.labelTextColor = COLOR_DARKGRAY;
        xAxis.avoidFirstLastClippingEnabled = YES;//设置为yes,避免第一个和最后一个label被裁剪
        [xAxis setLabelCount:5 force:YES];
        xAxis.valueFormatter = [[ZLChartsValueFormatter alloc]init];
    }
    return _combinedChartView;
}

#pragma mark  图表back
-(UIView *)kLineBackView {
    if (!_kLineBackView) {
        _kLineBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.multiTabView.bottom + 5, kScreenWidth, LineViewHeight + BarViewHeight + 10)];
        _kLineBackView.backgroundColor = COLOR_WHITE;
        [self.kLineBackView addSubview:self.combinedChartView];
        [self.kLineBackView addSubview:self.barChartView];

    }
    return _kLineBackView;
}

#pragma mark  成交量
-(UILabel *)volLabel {
    if (!_volLabel) {
        _volLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -2, 100, 12)];
        _volLabel.textColor = COLOR_RED;
        _volLabel.font = [UIFont systemFontOfSize:12];
    }
    return _volLabel;
}

#pragma mark  最高成交量
-(UILabel *)maxVolLabel {
    if (!_maxVolLabel) {
        _maxVolLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 12)];
        _maxVolLabel.textColor = COLOR_DARKGRAY;
        _maxVolLabel.font = [UIFont systemFontOfSize:12];
    }
    return _maxVolLabel;
}


#pragma mark  点击横屏操作
- (void)tap {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
    }];
}





- (void)requestFiveDaysData {
    NSString *url = @"http://dev-tnhq.tpyzq.com/hqserver/http/newGet";
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSMutableDictionary *paramsDic = @{}.mutableCopy;
    [paramsDic setValue:@"11600368" forKey:@"code"];
    [dic setValue:@"HQING018" forKey:@"FUNCTIONCODE"];
    [dic setValue:JSON_STR(paramsDic) forKey:@"PARAMS"];
    uWeakSelf
    [DataEmit requestGetTodayListParams:dic url:url successCompletionBlock:^(NSMutableArray *modelArray, NSInteger distanceTime, BOOL isSuccess) {
        if (modelArray.count > 0) {
//            [weakSelf dealWithLineChartData:modelArray.firstObject];
//            [weakSelf dealWithBarChartData:modelArray.firstObject];
        }
    } failueCompletionBlock:^(NSError *error) {
        
    }];
}

- (void)requestTimeDivisionData {
    NSLog(@"请求数据。。。。");
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSMutableDictionary *paramsDic = @{}.mutableCopy;
    [paramsDic setObject:@"1" forKey:@"market"];//
    if (_lastTime == nil || [_lastTime isEqualToString:@"0"]) {
        _lastTime = TIME;
    }
    [paramsDic setObject:_lastTime forKey:@"time"];
    [paramsDic setObject:@"0" forKey:@"type"];
    [dic setObject:@"HQING003" forKey:@"FUNCTIONCODE"];
    [paramsDic setObject:@"11600368" forKey:@"stockcode"];//  21000543  2 ,11600368 1
    [dic setObject:JSON_STR(paramsDic) forKey:@"PARAMS"];
    
    //http://dev-tnhq.tpyzq.com:80/hqserver/http/newGet
    
    
    uWeakSelf
    [DataEmit requestGetPriceToListParams:dic url:@"http://dev-tnhq.tpyzq.com/hqserver/http/newGet" successCompletionBlock:^(NSMutableArray *modelArray, NSInteger distanceTime) {
        [weakSelf timerControlWithTimeInterval:distanceTime == 0 ? 3 : labs(distanceTime)];
        if (modelArray.count > 0) {
            [weakSelf dealWithLineChartData:modelArray.firstObject];
            [weakSelf dealWithBarChartData:modelArray.firstObject];
        }else{
        }
        
    }failueCompletionBlock:^(NSError *error) {
        [weakSelf timerControlWithTimeInterval:4.f];
    }];
}

- (void)timerControlWithTimeInterval:(NSTimeInterval)timeInterval {
    uWeakSelf
    if (!self.timer) {
        self.timer = [NSTimer zl_scheduledTimerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf requestTimeDivisionData];
        }];
    }
    
}

- (void)dealWithFiveDaysLineChartData:(GetPriceToListModel *)model {
    
}

- (void)dealWithLineChartData:(GetPriceToListModel *)model {
    NSMutableArray *yAxis1Arr = [[NSMutableArray alloc]init];
    [model.timeDivision enumerateObjectsUsingBlock:^(TimeDivisionModel * _Nonnull tdModel, NSUInteger idx, BOOL * _Nonnull stop) {
        ChartDataEntry *entry1 = [[ChartDataEntry alloc]initWithX:idx y:[[DecimalNumber decimalTwoNumber:tdModel.price] doubleValue]];
        [yAxis1Arr addObject:entry1];
    }];
    
    double prePrice = [model.beforeClosePrice floatValue];//昨收价
    double highPrice = [model.high floatValue];//最高价
    double lowPrice = [model.low floatValue];//最低价
    double diff = MAX(fabs(highPrice - prePrice), fabs(prePrice - lowPrice));
    double maxPrice = prePrice + diff;//左Y轴最大值（价格）
    double minPrice = prePrice - diff;//左Y轴最小值（价格）
    double maxChgPrice = diff/prePrice * 100;//右Y轴最大值（涨跌幅）
    double minChgPrice = -maxChgPrice;//右Y轴最小值（涨跌幅）
    
    _combinedChartView.leftAxis.axisMaximum = maxPrice;
    _combinedChartView.leftAxis.axisMinimum = minPrice;
    _combinedChartView.rightAxis.axisMaximum = maxChgPrice;
    _combinedChartView.rightAxis.axisMinimum = minChgPrice;
    _combinedChartView.xAxis.axisMaximum = 241;
    
    LineChartDataSet *set1;
    set1 = [[LineChartDataSet alloc]initWithValues:yAxis1Arr];
    set1.lineWidth = KSINGLELINE_WIDTH;//设置绘制的线宽
    [set1 setColor:COLOR_BLUE];//设置绘制的线的颜色
    set1.axisDependency = AxisDependencyLeft;//以左边坐标轴为准
    set1.drawCirclesEnabled = NO;//在节点处不绘制圆圈
    set1.drawValuesEnabled = NO;//是否在节点处显示数值
    set1.drawFilledEnabled = YES;//与X轴之间是否填充
    set1.fillColor = COLOR_LIGHT_BLUE;//与X轴之间的填充色
    set1.highlightColor = COLOR_DARK;//十字线颜色
    set1.highlightLineWidth = 1;//十字线线宽
    LineChartData *lineData = [[LineChartData alloc]initWithDataSet:set1];
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.lineData = lineData;
    _combinedChartView.data = data;
}

- (void)dealWithBarChartData:(GetPriceToListModel *)model {
    NSMutableArray *yAxisArr1 = @[].mutableCopy;
    NSMutableArray *colorsArr = @[].mutableCopy;
    __block double lastAmount = 0;
    __block double maxAmount = 0;//最高成交量
    __block double lastPrice = [model.beforeClosePrice doubleValue];
    [model.timeDivision enumerateObjectsUsingBlock:^(TimeDivisionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        double diffPrice = [obj.price doubleValue] - lastPrice;
        lastPrice = [obj.price doubleValue];
        //obj.amount如果是小于等于lastAmount，是否currentAmount为0,应该是不能为负数的
        double currentAmount = [obj.amount doubleValue] <= lastAmount ? 0 : ([obj.amount doubleValue] - lastAmount);
        //        double currentAmount = [obj.amount doubleValue] - lastAmount;
        maxAmount = maxAmount > currentAmount ? maxAmount : currentAmount;
        BarChartDataEntry *entry = [[BarChartDataEntry alloc]initWithX:idx y:currentAmount];
        //        BarChartDataEntry *entry = [[BarChartDataEntry alloc]initWithX:idx y:currentAmount data:@(diffPrice)];
        [yAxisArr1 addObject:entry];
        lastAmount = [obj.amount doubleValue];
        [colorsArr addObject:[ZLChartsUtil colorWithValue:diffPrice]];
        
        if (idx == model.timeDivision.count - 1) {
            self.volLabel.text = kString_Format(@"成交量：%.f",currentAmount);
        }
    }];
    self.maxVolLabel.text = kString_Format(@"最高成交量：%.f",maxAmount);
    
    _barChartView.leftAxis.axisMinimum = 0;
    _barChartView.leftAxis.axisMaximum = maxAmount;
    _barChartView.xAxis.axisMaximum = 241;
    
    BarChartDataSet *set1;
    set1 = [[BarChartDataSet alloc]initWithValues:yAxisArr1];
    set1.colors = colorsArr;
    set1.highlightEnabled = YES;
    set1.highlightColor = COLOR_DARK;
    set1.highlightLineWidth = 1;
    set1.drawValuesEnabled = NO;
    
    BarChartData *data = [[BarChartData alloc]initWithDataSet:set1];
    _barChartView.data = data;
    
    
}





@end
