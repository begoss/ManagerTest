//
//  BaseTabBarController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabOneViewController.h"
#import "TabTwoViewController.h"
#import "TabThreeViewController.h"
#import "BaseNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "BaseNetWorkViewController.h"

@interface BaseTabBarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) BaseNetWorkViewController *network;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.clipsToBounds = YES;
    self.delegate = self;
    [self setupChildrenControllers];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isEqual:tabBarController.selectedViewController]) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reset {
    [self setupChildrenControllers];
}

- (void)setupChildrenControllers {
    for (UIViewController *vc in self.viewControllers) {
        [vc removeFromParentViewController];
    }
    self.viewControllers = nil;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithTabGreen], NSFontAttributeName:Font(11)} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:Color(123, 128, 135) , NSFontAttributeName:Font(11)} forState:UIControlStateNormal];
    self.tabBar.barTintColor = nil;
    self.tabBar.translucent = YES;
    self.tabBar.layer.borderWidth = 0.3;
    self.tabBar.layer.borderColor = [UIColor grayColor].CGColor;
    
    NSArray *imageArr1;
    NSArray *imageArry2;
    imageArr1 = @[@"tab1",@"tab1",@"tab1"];
    imageArry2 = @[@"tab1_selected",@"tab1_selected",@"tab1_selected"];
    
    TabOneViewController *oneVC = [[TabOneViewController alloc] init];
    BaseNavigationController *oneNav = [[BaseNavigationController alloc] initWithRootViewController:oneVC];
    oneNav.title = @"第一";
    oneNav.tabBarItem.image = [KImage(imageArr1[0]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    oneNav.tabBarItem.selectedImage = [KImage(imageArry2[0]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    oneNav.delegate = self;
    
    TabTwoViewController *twoVC = [[TabTwoViewController alloc] init];
    BaseNavigationController *twoNav = [[BaseNavigationController alloc] initWithRootViewController:twoVC];
    twoNav.title = @"第二";
    twoNav.tabBarItem.image = [KImage(imageArr1[1]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    twoNav.tabBarItem.selectedImage = [KImage(imageArry2[1]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    twoNav.delegate = self;
    
    TabThreeViewController *threeVC = [[TabThreeViewController alloc] init];
    BaseNavigationController *threeNav = [[BaseNavigationController alloc] initWithRootViewController:threeVC];
    threeNav.title = @"第三";
    threeNav.tabBarItem.image = [KImage(imageArr1[2]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    threeNav.tabBarItem.selectedImage = [KImage(imageArry2[2]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    threeNav.delegate = self;
    
    self.viewControllers = @[oneNav, twoNav, threeNav];
}

- (void)statusForNetwork:(NetworkStatus)status {
    if (!self.network) {return;}
    
    if (status == NotReachable) {// 无网络
        self.network.NotReachbleBlock();
    }else if (status == ReachableViaWiFi) {// Wifi
        self.network.ReachableViaWiFiBlock();
    }else if (status == ReachableViaWWAN) {// GPRS或3G
        self.network.ReachableViaWWANBlock();
    }else if (status == ReachableVia4G) {// 4G
        self.network.ReachableVia4GBlock();
    }else if (status == ReachableVia3G) {// 3G
        self.network.ReachableVia3GBlock();
    }else if (status == ReachableVia2G) {// 2G
        self.network.ReachableVia2GBlock();
    }

    if (status != NotReachable) {// 有网络
        self.network.ReachableBlock();
        [self.network netReachable];
    }
}

#pragma mark - delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count > 1) {
        viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30;
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BaseNavigationController *navi = (BaseNavigationController *)navigationController;
    if (navi._completion) {
        navi._completion();
        navi._completion = nil;
    }
    for( UIViewController *uvc in [navigationController childViewControllers]) {
        [self recursiveUpdate:uvc withTargetGesture:navigationController.fd_fullscreenPopGestureRecognizer];
    }
}



#pragma mark updateeGestureRelationship
- (void)recursiveUpdate:(UIViewController *)uvc withTargetGesture:(UIGestureRecognizer *) targetGr {
    if ([uvc isKindOfClass:[UIPageViewController class]]) {
        for(UIView *subview in uvc.view.subviews) {
            if([subview isKindOfClass:[UIScrollView class]]) {
                for(UIGestureRecognizer *gr in subview.gestureRecognizers) {
                    if([gr isKindOfClass:[UIPanGestureRecognizer class]]) {
                        [gr requireGestureRecognizerToFail:targetGr];
                    }
                }
            }
        }
        return;
    }
    for(UIView *subview in uvc.view.subviews) {
        if([subview isKindOfClass:[UIScrollView class]]) {
            for(UIGestureRecognizer *gr in subview.gestureRecognizers) {
                if([gr isKindOfClass:[UIPanGestureRecognizer class]]) {
                    [gr requireGestureRecognizerToFail:targetGr];
                    return;
                }
            }
        }
    }
    
    //    return ;
    if([[uvc childViewControllers] count] <= 0) return ;
    
    for(UIViewController *cUvc in [uvc childViewControllers]) {
        [self recursiveUpdate:cUvc withTargetGesture:targetGr];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

@end
