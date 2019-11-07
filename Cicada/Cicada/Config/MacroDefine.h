
//
//  MacroDefine.h
//  Cicada
//  宏定义
//  Created by 张琦 on 2017/3/7.
//  Copyright © 2017年 com. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define KSINGLELINE_WIDTH       1.0f/([UIScreen mainScreen].scale)

#define COLOR_BACK              [ToolHelper colorWithHexString:@"#f0f0f0"]
#define COLOR_YELLOW            [ToolHelper colorWithHexString:@"#f2ad27"]
#define COLOR_LIGHTGRAY         [ToolHelper colorWithHexString:@"#828282"]
#define COLOR_DARKGRAY          [ToolHelper colorWithHexString:@"#333333"]
#define COLOR_GREEN             [ToolHelper colorWithHexString:@"#38cb61"]
#define COLOR_WHITE             [ToolHelper colorWithHexString:@"#ffffff"]
#define COLOR_BLUE              [ToolHelper colorWithHexString:@"#368DE7"]
#define COLOR_RED               [ToolHelper colorWithHexString:@"#E84342"]
#define COLOR_DARK              [ToolHelper colorWithHexString:@"#000000"]
#define COLOR_LIGHT_BLUE        [UIColor colorWithRed:113/255.0 green:180/255.0 blue:255/255.0 alpha:0.2]
#define COLOR_CLEAR             [UIColor clearColor]



#define COLOR_KEYBOARD_GRAY     [ToolHelper colorWithHexString:@"#DCDCDC"]
#define COLOR_BACK_GRAY         [ToolHelper colorWithHexString:@"#F0F0F0"]
#define COLOR_LINE_GRAY         [ToolHelper colorWithHexString:@"#C7C7C7"]
#define COLOR_DATE_GRAY         [ToolHelper colorWithHexString:@"#999999"]
#define COLOR_SMALLTEXT_GRAY    [ToolHelper colorWithHexString:@"#4A4A4A"]
#define COLOR_BIGTEXT_BLACK     [ToolHelper colorWithHexString:@"#000000"]
#define COLOR_BUTTON_YELLOW     [ToolHelper colorWithHexString:@"#F2AD27"]


#define JSON_STR(A) [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@[A] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]


#define uWeakSelf typeof(self) __weak weakSelf = self;

#define kString_Format(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]
#define AssignmentStr(str)  [ToolHelper isBlankString:str] ? @"--" : str
#define AssignmentEmptyStr(str)  [ToolHelper isBlankString:str] ? @"" : str

#define LineViewWidth kScreenWidth/*340 * kScreenWidth / 375*/
#define LineViewHeight 166
#define BarViewHeight 80
#define TIME @"093000"

#endif /* MacroDefine_h */
