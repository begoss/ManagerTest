//
//  BaseViewController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor bg2Color];
    self.headerHeight = 64;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)netErrorAction{
}

- (UIView *)netErrorView{
    if (!_netErrorView) {
        _netErrorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerHeight, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        _netErrorView.backgroundColor = [UIColor whiteColor];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
        iv.image = [UIImage imageNamed:@"placehold_img_no_network"];
        //        if (self.navigationController.viewControllers.count == 1) {
        //            iv.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-self.headerHeight-49)/2);
        //        }else{
        //            iv.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-self.headerHeight)/2);
        //        }
        iv.center = CGPointMake(SCREEN_WIDTH/2, 304-38/2.0-self.headerHeight);
        [_netErrorView addSubview:iv];
        [_netErrorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(netErrorAction)]];
        UILabel *desc = [[UILabel alloc] init];
        desc.text = @"当前网络不给力，请检查网络或点击屏幕刷新";
        desc.textColor = [UIColor text1Color];
        desc.font = Font(11);
        [_netErrorView addSubview:desc];
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_netErrorView.mas_centerX);
            make.top.equalTo(iv.mas_bottom).offset(17);
        }];
    }
    return _netErrorView;
}

@end
