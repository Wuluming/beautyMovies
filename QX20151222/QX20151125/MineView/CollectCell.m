//
//  CollectCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Gap 10
#define HeadHeight MainItemCell_Height - 2 * Gap
#define HeadWidth (MainItemCell_Height - 2 * Gap)*2/3
#define TitleWidth 200
#define TitleHeight 20
#define StarWidth 200
#define StarHeight 30
#import "CollectCell.h"
#import "StarView.h"
#import "DeatailModel.h"
@interface CollectCell ()

@property (nonatomic,strong) UIImageView * headImage;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) StarView * avg_score;
@property (nonatomic,strong) UIButton * play;

@end

@implementation CollectCell
//    play_id
//    title;
//    image;
//    avg_score

- (UIImageView *)headImage {
    if (_headImage == nil) {
        _headImage = [[UIImageView alloc] init];
        _headImage.frame = CGRectMake(Gap, Gap, HeadWidth, HeadHeight);
    }
    return _headImage;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame) + Gap, 2 * Gap, TitleWidth, TitleHeight);
    }
    return _title;
}

- (StarView *)avg_score {
    if (_avg_score == nil) {
        _avg_score = [[StarView alloc] init];
        _avg_score.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame) + Gap, CGRectGetMaxY(self.title.frame) + 2 * Gap, StarWidth, StarHeight);
    }
    return _avg_score;
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
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.avg_score];
//    [self.contentView addSubview:self.play];
}

- (void)setModel:(DeatailModel *)model {
    _model = model;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.title.text = model.title;
    self.avg_score.star = [model.avg_score floatValue];
}



























@end
