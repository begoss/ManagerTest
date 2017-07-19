//
//  BaseNavigationController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)load {
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header1"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"CCCCCC"], NSFontAttributeName: Font(17)};
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [UIImage new];
//    self.navigationBar.translucent = YES;
//    self.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.visibleViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.visibleViewController.preferredInterfaceOrientationForPresentation;
}

- (BOOL)shouldAutorotate {
    return self.visibleViewController.shouldAutorotate;
}


- (UIViewController *) popViewControllerAnimated:(BOOL) animated completion:(void (^)()) completion {
    self._completion = completion;
    return [super popViewControllerAnimated:animated];
}

- (UIViewController *) popToRootViewControllerAnimated:(BOOL) animated completion:(void (^)()) completion {
    self._completion = completion;
    return [super popToRootViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {        
        //设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated:)];
    }
    [super pushViewController:viewController animated:animated];
}


@end
