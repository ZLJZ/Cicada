//
//  PicScanView.m
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import "PicScanView.h"
#import "PicScanCollectionViewCell.h"
#import "PicScanFlowLayout.h"
#import "PicScanModel.h"

//居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;

@interface PicScanView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIImageView *_imageView;
    
    UICollectionView *_collectionView;
    
    NSInteger _currentIndex;
    
    CGFloat _dragStartX;
    
    CGFloat _dragEndX;
}
@end

@implementation PicScanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    [self addImageView];
    
    [self addCollectionView];
}

-(void)addImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _imageView.bounds;
    [_imageView addSubview:effectView];
}

-(void)addCollectionView
{
    PicScanFlowLayout *flowLayout = [[PicScanFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake([self cellWidth],self.bounds.size.height * CardHeightScale)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:[self cellMargin]];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[PicScanCollectionViewCell class] forCellWithReuseIdentifier:@"picScanId"];
    [_collectionView setUserInteractionEnabled:YES];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}

#pragma mark -
#pragma mark Setter
-(void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    if (_modelArray.count) {
        PicScanModel *model = _modelArray.firstObject;
        _imageView.image = [UIImage imageNamed:model.picName];
    }
}

#pragma mark -
#pragma mark CollectionDelegate

//配置cell居中
-(void)fixCellToCenter
{
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _currentIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [self scrollToCenter];
}

-(void)scrollToCenter
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    PicScanModel *model = _modelArray[_currentIndex];
    _imageView.image = [UIImage imageNamed:model.picName];
    
    if ([_delegate respondsToSelector:@selector(picScanViewDidSelectedAt:)]) {
        [_delegate picScanViewDidSelectedAt:_currentIndex];
    }
}

#pragma mark -
#pragma mark CollectionDelegate
//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
    [self scrollToCenter];
}

#pragma mark -
#pragma mark CollectionDataSource

//卡片宽度
-(CGFloat)cellWidth
{
    return self.bounds.size.width * CardWidthScale;
}

//卡片间隔
-(float)cellMargin
{
    return (self.bounds.size.width - [self cellWidth])/4;
}

//设置左右缩进
-(CGFloat)collectionInset
{
    return self.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"picScanId";
    PicScanCollectionViewCell* card = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    card.model = _modelArray[indexPath.row];
    return  card;
}


@end
