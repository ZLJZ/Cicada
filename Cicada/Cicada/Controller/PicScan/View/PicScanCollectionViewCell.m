//
//  WxlPicScanCollectionViewCell.m
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import "PicScanCollectionViewCell.h"

@implementation PicScanCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
}

- (void)setModel:(PicScanModel *)model {
    PicScanModel *picScanModel = (PicScanModel *)model;
    _imageView.image = [UIImage imageNamed:picScanModel.picName];
}

@end
