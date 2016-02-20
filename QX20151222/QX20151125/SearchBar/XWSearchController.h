//
//  XWSearchController.h
//  UITableViewSearchBar
//
//  Created by qianfeng on 15/11/10.
//  Copyright (c) 2015年 xiaowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSearchController : UISearchController
//数据源
@property (nonatomic,retain) NSMutableArray * dataSource;
//重新加载数据
- (void)reloadSearchResults;
@end
