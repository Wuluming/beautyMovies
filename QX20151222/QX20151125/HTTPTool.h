//
//  HTTPTool.h
//  QX20151125
//
//  Created by qianfeng on 15/12/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(NSError * error);

@interface HTTPTool : NSObject

+ (void)getDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+ (void)postDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
@end
