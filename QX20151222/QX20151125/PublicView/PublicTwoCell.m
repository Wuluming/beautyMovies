//
//  PublicTwoCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PublicTwoCell.h"

@implementation PublicTwoCell
{
    UIImageView * _leftImageView;
    UIImageView * _rightImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    _leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImageView];
    
    _rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImageView];
}

- (void)setArr:(NSArray *)arr {
    CGFloat width = SCREEN_SIZE.width/2;
    if (arr.count == 2) {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
        _leftImageView.frame = CGRectMake(0, 0, width, PublicCell_Height);
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:arr[1]]placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
        _rightImageView.frame = CGRectMake(width, 0, width, PublicCell_Height);
    }else {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:arr[0]]placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
        _leftImageView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, PublicCell_Height);
    }
}


@end
