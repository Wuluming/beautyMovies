//
//  ShareCell.h
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCell : UITableViewCell

@property (nonatomic,copy) void (^shareClick)(NSInteger index);

@end
