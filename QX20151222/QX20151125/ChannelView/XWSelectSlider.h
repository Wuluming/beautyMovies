//
//  XWSelectSlider.h
//  QX20151125
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSelectSlider : UIView

@property (nonatomic,strong) NSArray * itemTitles;

@property (nonatomic,copy) void(^itemClick)(NSInteger index);

@end
