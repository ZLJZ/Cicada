//
//  FinancialCalendarViewController.m
//  Cicada
//
//  Created by 吴肖利 on 2018/9/26.
//  Copyright © 2018 com. All rights reserved.
//

#import "FinancialCalendarViewController.h"
#import "FSCalendar-umbrella.h"
#import "FinancialCalendarCell.h"

@interface FinancialCalendarViewController ()<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance>
//日历view
@property (nonatomic,strong) FSCalendar *calendar;
//上一发售日
@property (nonatomic, strong) UIButton *leftButton;
//下一发售日
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *displayLabel;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSCalendar *gregorianCalendar;

@end

@implementation FinancialCalendarViewController


/**
 得到的数据最好按顺序进行排列
 进入到该页面如果没有请求回来数据，应该该页面显示三无吧。。。。
 **/




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACK;
    self.gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

    [self.view addSubview:self.headView];
    
    //根据数据默认初始化设置
    if ([self.gregorianCalendar isDate:self.dataSource[0] inSameDayAsDate:[NSDate date]]) {
        if (self.dataSource.count >= 2) {
            [self.rightButton setTitle:kString_Format(@"%@日发售",@"9") forState:UIControlStateNormal];
        }
        self.displayLabel.text = @"今日发售";
    } else {
        if (self.dataSource.count >= 2) {
            [self.rightButton setTitle:kString_Format(@"%@日发售",@"10") forState:UIControlStateNormal];
        }
        self.displayLabel.text = @"9日发售";
    }
}

-(FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth - 20, 78)];
//        _calendar.firstWeekday = 2;//
        _calendar.backgroundColor = COLOR_WHITE;
        _calendar.delegate = self;
        _calendar.dataSource = self;
        _calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
 //        _calendar.allowsMultipleSelection = YES;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        _calendar.calendarHeaderView.hidden = YES;
        _calendar.headerHeight = 15;
        _calendar.appearance.weekdayFont = [UIFont systemFontOfSize:15];
        _calendar.appearance.titleFont = [UIFont systemFontOfSize:15];
        _calendar.appearance.weekdayTextColor = COLOR_DARKGRAY;
        _calendar.weekdayHeight = 15;
        _calendar.bottomBorder.hidden = YES;//隐藏底部分割线
        //设置周六和周日的文字颜色
        _calendar.calendarWeekdayView.weekdayLabels[0].textColor = COLOR_LIGHTGRAY;
        _calendar.calendarWeekdayView.weekdayLabels[6].textColor = COLOR_LIGHTGRAY;
        [_calendar registerClass:[FinancialCalendarCell class] forCellReuseIdentifier:NSStringFromClass([FinancialCalendarCell class])];
        if (self.dataSource) {
            [_calendar selectDate:self.dataSource[0]];
        }
    }
    return _calendar;
}

-(void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {

    /*
     坑爹啊。。。。。
     设置collectionView的高度，因为daysContainer为collectionView的父视图，所以其高度也必须设置，设置完必须reloadData，不然不会生效的啊啊啊啊啊，简直被自己蠢哭了。。
     这三个的高度都必须设置。。。
     */
    self.calendar.contentView.height = 78;
    self.calendar.daysContainer.height = 50;
    self.calendar.collectionView.height = 50;
    [self.calendar reloadData];

}

-(FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
    FinancialCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:NSStringFromClass([FinancialCalendarCell class]) forDate:date atMonthPosition:position];
    return cell;
}

-(void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    cell.layer.bounds = CGRectMake(0, 0, 26, 26);
}



//-(CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance imageOffsetForDate:(NSDate *)date {
//    return CGPointMake(0, 10);
//}

//-(CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleOffsetForDate:(NSDate *)date {
//    return CGPointMake(0, 10);
//}

//-(CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventOffsetForDate:(NSDate *)date {
//    return CGPointMake(0, 4);
//}


#pragma mark  默认title颜色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    //没有数据的日期和非交易日用周末颜色标志，禁止点击
    for (NSDate *obj in self.dataSource) {
        if ([self.gregorianCalendar isDate:obj inSameDayAsDate:date]) {
            return COLOR_DARKGRAY;
        }
    }
    return COLOR_LIGHTGRAY;
}

#pragma mark  选中title颜色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    return COLOR_WHITE;
}

