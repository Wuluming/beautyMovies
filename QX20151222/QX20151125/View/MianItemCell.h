//
//  MianItemCell.h
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentModel;
@interface MianItemCell : UITableViewCell

@property (nonatomic,strong) ContentModel * model;

@property (nonatomic,copy) void (^playBlock)();

@end
