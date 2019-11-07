//
//  AllAppsViewController.m
//  OperationTag
//  仿支付宝首页-点击全部 页面
//  Created by 张琦 on 2017/1/9.
//  Copyright © 2017年 com. All rights reserved.
//

#import "AllAppsViewController.h"
#import "AllAppsModel.h"
#import "AllAppsLayout.h"
#import "AllAppsCollectionViewCell.h"
#import "AllAppsHeaderView.h"
#import "AllAppsFooterView.h"

#define K_Cell @"cell"
#define K_No_Cell @"noCell"
#define K_Head_Cell @"headCell"
#define K_Foot_Cell @"footCell"


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface AllAppsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,AllAppsDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *groupArray;
@property (nonatomic, assign)BOOL isEdit;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)AllAppsLayout *flowLayout;



@end

@implementation AllAppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableArray *userDefaultsArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"editColumn"];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"editColumn"];
    NSMutableArray *userDefaultsArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (userDefaultsArr.count != 0) {
        self.dataArray = [userDefaultsArr[0] mutableCopy];
        self.groupArray = [userDefaultsArr[1] mutableCopy];
        
    } else {
        NSArray *arr = @[@[@"理财",@"more_icon_licai"],
                         @[@"查询余额",@"more_icon_Search"],
                         @[@"实时结算",@"more_icon_t0"],
                         @[@"信用卡还款",@"more_icon_Prepaidcard"],
                         @[@"我的客服",@"work-order"]];
        for (NSInteger i = 0; i < arr.count; i ++ ) {
            AllAppsModel *model = [[AllAppsModel alloc]init];
            model.title = arr[i][0];
            model.picture = arr[i][1];
            [self.dataArray addObject:model];
            [self.groupArray addObject:model];
        }
        
        NSArray *secondArr = @[@[@"P2P",@"more_icon_Mall"],
                               @[@"收银台",@"more_icon_shouyin"],
                               @[@"开通",@"more_icon_gift"],
                               @[@"充值",@"more_icon_Recharge"],
                               @[@"交易",@"more_icon_cancle_deal"],
                               @[@"结算",@"more_icon_Settlement"],
                               @[@"交易量",@"more_icon_Transaction_flow"],
                               @[@"快捷支付",@"more_icon_Credit-card-"]];
        for (NSInteger i = 0; i < secondArr.count; i ++ ) {
            AllAppsModel *model = [[AllAppsModel alloc]init];
            model.title = secondArr[i][0];
            model.picture = secondArr[i][1];
            [self.groupArray addObject:model];
        }

        
    }

//    self.title = @"全部应用";
//    NSArray *arr = @[@[@"理财",@"more_icon_licai"],
//                     @[@"查询余额",@"more_icon_Search"],
//                     @[@"实时结算",@"more_icon_t0"],
//                     @[@"信用卡还款",@"more_icon_Prepaidcard"],
//                     @[@"我的客服",@"work-order"]];
//    for (NSInteger i = 0; i < arr.count; i ++ ) {
//        AllAppsModel *model = [[AllAppsModel alloc]init];
//        model.title = arr[i][0];
//        model.picture = arr[i][1];
//        [self.dataArray addObject:model];
//        [self.groupArray addObject:model];
//    }
//    
//    NSArray *secondArr = @[@[@"P2P",@"more_icon_Mall"],
//                           @[@"收银台",@"more_icon_shouyin"],
//                           @[@"开通",@"more_icon_gift"],
//                           @[@"充值",@"more_icon_Recharge"],
//                           @[@"交易",@"more_icon_cancle_deal"],
//                           @[@"结算",@"more_icon_Settlement"],
//                           @[@"交易量",@"more_icon_Transaction_flow"],
//                           @[@"快捷支付",@"more_icon_Credit-card-"]];
//    for (NSInteger i = 0; i < secondArr.count; i ++ ) {
//        AllAppsModel *model = [[AllAppsModel alloc]init];
//        model.title = secondArr[i][0];
//        model.picture = secondArr[i][1];
//        [self.groupArray addObject:model];
//    }
    [self.view addSubview:self.collectionView];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTitle:@"管理" forState:UIControlStateNormal];
    [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - SYLifeManagerDelegate

//处于编辑状态
- (void)didChangeEditState:(BOOL)isEdit
{
    self.isEdit = isEdit;
    self.rightButton.selected = isEdit;
    for (AllAppsCollectionViewCell *cell in self.collectionView.visibleCells) {
        cell.inEditState = isEdit;
    }
}

//改变数据源中model的位置
- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath
{
    AllAppsModel *model = self.dataArray[formPath.row];
    //先把移动的这个model移除
    [self.dataArray removeObject:model];
    //再把这个移动的model插入到相应的位置
    [self.dataArray insertObject:model atIndex:toPath.row];
}



- (void)clickRightButton:(UIButton *)sender {
    if (!_isEdit) {//点击了管理
        _isEdit = YES;
        _collectionView.allowsSelection = NO;//设置collectionView不可以选中
    } else {//点击了完成
        _isEdit = NO;
        _collectionView.allowsSelection = YES;
       
        NSMutableArray *titleAndIsSelectedArr = @[self.dataArray,self.groupArray].mutableCopy;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:titleAndIsSelectedArr];
        if (data.length != 0) {
            [self userDefaults:data];
        }
////        _EditBlock(YES);
////        [self.navigationController popViewControllerAnimated:YES];

    }
    [self.flowLayout setIsEdit:_isEdit];
}

