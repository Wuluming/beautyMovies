//
//  MovieView.m
//  MovieDemo
//
//  Created by qianfeng on 15/11/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MovieView.h"

@implementation MovieView

-(void)playWithAVPlayer:(AVPlayer *)player {
    //他需要一个播放数据的layer
    AVPlayerLayer * playerLayer = (AVPlayerLayer *)self.layer;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playerLayer.player = player;
}

//当调用self.layer时，系统会自动调用layerClass方法，去获取真的layer
+(Class)layerClass {
    return [AVPlayerLayer class];
}

@end
