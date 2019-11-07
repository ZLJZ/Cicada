//
//  UIImage+Image.m
//  Cicada
//
//  Created by 张琦 on 2017/6/7.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>
@implementation UIImage (Image)

+(void)load {
    Method imageNamed = class_getClassMethod(self, @selector(imageNamed:));
    Method wxlImageNamed = class_getClassMethod(self, @selector(wxlImageNamed:));
    method_exchangeImplementations(imageNamed, wxlImageNamed);
}

+ (UIImage *)wxlImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage wxlImageNamed:imageName];
    if (image) {
        //
        NSLog(@"加载成功");
    } else {
        //
        NSLog(@"加载失败");
    }
    return image;
}

@end
