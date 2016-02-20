//
//  EpisodeOtherCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "EpisodeOtherCell.h"
#import "EpisodeModel.h"

@interface EpisodeOtherCell ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation EpisodeOtherCell

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 200);
    }
    return _scrollView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    [self.contentView addSubview:self.scrollView];
}

- (void)setEpisodesArray:(NSArray *)episodesArray {
    _episodesArray = episodesArray;
    
    CGFloat Gap = 20;
    CGFloat itemHeight = 30;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, (Gap + itemHeight) * episodesArray.count);
    
    for (int i = 0; i < episodesArray.count; i++) {
        EpisodeModel * model = episodesArray[i];
        UIButton * button = [[UIButton alloc] init];
        button.frame = CGRectMake(Gap, Gap + (itemHeight + Gap)* i, SCREEN_SIZE.width - 2 * Gap, itemHeight);
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:[NSString stringWithFormat:@"第%@期:%@",model.ID,model.title] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:@"episode_btn_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:@"episode_btn_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        button.selected = NO;
        button.tag = [model.ID intValue];
        
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
}

- (void)buttonClicked:(UIButton *)button {
    NSInteger index = button.tag;
    button.selected = YES;
    
    if (self.episodeClcked) {
        _episodeClcked(index);
    }
}

@end
