//
//  DeatailModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "ActorModel.h"
#import "DirectorModel.h"
#import "AddressModel.h"
#import "EpisodeModel.h"
@interface DeatailModel : JSONModel

@property (nonatomic,copy) NSString * area;
@property (nonatomic,copy) NSString<Optional> * descriptionStr;
@property (nonatomic,copy) NSString * duration;
@property (nonatomic,copy) NSString<Optional> * play_id;
@property (nonatomic,copy) NSString * douban_comment_url;
@property (nonatomic,copy) NSString * play_count;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * type;
//@property (nonatomic,copy) NSString<Optional> * episodes;
@property (nonatomic,copy) NSString<Optional> * episodes_count;
@property (nonatomic,copy) NSString<Optional> * is_following;
@property (nonatomic,copy) NSString<Optional> * language;
//@property (nonatomic,copy) NSString<Optional> * lost_episodes;
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * avg_score;

@property (nonatomic,strong) NSArray<EpisodeModel> * episodes;
@property (nonatomic,strong) NSArray<ActorModel> * actors;
@property (nonatomic,strong) NSArray<DirectorModel> * directors;
@property (nonatomic,strong) NSArray<AddressModel> * play_addresses;

@property (nonatomic,copy) NSString<Optional> * cellHeight;

@end
