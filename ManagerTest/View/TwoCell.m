//
//  TwoCell.m
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TwoCell.h"

//del_selected

@interface TwoCell ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *iconView;

@end

@implementation TwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.label.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return self;
}

- (UILabel *)label{
    if(!_label){
        _label = [UILabel new];
        [_label setText:@"成功实例"];
        [_label setFont:Font(16)];
    }
    return _label;
}

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [UIImageView new];
        _iconView.image = [UIImage imageNamed:@"del_selected"];
    }
    return _iconView;
}

@end
