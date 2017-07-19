//
//  TestFormDataCell.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TestFormDataCell.h"

@interface TestFormDataCell ()

@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *editselectedButton;

@end

@implementation TestFormDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.idLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.editselectedButton];
        self.editselectedButton.hidden = YES;
        self.isSelected = NO;
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
            make.height.equalTo(@0.5);
        }];
        [self.editselectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.offset(-20);
            make.height.equalTo(@38);
            make.width.equalTo(@38);
        }];
    }
    return self;
}

- (void)setModel:(TestModelData *)model {
    _model = model;
    self.idLabel.text = [NSString stringWithFormat:@"%ld",model.id];
    self.nameLabel.text = model.name;
    self.descLabel.text = model.desc;
}

- (void)setIsEditing:(BOOL)isEditing {
    if (isEditing) {
        self.editselectedButton.hidden = NO;
        self.isSelected = NO;
    }else {
        self.editselectedButton.hidden = YES;
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (!isSelected) {
        [_editselectedButton setImage:[UIImage imageNamed:@"del_unselected"] forState:UIControlStateNormal];
        _isSelected = NO;
    }else {
        [_editselectedButton setImage:[UIImage imageNamed:@"del_selected"] forState:UIControlStateNormal];
        _isSelected = YES;
    }
}

- (void)selectedBtn {
    self.isSelected = !_isSelected;
    if (self.editBlock) {
        self.editBlock(self.isSelected);
    }
}

- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = [UILabel new];
        _idLabel.font = Font(16);
        _idLabel.textColor = [UIColor text1Color];
    }
    return _idLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor text1Color];
        _nameLabel.font = Font(16);
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = [UIColor text1Color];
        _descLabel.font = Font(16);
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

- (UIButton *)editselectedButton {
    if (!_editselectedButton) {
        _editselectedButton = [UIButton new];
        [_editselectedButton setImage:[UIImage imageNamed:@"del_unselected"] forState:UIControlStateNormal];
        [_editselectedButton addTarget:self action:@selector(selectedBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editselectedButton;
}

@end
