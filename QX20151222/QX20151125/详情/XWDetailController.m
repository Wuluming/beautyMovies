//
//  XWDetailController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Video_URL  @"https://jp.kankan.1kxun.mobi/api/videos/%@.json"
#import "XWDetailController.h"
#import "ContentModel.h"
#import "DeatailModel.h"
#import "ActorModel.h"
#import "DirectorModel.h"
#import "AddressModel.h"
#import "EpisodeModel.h"
#import "DetailCell.h"
#import "ShareCell.h"
#import "DescCell.h"
#import "EpisodesCell.h"
#import "EpisodeOtherCell.h"
#import "DouBanViewController.h"
#import "AudioPlayerViewController.h"
#import "DBManager.h"
#import "UMSocial.h"
@interface XWDetailController ()

@property (nonatomic,strong) DeatailModel * detailModel;

@end

@implementation XWDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (DeatailModel *)detailModel {
    if (_detailModel == nil) {
        _detailModel = [[DeatailModel alloc] init];
    }
    return _detailModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setNavigationBar {
    
    self.title = _name;
}



-(void)loadData {
    NSString * path = [NSString stringWithFormat:Video_URL,self.play_id];
    [self loadDataWithPath:path Parameter:nil];
}
- (void)paseWithDictionary:(NSDictionary *)responseObject {
    self.detailModel = [[DeatailModel alloc] initWithDictionary:responseObject error:nil];
    self.detailModel.play_id = _play_id;
    self.detailModel.descriptionStr = responseObject[@"description"];
    NSArray * actors = responseObject[@"actors"];
    int i = 0;
    for (NSDictionary * dict in actors) {
        ActorModel * model =self.detailModel.actors[i];
        model.ID = dict[@"id"];

        i++;
    }
    NSArray * directors = responseObject[@"directors"];
    int j = 0;
    for (NSDictionary * dict in directors) {
        DirectorModel * model = self.detailModel.directors[j];
        model.ID = dict[@"id"];
        j++;
    }
    
    NSArray * episodes = responseObject[@"episodes"];
    int m = 0;
    for (NSDictionary * dict in episodes) {
        EpisodeModel * model = self.detailModel.episodes[m];
        model.ID = [NSString stringWithFormat:@"%@",dict[@"id"]];
        model.Description = dict[@"description"];
        m++;
    }
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    switch (indexPath.row) {
        case 0:
            cell = [self tableView:tableView playCellForRowAtIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableView:tableView sharCellForRowAtIndexPath:indexPath];
            break;
        case 2:
            cell = [self tableView:tableView descCellForRowAtIndexPath:indexPath];
            break;
        case 3:
            
            if ([_type isEqualToString:@"variety"] || [_type isEqualToString:@"variety"] || [_type isEqualToString:@"sport"] || [_type isEqualToString:@"game"] || [_type isEqualToString:@"music"] || [_type isEqualToString:@"tech"]) {
                cell = [self tableView:tableView OtherCellForRowAtIndexPath:indexPath];
            }else {
                cell = [self tableView:tableView episodesCellForRowAtIndexPath:indexPath];
            }
    
            break;
        case 4:
            cell = [self tableView:tableView doubanCellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }

    return cell;
}
#pragma mark - 创建第一个playCell

- (UITableViewCell *)tableView:tableView playCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"playCell"];
    if (cell == nil) {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"playCell"];
    }
    cell.detailModel = self.detailModel;
    cell.playBlock = ^(){
        AudioPlayerViewController * audio = [[AudioPlayerViewController alloc] init];
        audio.name = self.detailModel.title;
        audio.play_id = self.detailModel.play_id;
        audio.type = self.detailModel.type;
        [self.navigationController pushViewController:audio animated:NO];
        
    };
    return cell;
}



