//
//  XWSearchController.m
//  UITableViewSearchBar
//
//  Created by qianfeng on 15/11/10.
//  Copyright (c) 2015年 xiaowu. All rights reserved.
//

#import "XWSearchController.h"
#import "XWDetailController.h"
#import "SearchCell.h"
#import "PublicModel.h"
@interface XWSearchController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UINavigationController * nav;

@property (nonatomic,retain) UITableViewController * tvc;

@end

@implementation XWSearchController



- (instancetype)init {
    
    _tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    _tvc.tableView.delegate = self;
    _tvc.tableView.dataSource = self;
    _nav= [[UINavigationController alloc] initWithRootViewController:_tvc];
    if (self = [super initWithSearchResultsController:_tvc]) {
        self.searchBar.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44);
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)reloadSearchResults {
    [_tvc.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
    if (cell == nil) {
        cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aCell"];
    }
    
    cell.model = _dataSource[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ResearchCell_Height;
}

- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = NO;
    [super viewDidLoad];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XWDetailController * detail = [[XWDetailController alloc] init];
    PublicModel * model = self.dataSource[indexPath.row];
    detail.name = model.title;
    detail.play_id = [model.play_url lastPathComponent];
    [self.nav.navigationController pushViewController:detail animated:NO];
}

@end
