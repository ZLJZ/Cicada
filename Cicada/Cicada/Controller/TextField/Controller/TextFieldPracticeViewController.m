//
//  TextFieldPracticeViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/4/27.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TextFieldPracticeViewController.h"
#import "WXLKeyboard.h"

@interface TextFieldPracticeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TextFieldPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self createTextField];
//    [NSNotificationCenter defaultCenter]
}

- (void)createTextField {
    _textField = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2, 80, 150, 40)];
//    _textField.text = @"知了";
    _textField.backgroundColor = COLOR_BACK;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder = @"请输入代码";
//    _textField.delegate = self;
    _textField.tag = 700;
//    [_textField addTarget:self action:@selector(cicadaTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textField];
    WXLKeyboard *keyboard = [[WXLKeyboard alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220) textField:_textField keyboardBlock:^(NSString *text, UITextField *textField) {
        if (text.length >= 6) {
            textField.text = [text substringToIndex:6];
            [self.view endEditing:YES];
            NSLog(@"1");
        } else {
            textField.text = text;
            NSLog(@"2");
        }
//        textField.text = text;

    }];
    _textField.inputView = keyboard;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2, _textField.bottom + 70, 150, 40)];
    button.backgroundColor = COLOR_LIGHTGRAY;
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickButton:(UIButton *)sender {
    UITextField *textField = (UITextField *)[self.view viewWithTag:700];
    textField.text = @"233333333";
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)cicadaTextFieldDidChange:(UITextField *)textField {
    NSLog(@"%ld",textField.text.length);
    if (textField.text.length == 5) {
        [self.view endEditing:YES];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
