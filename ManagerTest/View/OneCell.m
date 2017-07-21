//
//  OneCell.m
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "OneCell.h"
#import "CellOneView.h"

@interface OneCell ()

@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) NSMutableArray *imgArray;
@property (strong, nonatomic) NSMutableArray *titleArray;

@end

@implementation OneCell

- (void)setModel:(MainPageUpperModel *)model{
    _model = model;
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 69, 200, 1)];
//    line.backgroundColor = [UIColor grayColor];
//    [self addSubview:line];
    if (!self.imgArray.count) {
        self.cellTitleLabel.text = model.title;
        self.imgArray = [model.imgArray mutableCopy];
        self.titleArray = [model.titleArray mutableCopy];
        for(int i=0;i<self.imgArray.count;i++)
        {
            CellOneView *cellView = [[CellOneView alloc] initWithImgName:self.imgArray[i] textLabelName:self.titleArray[i]];
            [self addSubview:self.cellTitleLabel];
            [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(@15);
                make.height.equalTo(@13);
            }];
            [self addSubview:cellView];
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.centerY.equalTo(self);
                make.left.equalTo(self.cellTitleLabel).offset(31+i*78);
                make.height.equalTo(@70);
                make.width.equalTo(@((SCREEN_WIDTH-70)/self.imgArray.count));
            }];
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
            [cellView addGestureRecognizer:ges];
        }
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgArray = [NSMutableArray new];
        self.titleArray = [NSMutableArray new];
    }
    return self;
}

- (UILabel *)cellTitleLabel{
    if(!_cellTitleLabel){
        _cellTitleLabel = [UILabel new];
        [_cellTitleLabel setFont:Font(13)];
        _cellTitleLabel.textColor = [UIColor darkGrayColor];
    }
    return _cellTitleLabel;
}

#warning UNDONE
- (void)tapView{
    if(self.touchBlock){
        self.touchBlock(self.cellTitleLabel.text);
    }
}

@end


