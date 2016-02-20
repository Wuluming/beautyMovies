//
//  ChannelViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define ChannelURL @"https://jp.kankan.1kxun.mobi/api/videos/channels.json"
#define AllYears @"https://jp.kankan.1kxun.mobi/api/videos/all_years"
#define AllTags @"https://jp.kankan.1kxun.mobi/api/videos/all_tags"
#define AllAreas @"https://jp.kankan.1kxun.mobi/api/videos/all_areas"
#define VideoURL1 @"https://jp.kankan.1kxun.mobi/api/videos.json?type=%@&page=%ld"
#define VideoURL2 @"https://jp.kankan.1kxun.mobi/api/videos.json?type=%@"
#define TagURL @"https://jp.kankan.1kxun.mobi/api/tags.json?video_id=%@"
#import "ChannelViewController.h"
#import "XWSelectSlider.h"
#import "HTTPTool.h"
#import "ChannelModel.h"
#import "ChannelCell.h"
#import "XWDetailController.h"
@interface ChannelViewController ()

@end

@implementation ChannelViewController
{
    NSArray * _ItemArray1;
    NSArray * _ItemArray1Type;
    NSArray * _ItemArray2;
    NSArray * _ItemArray2Type;
    XWSelectSlider * _bar1;
    XWSelectSlider * _bar2;
    NSInteger _item2ForItem1;
    NSInteger _item1ForItem2;
    NSInteger _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setNavigationBar {
    self.navigationController.navigationBarHidden = YES;
}

- (void)addUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_SIZE.width, SCREEN_SIZE.height -108)  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    [self.view addSubview:self.tableView];
    __weak ChannelViewController * weakSelf = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [weakSelf loadMoreData];
    }];
    [self addSliderBar];
}

- (void)loadMoreData {
    _index++;
    
    NSString * type = _ItemArray1Type[_item2ForItem1];
    NSString * path = [NSString stringWithFormat:VideoURL1,type,_index];
    [HTTPTool getDataWithPath:path Parameter:nil success:^(id JSON) {
        [self paseWithMoreData:JSON];
    } failure:^(NSError *error) {
        
    }];
}

- (void)paseWithMoreData:(id)JSON {
    NSArray * data = JSON[@"data"];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in data) {
        ChannelModel * model = [[ChannelModel alloc] initWithDictionary:dict error:nil];
        model.ID = dict[@"id"];
        [temp addObject:model];
    }
    [self.dataSource addObjectsFromArray:temp];
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
}

- (void)addSliderBar {
    __weak ChannelViewController * weakSelf = self;
    
    _bar1 = [[XWSelectSlider alloc] initWithFrame:CGRectMake(0, 20, SCREEN_SIZE.width, 44)];
    _bar1.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    
    _bar1.itemClick = ^(NSInteger item1Index){
        _item2ForItem1 = item1Index;
        [weakSelf item1AtIndex:item1Index item2AtIndex:0];
        
    };
    [self.view addSubview:_bar1];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bar1.frame), SCREEN_SIZE.width, 44)];
    view.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    _bar2 = [[XWSelectSlider alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 44)];
    
    NSInteger new = _item2ForItem1;
    _bar2.itemClick = ^(NSInteger item2Index){
        _item1ForItem2 = item2Index;
        [weakSelf item1AtIndex:new item2AtIndex:item2Index];
        
    };
    [view addSubview:_bar2];
    UIImage * image = [[UIImage imageNamed:@"my_qianxun_categery"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 60, 0, image.size.width, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"my_qianxun_categery_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(selectButton) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
    [self.view addSubview:view];
}

- (void)loadData {
    _ItemArray1 = @[@"电影",@"电视剧",@"综艺",@"动漫",@"体育",@"游戏",@"音乐",@"科教"];
    _bar1.itemTitles = [NSMutableArray arrayWithArray:_ItemArray1];
    
    _ItemArray1Type = @[@"movie",@"tv",@"variety",@"cartoon",@"sport",@"game",@"music",@"tech"];
    _ItemArray2 = @[@"默认",@"热播",@"好评",@"最新"];
    _ItemArray2Type = @[@"",@"order=top_played",@"order=top_rated",@"order=top_updated"];
    _bar2.itemTitles = [NSMutableArray arrayWithArray:_ItemArray2];
   
    [self item1AtIndex:0 item2AtIndex:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 0;
    }else {
        return self.dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return ChannelCell_Height;
    }
    return 44;
}

#pragma mark - 返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aCell"];
        }
        return cell;
    }
    
    ChannelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - cell点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        XWDetailController * detail = [[XWDetailController alloc] init];
        ChannelModel * model = self.dataSource[indexPath.row];
        detail.name = model.title;
        detail.play_id = model.ID;
        detail.type = model.type;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

#pragma mark -  漏斗选择年份，类别，地区

- (void)selectButton {
#warning 未实现
}

- (void)item1AtIndex:(NSInteger)item1Index item2AtIndex:(NSInteger)item2Index{
   
    
     NSString * type = nil;
    NSString * path = nil;
    
    if (_item2ForItem1 != item1Index) {
        type = _ItemArray1Type[_item2ForItem1];
    }else {
        type = _ItemArray1Type[item1Index];
    }
    
    if (_item2ForItem1 >3 || item1Index == 0) {
        path = [NSString stringWithFormat:VideoURL2,type];
    }
if (_item2ForItem1 < 4 ) {
        _index = 1;
        path = [NSString stringWithFormat:VideoURL1,type,_index];
        NSString * order = nil;
        if (item2Index == 0 && _item1ForItem2 > 0) {
            order = _ItemArray2Type[_item1ForItem2];
        }
        if (item2Index > 0) {
            if (_item1ForItem2 != item2Index) {
                order = _ItemArray2Type[item2Index];
            }else {
                order = _ItemArray2Type[_item1ForItem2];
            }
        }
        if (order) {
            NSString * newPath = path;
            path = [NSString stringWithFormat:@"%@&%@",newPath,order];
        }
    }
    
    [HTTPTool getDataWithPath:path Parameter:nil success:^(id JSON) {
        [self paseWithData:JSON];
    } failure:^(NSError *error) {
        
    }];
}

- (void)paseWithData:(id)responseObject {
    NSArray * data = responseObject[@"data"];
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in data) {
        ChannelModel * model = [[ChannelModel alloc] initWithDictionary:dict error:nil];
        model.ID = dict[@"id"];
        [temp addObject:model];
    }
    [self.dataSource addObjectsFromArray:temp];
    [self.tableView reloadData];
}



@end
