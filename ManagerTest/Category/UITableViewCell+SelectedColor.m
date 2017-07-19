//
//  UITableViewCell+SelectedColor.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "UITableViewCell+SelectedColor.h"

@implementation UITableViewCell (SelectedColor)

@dynamic selectedBackgroundColor;

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = selectedBackgroundColor;
    self.selectedBackgroundView = backgroundView;
}

@end
