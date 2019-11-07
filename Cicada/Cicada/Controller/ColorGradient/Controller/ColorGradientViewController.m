//
//  ColorGradientViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/10/9.
//  Copyright © 2017年 com. All rights reserved.
//

#import "ColorGradientViewController.h"

#define kString_Format(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]
@interface ColorGradientViewController ()

@end

@implementation ColorGradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;

    // Do any additional setup after loading the view.
    /*
    NSString *str1 = @"1000000000.00";
    NSString *str2 = @"999950000.00";
    NSString *str3 = @"0";

    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc]initWithRoundingMode:NSRoundDown scale:2.0f raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *currentDN = [NSDecimalNumber decimalNumberWithString:str2];
    NSDecimalNumber *resCurrentDN = [currentDN decimalNumberByRoundingAccordingToBehavior:handler];
    NSString *currentStr = kString_Format(@"%@",resCurrentDN);
    NSLog(@"%@",currentStr);
    
    NSArray *amountArr = @[kString_Format(@"当前数量:%.f",[str1 ? str1 : @"" floatValue]),
                           kString_Format(@"可用数量:%.f",[str2 ? str2 : @"" floatValue]),
                           kString_Format(@"冻结数量:%.f",[str3 ? str3 : @"" floatValue])];
    NSArray *sortArr = [amountArr sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return [ToolHelper sizeForNoticeTitle:obj1 font:[UIFont systemFontOfSize:13]].width < [ToolHelper sizeForNoticeTitle:obj2 font:[UIFont systemFontOfSize:13]].width;
        //
    }];
    */
    
    
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    //FF3E83
    UIView *gradientView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 244)];
    gradientView.backgroundColor = COLOR_BACK;
    [self.view addSubview:gradientView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = gradientView.bounds;
    gradientLayer.colors = @[(id)[ToolHelper colorWithHexString:@"#FF3E83"].CGColor,(id)[ToolHelper colorWithHexString:@"#FF1818"].CGColor];
    gradientLayer.locations = @[@(0.2f),@(0.8f)];
    gradientLayer.startPoint = CGPointMake(0.2, 0);
    gradientLayer.endPoint = CGPointMake(1.8, 1);
    [gradientView.layer addSublayer:gradientLayer];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(0, 232)];
    [bezierPath addCurveToPoint:CGPointMake(375, 224) controlPoint1:CGPointMake(92, 204) controlPoint2:CGPointMake(264, 264)];
    [bezierPath addLineToPoint:CGPointMake(375, 244)];
    [bezierPath addLineToPoint:CGPointMake(0, 244)];
    [bezierPath addLineToPoint:CGPointMake(0, 232)];

    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = COLOR_WHITE.CGColor;
    shapeLayer.fillColor = COLOR_WHITE.CGColor;
    [gradientView.layer addSublayer:shapeLayer];
    
    UIView *brokenLineView = [[UIView alloc]initWithFrame:CGRectMake(0, gradientView.bottom + 20, kScreenWidth, 150)];
    brokenLineView.backgroundColor = COLOR_BACK;
    [self.view addSubview:brokenLineView];
    CGFloat spaceL = 20;
    CGFloat spaceT = 20;
    CGFloat width = kScreenWidth - spaceL * 2;
    CGFloat height = 150 - spaceT * 2;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(spaceL + width/3, spaceT)];
    [path addLineToPoint:CGPointMake(spaceL, spaceT)];
    [path addLineToPoint:CGPointMake(spaceL, spaceT + height)];
    [path addLineToPoint:CGPointMake(kScreenWidth - spaceL, spaceT + height)];
    [path addLineToPoint:CGPointMake(kScreenWidth - spaceL, spaceT)];
    [path addLineToPoint:CGPointMake(spaceL + width/3, spaceT)];
    [path addLineToPoint:CGPointMake(spaceL + width * 2/3, spaceT + height)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    layer.strokeColor = COLOR_DARKGRAY.CGColor;
    layer.fillColor = COLOR_WHITE.CGColor;
    [brokenLineView.layer addSublayer:layer];
    
    
}

//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
//
//}


-(void)loadView {
    [super loadView];
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
