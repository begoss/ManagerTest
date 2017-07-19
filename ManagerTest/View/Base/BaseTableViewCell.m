//
//  BaseTableViewCell.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UITableViewCell+SelectedColor.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //#warning colorSeeAll
        self.selectedBackgroundColor = [UIColor selectedColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
