//
//  NSTimer+ZLTimerControl.h
//  Cicada
//
//  Created by 吴肖利 on 2018/9/3.
//  Copyright © 2018 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (ZLTimerControl)

+ (NSTimer *)zl_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
