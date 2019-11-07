//
//  TestRuntimeClang.m
//  Cicada
//
//  Created by 张琦 on 2017/6/6.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TestRuntimeClang.h"
#import <objc/runtime.h>

@implementation TestRuntimeClang


/**********
 
 static id _I_TestRuntimeClang_init(TestRuntimeClang * self, SEL _cmd) {
 if (self = ((TestRuntimeClang *(*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("TestRuntimeClang"))}, sel_registerName("init"))) {
 ((void (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("showAge"));
 }
 return self;
 }
 
 ***********/
//- (id)init {
//    if (self = [super init]) {
//        [self showAge];
//    }
//    return self;
//}

- (void)showAge {
    NSLog(@"Cicada");
}

- (void)showName:(NSString *)name {
    NSLog(@"%@",name);
}

- (void)showWidth:(float)width andHeight:(float)height {
    NSLog(@"width:%f,height:%f",width,height);
}

- (NSString *)getName {
    return @"***Cicada";
}



/************************   动态添加方法   **********************/

//没有返回值，一个参数
//void (id ,SEL)
void aaa (id self,SEL _cmd,NSNumber *meter) {

    NSLog(@"%@米",meter);

}


//任何方法默认都有两个隐式参数，self,_cmd(当前方法的方法编号)
//什么时候调用：只要一个对象调用了一个未实现的方法就会调用该方法进行处理
//方法的作用：动态添加方法，处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == NSSelectorFromString(@"run:")) {
        //        class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
        //Types Encoding 文档地址：https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
        //使用IMP可以直接找到地址
        
        // 动态添加run方法
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法，即添加方法的方法编号
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名（添加方法的函数实现（函数地址））
        // type: 方法类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        
        /********* 比如要添加的方法如下
         方法：
        int say(id self, SEL _cmd, NSString *str) {
            NSLog(@"%@", str);
            return 100;//随便返回个值
        }
         那么class_addMethod：
         class_addMethod(self, sel, (IMP)say, "i@:@");
         
         i：返回值类型int，若是v则表示void
         @：参数id(self)
         :：SEL(_cmd)
         @：id(str)
         ********/
        
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}





@end
