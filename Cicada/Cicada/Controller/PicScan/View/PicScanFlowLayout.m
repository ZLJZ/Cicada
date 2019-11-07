//
//  PicScanFlowLayout.m
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import "PicScanFlowLayout.h"

@implementation PicScanFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0;
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(apartScale*M_PI/4));
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
    }
    return arr;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}

@end
