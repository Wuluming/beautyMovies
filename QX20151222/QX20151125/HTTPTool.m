//
//  HTTPTool.m
//  QX20151125
//
//  Created by qianfeng on 15/12/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HTTPTool.h"
#import "AFHTTPRequestOperationManager.h"
@implementation HTTPTool

+ (void)getDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestDataWithPath:path Parameter:dict success:success failure:failure method:@"GET"];
}

+ (void)postDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestDataWithPath:path Parameter:dict success:success failure:failure method:@"POST"];
}

+ (void)requestDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"application/json", nil];
    
    
    NSMutableDictionary * allParams = [NSMutableDictionary dictionary];
    if (dict) {
        [allParams setDictionary:dict];
    }
    if ([method isEqualToString:@"GET"]) {
        [manager GET:path parameters:allParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success == nil) return;
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure == nil) return;
            failure(error);
        }];
    }else if ([method isEqualToString:@"POST"]) {
        [manager POST:path parameters:allParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success == nil) return;
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure == nil) return;
            failure(error);
        }];
    }
    

}


@end
