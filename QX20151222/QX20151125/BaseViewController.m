//
//  BaseViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (DBManager *)dbManager {
    if (_dbManager == nil) {
        _dbManager = [DBManager defaultDBmanager];
    }
    return _dbManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBar];
    
    [self initDataSource];
    
    [self addUI];
    
    [self loadData];
}

- (void)loadData {
}


- (void)loadDataWithPath:(NSString *)path Parameter:(NSDictionary *)dict {
    [_manager GET:path parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseWithDictionary:responseObject];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)paseWithDictionary:(NSDictionary *)responseObject {
    
}

- (void)paseWithArray:(NSArray *)responseObject {
    
}

- (void)addUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    return cell;
}

- (void)setNavigationBar {
    self.navigationController.navigationBar.translucent = NO;
}

- (void)initDataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
}

@end
