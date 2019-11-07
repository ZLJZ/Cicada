//
//  WXLKeyboard.m
//  Cicada
//
//  Created by 张琦 on 2017/7/19.
//  Copyright © 2017年 com. All rights reserved.
//

#import "WXLKeyboard.h"

#define LeftNumCount    5
#define RightNumCount   4
#define KSingleLine     1.0/([UIScreen mainScreen].scale)
#define AlphaSpace      5.0
#define HalfAlphaSpace  AlphaSpace/2.0
@interface WXLKeyboard ()
{
    NSArray *alphaArr;
    NSArray *capsArr;
}

@end
@implementation WXLKeyboard

- (id)initWithFrame:(CGRect)frame textField:(UITextField *)textField keyboardBlock:(KeyboardBlock)keyboardBlock {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_BACK_GRAY;
        [self createNumAlphaView:frame];
        _alphaView.hidden = YES;
        [self customNumberKeyboardButton];
        [self customAlphaKeyboardButton];
        _inputText = @"";
        _textField = textField;
        _textField.delegate = self;
        _keyboardBlock = keyboardBlock;
        [_textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
//        [_textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

/*
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSString *newStr = change[@"new"];
    NSString *oldStr = change[@"old"];

    if (oldStr.length >= newStr.length) {
        return;
    }
    
//    if ([[newStr substringToIndex:oldStr.length] isEqualToString:oldStr] && ![oldStr isEqualToString:@""]) {
//        return;
//    }
    if ([newStr isEqualToString:@""]) {
        return;
    }
    
    if ([oldStr isEqualToString:newStr]) {
        return;
    }
    UITextField *textField = (UITextField *)object;
    if (_textField == textField && [keyPath isEqualToString:@"text"]) {
        _inputText = change[@"new"];
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    }
   
}
 */

-(void)textFieldDidEndEditing:(UITextField *)textField {
    _inputText = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _inputText = textField.text;
}

- (void)textChange:(UITextField *)textField {
    _inputText = textField.text;
    if (_keyboardBlock) {
        _keyboardBlock(_inputText,textField);
    }
}

- (void)createNumAlphaView:(CGRect)frame {
    _numView = [[UIView alloc]initWithFrame:frame];
    _numView.backgroundColor = COLOR_BACK_GRAY;
    [self addSubview:_numView];
    _alphaView = [[UIView alloc]initWithFrame:frame];
    _alphaView.backgroundColor = COLOR_BACK_GRAY;
    [self addSubview:_alphaView];
}


- (void)customNumberKeyboardButton {
    CGFloat leftRowHeight = self.height/LeftNumCount;
    CGFloat btnWidth = self.width/LeftNumCount;
    NSArray *leftArr = @[@"600",@"601",@"000",@"002",@"300"];
    [leftArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        numBtn.frame = CGRectMake(0, leftRowHeight * idx, btnWidth, leftRowHeight);
        numBtn.backgroundColor = COLOR_KEYBOARD_GRAY;
        [numBtn setTitle:obj forState:UIControlStateNormal];
        [numBtn setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        numBtn.layer.borderWidth = KSingleLine;
        numBtn.layer.borderColor = COLOR_LINE_GRAY.CGColor;
        numBtn.tag = 7000 + idx;
        [numBtn addTarget:self action:@selector(clickNumButton:) forControlEvents:UIControlEventTouchUpInside];
        [_numView addSubview:numBtn];
    }];
    
    CGFloat rightRowHeight = self.height/RightNumCount;
    NSArray *rightArr = @[@[@"1",@"2",@"3",@"back-arrow"],
                          @[@"4",@"5",@"6",@"清空"],
                          @[@"7",@"8",@"9",@"收起"],
                          @[@"ABC",@"0",@".",@"确定"]];
    [rightArr enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        //
        [rightArr[i] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger j, BOOL * _Nonnull stop) {
            //
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnWidth * (j + 1), rightRowHeight * i, btnWidth, rightRowHeight);
            btn.backgroundColor = COLOR_WHITE;
            if (i == 0 && j == 3) {
                [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
            } else {
                [btn setTitle:obj forState:UIControlStateNormal];
            }
            if (i == 3 || j == 3) {
                btn.backgroundColor = COLOR_KEYBOARD_GRAY;
            }
            if (i == 3 && j == 1) {
                btn.backgroundColor = COLOR_WHITE;
            }
            if (i == 3 && j == 3) {
                btn.backgroundColor = COLOR_BLUE;
            }
            [btn setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            btn.layer.borderWidth = KSingleLine;
            btn.layer.borderColor = COLOR_LINE_GRAY.CGColor;
            btn.tag = 8000 + i * 4 + j;
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_numView addSubview:btn];
        }];
    }];
    
}

