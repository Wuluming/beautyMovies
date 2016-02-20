//
//  EpisodesCell.h
//  QX20151125
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EpisodesCell : UITableViewCell

@property (nonatomic,assign) int episodes;

@property (nonatomic,copy) void (^episodeClcked)(NSInteger index);


@end
