//
//  AudioPlayerViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#define  MovieURL @"https://jp.kankan.1kxun.mobi/api/movies/mp4"
#define TvsURL @"https://jp.kankan.1kxun.mobi/api/tvs/mp4/%@?episode_id=%ld"
#define CartoonsURL @"https://jp.kankan.1kxun.mobi/api/cartoons/mp4/%@?episode_id=0"
#define VarietiesURL @"http://kankan.1kxun.com/video_kankan_tags/v2/api/varieties/mp4/%@?episode_id=%ld"
#define SportURL @"http://kankan.1kxun.com/video_kankan_tags/v2/api/sports/mp4/%@?episode_id=%ld"
#define GameURL @"http://kankan.1kxun.com/video_kankan_tags/v2/api/game/mp4/%@?episode_id=%ld"
#import "AudioPlayerViewController.h"
#import "GDataXMLNode.h"
#import "MovieView.h"

@interface AudioPlayerViewController ()
@property (nonatomic,strong) NSURL * playUrl;

@property (nonatomic,strong) NSMutableArray * DataSourceURL;
@property (nonatomic,strong) MovieView * movieView;
@property (nonatomic,strong) UIButton * playOrPause;
@property (nonatomic,strong) UIProgressView * progress;
@property (nonatomic,strong) UISlider * slider;
@property (nonatomic,strong) UILabel * titmeLabel;
@property (nonatomic,strong) UILabel * leftLabel;
@property (nonatomic,strong) UIActivityIndicatorView * indicator;

@end

@implementation AudioPlayerViewController
{
    AVPlayer * _player;
    AVPlayerItem * _playerItem;
}

- (UIActivityIndicatorView *)indicator {
    if (_indicator == nil) {
        _indicator = [[UIActivityIndicatorView alloc] init];
        _indicator.frame = CGRectMake(self.movieView.frame.size.width/2 - 20, self.movieView.frame.size.height/2 - 20, 40, 40);
        [_indicator startAnimating];
        _indicator.tintColor = [UIColor orangeColor];
    }
    return _indicator;
}

- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = [UIColor grayColor];
        _leftLabel.text = [NSString stringWithFormat:@"00:00"];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont systemFontOfSize:15];
        _leftLabel.frame = CGRectMake(35, 379, 60, 40);
    }
    return _leftLabel;
}

