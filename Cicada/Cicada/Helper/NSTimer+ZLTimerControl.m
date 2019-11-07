//
//  NSTimer+ZLTimerControl.m
//  Cicada
//
//  Created by 吴肖利 on 2018/9/3.
//  Copyright © 2018 com. All rights reserved.
//

#import "NSTimer+ZLTimerControl.h"

@implementation NSTimer (ZLTimerControl)

+ (NSTimer *)zl_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block {
    
    /**
     使用copy将block拷贝到堆上，避免稍后执行时可能就无效了
     将计时器所执行的任务封装成块，在调用计时器函数时，把它作为参数传递过去
     */
    return [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(zl_blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)zl_blockInvoke:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}



@end
