//
//  EpisodeOtherCell.h
//  QX20151125
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EpisodeOtherCell : UITableViewCell

@property (nonatomic,strong) NSArray * episodesArray;

@property (nonatomic,copy) void (^episodeClcked)(NSInteger index);

@end
