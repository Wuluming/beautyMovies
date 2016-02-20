//
//  DetailCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Gap 10
#define MinGap 5
#define IconWidth 125
#define IconHeight 150
#define LabelWidth 200
#define LabelHeight 30
#define Button_Tag 100

#import "DetailCell.h"
#import "DeatailModel.h"
#import "ActorModel.h"
#import "DirectorModel.h"
#import "AddressModel.h"
#import "UIButton+WebCache.h"

@interface DetailCell ()
@property (nonatomic,strong) UIImageView * iconView;
@property (nonatomic,strong) UIButton * play;
@property (nonatomic,strong) UILabel * area;
@property (nonatomic,strong) UILabel * duration;
@property (nonatomic,strong) UILabel * year;
@property (nonatomic,strong) UILabel * play_count;
@property (nonatomic,strong) UILabel * resource;
@end

@implementation DetailCell

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
        _iconView.frame = CGRectMake(Gap, Gap, IconWidth, IconHeight);
    }
    return _iconView;
}

- (UIButton *)play {
    if (_play == nil) {
        _play = [[UIButton alloc] init];
        UIImage * image = [UIImage imageNamed:@"play_detail_btn"];
        _play.frame = CGRectMake((self.iconView.frame.size.width - image.size.width)/2, (self.iconView.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
        [_play setImage:image forState:UIControlStateNormal];
        [_play addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    }
    return _play;
}

- (void)playAudio {
    if (self.playBlock) {
        _playBlock();
    }
}

- (UILabel *)year {
    if (_year == nil) {
        _year = [[UILabel alloc] init];
        _year.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, Gap, LabelWidth, LabelHeight);
    }
    return _year;
}

- (UILabel *)area {
    if (_area == nil) {
        _area = [[UILabel alloc] init];
        _area.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, CGRectGetMaxY(self.year.frame) + MinGap , LabelWidth, LabelHeight);
    }
    return _area;
}

- (UILabel *)duration {
    if (_duration == nil) {
        _duration = [[UILabel alloc] init];
        _duration.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, CGRectGetMaxY(self.area.frame) + MinGap, LabelWidth, LabelHeight);
    }
    return _duration;
}

- (UILabel *)play_count {
    if (_play_count == nil) {
        _play_count = [[UILabel alloc] init];
        _play_count.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, CGRectGetMaxY(self.duration.frame) + MinGap, LabelWidth, LabelHeight);
    }
    return _play_count;
}

- (UILabel *)resource {
    if (_resource == nil) {
        _resource = [[UILabel alloc] init];
        _resource.frame = CGRectMake(Gap, CGRectGetMaxY(self.iconView.frame) + MinGap, 60, 44);
        _resource.text = @"播放源: ";
        
    }
    return _resource;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.iconView];
    [self.iconView addSubview:self.play];
    [self.contentView addSubview:self.year];
    [self.contentView addSubview:self.area];
    [self.contentView addSubview:self.duration];
    [self.contentView addSubview:self.play_count];
    [self.contentView addSubview:self.resource];
    
    [self addLines];
    
    [self addResources];
}

- (void)addLines {
    for (int i = 0; i < 2; i++) {
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(CGRectGetMidX(self.iconView.frame), self.resource.frame.origin.y + 44 * i, self.bounds.size.width - 2*Gap, 1);
        line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:line];
    }
}

- (void)addResources {
    for (int i = 0; i <5; i++) {
        UIButton * button = [[UIButton alloc] init];
        button.frame = CGRectMake(CGRectGetMaxX(self.resource.frame) + MinGap + (44 + MinGap)*i, self.resource.frame.origin.y, 44, 44);
        [button setBackgroundImage:[UIImage imageNamed:@"video.detail.source.cover"] forState:UIControlStateNormal];
        button.tag = Button_Tag + i;
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = YES;
        button.hidden = YES;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}

#pragma mark - 按钮点击事件
- (void)buttonClicked:(UIButton *)button {
    
}

- (void)setDetailModel:(DeatailModel *)detailModel {
    _detailModel = detailModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:detailModel.image] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
    self.year.text = [NSString stringWithFormat:@"年份: %@",detailModel.year];
    self.area.text = [NSString stringWithFormat:@"地区: %@",detailModel.area];
    if ([detailModel.type isEqualToString:@"movie"]) {
        self.duration.text = [NSString stringWithFormat:@"时长: %@分钟",detailModel.duration];
    }else if ([detailModel.type isEqualToString:@"tv"]) {
        self.duration.text = [NSString stringWithFormat:@"集数: %@集",detailModel.episodes_count];
    }
    
    self.play_count.text = [NSString stringWithFormat:@"人气: %@",detailModel.play_count];
    NSArray * addresss = detailModel.play_addresses;
    for (int i = 0; i < addresss.count; i++) {
        AddressModel * add = addresss[i];
        UIButton * button = (id)[self.contentView viewWithTag:Button_Tag + i];
        button.hidden = NO;
        [button sd_setImageWithURL:[NSURL URLWithString:add.url] forState:UIControlStateNormal];
    }
}








@end
