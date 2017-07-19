//
//  TestFormHead.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TestFormHead.h"

@interface TestFormHead ()

@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation TestFormHead

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.idLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.lineView];
        [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(20);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(20+SCREEN_WIDTH/3);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(20+2*SCREEN_WIDTH/3);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = [UILabel new];
        _idLabel.text = @"编号";
        _idLabel.font = MediumFont(18);
        _idLabel.textColor = [UIColor text2Color];
    }
    return _idLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor text2Color];
        _nameLabel.text = @"名字";
        _nameLabel.font = MediumFont(18);
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = [UIColor text2Color];
        _descLabel.text = @"描述";
        _descLabel.font = MediumFont(18);
    }
    return _descLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor bg1Color];
    }
    return _lineView;
}

@end
