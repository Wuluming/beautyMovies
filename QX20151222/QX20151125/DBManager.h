//
//  DBManager.h
//  QX20151125
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DeatailModel;
@interface DBManager : NSObject

+ (id)defaultDBmanager;

- (void)addModel:(DeatailModel *)model;

- (void)deleteModel:(DeatailModel *)model;

- (NSArray *)allModel;

@end
