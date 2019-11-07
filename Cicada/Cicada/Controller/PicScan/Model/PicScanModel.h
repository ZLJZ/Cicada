//
//  PicScanModel.h
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicScanModel : NSObject

//图片名称
@property (nonatomic, copy) NSString *picName;
//图片标题
@property (nonatomic, copy) NSString *picTitle;
//等级
@property (nonatomic, copy) NSString *level;
//是否订阅
@property (nonatomic, copy) NSString *isSubscribe;



@end
