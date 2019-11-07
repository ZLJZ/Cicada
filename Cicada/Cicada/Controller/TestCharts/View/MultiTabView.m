//
//  MultiTabView.m
//  Cicada
//  自定义多页签选择view
//  Created by 吴肖利 on 2018/9/7.
//  Copyright © 2018 com. All rights reserved.
//

#import "MultiTabView.h"


@interface MultiTabView ()
//标题数据源
@property (nonatomic, strong) NSArray *titleArr;
//是否均分屏幕宽度
@property (nonatomic, assign) BOOL isAverage;
//默认选中索引的下标
@property (nonatomic, assign) NSInteger defaultIdx;
//下划线
@property (nonatomic, strong) UIView *indictorView;
//当前选中tab的回调
@property (nonatomic, copy) void(^block)(NSInteger selectedIdx,UIButton *selectedButton);
//记录上一次点击的button
@property (nonatomic, strong) UIButton *lastSelectedButton;

@end
@implementation MultiTabView

-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr defaultIdx:(NSInteger)defaultIdx selectedTabBlock:(void(^)(NSInteger selectedIdx,UIButton *selectedButton))selectedTabBlock {
    if (self = [super initWithFrame:frame]) {
        self.block = selectedTabBlock;
        self.titleArr = titleArr;
        self.defaultIdx = defaultIdx;
        self.delegate = self;
        self.backgroundColor = COLOR_WHITE;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = 0;
        [self addViews];
    }
    return self;
}

- (void)addViews {
    //默认按钮宽度 一屏均分
    CGFloat buttonW = self.width/self.titleArr.count;
    self.contentSize = CGSizeMake(self.width, self.height);
    
    [self.titleArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
        [button setTitleColor:COLOR_RED forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(buttonW * idx, 0, buttonW, self.height);
        [button addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10000 + idx;
        [self addSubview:button];
        if (idx == self.defaultIdx) {
            button.selected = YES;
            self.indictorView.centerX = button.centerX;
            self.lastSelectedButton = button;
            if (self.block) {
                self.block(idx, button);
            }
        }
    }];
}

#pragma mark  点击事件
- (void)clickEvent:(UIButton *)sender {
    self.lastSelectedButton.selected = NO;
    sender.selected = YES;
    self.lastSelectedButton = sender;
    [UIView animateWithDuration:0.2 animations:^{
        self.indictorView.centerX = sender.centerX;
    }];
    if (self.block) {
        self.block(sender.tag - 10000, sender);
    }
}

#pragma mark  lazy
-(UIView *)indictorView {
    if (!_indictorView) {
        //距离底部4，高度为2，宽20
        _indictorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 4 - 2, 20, 2)];
        _indictorView.backgroundColor = COLOR_RED;
        [self addSubview:_indictorView];
    }
    return _indictorView;
}


//所有文字的总宽度
//    __block CGFloat totalWidth = 0;
//    [self.titleArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat width = [ToolHelper sizeForNoticeTitle:obj font:[UIFont systemFontOfSize:14]].width;
//        totalWidth += width;
//    }];

//默认第一个按钮距离当前视图左边界的距离
//    CGFloat disX = 0;
//    CGFloat space = 0;

//
//    if (self.isAverage) {
//        disX = 0;
//        buttonW = kScreenWidth/self.titleArr.count;
//    }


/*
 //判断space设置为30时能否放满一屏，如果不能则放满一屏，均分间隙；如果能放满一屏，则space默认设置为30
 if (totalWidth + (self.titleArr.count - 1) * 30 + 40 <= kScreenWidth) {
 if (self.titleArr.count == 2) {
 //如果只有两个，就屏宽均分
 disX = (kScreenWidth - totalWidth)/4.0;
 space =
 } else {
 
 }
 
 
 } else {
 disX = 20;
 space = 30;
 }
 */


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
