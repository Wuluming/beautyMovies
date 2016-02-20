//
//  MainViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#define Item_Width 120

#define URL @"https://jp.kankan.1kxun.mobi/api/homePageItemsForPhone"
#define TITLE_SCROLL_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections"
#define HOT_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections/1.json"
#define MOTIVATIONAL_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections/93.json"
#define EMPIRE_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections/94.json"
#define GODDESS_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections/95.json"
#define THEATER_FILM_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections/96.json"
#define OCTOBER_URL @"https://jp.kankan.1kxun.mobi/api/homePageVideoCollections/97.json"


#import "MainViewController.h"
#import "mainModel.h"
#import "UIImageView+WebCache.h"
#import "XWScrollView.h"
#import "XWImageView.h"
#import "HTTPTool.h"
#import "XWSliderBar.h"
#import "ContentModel.h"
#import "LineModel.h"
#import "MianItemCell.h"
#import "XWDetailController.h"
#import "AudioPlayerViewController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    XWScrollView * _scrollView;
}

@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) XWSliderBar * sliderBar;
@property (nonatomic,strong) UIScrollView * downScroll;
@property (nonatomic,strong) NSMutableArray * downDataSource;
@end

@implementation MainViewController
#pragma mark - 懒加载

- (NSMutableArray *)downDataSource {
    if (_downDataSource == nil) {
        _downDataSource = [NSMutableArray new];
    }
    return _downDataSource;
}

- (XWSliderBar *)sliderBar {
    if (_sliderBar == nil) {
        _sliderBar = [[XWSliderBar alloc] initWithFrame:CGRectMake(0, 170, SCREEN_SIZE.width, 44)];
        _sliderBar.backgroundColor = [UIColor grayColor];
        self.sliderBar.itemTitles = [NSMutableArray arrayWithArray:@[@"精彩推荐",@"乐视专区",@"经典谍战剧",@"热播喜剧",@"综艺大观"]];
        __weak MainViewController *  weakSelf = self;
        self.sliderBar.itemClick = ^(NSInteger index) {
            [weakSelf sliderBarChangeDownTableViewWith:index];
        };
        [self sliderBarChangeDownTableViewWith:0];
    }
    return _sliderBar;
}

- (UIScrollView *)downScroll {
    if (_downScroll == nil) {
        _downScroll = [[UIScrollView alloc] init];
        _downScroll.frame = CGRectMake(0, 214, SCREEN_SIZE.width, SCREEN_SIZE.height - 48 - 214);
        _downScroll.contentSize = CGSizeMake(_downScroll.bounds.size.width * 5, _downScroll.bounds.size.height);
        _downScroll.pagingEnabled = YES;
        _downScroll.delegate = self;
        _downScroll.showsHorizontalScrollIndicator = NO;
    }
    return _downScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addUI];
    
    [self loadData];
}

#pragma mark - 数据请求
- (void)loadData {
    [self loadScrollData];
}

- (void)loadScrollData {
    [HTTPTool getDataWithPath:URL Parameter:nil success:^(id JSON) {
        [self parseData:JSON];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)parseData:(id)JSON {
    NSArray * data = JSON[@"data"];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (NSDictionary * item  in data) {
        mainModel * model = [[mainModel alloc] initWithDictionary:item error:nil];
        model.ID = item[@"id"];
        [temp addObject:model];
    }
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    [_dataSource removeAllObjects];
    
    [_dataSource addObjectsFromArray:temp];
    
    [_scrollView loadDataWithArray:_dataSource];
}

#pragma mark - 添加UI
- (void)addUI {
    _scrollView = [[XWScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_SIZE.width, 150)];
    [self.view addSubview:_scrollView];
    
    [self.view addSubview:self.sliderBar];
    
    [self.view addSubview:self.downScroll];
    
    [self adddownTableView];
}
#pragma mark 添加下部的内容TableView

- (void)adddownTableView {
    for (int i = 0; i < 5; i++) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.downScroll.bounds.size.width * i, 0,self.downScroll.bounds.size.width, self.downScroll.bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.alwaysBounceHorizontal = NO;
        tableView.alwaysBounceVertical = NO;
        tableView.tag = 11 + i;
        [self.downScroll addSubview:tableView];
    }
}

#pragma mark 实现UITableView代理和数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.downDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MianItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
    if (cell == nil) {
        cell = [[MianItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aCell"];
    }
    ContentModel * model = self.downDataSource[indexPath.row];
    cell.model = model;
    cell.playBlock = ^(){
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MainItemCell_Height;
}

#pragma mark -TableView的协议方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XWDetailController * detail = [[XWDetailController alloc] init];
    
    ContentModel * model = self.downDataSource[indexPath.row];
    detail.name = model.title;
    detail.play_id = [model.detail_url lastPathComponent];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showDeterminateProgressWithTitle:@"视频加载中" status:@"请稍等"];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [MMProgressHUD dismiss];
}



#pragma mark - 点击sliderBar，调节对应的内容tableView

- (void)sliderBarChangeDownTableViewWith:(NSInteger)index {
    [self.downScroll setContentOffset:CGPointMake(self.downScroll.bounds.size.width * index, 0) animated:YES];
    NSString * url = nil;
    switch (index) {
        case 0:
            url = MOTIVATIONAL_URL;
            break;
        case 1:
            url = GODDESS_URL;
            break;
        case 2:
            url = EMPIRE_URL;
            break;
        case 3:
            url = THEATER_FILM_URL;
            break;
        case 4:
            url = OCTOBER_URL;
            break;
        default:
            break;
    }
    
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
//    [MMProgressHUD showDeterminateProgressWithTitle:@"下载中" status:@"loading"];
    
    [HTTPTool getDataWithPath:url Parameter:nil success:^(id JSON) {
        [self parseDownData:JSON withIndex:index];
//        [MMProgressHUD dismissWithSuccess:@"下载成功"];
    } failure:^(NSError *error) {
//        [MMProgressHUD dismissWithError:@"下载失败"];
    }];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self sliderBarChangeDownTableViewWith:index];
    [self.sliderBar setItemAtIndex:index];
}

- (void)parseDownData:(id)JSON withIndex:(NSInteger)index{
    NSArray * array = JSON[@"items"];
    
    [self.downDataSource removeAllObjects];
    [self.downDataSource addObjectsFromArray:[ContentModel arrayOfModelsFromDictionaries:array]];
    
    UITableView * tableView = (id)[self.view viewWithTag:11 + index];
    [tableView reloadData];
}















@end
