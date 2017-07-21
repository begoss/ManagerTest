//
//  ThreeCell.m
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "ThreeCell.h"

@interface ThreeCell ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation ThreeCell

- (void)setModel:(MainPageDetailModel *)model{
    _model = model;
    [self.iconView loadImageWithURL:model.img placeholderImage:nil];
    [self.titleLabel setText:model.title];
    [self.descLabel setText:model.text];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(30);
            make.top.equalTo(self.iconView.mas_top);
        }];
        [self addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.right.offset(-30);
        }];
        self.iconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon)];
        [self.iconView addGestureRecognizer:ges];
    }
    return self;
}

- (void)tapIcon {
    if(self.tapBlock){
        self.tapBlock(self.titleLabel.text);
    }
}

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [UIImageView new];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel new];
        [_titleLabel setFont:Font(16)];
        [_titleLabel setTextColor:[UIColor text2Color]];
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if(!_descLabel){
        _descLabel = [UILabel new];
        [_descLabel setFont:Font(16)];
        [_descLabel setTextColor:[UIColor text1Color]];
        _descLabel.numberOfLines = 2;
    }
    return _descLabel;
}

@end
