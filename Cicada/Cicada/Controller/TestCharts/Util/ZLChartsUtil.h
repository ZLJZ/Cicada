//
//  ZLChartsUtil.h
//  Cicada
//
//  Created by 吴肖利 on 2019/7/5.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLChartsHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLChartsUtil : NSObject

//X轴点数
+ (CGFloat)getXAxisMaxValueByLineType:(ZLLineType)lineType;

//颜色处理
+ (UIColor *)colorWithValue:(double)value;

@end

NS_ASSUME_NONNULL_END
