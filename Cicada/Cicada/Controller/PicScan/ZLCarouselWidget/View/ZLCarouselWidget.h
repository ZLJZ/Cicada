//
//  ZLCarouselWidget.h
//  Cicada
//
//  Created by 吴肖利 on 2019/7/10.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZLCarouselWidget;

@protocol ZLCarouselWidgetDelegate <NSObject>

@optional
/**
 点击Item的回调

 @param carousel ZLCarouselWidget
 @param index 当前点击的Item
 */
- (void)carousel:(ZLCarouselWidget *)carousel didSelectItemAtIndex:(NSInteger)index;


/**
 获取当前Item所在的下标

 @param carousel ZLCarouselWidget
 @param index 当前Item下标
 */
- (void)carousel:(ZLCarouselWidget *)carousel itemAtIndex:(NSInteger)index;

/**
 自定义collectionViewCell

 @param carousel ZLCarouselWidget
 @return 自定义的cell
 */
- (Class)customCollectionViewCellForCarousel:(ZLCarouselWidget *)carousel;

- (void)carousel:(ZLCarouselWidget *)carousel cell:(UICollectionViewCell *)cell cellForItemAtIndex:(NSInteger)index;


@end

@interface ZLCarouselWidget : UIView


/* 代理 */
@property (nonatomic, weak) id <ZLCarouselWidgetDelegate> delegate;

/* imageView的contentMode, default is UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;

/* 占位图 */
@property (nonatomic, strong) UIImage *placeholderImage;

/* 图片数据源 */
@property (nonatomic, strong) NSArray *imageDataSource;

/* 左右缩进 default is 50 */
@property (nonatomic, assign) CGFloat indent;

/* 最小滚动距离 default is CGRectGetWidth(self.bounds)/20.0 */
@property (nonatomic, assign) CGFloat minRollDistance;

/* 缩放比例 default is M_PI/4 */
@property (nonatomic, assign) CGFloat scale;



/**
 初始化方法

 @param frame frame
 @param imageLocalData 本地资源图片
 @return carousel
 */
+ (instancetype)carouselWithFrame:(CGRect)frame imageLocalData:(NSArray *)imageLocalData;

@end

@interface ZLCarouselFlowLayout : UICollectionViewFlowLayout

/* 缩放比例 */
@property (nonatomic, assign) CGFloat scale;

@end

@interface ZLCarouselCollectionViewCell : UICollectionViewCell

/* 图片imageView */
@property (nonatomic, strong) UIImageView *imageView;

/* 图片数据 */
@property (nonatomic, strong) id imageData;

/* 占位图 */
@property (nonatomic, strong) UIImage *placeholderImage;

@end



NS_ASSUME_NONNULL_END
