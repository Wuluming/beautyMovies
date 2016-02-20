//
//  DouBanViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DouBanViewController.h"

@interface DouBanViewController ()

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation DouBanViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadView {
    UIWebView * webView = [[UIWebView alloc] init];
    self.view = webView;
    self.webView = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addUI {
}

- (void)loadData {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_douBanURL]];
    [self.webView loadRequest:request];
}


@end
