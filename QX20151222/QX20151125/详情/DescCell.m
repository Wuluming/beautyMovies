//
//  DescCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DescCell.h"
#import "DeatailModel.h"
#import "DirectorModel.h"
#import "ActorModel.h"

@interface DescCell ()

@property (nonatomic,strong) UILabel * director;
@property (nonatomic,strong) UILabel * actors;
@property (nonatomic,strong) UILabel * desc;

@end
@implementation DescCell

- (UILabel *)director {
    if (_director == nil) {
        _director = [[UILabel alloc] init];
        _director.font = [UIFont systemFontOfSize:15];
        _director.numberOfLines = 0;
//        _actors.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _director;
}

- (UILabel *)actors {
    if (_actors == nil) {
        _actors = [[UILabel alloc] init];
        _actors.font = [UIFont systemFontOfSize:15];
        _actors.numberOfLines = 0;
        _actors.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _actors;
}

- (UILabel *)desc {
    if (_desc == nil) {
        _desc = [[UILabel alloc] init];
        _desc.font = [UIFont systemFontOfSize:15];
        _desc.numberOfLines = 0;
        _desc.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _desc;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    [self.contentView addSubview:self.director];
    [self.contentView addSubview:self.actors];
    [self.contentView addSubview:self.desc];
}

- (void)setModel:(DeatailModel *)model {
    _model = model;
    NSMutableString * dirs = [NSMutableString new];
    for (DirectorModel * dir in model.directors) {
        [dirs appendFormat:@" %@",dir.name];
    }
    NSString * dStr = [NSString stringWithFormat:@"导演:%@ ",dirs];
    self.director.text = dStr;
    NSDictionary * dirAttribute = @{NSFontAttributeName:self.director.font};
    CGSize directorSize = [dStr boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dirAttribute context:nil].size;
    self.director.frame = CGRectMake(10, 10, directorSize.width, directorSize.height);
    
    
    NSMutableString * actors = [NSMutableString new];
    for (ActorModel * act in model.actors) {
        [actors appendFormat:@" %@",act.name];
    }
    NSString * aStr = [NSString stringWithFormat:@"演员:%@ ",actors];
    self.actors.text = aStr;
    NSDictionary * actorAttribute = @{NSFontAttributeName:self.actors.font};
    CGSize actorSize = [aStr boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:actorAttribute context:nil].size;
    self.actors.frame = CGRectMake(10, CGRectGetMaxY(self.director.frame) + 10, actorSize.width, actorSize.height);
    
    self.desc.text = model.descriptionStr;
    NSDictionary * descAttribute = @{NSFontAttributeName:self.desc.font};
    CGSize descSize = [model.descriptionStr boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:descAttribute context:nil].size;
    self.desc.frame = CGRectMake(10, CGRectGetMaxY(self.actors.frame) + 10, descSize.width, descSize.height);
    
    
    
    model.cellHeight = [NSString stringWithFormat:@"%f",CGRectGetMaxY(self.desc.frame)];
    
}

@end
