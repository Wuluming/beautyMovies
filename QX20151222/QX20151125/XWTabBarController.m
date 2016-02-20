//
//  XWTabBarController.m
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XWTabBarController.h"
#import "XWNavigationController.h"
#import "MainViewController.h"
#import "ChannelViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "PublicViewController.h"
@interface XWTabBarController ()

@end
#define Button_Tag 10
@implementation XWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tabBar setHidden:YES];
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    
    [self addControllers];
    
}

- (void)addControllers {
    NSArray * controllers = @[@"MainViewController",@"ChannelViewController",@"MineViewController",@"PublicViewController",@"MoreViewController"];
    NSArray * barTitles = @[@"首页",@"频道",@"我的",@"广场",@"更多"];
    NSArray *selectedImages=@[@"menu_selected_1",@"menu_selected_2",@"menu_selected_3",@"menu_selected_4",@"menu_selected_5"];
    NSArray * images=@[@"menu_default_1",@"menu_default_2",@"menu_default_3",@"menu_default_4",@"menu_default_5"];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < controllers.count; i++) {
        Class class = NSClassFromString(controllers[i]);
        UIViewController * vc = [[class alloc] init];
        vc.title = barTitles[i];
        XWNavigationController * nav = [[XWNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:barTitles[i] image:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        vc.tabBarItem = item;
        [temp addObject:nav];
    }
    self.viewControllers = temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
