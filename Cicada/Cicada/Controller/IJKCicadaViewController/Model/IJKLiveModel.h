//
//  IJKLiveModel.h
//  Cicada
//
//  Created by 张琦 on 2017/6/1.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IJKLiveCreatorModel;
@interface IJKLiveModel : NSObject


/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) IJKLiveCreatorModel *creator;

@end
