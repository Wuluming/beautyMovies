//
//  ContentModel.h
//  QX20151125
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
@class LineModel;
@interface ContentModel : JSONModel

@property (nonatomic,strong) NSString * detail_url;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,strong) LineModel * line1;
@property (nonatomic,strong) LineModel * line2;
@property (nonatomic,strong) NSString * play_url;
@property (nonatomic,strong) NSString * title;

@end
