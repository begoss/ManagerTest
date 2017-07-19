//
//  TabOneViewController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TabOneViewController.h"
#import "TestViewController.h"

@interface TabOneViewController ()

@property (nonatomic, strong) UIButton *testButton;

@end

@implementation TabOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一";
    [self.view addSubview:self.testButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testButtonClick {
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter

- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 80, 40)];
        _testButton.backgroundColor = [UIColor blueColor];
        [_testButton setTitleColor:Color(100, 181, 246) forState:UIControlStateNormal];
        [_testButton setTitle:@"测试" forState:UIControlStateNormal];
        _testButton.titleLabel.font = Font(14);
        [_testButton addTarget:self action:@selector(testButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testButton;
}

@end
