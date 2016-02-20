//
//  ShareCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Gap 20
#define MiddleGap 30
#define Width (SCREEN_SIZE.width - 2*Gap - 3 *MiddleGap)/4
#define Height 60
#define Button_Tag 1000
#import "ShareCell.h"
#import "XWButton.h"

@implementation ShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)addUI{
    
    NSArray * titles = @[@"评分",@"分享",@"收藏",@"缓存"];
    NSArray * images = @[@"icon_score",@"icon_share",@"icon_favorite",@"icon_download"];
    for (int i = 0; i < 4; i++) {
        XWButton * button = [[XWButton alloc] initWithFrame:CGRectMake(Gap + (Width + MiddleGap)*i, 0, Width, Height)];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",images[i]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        button.tag = Button_Tag + i;
        button.selected = NO;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}

#pragma mark - 按钮点击事件
- (void)buttonClicked:(UIButton *)button {
    button.selected = YES;
    NSInteger index = button.tag - Button_Tag;
    if (self.shareClick) {
        _shareClick(index);
    }
}
@end
