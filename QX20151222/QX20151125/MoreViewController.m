//
//  MoreViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreViewController.h"
#import "XWMoreViewCell.h"
#import "SysSetController.h"
#import "SysMsgViewController.h"
#import "RelateMsgController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController{
    NSMutableArray * _titles;
}

- (void)addUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titles = @[@[@[@"more_1_0",@"系统设置"],@[@"more_1_2",@"系统消息"]],@[@[@"more_1_4",@"相关信息"],@[@"more_2_1",@"官方微博"]]];
    [self.dataSource addObjectsFromArray:titles];
}

-(void)setNavigationBar {
    [super setNavigationBar];
    self.navigationItem.title = @"更多";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWMoreViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"momer"];
    if (cell == nil) {
        cell = [[XWMoreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"momer"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString * name = self.dataSource[indexPath.section][indexPath.row][0];
    cell.leftImageView.image = [UIImage imageNamed:name];
    cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row][1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SysSetController * set = [[SysSetController alloc] init];
            set.title = self.dataSource[indexPath.section][indexPath.row][1];
            [self.navigationController pushViewController:set animated:YES];
        }else if (indexPath.row == 1) {
            SysMsgViewController * msg = [[SysMsgViewController alloc] init];
            msg.title = self.dataSource[indexPath.section][indexPath.row][1];
            [self.navigationController pushViewController:msg animated:YES];
        }
    }else {
        if (indexPath.row ==0) {
            RelateMsgController * relate = [[RelateMsgController alloc] init];
            relate.title = self.dataSource[indexPath.section][indexPath.row][1];
            [self.navigationController pushViewController:relate animated:YES];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.weibo.com/u/3299986041"]];
        }
    }
}

@end
