//
//  UIViewController+WXLViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/4/17.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UIViewController+WXLViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (WXLViewController)
/**
 * 利用静态变量地址唯一不变的特性
 */
static NSString *alphaKey = @"WXLAlphaKey";


- (void)setAlphaStr:(NSString *)alphaStr {
    /**
     * OBJC_ASSOCIATION_ASSIGN = 0,             //关联对象的属性是弱引用
     * OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   //关联对象的属性是强引用，并且关联对象不使用原子性
     * OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     //关联对象的属性是copy，并且关联对象不使用原子性
     * OBJC_ASSOCIATION_RETAIN = 01401,         //关联对象的属性是强引用，并且关联对象使用原子性
     * OBJC_ASSOCIATION_COPY = 01403            //关联对象的属性是copy，并且关联对象使用原子性
     */
    
    /**
     * objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
     * @param1 : 源对象
     * @param2 : 关联时用来标记是哪一个属性的key(因为可能会添加多个属性)
     * @param3 : 关联的对象
     * @param4 : 关联的策略
     */
    objc_setAssociatedObject(self, &alphaKey, alphaStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark  getter方法
- (NSString *)alphaStr {
    return objc_getAssociatedObject(self, &alphaKey);
}

@end
