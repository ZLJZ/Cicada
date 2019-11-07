//
//  NSObject+Property.m
//  Cicada
//
//  Created by 张琦 on 2017/6/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
@implementation NSObject (Property)

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, "name");
}

@end
