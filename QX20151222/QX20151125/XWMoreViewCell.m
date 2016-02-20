//
//  XWMoreViewCell.m
//  QX20151125
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XWMoreViewCell.h"

@implementation XWMoreViewCell
{
    
    UIImageView * _rightImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    [self.contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(self.bounds.size.height, 0, 100, self.bounds.size.height);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
//    _rightImageView = [[UIImageView alloc] init];
//    _rightImageView.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
//    _rightImageView.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"arrow_right" ofType:@"png"]];
//    [self.contentView addSubview:_rightImageView];
}

@end
