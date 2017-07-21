//
//  TabTwoViewController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TabTwoViewController.h"
#import "MyViewController.h"

@interface TabTwoViewController ()

@property (strong , nonatomic) UIButton *btn;

@end

@implementation TabTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二";
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)btn{
    if(!_btn){
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 80, 40)];
        _btn.backgroundColor = [UIColor blueColor];
        [_btn setTitleColor:Color(100, 181, 246) forState:UIControlStateNormal];
        [_btn setTitle:@"测试" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick{
    MyViewController *vc = [MyViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
