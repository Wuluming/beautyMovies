//
//  XWSliderBar.h
//  QX20151125
//
//  Created by qianfeng on 15/12/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSliderBar : UIView

@property (nonatomic,strong) NSMutableArray * itemTitles;

@property (nonatomic,copy) void(^itemClick)(NSInteger index);

- (void)setItemAtIndex:(NSInteger)index;
@end
