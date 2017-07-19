//
//  UIColor+Custom.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+ (UIColor *)colorWithTabGreen {
    return Color(50, 184, 70);
}

//更浅的颜色
+ (UIColor *)text0Color {
    return [UIColor colorWithRed:190.0/255.0 green:200.0/255.0 blue:210.0/255.0 alpha:1];
}
/** 浅色字体 */
+ (UIColor *)text1Color {
    return [UIColor colorWithRed:140.0/255.0 green:150.0/255.0 blue:160.0/255.0 alpha:1];
}

/** 深色字体 */
+ (UIColor *)text2Color {
    return [UIColor colorWithRed:40.0/255.0 green:50.0/255.0 blue:60.0/255.0 alpha:1];
}

+ (UIColor *)selectedColor {
    return Color(240, 242, 245);
}

+ (UIColor *)bg1Color {
    return Color(225, 230, 235);
}

+ (UIColor *)bg2Color {
    return Color(235, 240, 245);
}

@end
