//
//  XWSelectSlider.m
//  QX20151125
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define ItemWidth 80
#define Button_Tag 100
#define ItemHeight self.bounds.size.height
#import "XWSelectSlider.h"

@interface XWSelectSlider ()

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView * sliderView;
@end
@implementation XWSelectSlider

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)sliderView {
    if (_sliderView == nil) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        _sliderView.layer.cornerRadius = 5;
        _sliderView.layer.borderWidth = 1;
        _sliderView.layer.borderColor = [UIColor grayColor].CGColor;
        _sliderView.layer.masksToBounds = YES;
    }
    return _sliderView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    [self.scrollView addSubview:self.sliderView];
}




- (void)setItemTitles:(NSArray *)itemTitles {
    _itemTitles = itemTitles;
    
    self.sliderView.frame = CGRectMake(0, 0, ItemWidth, ItemHeight);
    self.scrollView.contentSize = CGSizeMake(ItemWidth * itemTitles.count, ItemHeight);
    
    for (int i = 0; i< itemTitles.count; i++) {
        UIButton * button = [[UIButton alloc] init];
        button.frame = CGRectMake(ItemWidth * i , 0, ItemWidth, ItemHeight);
        [button setTitle:itemTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = Button_Tag + i;
        [self.scrollView addSubview:button];
    }
    
}

- (void)buttonClicked:(UIButton *)button {
    NSInteger index = button.tag - Button_Tag;
    
    if (self.itemClick) {
        _itemClick(index);
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.sliderView.frame = CGRectMake(ItemWidth * index, 0, ItemWidth, ItemHeight);
    }];
    
}





















@end
