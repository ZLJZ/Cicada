//
//  RootViewController.m
//  BezierPathDemo
//  进度条
//  Created by 张琦 on 2017/3/6.
//  Copyright © 2017年 com. All rights reserved.
//

#import "ProgressBarViewController.h"
#import "CircleProgressBarView.h"
#import "DialView.h"
#import "DotView.h"
#import "TestView.h"
#import <objc/runtime.h>


@interface Speak ()

@property (nonatomic, copy) NSString *name;

@end
@implementation Speak

- (void)speakA {
    NSLog(@"My name is %@",self.name);
}

@end

@interface ProgressBarViewController ()

@property (nonatomic ,strong) CAShapeLayer *shapeLayer;
@property (nonatomic ,strong)  CAShapeLayer *bottomShapeLayer;

@property (nonatomic ,strong) CircleProgressBarView *bottomProgressBarView;

@property (nonatomic ,strong) CircleProgressBarView *progressBarView;

@end

@implementation ProgressBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *jsonData = @{@"radialWarningValue" : @"0.762"};
    NSLog([jsonData isKindOfClass:[NSDictionary class]] ? @"YES" : @"NO");
    NSString *printString1 = (NSString*)[jsonData valueForKey:@"radialWarningValue"];
    NSString *printString2 = @"0.762";
    NSLog([printString1 isEqualToString:printString2] ? @"YES" : @"NO");
    
    //这种形式创建的都是在常量区
//    NSString *str0 = @"qwerewerfiuwbevibwevievieh归还世界给你归还世界给你归还世界给你归还世界给你归还世界给你归还世界给你归还世界给你归还世界给你";
//
////    NSString *str = [NSString stringWithFormat:@"aaaaaaaaaa"];
//
//    NSString *str1 = [NSString stringWithUTF8String:"a"];
//
    
    NSArray *arr = @[@"laji",@"haishilaji"];
    NSArray *copyArr = [arr copy];
    NSMutableArray *mulCopyArr = [arr mutableCopy];
    
    NSMutableArray *arr1 = @[@"laji",@"doushilaji"].mutableCopy;
    NSArray *copyArr1 = [arr1 copy];
    NSMutableArray *mulCopyArr1 = [arr1 mutableCopy];
    
    /**
     NSArray：
     copy是浅拷贝，内存地址相同
     mutableCopy是深拷贝，内存地址不同，得到的是一个新的可变数组
     NSMutableArray：
     copy是深拷贝，内存地址不同，得到一个新的不可变数组
     mutableCopy是深拷贝，内存地址不同，得到的是一个新的可变数组
     */
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    id cls = [Speak class];
    void *obj = &cls;
    [(__bridge id)obj speakA];
    
    return;
    // Do any additional setup after loading the view.
    
//    TestView *tView = [[TestView alloc]init];
//    tView.frame = CGRectMake(10, 100, 100, 100);
//    tView.backgroundColor = COLOR_GREEN;
//    [self.view addSubview:tView];
    
    
    TestView *tView = [[TestView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    tView.backgroundColor = COLOR_GREEN;
    [self.view addSubview:tView];
    
    return;
    
//    CGContextRef
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : COLOR_YELLOW};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"如果你认识从前的我，你会原谅现在的我。"];
    [attrStr setAttributes:dic range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(8, 1)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:COLOR_RED range:NSMakeRange(attrStr.length - 2, 1)];
    
    [attrStr removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(3, 2)];
    [attrStr removeAttribute:NSFontAttributeName range:NSMakeRange(12, 2)];
    
    label.attributedText = attrStr;
    
    return;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
    
    return;
    
    /* 测试 colorWithPatternImage 的内存占用问题 在iphone7上和下面的方法没有什么差别
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReverseRepoBg"]];
    //
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [UIImage imageNamed:@"ReverseRepoBg"];
    [self.view addSubview:imageView];
     */
    
    //创建圆形进度条**
    [self createCircleProgressBar];
    
    NSString *numStr = @"2222222";
    BOOL isNum1 = [ToolHelper validateNumber:numStr];
    if (isNum1) {
        NSLog(@"validateNumber----是数字");
    } else {
        NSLog(@"validateNumber----不是数字");
    }
    
    BOOL isNum2 = [ToolHelper isNumText:numStr];
    if (isNum2) {
        NSLog(@"isNumText----是数字");
    } else {
        NSLog(@"isNumText----不是数字");
    }
    
}



#pragma mark 创建圆形进度条
- (void)createCircleProgressBar {
    _bottomProgressBarView = [[CircleProgressBarView alloc]initWithFrame:CGRectMake(0, 0, 40, 40) lineWidth:2 strokeColor:[UIColor colorWithWhite:1 alpha:0.2] fillColor:[UIColor clearColor] startAngle:0 endAngle:2 * M_PI lineCapType:kCALineCapRound];
    _bottomProgressBarView.center = self.view.center;
    [_bottomProgressBarView setStrokeEnd:1];
    [self.view addSubview:_bottomProgressBarView];
    
    _progressBarView = [[CircleProgressBarView alloc]initWithFrame:CGRectMake(0, 0, 40, 40) lineWidth:2 strokeColor:UIColor.whiteColor fillColor:[UIColor clearColor] startAngle:(3 * M_PI) / 2 endAngle:2 * M_PI lineCapType:kCALineCapRound];
    _progressBarView.center = self.view.center;
    [self.view addSubview:_progressBarView];
    
    [_progressBarView setAnimated:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_progressBarView setAnimated:NO];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
