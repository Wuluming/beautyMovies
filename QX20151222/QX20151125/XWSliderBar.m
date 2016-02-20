//
//  XWSliderBar.m
//  QX20151125
//
//  Created by qianfeng on 15/12/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Item_Width 120
#define Button_Tag 100
#import "XWSliderBar.h"

@interface XWSliderBar ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation XWSliderBar

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.scrollView];
}

- (void)setItemTitles:(NSMutableArray *)itemTitles {
    _itemTitles = itemTitles;
    self.scrollView.contentSize = CGSizeMake(Item_Width*itemTitles.count, self.bounds.size.height);
    for (int i = 0; i < itemTitles.count; i++) {
        
        UIButton * button = [[UIButton alloc] init];
        button.frame = CGRectMake(Item_Width * i , 0, Item_Width, _scrollView.bounds.size.height);
        [button setTitle:itemTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        button.tag = Button_Tag + i;
        [self.scrollView addSubview:button];
    }
}


- (void)buttonClicked:(UIButton *)button {
    NSInteger index = button.tag - Button_Tag;
    if (self.itemClick) {
        _itemClick(index);
    }
}

- (void)setItemAtIndex:(NSInteger)index {
    if (index == 1) {
        [self.scrollView setContentOffset:CGPointMake(Item_Width, 0) animated:YES];
    }
    if (index == 2) {
        [self.scrollView setContentOffset:CGPointMake(Item_Width * 2, 0) animated:YES];
    }
}




@end
