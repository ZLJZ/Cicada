//
//  ZLCardCollectionViewCell.m
//  Cicada
//
//  Created by 吴肖利 on 2019/7/18.
//  Copyright © 2019 com. All rights reserved.
//

#import "ZLCardCollectionViewCell.h"

@interface ZLCardCollectionViewCell ()

@property (nonatomic, strong) PicScanModel *model;

@end
@implementation ZLCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.backImageView = [[UIImageView alloc]init];
    self.backImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.backImageView];
    self.accountLabel = [[UILabel alloc]init];
    [self.backImageView addSubview:self.accountLabel];
    self.levelLabel = [[UILabel alloc]init];
    [self.backImageView addSubview:self.levelLabel];

    self.dueDateLabel = [[UILabel alloc]init];
    [self.backImageView addSubview:self.dueDateLabel];

    self.priceLabel = [[UILabel alloc]init];
    [self.backImageView addSubview:self.priceLabel];

    self.subscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.subscribeButton.backgroundColor = COLOR_YELLOW;
    [self.subscribeButton setTitle:@"订阅" forState:UIControlStateNormal];
    [self.subscribeButton setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [self.backImageView addSubview:self.subscribeButton];

    
}

- (void)configData:(PicScanModel *)model {
    self.model = model;
    self.backImageView.image = [UIImage imageNamed:model.picName];
    self.levelLabel.text = model.level;
    
    if ([self.model.isSubscribe integerValue] == 1) {
        self.accountLabel.text = @"177****7777";

    } else {
        self.priceLabel.text = @"￥5.00/月";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = self.bounds;
    if ([self.model.isSubscribe integerValue] == 1) {
        self.accountLabel.frame = CGRectMake(20, 20, CGRectGetWidth(self.bounds) - 40, 15);
        self.accountLabel.text = @"177****7777";
        self.levelLabel.frame = CGRectMake(20, self.accountLabel.bottom + 20, CGRectGetWidth(self.bounds) - 40, 15);
    } else {
        self.levelLabel.frame = CGRectMake(20, 20, CGRectGetWidth(self.bounds) - 40, 15);
        self.priceLabel.frame = CGRectMake(20, self.levelLabel.bottom + 10, CGRectGetWidth(self.bounds) - 40, 15);
        self.subscribeButton.frame = CGRectMake(20, self.priceLabel.bottom + 20, 80, 15);

    }
    
}

@end
