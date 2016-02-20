//
//  XWScrollView.m
//  自己定制Cell
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 xiaowu. All rights reserved.
//

#import "XWScrollView.h"
#import "XWImageView.h"
#import "mainModel.h"
@implementation XWScrollView
{
    UIScrollView *_scrollView;
    UIPageControl * _pageControll;
//    UILabel * _titleLabel;
    NSMutableArray * _imageNames;
    NSInteger _count;
    NSTimer * _timer;
}

- (void)dealloc
{
    [_scrollView release];
    [_pageControll release];
//    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加子视图
        [self addSubviews];
        
        //开辟空间
        _imageNames = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addSubviews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    
    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2-60, self.frame.size.height-24, 120, 24)];
    _pageControll.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControll.pageIndicatorTintColor = [UIColor whiteColor];
    [_pageControll addTarget:self action:@selector(pagging:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 24, self.frame.size.width,24)];
//    _titleLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
//    _titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControll];
//    [self addSubview:_titleLabel];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerGo:) userInfo:nil repeats:YES];
}

- (void)timerGo:(NSTimer *)timer {
    NSInteger currentpage = _scrollView.contentOffset.x / SCREEN_SIZE.width;
    [_scrollView setContentOffset:CGPointMake((currentpage + 1) * SCREEN_SIZE.width, 0) animated:YES];
}

- (void)loadDataWithArray:(NSArray *)arr {
    _count = arr.count;
    //填充滚动视图
    _scrollView.contentSize = CGSizeMake((arr.count + 1) * self.frame.size.width, self.frame.size.height);
    for (int i = 0; i < arr.count + 1; i++) {
        XWImageView * imageView = [[XWImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        if (i == arr.count) {
            mainModel * model = arr[0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.retina_image_path]];
        }else {
            mainModel * model = arr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.retina_image_path]];
        }
        [_scrollView addSubview:imageView];
        [imageView release];
    }
    _imageNames.array = arr;
}

- (void)pagging:(UIPageControl *)pc {
    NSInteger currentPage = pc.currentPage;
    if (currentPage == _count) {
        pc.currentPage = 0;
        [_scrollView setContentOffset:CGPointZero animated:NO];
    }else {
        [_scrollView setContentOffset:CGPointMake(currentPage * self.frame.size.width, 0) animated:YES];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / self.frame.size.width;
    
    if (currentPage == _count) {
        _pageControll.currentPage = 0;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }else {
        _pageControll.currentPage = currentPage;
    }
}



@end
