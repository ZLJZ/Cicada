//
//  MultiTabView.h
//  Cicada
//  自定义多页签选择view
//  Created by 吴肖利 on 2018/9/7.
//  Copyright © 2018 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiTabView : UIScrollView<UIScrollViewDelegate>



/**
 自定义多页签view(self宽，且均分)

 @param frame frame
 @param titleArr 标题数据
 @param defaultIdx 默认选择下标
 @param selectedTabBlock 当前选中的tab的回调
 @return 自定义多标签view
 */
-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr defaultIdx:(NSInteger)defaultIdx selectedTabBlock:(void(^)(NSInteger selectedIdx,UIButton *selectedButton))selectedTabBlock;


@end

NS_ASSUME_NONNULL_END
