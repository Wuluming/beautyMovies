//
//  XWDetailController.h
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
@class ContentModel;
@interface XWDetailController : BaseViewController

@property (nonatomic,strong) ContentModel * model;

@property (nonatomic,copy) NSString * play_id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * type;

@end
