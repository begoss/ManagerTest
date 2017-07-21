
//
//  CellOneView.m
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/21.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "CellOneView.h"

@interface CellOneView ()

@property (strong, nonatomic) UIImageView *iconImgView;
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation CellOneView

- (instancetype)initWithImgName:(NSString *)imgName textLabelName:(NSString *)textLabelName{
    if([super init]){
        [self addSubview:self.iconImgView];
        self.iconImgView.image = [UIImage imageNamed:imgName];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self addSubview:self.textLabel];
        self.textLabel.text = textLabelName;
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.iconImgView.mas_bottom).offset(10);
//            make.height.equalTo(@11);
//            make.left.equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)iconImgView{
    if(!_iconImgView){
        _iconImgView = [UIImageView new];
    }
    return _iconImgView;
}

- (UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [UILabel new];
        [_textLabel setFont:Font(11)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}


@end