#pragma mark  默认填充色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    
    return COLOR_CLEAR;
}

#pragma mark  选中填充色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date {
    return COLOR_YELLOW;
}

#pragma mark  默认边框色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date {
    for (NSDate *obj in self.dataSource) {
        if ([self.gregorianCalendar isDate:obj inSameDayAsDate:date]) {
            return COLOR_YELLOW;
        }
    }
    return COLOR_CLEAR;
}
#pragma mark  选中边框色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date {
    return COLOR_YELLOW;
}

#pragma mark  默认事件的颜色
-(NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date {
    for (NSDate *obj in self.dataSource) {
        if ([self.gregorianCalendar isDate:obj inSameDayAsDate:date]) {
            return @[COLOR_RED,COLOR_YELLOW];
        }
    }
    return @[COLOR_CLEAR,COLOR_CLEAR];
}

#pragma mark  选中事件的颜色
-(NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventSelectionColorsForDate:(NSDate *)date {
    return @[COLOR_RED,COLOR_YELLOW];
}

#pragma mark  事件显示的个数
-(NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
    //事件显示的个数由接口返回数据决定
    return 2;
}

-(BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    for (NSDate *obj in self.dataSource) {
        if ([self.gregorianCalendar isDate:obj inSameDayAsDate:date]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    //设置不能取消选中
    return NO;
}

-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    //记录当前选中的日期所在的星期，当滑到其他月时，图片上的日期要变为对应上次记录的星期所在的月
    //记录星期几   如果滑动后某个日期对应转完星期一致，则显示这个日期对应的月  willDisplay
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"EEEE";
    NSString *weekStr = [dateFormatter stringFromDate:date];
    dateFormatter.dateFormat = @"MMMM";
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *enStr = [dateFormatter stringFromDate:date];
    
    dateFormatter.dateFormat = @"MM";
    NSString *numberStr = [dateFormatter stringFromDate:date];
}

-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 238)];
        _headView.backgroundColor = COLOR_WHITE;
        
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 178)];
        shadowView.layer.shadowColor = COLOR_LIGHTGRAY.CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        shadowView.layer.shadowOpacity = 0.5;
        shadowView.layer.shadowRadius = 5;
        [_headView addSubview:shadowView];
        
        UIView *calendarBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, shadowView.width, shadowView.height)];
        calendarBackView.backgroundColor = COLOR_WHITE;
        [shadowView addSubview:calendarBackView];
        calendarBackView.layer.cornerRadius = 10;
        calendarBackView.layer.masksToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, calendarBackView.width, 100)];
        imageView.backgroundColor = COLOR_LIGHTGRAY;
        [calendarBackView addSubview:imageView];
        [calendarBackView addSubview:self.calendar];
        [_headView addSubview:self.leftButton];
        [_headView addSubview:self.rightButton];
        [_headView addSubview:self.displayLabel];
    }
    return _headView;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        NSArray *dateArr = @[@"2018-10-08",@"2018-10-10",@"2018-10-09",@"2018-10-17"];
        [dateArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            [_dataSource addObject:[dateFormatter dateFromString:obj]];
        }];
        NSArray *sortedArr = [_dataSource sortedArrayUsingComparator:^NSComparisonResult(NSDate *  _Nonnull obj1, NSDate *  _Nonnull obj2) {
            
            if ([obj1 compare:obj2] == NSOrderedAscending) {
                return NSOrderedAscending;
            } else if ([obj1 compare:obj2] == NSOrderedDescending) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
        _dataSource = sortedArr.mutableCopy;
    }
    return _dataSource;
}

//如果是nearstDate则左侧翻动功能不可用
-(UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(10, self.headView.height - 50, 90, 50);
        _leftButton.backgroundColor = COLOR_RED;
        [_leftButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(self.headView.width - 100, self.headView.height - 50, 90, 50);
        _rightButton.backgroundColor = COLOR_BLUE;
        [_rightButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightButton;
}

-(UILabel *)displayLabel {
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.headView.width - 100)/2.0, self.headView.height - 50, 100, 50)];
        _displayLabel.backgroundColor = COLOR_YELLOW;
        _displayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _displayLabel;
}

- (void)clickEvent:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    [_calendar selectDate:[dateFormatter dateFromString:@"2018-10-17"]];
}


@end
