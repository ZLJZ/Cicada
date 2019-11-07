//
//  AllAppsLayout.h
//  OperationTag
//
//  Created by 张琦 on 2017/1/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllAppsDelegate <NSObject>

//移动更新数据源
- (void)moveItemAtIndexPath:(NSIndexPath *)oldIndexPath toIndexPath:(NSIndexPath *)newIndexPath;

- (void)didChangeEditState:(BOOL)isEdit;

@end

@interface AllAppsLayout : UICollectionViewFlowLayout

@property (nonatomic, assign)BOOL isEdit;

@property (nonatomic, weak)id<AllAppsDelegate> delegate;


@end
