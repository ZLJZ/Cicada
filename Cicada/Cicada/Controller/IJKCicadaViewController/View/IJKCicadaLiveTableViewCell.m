//
//  IJKCicadaLiveTableViewCell.m
//  Cicada
//
//  Created by 张琦 on 2017/6/1.
//  Copyright © 2017年 com. All rights reserved.
//

#import "IJKCicadaLiveTableViewCell.h"

@implementation IJKCicadaLiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customCell];
    }
    return self;
}

- (void)customCell {
    _imageViewLive = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, 70)];
    _imageViewLive.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_imageViewLive];
}

+ (id)cicadaLiveTableViewCellTableView:(UITableView *)tableView {
    static NSString *cellId = @"IJKLiveCellId";
    IJKCicadaLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[IJKCicadaLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
