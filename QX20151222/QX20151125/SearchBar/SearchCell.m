//
//  SearchCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define Gap 10

#define HeadHeight  (ResearchCell_Height - 2 * Gap)
#define HeadWidth HeadHeight*2/3
#define TitleWidth 200
#define TitleHeight 20
#define StarWidth 200
#define StarHeight 30

#import "SearchCell.h"
#import "PublicModel.h"
#import "StarView.h"
@interface SearchCell ()

@property (nonatomic,strong) UIImageView * headImage;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * duration;
@property (nonatomic,strong) StarView * startView;
@end

@implementation SearchCell

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
        _title.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame) + 5 * Gap, Gap, TitleWidth, TitleHeight);
    }
    return _title;
}

- (UILabel *)duration {
    if (_duration == nil) {
        _duration = [[UILabel alloc] init];
        _duration.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame) + 5 * Gap, CGRectGetMaxY(self.title.frame) + Gap, TitleWidth, TitleHeight);
    }
    return _duration;
}

- (StarView *)startView {
    if (_startView == nil) {
        _startView = [[StarView alloc] init];
        _startView.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame) + 5 * Gap, CGRectGetMaxY(self.duration.frame) + Gap, StarWidth, StarHeight);
    }
    return _startView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.duration];
    [self.contentView addSubview:self.startView];
}

- (void)setModel:(PublicModel *)model {
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.title.text = model.title;
    if ([model.line1_type isEqualToString:@"5"]) {
        self.duration.text = [NSString stringWithFormat:@"集数:%@",model.line2_value];
    }else {
        self.duration.text = [NSString stringWithFormat:@"时长:%@",model.line1_value];
    }
    self.startView.star = [model.line2_value floatValue];
}















@end