- (void)customAlphaKeyboardButton {
    
    CGFloat alphaWidth = (self.width - AlphaSpace * 10)/10.0;
    CGFloat alphaHeight = (self.height - AlphaSpace * 2 * 4)/4.0;
    CGFloat topY = alphaHeight + AlphaSpace * 2;
    alphaArr = @[@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"],
                          @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"],
                          @[@"",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@""],
                          @[@"123",@"收起",@"空格",@"确定"]];
    capsArr = @[@[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                         @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                         @[@"",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@""],
                         @[@"123",@"收起",@"空格",@"确定"]];
    NSArray*tempArr = alphaArr;//默认为小写
    
    CGFloat leftWidth = (self.width - 9 * alphaWidth - 8 * AlphaSpace)/2.0;//第二行字符两端的空隙宽
    CGFloat confirmW = (alphaWidth + AlphaSpace) * 2;//收起和确定按钮的宽
    CGFloat capW = alphaWidth + leftWidth - HalfAlphaSpace;//大小写，删除字符，切换数字字母按钮的宽
    CGFloat disW = alphaWidth + AlphaSpace;//字符按钮宽+空隙

    [tempArr enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        //
        [tempArr[i] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger j, BOOL * _Nonnull stop) {
            //
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = COLOR_WHITE;
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            btn.layer.cornerRadius = 5;
            if (i == 0) {
                btn.frame = CGRectMake(HalfAlphaSpace+ disW * j, AlphaSpace, alphaWidth, alphaHeight);
                btn.tag = 5000 + j;
            } else if (i == 1) {
                btn.frame = CGRectMake(leftWidth + disW * j, AlphaSpace + topY * i, alphaWidth, alphaHeight);
                btn.tag = 5001 + i * 9 + j;// 5010 5011 5012 5013 5014 5015 5016 5017 5018
            } else if (i == 2) {
                btn.tag = 5001 + i * 9 + j;// 5019 5020 5021 5022 5023 5024 5025 5026 5027

                if (j ==0) {
                    btn.frame = CGRectMake(HalfAlphaSpace,AlphaSpace + topY * i, capW, alphaHeight);
                    btn.backgroundColor = COLOR_KEYBOARD_GRAY;
                    [btn setImage:[UIImage imageNamed:@"up-arrow"] forState:UIControlStateNormal];
                } else if (j == 8) {
                    btn.frame = CGRectMake(leftWidth + disW * j, AlphaSpace + topY * i, capW, alphaHeight);
                    [btn setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
                    btn.backgroundColor = COLOR_KEYBOARD_GRAY;
                } else {
                    btn.frame = CGRectMake(leftWidth + disW * j, AlphaSpace + topY * i, alphaWidth, alphaHeight);
                }
            } else if (i == 3) {
                btn.backgroundColor = COLOR_KEYBOARD_GRAY;
                btn.tag = 5028 + j;
                if (j == 0) {
                    btn.frame = CGRectMake(HalfAlphaSpace, AlphaSpace + topY * i, capW, alphaHeight);
                } else if (j == 1) {
                    btn.frame = CGRectMake(capW + 2 * AlphaSpace, AlphaSpace + topY * i, confirmW, alphaHeight);
                } else if (j == 2) {
                    btn.frame = CGRectMake(capW + 3 * AlphaSpace + confirmW, AlphaSpace + topY * i, self.width - confirmW - AlphaSpace - HalfAlphaSpace - (capW + 3 * AlphaSpace + confirmW) , alphaHeight);
                    btn.backgroundColor = COLOR_WHITE;
                } else if (j == 3){
                    btn.frame = CGRectMake(self.width - confirmW - HalfAlphaSpace, AlphaSpace + topY * i, confirmW, alphaHeight);
                    btn.backgroundColor = COLOR_BLUE;
                    
                }
            }
            
            [btn addTarget:self action:@selector(clickAlphaButton:) forControlEvents:UIControlEventTouchUpInside];
            [_alphaView addSubview:btn];
        }];
    }];
}

- (void)clickAlphaButton:(UIButton *)sender {
    
    if (sender.tag == 5019) {//字母键盘 切换大小写
        _isCap = !_isCap;
        [self switchCase];
    } else if (sender.tag == 5027) {//字母键盘删除字符
        if (_inputText.length == 0) {
            return;
        }
        _inputText = [_inputText substringToIndex:_inputText.length - 1];
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    } else if (sender.tag == 5028) { //字母键盘点击123
        _isCap = NO;
        [self switchCase];
        _alphaView.hidden = YES;
        _numView.hidden = NO;
    } else if (sender.tag == 5029 || sender.tag == 5031) {//字母键盘点击收起和确定按钮
        [_textField endEditing:YES];
    } else if (sender.tag == 5030) {//
        _inputText = [_inputText stringByAppendingString:@" "];
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    } else {
        _inputText = [_inputText stringByAppendingString:sender.titleLabel.text];
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    }
    
}

- (void)switchCase {
    
    NSArray *tempArr = _isCap?capsArr:alphaArr;
    [_alphaView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (btn.tag == 5019) {
            [btn setImage:[UIImage imageNamed:_isCap?@"up-arrowafter":@"up-arrow"] forState:UIControlStateNormal];
        }
        NSInteger flag =  btn.tag - 5000;
        __block NSInteger count = 0;
        [tempArr enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (flag < obj.count + count && flag >= count) {
                [btn setTitle:obj[flag - count] forState:UIControlStateNormal];
            }
            count = obj.count + count;
        }];
    }];
}

- (void)clickNumButton:(UIButton *)sender {
    _inputText = [_inputText stringByAppendingString:sender.titleLabel.text];
    if (_keyboardBlock) {
        _keyboardBlock(_inputText,_textField);
    }
}

- (void)clickButton:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    if (sender.tag == 8003) {//删除字符
        if (_inputText.length == 0) {
            return;
        }
        _inputText = [_inputText substringToIndex:_inputText.length - 1];
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    } else if (sender.tag == 8007) {//点击清空
        _inputText = @"";
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    } else if (sender.tag == 8011 || sender.tag == 8015) {//点击收起和确定
        [_textField endEditing:YES];
    } else if (sender.tag == 8012) {//点击ABC
        _numView.hidden = YES;
        _alphaView.hidden = NO;
        
    } else {
        _inputText = [_inputText stringByAppendingString:sender.titleLabel.text];
        if (_keyboardBlock) {
            _keyboardBlock(_inputText,_textField);
        }
    }
}

//-(void)dealloc{
//    [_textField removeObserver:self forKeyPath:@"text" context:nil];
//}

@end
