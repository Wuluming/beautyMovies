//
//  MianItemCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Gap 10
#define IconHeight MainItemCell_Height - 2 * Gap
#define IconWidth (MainItemCell_Height - 2 * Gap)*2/3
#define TitleWidth 200
#define TitleHeight 20
#define LineHeight 20
#import "MianItemCell.h"
#import "ContentModel.h"
#import "LineModel.h"

@interface MianItemCell ()

@property (nonatomic,strong) UIImageView * iconView;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * line1;
@property (nonatomic,strong) UILabel * line2;
@property (nonatomic,strong) UIButton * play;

@end


@implementation MianItemCell

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.frame = CGRectMake(Gap, Gap, IconWidth, IconHeight);
    }
    return _iconView;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _line1.font = [UIFont systemFontOfSize:18];
        _title.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, Gap, TitleWidth, TitleHeight);
    }
    return _title;
}

- (UILabel *)line1 {
    if (_line1 == nil) {
        _line1 = [[UILabel alloc] init];
        _line1.font = [UIFont systemFontOfSize:12];
        _line1.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, CGRectGetMaxY(self.title.frame) + TitleHeight, TitleWidth, LineHeight);
    }
    return _line1;
}

- (UILabel *)line2 {
    if (_line2 == nil) {
        _line2 = [[UILabel alloc] init];
        _line2.font = [UIFont systemFontOfSize:12];
        _line2.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + Gap, Gap + CGRectGetMaxY(self.line1.frame), TitleWidth, LineHeight);
    }
    return _line2;
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

#pragma mark - 按钮被点击了，视频播放

- (void)buttonClicked {
    if (self.playBlock) {
        _playBlock();
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        self.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1];
    }
    return self;
}

- (void)addUI {
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.line1];
    [self.contentView addSubview:self.line2];
//    [self.contentView addSubview:self.play];
}


- (void)setModel:(ContentModel *)model {
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.title.text = model.title;
    self.line1.text = model.line1.value;
    self.line2.text = model.line2.value;
}













@end
