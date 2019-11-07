//
//  NSString+Calculate.h
//  Cicada
//
//  Created by 吴肖利 on 2019/7/3.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Calculate)

- (NSString *)CicadaCaculateKeepFiguresByRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale;

- (NSString *)CicadaCalculateDefault;

@end

NS_ASSUME_NONNULL_END
