//
//  ChannelModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface ChannelModel : JSONModel

@property (nonatomic,copy) NSString * avg_score;
@property (nonatomic,copy) NSString<Optional> * duration;
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString<Optional> * image;
@property (nonatomic,copy) NSString * play_count;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString<Optional> * is_following;
@property (nonatomic,copy) NSString<Optional> * episodes_count;
//@property (nonatomic,copy) NSString<Optional> * recent_episode;
@end
