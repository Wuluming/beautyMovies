//
//  DBManager.m
//  QX20151125
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DBManager.h"
#import "DeatailModel.h"
@implementation DBManager{
    FMDatabase * _db;
}

+ (id)defaultDBmanager {
    static DBManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self prepareDB];
    }
    return self;
}

- (void)prepareDB {
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/db"];
    if (_db == nil) {
        _db = [[FMDatabase alloc] initWithPath:path];
    }
    [_db open];
    [self createDataList];
}

- (void)createDataList {
//    play_id
//    title;
//    image;
//    avg_score
    NSString * sql = @"create table if not exists APP(ID integer primary key autoincrement,play_id varcher(50),title varcher(50),image varcher(200),avg_score varcher(50));";
    BOOL success = [_db executeUpdate:sql];
    if (success) {
        MyLog(@"表单创建成功");
    }
}

- (void)addModel:(DeatailModel *)model {
    NSString * sql = @"insert into APP(play_id,title,image,avg_score) values (?,?,?,?);";
    BOOL success = [_db executeUpdate:sql,model.play_id,model.title,model.image,model.avg_score];
    if (success) {
        MyLog(@"保存信息成功");
    }
}

- (void)deleteModel:(DeatailModel *)model {
    NSString * sql = @"delete from APP where play_id = ?;";
    BOOL success = [_db executeUpdate:sql,model.play_id];
    if (success) {
        MyLog(@"删除信息成功");
    }
}

- (NSArray *)allModel {
    NSString * sql = @"select * from APP";
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    while (set.next) {
        DeatailModel * model = [[DeatailModel alloc] init];
        model.play_id = [set stringForColumn:@"play_id"];
        model.title = [set stringForColumn:@"title"];
        model.image = [set stringForColumn:@"image"];
        model.avg_score = [set stringForColumn:@"avg_score"];
        [temp addObject:model];
    }
    return temp;
}
@end
