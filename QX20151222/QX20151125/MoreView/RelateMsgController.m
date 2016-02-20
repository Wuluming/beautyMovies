//
//  RelateMsgController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RelateMsgController.h"

@interface RelateMsgController ()

@end

@implementation RelateMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
}

- (void)addView {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 200)];
    label.text = @"负责声明:\n本软件中的视频内容与搜索结果均系通过搜索引擎技术从第三方自动获取，请自觉支持正版";
    label.font = [UIFont systemFontOfSize:20];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
}

@end

