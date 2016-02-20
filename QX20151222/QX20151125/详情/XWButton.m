//
//  XWButton.m
//  看天下
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XWButton.h"
#define sta 0.6
@implementation XWButton

- (instancetype)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat  titleHeight= contentRect.size.height * (1 - sta);
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleY = contentRect.size.height - titleHeight -2;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = 5;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * sta;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}
@end
