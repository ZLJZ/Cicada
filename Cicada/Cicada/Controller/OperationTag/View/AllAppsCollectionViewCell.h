//
//  AllAppsTableViewCell.h
//  OperationTag
//
//  Created by 张琦 on 2017/1/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllAppsModel.h"
@interface AllAppsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) AllAppsModel *model;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipLabel;


@property (nonatomic, assign) BOOL inEditState; //是否处于编辑状态

- (void)setModel:(AllAppsModel *)model indexPath:(NSIndexPath *)indexPath exist:(BOOL)exist;

- (void)setDataArr:(NSMutableArray *)dataArr groupArr:(NSMutableArray *)groupArr indexPath:(NSIndexPath *)indexPath;


- (void)addTipLabel;


@end
