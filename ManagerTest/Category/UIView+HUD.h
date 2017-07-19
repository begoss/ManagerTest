//
//  UIView+HUD.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

- (void)showAlertTitle:(NSString *)title;
- (void)showAlertTitle:(NSString *)title duration:(CGFloat)duration;
- (void)showBadtipsAlert:(NSString *)title duration:(CGFloat)duration;
- (void)showGoodtipsAlert:(NSString *)title duration:(CGFloat)duration;
- (void)showGoodtipsAlert:(NSString *)title;
- (void)showBadtipsAlert:(NSString *)title ;
@end
