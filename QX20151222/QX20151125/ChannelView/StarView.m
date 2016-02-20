//
//  StarView.m
//  QX20151125
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "StarView.h"

@implementation StarView
{
    UIImageView * _bgImageView;
    UIImageView * _fgImageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    UIImage * WImage = [UIImage imageNamed:@"StarsBackground"];
    UIImage * YImage = [UIImage imageNamed:@"StarsForeground"];
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WImage.size.width, WImage.size.height)];
    _bgImageView.image = WImage;
    [self addSubview:_bgImageView];
    
    
    _fgImageView = [[UIImageView alloc] init];
    _fgImageView.image = YImage;
    _fgImageView.contentMode = UIViewContentModeLeft;
    _fgImageView.layer.masksToBounds = YES;
    [self addSubview:_fgImageView];
}

- (void)setStar:(CGFloat)star {
    _star = star;
    UIImage * WImage = [UIImage imageNamed:@"StarsBackground"];
    _fgImageView.frame = CGRectMake(0, 0, WImage.size.width * star/5, WImage.size.height);
}

@end
