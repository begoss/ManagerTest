//
//  BaseTabBarController.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface BaseTabBarController : UITabBarController

- (void)statusForNetwork:(NetworkStatus)status;
- (void) reset;

@end
