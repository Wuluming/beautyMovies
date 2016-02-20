//
//  ActorModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@protocol ActorModel
@end

@interface ActorModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString<Optional> * weibo_id;

@end
