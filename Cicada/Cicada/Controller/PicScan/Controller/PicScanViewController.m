//
//  PicScanViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/4/11.
//  Copyright © 2017年 com. All rights reserved.
//

#import "PicScanViewController.h"
#import "PicScanView.h"
#import "PicScanModel.h"
#import "ZLCarouselWidget.h"
#import "ZLCardCollectionViewCell.h"

static inline CGRect transformRect(CGRect frame) {
    NSInteger count = 0;
//    for (NSInteger i = 0; i < 100; i ++) {
//        count += i;
//        NSLog(@"count:%ld",count);
        NSLog(@"aa");
//    }
//    UIViewContentMode mode = UIViewContentModeScaleToFill;
//    switch (mode) {
//        case UIViewContentModeScaleAspectFit:
//
//            break;
//
//        default:
//            break;
//    }
    
    CGRect tmp = frame;
    tmp.origin.x = frame.origin.y;
    return tmp;
}

@interface PicScanViewController ()<PicScanViewDelegate,ZLCarouselWidgetDelegate>
@property (nonatomic, strong) PicScanView *picScanView;

@property (nonatomic, strong) ZLCarouselWidget *carousel;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation PicScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = @[].mutableCopy;
    CGRect aa = CGRectMake(20, 40, 100, 80);
    CGRect test = transformRect(aa);
//    CGRect test = [self transformRect:aa];


    NSLog(@"aa:%f",aa.origin.x);
    NSLog(@"test:%f",test.origin.x);
    
    
    [self createUI];
}

//- (CGRect)transformRect:(CGRect)frame {
//    NSLog(@"bb");
//    NSInteger count = 0;
//    CGRect tmp = frame;
//    tmp.origin.x = frame.origin.y;
//    return tmp;
//}

- (void)createUI {
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
#if 1
    
    
    for (NSInteger i = 0; i < 5; i ++ ) {
        PicScanModel *model = [[PicScanModel alloc]init];
        model.picName = [NSString stringWithFormat:@"%ld.jpg",i + 1];
        model.level = [NSString stringWithFormat:@"VIP%ld",i + 1];
        if (i == 0 || i == 3) {
            model.isSubscribe = @"1";
        } else {
            model.isSubscribe = @"0";
        }
        [self.dataSource addObject:model];
    }
    
    self.carousel = [[ZLCarouselWidget alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 120)];
    self.carousel.imageDataSource = self.dataSource;
    self.carousel.backgroundColor = COLOR_LIGHTGRAY;
    self.carousel.delegate = self;
    [self.view addSubview:self.carousel];
    
//    for (NSInteger i = 0; i < 5; i ++ ) {
//        NSString *picName = [NSString stringWithFormat:@"%d.JPG",i+1];
//        [arr addObject:picName];
//    }
//
//    self.carousel = [ZLCarouselWidget carouselWithFrame:CGRectMake(0, 100, kScreenWidth, 120) imageLocalData:arr];
//    self.carousel.backgroundColor = COLOR_LIGHTGRAY;
////    self.carousel.scale = M_PI/3;
//    self.carousel.delegate = self;
//    [self.view addSubview:self.carousel];
#else
    
    for (NSInteger i = 0; i < 5; i ++ ) {
        PicScanModel *model = [[PicScanModel alloc]init];
        model.picName = [NSString stringWithFormat:@"%ld.JPG",i+2];
        [arr addObject:model];
    }
    _picScanView = [[PicScanView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 120)];
    _picScanView.modelArray = arr;
    _picScanView.delegate = self;
    [self.view addSubview:_picScanView];
    
#endif
    
    
    
    UILabel *tagLabel = [[UILabel alloc]init];
    
    
    
    
    
}

- (void)carousel:(ZLCarouselWidget *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击回调下标：%ld",index);
}

- (void)carousel:(ZLCarouselWidget *)carousel itemAtIndex:(NSInteger)index {
    NSLog(@"当前下标：%ld",index);
}

- (Class)customCollectionViewCellForCarousel:(ZLCarouselWidget *)carousel {
    return [ZLCardCollectionViewCell class];
//    return [[UICollectionViewCell alloc]init];
}

- (void)carousel:(ZLCarouselWidget *)carousel cell:(UICollectionViewCell *)cell cellForItemAtIndex:(NSInteger)index {
//    cell.contentView.backgroundColor = UIColor.blueColor;
    if ([cell isKindOfClass:[ZLCardCollectionViewCell class]]) {
        [((ZLCardCollectionViewCell *)cell) configData:self.dataSource[index]];
    }
}

//- (void)picScanViewDidSelectedAt:(NSInteger)index {
//    NSLog(@"第%ld张",index + 1);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
