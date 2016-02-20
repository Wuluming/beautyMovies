//
//  MsgCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MsgCell.h"
#import "MsgModel.h"
@interface MsgCell ()
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * textView;

@end

@implementation MsgCell

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.frame = CGRectMake(10, 5, 300, 20);
    }
    return _title;
}

- (UILabel *)textView {
    if (_textView == nil) {
        _textView = [[UILabel alloc] init];
        _textView.numberOfLines = 0;
        _textView.font = [UIFont systemFontOfSize:13];
    }
    return _textView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.textView];
}

- (void)setModel:(MsgModel *)model {
    _model = model;
    self.title.text = [NSString stringWithFormat:@"%@  %@",model.type_name,model.created_at];
    self.textView.text = model.title;
    NSDictionary * attribute = @{NSFontAttributeName:self.textView.font};
    CGSize textView = [model.title boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    self.textView.frame = CGRectMake(10, CGRectGetMaxY(self.title.frame), SCREEN_SIZE.width - 20, textView.height);
    
    model.height = [NSString stringWithFormat:@"%f",CGRectGetMaxY(self.textView.frame)];
}

@end
