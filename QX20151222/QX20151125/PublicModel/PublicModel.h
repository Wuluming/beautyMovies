//
//  PublicModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface PublicModel : JSONModel

@property (nonatomic,copy) NSString * image_url;
@property (nonatomic,copy) NSString * line1_type;
@property (nonatomic,copy) NSString * line1_value;
@property (nonatomic,copy) NSString * line2_type;
@property (nonatomic,copy) NSString * line2_value;
@property (nonatomic,copy) NSString * play_url;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * url;

@end
