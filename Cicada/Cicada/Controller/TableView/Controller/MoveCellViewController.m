//
//  MoveCellViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/9/29.
//  Copyright © 2017年 com. All rights reserved.
//

#import "MoveCellViewController.h"
#import <objc/runtime.h>
@interface MoveCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MoveCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
//    [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //
//    }];
    
//    NSNumber *intNumber = [NSNumber numberWithInt:1];
//    NSNumber *intNumberN = @1;
//
//    NSNumber *floatNumber = [NSNumber numberWithFloat:3.2];
//    NSNumber *floatNumberN = @3.2f;
//
//    NSNumber *boolNumber = [NSNumber numberWithBool:YES];
//    NSNumber *boolNumberN = @YES;
//
//    NSNumber *charNumber = [NSNumber numberWithChar:'a'];
//    NSNumber *charNumberN = @'a';
//
//
//    NSLog(@"%@  %@  %@  %@",intNumber,floatNumber,boolNumber,charNumber);
//    NSLog(@"%@  %@  %@  %@",intNumberN,floatNumberN,boolNumberN,charNumberN);
//
//    int a = 2;
//    float b = 3.5;
//    NSNumber *mulNumber = @(a*b);
//    NSLog(@"%@",mulNumber);
//
//    id object1 = @"1";
//    id object2 = nil;
//    id object3 = @"3";
//    NSArray *arrayA = [NSArray arrayWithObjects:object1,object2,object3, nil];
//    NSLog(@"%@",arrayA);
//
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"obj1",@"key1",@"obj2",@"key2", nil];
//    NSLog(@"%@",dic);
    
    NSString *strA = @"cicada";
//    NSString *strB = strA;
    NSString *strB = [NSString stringWithFormat:@"%@",@"cicada"];
    BOOL isEqual1 = (strA == strB);
    BOOL isEqual2 = [strA isEqual:strB];
    BOOL isEqual3 = [strA isEqualToString:strB];
    
    //打印strA和strB的内存地址  控制台使用：p strA 命令打印结果为：(__NSCFConstantString *) $0 = 0x0000000102fa43a8 @"cicada",可以看到类型，地址及字符串值
    NSLog(@"\n strA:%p\n strB:%p",strA,strB);
    //布尔值打印 %d 0：NO  1：true   目前没有发现布尔值占位符
    NSLog(@"\n isEqual1:%d\n isEqual2:%d\n isEqual3:%d\n",isEqual1,isEqual2,isEqual3);
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIButton class], &count);
    Ivar ivar = ivars[100];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
