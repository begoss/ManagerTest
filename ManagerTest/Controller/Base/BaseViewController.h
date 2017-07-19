//
//  BaseViewController.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetWorkViewController.h"
#define LOADING_ANMI_TIME 0.8
typedef enum : NSUInteger {
    LoadingStyleLight,
    LoadingStyleDark,
} LoadingStyle;
@interface BottomView : UIView
@end
@interface BaseViewController : BaseNetWorkViewController

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) LoadingStyle LoadingStyle;

/* 无可用网络*/
@property (nonatomic, strong) UIView *netErrorView;

@end
