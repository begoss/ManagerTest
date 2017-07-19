//
//  BaseNavigationController.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate>

@property (nonatomic, copy)void (^_completion)();

- (UIViewController *) popToRootViewControllerAnimated:(BOOL) animated completion:(void (^)()) completion;

@end
