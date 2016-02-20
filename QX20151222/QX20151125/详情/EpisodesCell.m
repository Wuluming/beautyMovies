//
//  EpisodesCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#import "EpisodesCell.h"

@interface EpisodesCell ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation EpisodesCell

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
- (void)setEpisodes:(int)episodes {
    _episodes = episodes;
    CGFloat Gap = 20;
    CGFloat MidGap = 20;
    CGFloat itemWidth = (SCREEN_SIZE.width - Gap * 2 - 2 * MidGap)/3;
    CGFloat itemHeight = 30;
    int index = episodes/3;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, (Gap + itemHeight) * (index + 1));
    
    for (int i = 0; i < episodes; i++) {
        UIButton * button = [[UIButton alloc] init];
        button.frame = CGRectMake(Gap + (itemWidth + MidGap) * (i%3), Gap+(Gap + itemHeight) * (i /3), itemWidth, itemHeight);
        [button setBackgroundColor:[UIColor grayColor]];
        
        [button setTitle:[NSString stringWithFormat:@"第%d集",i + 1] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:@"episode_btn_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:@"episode_btn_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        button.selected = NO;
        button.tag = i;
        
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