- (UILabel *)titmeLabel {
    if (_titmeLabel == nil) {
        _titmeLabel = [[UILabel alloc] init];
        _titmeLabel.frame = CGRectMake(SCREEN_SIZE.width -70, 379, 70, 40);
        _titmeLabel.textColor = [UIColor grayColor];
        _titmeLabel.text = [NSString stringWithFormat:@"00:00"];
        _titmeLabel.textAlignment = NSTextAlignmentCenter;
        _titmeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titmeLabel;
}

- (UISlider *)slider {
    if (_slider == nil) {
        _slider = [[UISlider alloc] init];
        UIGraphicsBeginImageContextWithOptions((CGSize){1,1}, NO, 0.0f);
        UIImage * transparentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [_slider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
        [_slider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
        _slider.frame = CGRectMake(90, 399, SCREEN_SIZE.width - 150, 5);
        [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UIButton *)playOrPause {
    if (_playOrPause == nil) {
        _playOrPause = [[UIButton alloc] init];
        _playOrPause.frame = CGRectMake(5, 384, 30, 30);
        _playOrPause.backgroundColor = [UIColor grayColor];
        [_playOrPause setImage:[UIImage imageNamed:@"gui_play@1x"] forState:UIControlStateNormal];
        [_playOrPause addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playOrPause;
}


- (void)playOrPause:(UIButton *)button {
    if (_player.rate == 0) {
        [button setImage:[UIImage imageNamed:@"gui_pause@1x"] forState:UIControlStateNormal];
        [_player play];
    }else if (_player.rate == 1) {
        [button setImage:[UIImage imageNamed:@"gui_play@1x"] forState:UIControlStateNormal];
        [_player pause];
    }
}

- (UIProgressView *)progress {
    if (_progress == nil) {
        _progress = [[UIProgressView alloc] init];
        _progress.frame = CGRectMake(90, 399, SCREEN_SIZE.width - 150, 5);
        _progress.progressTintColor = [UIColor blackColor];
        _progress.trackTintColor = [UIColor whiteColor];
        
    }
    return _progress;
}

- (MovieView *)movieView {
    if (_movieView == nil) {
        _movieView = [[MovieView alloc] init];
        _movieView.frame = CGRectMake(0, 114, SCREEN_SIZE.width, 250);
        _movieView.backgroundColor = [UIColor grayColor];
    }
    return _movieView;
}


- (NSURL *)playUrl {
    if (_playUrl == nil) {
        _playUrl = [[NSURL alloc] init];
    }
    return _playUrl;
}

- (NSMutableArray *)DataSourceURL {
    if (_DataSourceURL == nil) {
        _DataSourceURL = [[NSMutableArray alloc] init];
    }
    return _DataSourceURL;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
    
    [self loadData];
    
}

- (void)addUI {
    
    
    
    [self.view addSubview:self.movieView];
    [self.movieView addSubview:self.indicator];
    [self.view addSubview:self.playOrPause];
    [self.view addSubview:self.progress];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.leftLabel];
    [self.view addSubview:self.titmeLabel];
}

- (void)loadData {

    NSString * path = nil;
    if ([self.type isEqualToString:@"movie"]) {
        path = [MovieURL stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_play_id]];
    }else if ([self.type isEqualToString:@"tv"]){
        path = [NSString stringWithFormat:TvsURL,_play_id,_episode_id];
    }else if ([self.type isEqualToString:@"cartoon"]){
        path = [NSString stringWithFormat:CartoonsURL,_play_id];
    }else if ([self.type isEqualToString:@"variety"]) {
        path = [NSString stringWithFormat:VarietiesURL,_play_id,_episode_id];
    }else if ([self.type isEqualToString:@"sport"]) {
        path = [NSString stringWithFormat:SportURL,_play_id,_episode_id];
    }else if ([self.type isEqualToString:@"game"]) {
        path = [NSString stringWithFormat:GameURL,_play_id,_episode_id];
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *xmlString=[NSString stringWithContentsOfURL:[NSURL URLWithString:path] encoding:NSUTF8StringEncoding error:nil];
        GDataXMLDocument*doc=[[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    
        NSArray *play=[doc nodesForXPath:@"//url" error:nil];
        
       __block  BOOL is = NO;
            for (int i = 0; i < play.count; i++) {
                self.playUrl = [NSURL URLWithString:[[play[i] stringValue] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                MyLog(@"%@",self.playUrl);
                AVAsset * sset = [AVAsset assetWithURL:self.playUrl];
                [sset loadValuesAsynchronouslyForKeys:[NSArray arrayWithObject:@"tracks"] completionHandler:^{
                    AVKeyValueStatus status = [sset statusOfValueForKey:@"tracks" error:nil];
                    if (status == AVKeyValueStatusLoaded) {
                        if (is != YES) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                is = YES;
                                _playerItem = [[AVPlayerItem alloc] initWithAsset:sset];
                                _player = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
                                
                                [self.movieView playWithAVPlayer:_player];
                                [_player play];
                                [self.playOrPause setImage:[UIImage imageNamed:@"gui_pause@1x"] forState:UIControlStateNormal];
                                
                                [self addNotification];
                                [self addObserverToPlayerItem:_playerItem];
                            });
                        }
                        
                    }
                }];
            }
  
    });
}


- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
}

- (void)playBackFinished:(NSNotification *)notification {
    MyLog(@"视频播放完成");
}


- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    
    AVPlayerItem * playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            [_indicator stopAnimating];
            [_player play];
            float total = CMTimeGetSeconds(playerItem.duration);
            
            self.titmeLabel.text = [self convertTime:total];
            [self monitoringPlayback:playerItem];
            
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray * array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totlaBuffer = startSeconds + durationSeconds;
        CGFloat totalDuration = CMTimeGetSeconds(playerItem.duration);
        [self.progress setProgress:totlaBuffer/totalDuration animated:YES];
    }
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak AudioPlayerViewController * weakSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float total = CMTimeGetSeconds([playerItem duration]);
        
        if (total!=NAN) {
            //slider
            CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;//计算当前在第几秒
            weakSelf.slider.maximumValue = 1;
            weakSelf.slider.minimumValue = 0;
            weakSelf.slider.value = currentSecond/total;
            weakSelf.leftLabel.text = [weakSelf convertTime:currentSecond];
        }
    }];
}

- (NSString *)convertTime:(CGFloat)second {
    
    NSString * t = nil;
    if (second/3600>=1) {
        int h = second/3600;
        int m = (second-3600 * h)/60;
        CGFloat s = second -3600*h-60*m;
        t = [NSString stringWithFormat:@"%d:%d:%.0f",h,m,s];
    }else {
        int m = second/60;
        int s = second - m*60;
        t = [NSString stringWithFormat:@"%d:%d",m,s];
    }
    return t;
    
}



- (void)dealloc {
    [_player pause];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sliderChange:(UISlider *)slider {
    float current = slider.value * CMTimeGetSeconds(_playerItem.duration);
    [_playerItem seekToTime:CMTimeMake(current, 1)];
    _player.rate = 1;
}

@end
