//
//  WXLKeyboard.h
//  Cicada
//
//  Created by 张琦 on 2017/7/19.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KeyboardBlock)(NSString *text,UITextField *textField);
@interface WXLKeyboard : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIView *numView;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, copy) KeyboardBlock keyboardBlock;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, assign) BOOL isCap;


- (id)initWithFrame:(CGRect)frame textField:(UITextField *)textField keyboardBlock:(KeyboardBlock)keyboardBlock;
@end
