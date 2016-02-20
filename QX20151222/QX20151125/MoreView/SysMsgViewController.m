//
//  SysMsgViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define MsgURL @"http://kankan.1kxun.com/video_kankan_tags/v2/api/messages.json"

#import "SysMsgViewController.h"
#import "HTTPTool.h"
#import "MsgModel.h"
#import "MsgCell.h"
@interface SysMsgViewController ()

@end

@implementation SysMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadData {
    [HTTPTool getDataWithPath:MsgURL Parameter:nil success:^(id JSON) {
        [self paseWithDictionary:JSON];
    } failure:^(NSError *error) {
        
    }];
}

- (void)paseWithDictionary:(NSDictionary *)responseObject {
    NSArray * array = responseObject[@"data"];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dict = array[i];
        MsgModel * model = [[MsgModel alloc] initWithDictionary:dict error:nil];
        model.ID = dict[@"id"];
        [temp addObject:model];
    }
    
    [self.dataSource addObjectsFromArray:temp];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"msgCell"];
    if (cell == nil) {
        cell = [[MsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"msgCell"];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgModel * model = self.dataSource[indexPath.row];
    return [model.height floatValue] + 10;
}









@end
