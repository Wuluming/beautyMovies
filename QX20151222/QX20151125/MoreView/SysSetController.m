//
//  SysSetController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SysSetController.h"

@interface SysSetController ()

@end

@implementation SysSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadData {
    
    NSInteger data = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    [self.dataSource addObject:[NSString stringWithFormat:@"%ld",data]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aCell"];
    }
    cell.textLabel.text = @"清空图片缓存";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@M",self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[SDImageCache sharedImageCache] clearDisk];
    self.dataSource[indexPath.row] = @"0";
    [self.tableView reloadData];
}

@end
