//
//  TestRuntimeViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/6/8.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TestRuntimeViewController.h"
#import "TestRuntimeClang.h"
#import <objc/runtime.h>
#import "UIImage+Image.h"
#import "NSObject+Property.h"
#import <objc/message.h>
#import "Cicada-Swift.h"

@interface TestRuntimeViewController ()

@end

@implementation TestRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    PieChartView *view = [[PieChartView alloc]init];
    // Do any additional setup after loading the view.
    
    //    BuildSetting->msg (默认YES，置为NO)
    //    TestRuntimeClang *runtimeClang = [[TestRuntimeClang alloc]init];
    TestRuntimeClang *runtimeClang = objc_msgSend(objc_getClass("TestRuntimeClang"),sel_registerName("alloc"));
    runtimeClang = objc_msgSend(runtimeClang,sel_registerName("init"));
    //
    
    ((void (*)(id,SEL)) objc_msgSend)(runtimeClang,sel_registerName("showAge"));
    ((void (*)(id,SEL,NSString *)) objc_msgSend)(runtimeClang,sel_registerName("showName:"),@"打印Cicada");
    ((void (*)(id,SEL,float,float)) objc_msgSend)(runtimeClang,sel_registerName("showWidth:andHeight:"),40,77);
    //    ((NSString * (*)(id,SEL)) objc_msgSend)(runtimeClang,sel_registerName("getName"));
    NSString *str = ((NSString * (*)(id,SEL)) objc_msgSend)(runtimeClang,sel_registerName("getName"));
    NSLog(@"....%@",str);
    
    
    /*********************    Runtime 交换方法    *****************/
    //资源里存在 life_add 图片，所以加载成功；不存在 noImageCicada 图片，所以加载失败
    //要在系统的imageNamed方法调用前改变两个方法的地址指向，所以应该在load方法里边交换地址指向（load方法在把类加载进内存时调用，且只会调用一次）
    UIImage *image = [UIImage imageNamed:@"life_add"];
    
    UIImage *noImage = [UIImage imageNamed:@"noImageCicada"];
    
    
    /*********************    Runtime 给分类添加属性    *******************/
    NSObject *object = [[NSObject alloc]init];
    object.name = @"cicada";
    NSLog(@"给object增加属性name:%@",object.name);

    
    //没有实现方法run:方法，可以通过performSelector调用，但会报错，但使用动态添加方法就不会报错
    [runtimeClang performSelector:@selector(run:) withObject:@10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
