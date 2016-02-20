//
//  PublicViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#define Search_URL @"https://jp.kankan.1kxun.mobi/api/search.json?word=%@&page=0"
#define AutoCompleteURL @"https://jp.kankan.1kxun.mobi/api/search/autoComplete.json?word=%@"
#define SquareURL @"https://jp.kankan.1kxun.mobi/api/squares"

#import "PublicViewController.h"
#import "XWSearchController.h"
#import "HTTPTool.h"
#import "GDataXMLNode.h"
#import "XWDetailController.h"
#import "PublicTwoCell.h"
#import "ContentModel.h"
#import "PublicModel.h"
@interface PublicViewController ()<UISearchResultsUpdating>
{
    XWSearchController * _searchController;
}
@end

@implementation PublicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _searchController = [[XWSearchController alloc] init];
    _searchController.searchBar.placeholder = @"请输入片名";
    _searchController.searchResultsUpdater = self;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.tableHeaderView = _searchController.searchBar;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString * path = [NSString stringWithFormat:Search_URL,_searchController.searchBar.text];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [HTTPTool getDataWithPath:path Parameter:nil success:^(id JSON) {
        NSArray * array = JSON[@"data"];
        [_searchController.dataSource removeAllObjects];
        [_searchController.dataSource addObjectsFromArray:[PublicModel arrayOfModelsFromDictionaries:array]];
        [_searchController reloadSearchResults];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadData {
    NSString * xmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:SquareURL] encoding:NSUTF8StringEncoding error:nil];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    NSArray * images = [doc nodesForXPath:@"//image" error:nil];
    NSArray * urls = [doc nodesForXPath:@"//url" error:nil] ;
    NSMutableArray * temp1 = [[NSMutableArray alloc] init];
    for (GDataXMLElement * ele in images) {
        [temp1 addObject:[ele stringValue]];
    }
    [self.dataSource addObject:temp1];
    
    NSMutableArray * temp2 = [[NSMutableArray alloc] init];
    for (GDataXMLElement * ele in urls) {
        [temp2 addObject:[[ele stringValue] lastPathComponent]];
    }
    [self.dataSource addObject:temp2];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PublicTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell"];
    if (cell == nil) {
        cell = [[PublicTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OneCell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.arr = @[self.dataSource[0][3],self.dataSource[0][5]];
            break;
        case 1:
            cell.arr = @[self.dataSource[0][4]];
            break;
        case 2:
            cell.arr = @[self.dataSource[0][0],self.dataSource[0][1]];
            break;
        case 3:
            cell.arr = @[self.dataSource[0][2]];
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PublicCell_Height;
}




















@end
