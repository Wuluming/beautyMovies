//
//  HeadViewCell.m
//  QX20151125
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeadViewCell.h"
#import "XWImageView.h"
@interface HeadViewCell ()

@property (nonatomic,strong) XWImageView * headImage;


@end

@implementation HeadViewCell

- (XWImageView *)headImage {
    if (_headImage == nil) {
        _headImage = [[XWImageView alloc] init];
        _headImage.layer.borderWidth = 1;
        _headImage.layer.borderColor = [UIColor grayColor].CGColor;
        _headImage.backgroundColor = [UIColor redColor];
    }
    return _headImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        
        self.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.headImage];
    
    [self addTextFiled];
}

- (void)addTextFiled {
    for (int i = 0; i < 2; i++) {
        UITextField * textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(20, 100 + (200 + 10) * i, 200, 20);
        textField.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:textField];
    }
}


@end