- (void)userDefaults:(NSData *)data {
    NSUserDefaults *editDefaults = [NSUserDefaults standardUserDefaults];
    [editDefaults setValue:data forKey:@"editColumn"];
    [editDefaults synchronize];
}

- (void)btnClick:(UIButton *)sender event:(id)event
{
    //获取点击button的位置
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_collectionView];
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:currentPoint];
    if (indexPath.section == 0 && indexPath != nil) { //点击移除
        [self.collectionView performBatchUpdates:^{
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [self.dataArray removeObjectAtIndex:indexPath.row]; //删除
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    } else if (indexPath != nil) { //点击添加
        //在第一组最后增加一个
        [self.dataArray addObject:self.groupArray[indexPath.row]];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
        [self.collectionView performBatchUpdates:^{
            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
}



#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    } else {
        return self.groupArray.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AllAppsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_Cell forIndexPath:indexPath];
    [cell setDataArr:self.dataArray groupArr:self.groupArray indexPath:indexPath];
    //是否处于编辑状态，如果处于编辑状态，出现边框和按钮，否则隐藏
    cell.inEditState = self.isEdit;
    [cell.button addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - 点击collectionView的方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isEdit) { //如果不在编辑状态
        NSLog(@"点击了第%@个分区的第%@个cell", @(indexPath.section), @(indexPath.row));
    }
}

#pragma mark - HeaderAndFooter

//区头区尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        AllAppsHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:K_Head_Cell forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headView.headLabel.text = @"我的应用";
        } else {
            headView.headLabel.text = @"便捷生活";
        }
        return headView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        AllAppsFooterView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:K_Foot_Cell forIndexPath:indexPath];
        return footView;
    }
    return nil;
}

//头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.dataArray.count == 0) {
        if (section == 0) {
            CGFloat width = (kScreenWidth - 80) / 4;
            self.tipLabel.frame = CGRectMake(0, 30, kScreenWidth, width);
            //显示没有更多的提示
            [self.collectionView addSubview:self.tipLabel];
            return CGSizeMake(kScreenWidth, 25 + width);
        } else {
            return CGSizeMake(kScreenWidth, 25);
        }
    } else {
        [self.tipLabel removeFromSuperview];
        return CGSizeMake(kScreenWidth, 25);
    }
}

//尾视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 10);
    } else {
        return CGSizeMake(kScreenWidth, 0.5);
    }
}

#pragma mark - init

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //给集合视图注册一个cell
        [_collectionView registerClass:[AllAppsCollectionViewCell class] forCellWithReuseIdentifier:K_Cell];
        //注册一个区头视图
        [_collectionView registerClass:[AllAppsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:K_Head_Cell];
        //注册一个区尾视图
        [_collectionView registerClass:[AllAppsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:K_Foot_Cell];
    }
    return _collectionView;
}



- (AllAppsLayout *)flowLayout
{
    if (!_flowLayout) {
        CGFloat width = (kScreenWidth - 80) / 4;
        _flowLayout = [[AllAppsLayout alloc] init];
        _flowLayout.delegate = self;
        //设置每个图片的大小
        _flowLayout.itemSize = CGSizeMake(width, width);
        //设置滚动方向的间距
        _flowLayout.minimumLineSpacing = 10;
        //设置上方的反方向
        _flowLayout.minimumInteritemSpacing = 0;
        //设置collectionView整体的上下左右之间的间距
        _flowLayout.sectionInset = UIEdgeInsetsMake(15, 20, 20, 20);
        //设置滚动方向
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (NSMutableArray *)groupArray
{
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _groupArray;
}

//没有应用的提示
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"您还未添加任何应用\n长按下面的应用可以添加";
    }
    return _tipLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
