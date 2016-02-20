//
//  AddressModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@protocol AddressModel
@end

@interface AddressModel : JSONModel

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString *url;

@end