#pragma mark - 创建第二个sharCell
- (UITableViewCell *)tableView:tableView sharCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell"];
    if (cell == nil) {
        cell = [[ShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shareCell"];
    }
    cell.shareClick = ^(NSInteger index) {
        [self shareClikAtIndex:index];
    };
    return cell;
}

#pragma mark - 收藏，分享，点击事件
- (void)shareClikAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            //评分
            [self avgScore];
            break;
        case 1:
            //分享
            [self shareShow];
            break;
        case 2:
            //收藏
            [self.dbManager addModel:self.detailModel];
            [self alertShow];
            break;
            
        case 3:
            //缓存
            [self collectShow];
            break;
        default:
            break;
    }
}

- (void)collectShow {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提升" message:@"下载尚未实现" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"正确", nil];
    [alert show];
}

- (void)avgScore {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"评分" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * one = [UIAlertAction actionWithTitle:@"完美" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * two = [UIAlertAction actionWithTitle:@"很好" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * three = [UIAlertAction actionWithTitle:@"不错" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * four = [UIAlertAction actionWithTitle:@"一般" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * five = [UIAlertAction actionWithTitle:@"很差" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:one];
    [alert addAction:two];
    [alert addAction:three];
    [alert addAction:four];
    [alert addAction:five];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)shareShow {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5670c33067e58eb2300012c3"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:nil];
}

- (void)alertShow {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"OK" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sure];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 创建第三个descCell
- (UITableViewCell *)tableView:tableView descCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DescCell * cell = [tableView dequeueReusableCellWithIdentifier:@"descCell"];
    if (cell == nil) {
        cell = [[DescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"descCell"];
    }
    cell.model = self.detailModel;
    return cell;
}

#pragma mark - 创建第四个episodesCell


- (UITableViewCell *)tableView:(UITableView *)tableView OtherCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EpisodeOtherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EpisodeOtherCell"];
    if (cell == nil) {
        cell = [[EpisodeOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EpisodeOtherCell"];
    }
    
    cell.episodesArray = self.detailModel.episodes;
    cell.episodeClcked = ^(NSInteger index){
        AudioPlayerViewController * audio = [[AudioPlayerViewController alloc] init];
        audio.name = self.detailModel.title;
        audio.play_id = self.detailModel.play_id;
        audio.type = self.detailModel.type;
        audio.episode_id = index;
        [self.navigationController pushViewController:audio animated:YES];
        
    };
    return cell;
}

- (UITableViewCell *)tableView:tableView episodesCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EpisodesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"episodesCell"];
    if (cell == nil) {
        cell = [[EpisodesCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"episodesCell"];
    }
    
    cell.episodes = [self.detailModel.episodes_count intValue];
    
    cell.episodeClcked = ^(NSInteger index){
        AudioPlayerViewController * audio = [[AudioPlayerViewController alloc] init];
        audio.name = self.detailModel.title;
        audio.play_id = self.detailModel.play_id;
        audio.type = self.detailModel.type;
        audio.episode_id = index;
        [self.navigationController pushViewController:audio animated:YES];
        
    };
    return cell;
}

#pragma mark - 创建第五个doubanCell
- (UITableViewCell *)tableView:tableView doubanCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"doubanCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"doubanCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"豆瓣精彩影评";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = @"欣赏影评";
    }
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cell_hight = 0;
    switch (indexPath.row) {
        case 0:
            cell_hight = kDetailCell_Height;
            break;
        case 1:
            cell_hight = 60;
            break;
        case 2:
            cell_hight = [self.detailModel.cellHeight floatValue];
            break;
        case 3:
            if ([self.detailModel.episodes_count floatValue] != 0 ) {
                return cell_hight = 200;
            }
            cell_hight = 0;
            break;
        case 4:
            cell_hight = 44;
        default:
            break;
    }
    return cell_hight;
}

#pragma mark - Cell的点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        DouBanViewController * douBan = [[DouBanViewController alloc] init];
        douBan.douBanURL = self.detailModel.douban_comment_url;
        douBan.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:douBan animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}


@end
