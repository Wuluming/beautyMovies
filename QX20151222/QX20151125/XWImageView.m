//
//  XWImageView.m
//  PhotosWall
//
//  Created by qianfeng on 15/11/5.
//  Copyright (c) 2015年 xiaowu. All rights reserved.
//

#import "XWImageView.h"

@implementation XWImageView
{
    id _target;
    SEL _selector;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)dealloc
{
    [_target release];
    _target = nil;
    [super dealloc];
}

- (void)addTarget:(id)target withSelector:(SEL)selector{
    if (_target != target) {
        [_target release];
        _target = [target retain];
    }
    
    _selector = selector;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //当前图片视图被触摸的时候，如果被绑定事件的对象能够响应该消息，就执行该方法，传参为当前图片视图
    if ([_target respondsToSelector:_selector] == YES) {
        [_target performSelector:_selector withObject:self];
    }
}

@end
