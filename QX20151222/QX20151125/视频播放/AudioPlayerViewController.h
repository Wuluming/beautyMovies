//
//  AudioPlayerViewController.h
//  QX20151125
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DeatailModel;
@interface AudioPlayerViewController : UIViewController

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * play_id;
@property (nonatomic,copy) NSString * type;

@property (nonatomic,assign) NSInteger episode_id;
@end
