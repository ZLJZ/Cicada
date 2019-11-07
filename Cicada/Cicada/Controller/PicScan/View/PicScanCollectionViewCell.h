//
//  WxlPicScanCollectionViewCell.h
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicScanModel.h"

@interface PicScanCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) id model;

@end
