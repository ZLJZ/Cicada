//
//  NSString+Calculate.m
//  Cicada
//
//  Created by 吴肖利 on 2019/7/3.
//  Copyright © 2019 com. All rights reserved.
//

#import "NSString+Calculate.h"

@implementation NSString (Calculate)

- (NSString *)CicadaCaculateKeepFiguresByRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale {
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *resNumber = [number1 decimalNumberByRoundingAccordingToBehavior:behavior];
    
    NSMutableString *formatterString = scale == 0 ? @"".mutableCopy : @"0.".mutableCopy;
    for (NSInteger i = 0; i < scale; ++i) {
        [formatterString appendString:@"0"];
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:formatterString];
    return [formatter stringFromNumber:resNumber];
}

- (NSNumber *)CicadaCalculateDefault {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:1];
    [formatter setMaximumFractionDigits:MAXFLOAT];
    NSNumber *num = [formatter numberFromString:self];
    return [formatter stringFromNumber:num];
}

@end
