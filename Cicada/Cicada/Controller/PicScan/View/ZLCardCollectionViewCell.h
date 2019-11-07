//
//  ZLCardCollectionViewCell.h
//  Cicada
//
//  Created by 吴肖利 on 2019/7/18.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicScanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLCardCollectionViewCell : UICollectionViewCell

//背景
@property (nonatomic, strong) UIImageView *backImageView;
//账户
@property (nonatomic, strong) UILabel *accountLabel;
//等级
@property (nonatomic, strong) UILabel *levelLabel;
//到期日期
@property (nonatomic, strong) UILabel *dueDateLabel;
//价格
@property (nonatomic, strong) UILabel *priceLabel;
//订阅按钮
@property (nonatomic, strong) UIButton *subscribeButton;

- (void)configData:(PicScanModel *)model;

@end

NS_ASSUME_NONNULL_END
