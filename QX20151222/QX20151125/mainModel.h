//
//  mainModel.h
//  QX20151125
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface mainModel : JSONModel

@property (nonatomic,strong) NSString * click_url;
@property (nonatomic,strong) NSString<Optional> * ID;
@property (nonatomic,strong) NSString * image_path;
@property (nonatomic,strong) NSString * is_ad;
@property (nonatomic,strong) NSString * retina_image_path;
@end
