//
//  BaseViewController.h
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
@property (nonatomic,strong) DBManager * dbManager;

- (void)addUI;
- (void)initDataSource;
- (void)setNavigationBar;
- (void)loadData;
- (void)loadDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict;


- (void)paseWithDictionary:(NSDictionary *)responseObject;
- (void)paseWithArray:(NSArray *)responseObject;
@end
