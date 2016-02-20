//
//  MsgModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface MsgModel : JSONModel

@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *type_name;
@property (nonatomic,copy) NSString<Optional> *ID;

@property (nonatomic,copy) NSString<Optional> *height;
@end
