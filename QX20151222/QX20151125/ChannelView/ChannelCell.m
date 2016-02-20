//
//  ChannelCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Gap 10
#define IconHeight ChannelCell_Height - 2 * Gap
#define IconWidth (ChannelCell_Height - 2 * Gap)*2/3
#define TitleWidth 200
#define TitleHeight 20
#define StarWidth 200
#define StarHeight 30
#define ElseWidth 200
#define ElseHeight 30
#import "ChannelCell.h"
#import "StarView.h"
#import "ChannelModel.h"
@interface ChannelCell ()

@property (nonatomic,strong) UIImageView * IconImage;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) StarView * starView;
@property (nonatomic,strong) UILabel * duration;
@property (nonatomic,strong) UILabel * episodes_cound;
@property (nonatomic,strong) UIButton * play;

@end
@implementation ChannelCell

- (UIImageView *)IconImage {
    if (_IconImage == nil) {
        _IconImage = [[UIImageView alloc] init];
        _IconImage.frame = CGRectMake(Gap, Gap, IconWidth, IconHeight);
    }
    return _IconImage;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(CGRectGetMaxX(self.IconImage.frame) + Gap, Gap, TitleWidth, TitleHeight);
    }
    return _title;
}

- (StarView *)starView {
    if (_starView == nil) {
        _starView = [[StarView alloc] init];
        _starView.frame = CGRectMake(CGRectGetMaxX(self.IconImage.frame) + Gap, CGRectGetMaxY(self.title.frame) + TitleHeight, StarWidth, StarHeight);
    }
    return _starView;
}

- (UILabel *)duration {
    if (_duration == nil) {
        _duration = [[UILabel alloc] init];
    }
    return _duration;
}

- (UILabel *)episodes_cound {
    if (_episodes_cound == nil) {
        _episodes_cound = [[UILabel alloc] init];
    }
    return _episodes_cound;
}

- (UIButton *)play {
    if (_play == nil) {
        _play = [[UIButton alloc] init];
        UIImage * image = [UIImage imageNamed:@"play_btn"];
        _play.frame = CGRectMake(self.bounds.size.width - image.size.width,self.bounds.size.height/2 + Gap, image.size.width, image.size.height);
        [_play setImage:image forState:UIControlStateNormal];
        [_play setImage:[UIImage imageNamed:@"play_btn_highlight"] forState:UIControlStateHighlighted];
        [_play addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _play;
}

- (void)buttonClicked {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        self.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1];
    }
    return self;
}

- (void)addUI {
    [self.contentView addSubview:self.IconImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.duration];
    [self.contentView addSubview:self.episodes_cound];
//    [self.contentView addSubview:self.play];
}

- (void)setModel:(ChannelModel *)model {
    _model = model;
    
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.title.text = model.title;
    self.starView.star = [model.avg_score floatValue];
    if (model.duration) {
        self.duration.hidden = NO;
        self.episodes_cound.hidden = YES;
        self.duration.text = [NSString stringWithFormat:@"时长:%@",model.duration];
        _duration.frame = CGRectMake(CGRectGetMaxX(self.IconImage.frame) + Gap, CGRectGetMaxY(self.starView.frame)- 10, ElseWidth, ElseHeight);
    }else {
        self.episodes_cound.hidden = NO;
        self.duration.hidden = YES;
        self.episodes_cound.text = [NSString stringWithFormat:@"集数；%@",model.episodes_count];
        _episodes_cound.frame = CGRectMake(CGRectGetMaxX(self.IconImage.frame) + Gap, CGRectGetMaxY(self.starView.frame), ElseWidth, ElseHeight);
    }
    

    
}










@end
