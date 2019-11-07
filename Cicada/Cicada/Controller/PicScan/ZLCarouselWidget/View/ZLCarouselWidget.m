//
//  ZLCarouselWidget.m
//  Cicada
//
//  Created by 吴肖利 on 2019/7/10.
//  Copyright © 2019 com. All rights reserved.
//

#import "ZLCarouselWidget.h"

NSString *const ZLCarouselIdentifier = @"ZLCarouselIdentifier";

@interface ZLCarouselWidget () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//自定义flowLayout
@property (nonatomic, strong) ZLCarouselFlowLayout *flowLayout;
//itemsCount
@property (nonatomic, assign) NSInteger itemsCount;
//卡片宽
@property (nonatomic, assign) CGFloat itemWidth;
//卡片间隔
@property (nonatomic, assign) CGFloat cardInterval;
//当前下标
@property (nonatomic, assign) NSInteger currentIndex;
//拖拽起始点
@property (nonatomic, assign) CGFloat dragBeginOffsetX;
//拖拽结束点
@property (nonatomic, assign) CGFloat dragEndOffsetX;

@end

@implementation ZLCarouselWidget

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self addViews];
        //
    }
    return self;
}

+ (instancetype)carouselWithFrame:(CGRect)frame imageLocalData:(NSArray *)imageLocalData {
    ZLCarouselWidget *carousel = [[self alloc]initWithFrame:frame];
    carousel.imageDataSource = imageLocalData;
    return carousel;
}

- (void)initialization {
    self.dragBeginOffsetX = 0;
    self.dragEndOffsetX = 0;
    self.itemsCount = 0;
    self.scale = M_PI/4;
    self.indent = 50;
    self.minRollDistance = CGRectGetWidth(self.bounds)/20.0;
    self.imageViewContentMode = UIViewContentModeScaleToFill;
}

- (void)addViews {
    [self addSubview:self.collectionView];
}

#pragma UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZLCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZLCarouselIdentifier forIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(customCollectionViewCellForCarousel:)] && [self.delegate respondsToSelector:@selector(carousel:cell:cellForItemAtIndex:)] && [self.delegate customCollectionViewCellForCarousel:self]) {
        [self.delegate carousel:self cell:cell cellForItemAtIndex:indexPath.item];
        return cell;
    }
    
    NSString *imagedata = self.imageDataSource[indexPath.item];
    cell.imageView.contentMode = self.imageViewContentMode;
    cell.placeholderImage = self.placeholderImage;
    cell.imageData = imagedata;
    
    //
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.indent, 0, self.indent);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastIndex= self.currentIndex;
    self.currentIndex = indexPath.row;
    
    //点击的如果是同一个Item，则不进行滚动及当前Item下标的回调
    if (lastIndex != self.currentIndex) {
        [self scrollToCenter];
    }
    
    if ([self.delegate respondsToSelector:@selector(carousel:didSelectItemAtIndex:)]) {
        [self.delegate carousel:self didSelectItemAtIndex:self.currentIndex];
    }
}

- (void)scrollToCenter {
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if ([self.delegate respondsToSelector:@selector(carousel:itemAtIndex:)]) {
        [self.delegate carousel:self itemAtIndex:self.currentIndex];
    }
}


#pragma mark  UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.dragBeginOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.dragEndOffsetX = scrollView.contentOffset.x;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.dragBeginOffsetX - self.dragEndOffsetX >= self.minRollDistance) {
            self.currentIndex -= 1;
        } else if (self.dragEndOffsetX - self.dragBeginOffsetX >= self.minRollDistance) {
            self.currentIndex += 1;
        }
        
        self.currentIndex = MAX(0, self.currentIndex);
        self.currentIndex = MIN(self.currentIndex, self.itemsCount - 1);
        
        [self scrollToCenter];
    });
}


#pragma mark  --lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.userInteractionEnabled = YES;
        [_collectionView registerClass:[ZLCarouselCollectionViewCell class] forCellWithReuseIdentifier:ZLCarouselIdentifier];
        //
    }
    return _collectionView;
}

- (ZLCarouselFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[ZLCarouselFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //
    }
    return _flowLayout;
}

#pragma mark  Property

- (void)setDelegate:(id<ZLCarouselWidgetDelegate>)delegate {
    _delegate = delegate;
    //如果实现以下方法，则注册自定义的cell
    if ([self.delegate respondsToSelector:@selector(customCollectionViewCellForCarousel:)] && [self.delegate respondsToSelector:@selector(carousel:cell:cellForItemAtIndex:)]) {
        [self.collectionView registerClass:[self.delegate customCollectionViewCellForCarousel:self] forCellWithReuseIdentifier:ZLCarouselIdentifier];
    }
}

- (void)setImageDataSource:(NSArray *)imageDataSource {
    _imageDataSource = imageDataSource;
    self.itemsCount = self.imageDataSource.count;
}

- (void)setIndent:(CGFloat)indent {
    _indent = indent;
    self.cardInterval = self.indent/2.0;
    self.itemWidth = (CGRectGetWidth(self.bounds) - self.indent * 2.0);
    self.flowLayout.itemSize = CGSizeMake(self.itemWidth, CGRectGetHeight(self.bounds));
    self.flowLayout.minimumLineSpacing = self.cardInterval;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.flowLayout.scale = self.scale;
}


@end

@implementation ZLCarouselFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0;
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(apartScale*self.scale));
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
    }
    return arr;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}

@end

@implementation ZLCarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageView];
}

- (void)setImageData:(id)imageData {
    _imageData = imageData;
    if ([imageData isKindOfClass:[UIImage class]]) {
        self.imageView.image = (UIImage *)imageData;
    } else if ([imageData isKindOfClass:[NSString class]]) {
        if ([imageData hasPrefix:@"http"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageData] placeholderImage:self.placeholderImage options:SDWebImageRetryFailed | SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
        } else {
            UIImage *image = [UIImage imageNamed:imageData];
            if (!image) {
                image = [UIImage imageWithContentsOfFile:imageData];
            }
            
            if (!image) {
                image = self.placeholderImage;
            }
            self.imageView.image = image;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
