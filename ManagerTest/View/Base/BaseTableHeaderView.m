//
//  BaseTableHeaderView.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseTableHeaderView.h"

@implementation BaseTableHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.label];
        [self addSubview:self.lineView];
        [self addSubview:self.top];
        [self addSubview:self.bottom];
        self.contentView.backgroundColor = [UIColor bg1Color];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.width.equalTo(@(3.5));
            make.height.equalTo(@(16));
            make.centerY.equalTo(self.mas_top).offset(26);
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lineView.mas_centerY);
            make.left.equalTo(self.lineView.mas_right).offset(6.5);
        }];
    }
    return self;
}

#pragma mark - getter and setter

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        _label.text = @"";
        _label.textColor = [UIColor colorWithHexString:@"141E28"];
        _label.font = Font(12);
    }
    return _label;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
        _lineView.backgroundColor = [UIColor colorWithHexString:@"242C35"];
    }
    return _lineView;
}

- (UIImageView *)bottom {
    if (!_bottom) {
        _bottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_bottom"]];
        _bottom.frame = CGRectMake(0, TITLESECTION_HEIGHT-3, SCREEN_WIDTH, 3);
    }
    return _bottom;
}
- (UIImageView *)top {
    if (!_top) {
        _top = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_top"]];
        _top.frame = CGRectMake(0, 0, SCREEN_WIDTH, 3);
        _top.hidden = YES;
    }
    return _top;
}

@end
