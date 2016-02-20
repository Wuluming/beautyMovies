//
//  EpisodeModel.h
//  QX20151125
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@protocol EpisodeModel
@end

@interface EpisodeModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * Description;
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString * title;

@end
