//
//  AllAppsTableViewCell.m
//  OperationTag
//
//  Created by 张琦 on 2017/1/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import "AllAppsCollectionViewCell.h"
#import <Masonry/Masonry.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation AllAppsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = (kScreenWidth - 80) / 4;

        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 15, 15, 15));
//            make.top.equalTo(self.contentView.mas_top).offset((width-(14+36+10))/2);
            make.left.equalTo(self.contentView.mas_left).offset((width-36)/2);
            make.size.mas_equalTo(CGSizeMake(36, 36));
    
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(3);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-(width-(14+36+3))/2);
            make.left.and.right.equalTo(self);
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.height.equalTo(@15);
            make.width.equalTo(@15);
        }];
        self.button.hidden = YES;
    }
    return self;
}

- (void)addTipLabel
{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)setModel:(AllAppsModel *)model indexPath:(NSIndexPath *)indexPath exist:(BOOL)exist
{
    if (_model != model) {
        self.titleLabel.text = model.title;
        self.imgView.image = [UIImage imageNamed:model.picture];
        if (indexPath.section == 0) {
            [self.button setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
            self.button.userInteractionEnabled = YES;
        } else {
            if (exist) {
                [self.button setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
                self.button.userInteractionEnabled = NO;
            } else {
                [self.button setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
                self.button.userInteractionEnabled = YES;
            }
        }
    }
    _model = model;
}

- (void)setDataArr:(NSMutableArray *)dataArr groupArr:(NSMutableArray *)groupArr indexPath:(NSIndexPath *)indexPath
{
    AllAppsModel *model;
    if (indexPath.section == 0) {
        model = dataArr[indexPath.row];
    } else {
        model = groupArr[indexPath.row];
    }
    self.titleLabel.text = model.title;
    self.imgView.image = [UIImage imageNamed:model.picture];
    if (indexPath.section == 0) {
        self.button.userInteractionEnabled = YES;
        [self.button setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
    } else {
        if ([dataArr containsObject:model]) {
            self.button.userInteractionEnabled = NO;
            [self.button setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
        } else {
            self.button.userInteractionEnabled = YES;
            [self.button setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 是否处于编辑状态

- (void)setInEditState:(BOOL)inEditState
{
    if (inEditState && _inEditState != inEditState) {
        self.layer.borderWidth = 0.5;
        //设置collectionVIew边界的颜色
//        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:0.5].CGColor;
        self.button.hidden = NO;
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.button.hidden = YES;
    }
}

#pragma mark - init

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"wallet_payChange"];
        _imgView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"您还未添加任何应用\n长按下面的应用可以添加";
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.layer.cornerRadius = 7.5;
        [self addSubview:_button];
    }
    return _button;
}


@end
