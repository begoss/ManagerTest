//
//  BaseNetWorkViewController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseNetWorkViewController.h"
#import "Reachability.h"
#import "ApiClient.h"

@interface BaseNetWorkViewController ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@property (nonatomic, strong) Reachability *   reachability;

@end

@implementation BaseNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setReachableBlock:^{}];
    [self setNotReachbleBlock:^{}];
    [self setReachableViaWiFiBlock:^{}];
    [self setReachableViaWWANBlock:^{}];
    [self setReachableVia4GBlock:^{}];
    [self setReachableVia3GBlock:^{}];
    [self setReachableVia2GBlock:^{}];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"%@",NSStringFromClass([self class]));
}

- (void)dealloc {
    DLog(@"----------------------\n%@ dealloc\n-----------------------", NSStringFromClass(self.class));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 网络请求
- (void)postRequestWithPath:(NSString *)path params:(NSDictionary *)params tag:(NSString *)tag{
    NSString *completePath = [ApiClient appendSignatureParameters:path];
    [ApiClient postWithPath:completePath params:params success:^(id JSON) {
        if ([JSON[@"status"] isEqualToString:@"ok"]) {
            if (_PostSuccessBlock) {
                _PostSuccessBlock(JSON, tag);
            }
        }else {
            if (_PostFailureBlock) {
                _PostFailureBlock(JSON, tag);
            }
        }
    } failure:^(NSError *error) {
        if (_PostFailureBlock) {
            _PostFailureBlock(error, tag);
        }
    }];
}

- (void)getRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                  toInsert:(BOOL)insert tag:(NSString *)tag {
    if (self.netWorkEnable) {
        NSMutableDictionary *mutabeDict = [params mutableCopy];
        NSString *completePath = [ApiClient appendSignatureParameters:path];
        //                NSString *completePath = path;
        if (insert) {// 上拉加载
            if (![self.dictionary objectForKey:NSStringFromClass(self.class)]) {
                [self.dictionary setObject:@"30" forKey:NSStringFromClass(self.class)];
            }
            [mutabeDict setObject:self.dictionary[NSStringFromClass(self.class)] forKey:@"offset"];
            [self upLoadWithPath:completePath params:mutabeDict tag:tag];
        }else {// 下拉刷新
            [self pullDownWithPath:completePath params:params tag:tag];
        }
    }else {
        if (self.reachability.currentReachabilityStatus == NotReachable) {
            if (self.netWorkError) {
                self.netWorkError();
            }
            [self failureRequestMessage:@"当前无可用网络，检查你的网络设置" tag:@"noNetWork"];
        }
    }
}

- (void)getRequestForLinkWithPathPath:(NSString *)path params:(NSDictionary *)params toInsert:(BOOL)insert tag:(NSString *)tag {
    if (self.netWorkEnable) {
        NSString *completePath = [ApiClient appendSignatureParameters:path];
        WS(weakSelf);
        [HttpTool getWithPath:completePath params:params success:^(id JSON) {
            StrS(strongSelf);
            NSString *status = JSON[@"status"];
            if ([status isEqualToString:@"ok"]) {
                [strongSelf successRequestForDict:JSON toInsert:insert tag:tag];
            }else if ([status isEqualToString:@"relogin"]) {
                [strongSelf reloginRequest];
            }else {
                [strongSelf failureRequestMessage:JSON[@"msg"] tag:tag];
            }
        } failure:^(NSError *error) {
            DLog(@"System error=%@", error);
            StrS(strongSelf);
            [strongSelf.view showBadtipsAlert:@"请求超时" duration:1];
            [strongSelf failureRequestMessage:@"请求超时" tag:tag];
        }];
    }else{
        if (self.reachability.currentReachabilityStatus == NotReachable) {
            if (self.netWorkError) {
                self.netWorkError();
            }
            [self failureRequestMessage:@"当前无可用网络，检查你的网络设置" tag:@"noNetWork"];
        }
    }
}

// 下拉刷新
- (void)pullDownWithPath:(NSString *)path params:(NSDictionary *)params tag:(NSString *)tag {
    WS(weakSelf);
    [ApiClient getWithPath:path params:params success:^(id JSON) {
        StrS(strongSelf);
        NSString *status = JSON[@"status"];
        if ([status isEqualToString:@"ok"]) {
            [strongSelf successRequestForDict:JSON toInsert:NO tag:tag];
        }else if ([status isEqualToString:@"relogin"]) {
            [strongSelf reloginRequest];
        }else {
            [strongSelf failureRequestMessage:JSON[@"msg"] tag:tag];
        }
    } failure:^(NSError *error) {
        DLog(@"System error=%@", error);
        StrS(strongSelf);
        [strongSelf.view showBadtipsAlert:@"请求超时" duration:1];
        [strongSelf failureRequestMessage:@"请求超时" tag:tag];
    }];
    // 移除上拉加载页数
    [self.dictionary removeObjectForKey:NSStringFromClass(self.class)];
}

// 上拉加载
- (void)upLoadWithPath:(NSString *)path params:(NSDictionary *)params tag:(NSString *)tag {
    WS(weakSelf);
    DLog(@"%@, param=%@", path, params);
    [ApiClient getWithPath:path params:params success:^(id JSON) {
        StrS(strongSelf);
        NSString *status = JSON[@"status"];
        if ([status isEqualToString:@"ok"]) {
            [strongSelf successRequestForDict:JSON toInsert:YES tag:tag];
            // 增加下拉加载请求数据
            NSInteger value = [strongSelf.dictionary[NSStringFromClass(strongSelf.class)] integerValue] + 30;
            [strongSelf.dictionary setObject:[NSString stringWithFormat:@"%ld", (long)value] forKey:NSStringFromClass(strongSelf.class)];
        }else if ([status isEqualToString:@"relogin"]) {
            [strongSelf reloginRequest];
        }else {
            [strongSelf failureRequestMessage:JSON[@"msg"] tag:tag];
        }
    } failure:^(NSError *error) {
        DLog(@"System error=%@", error);
        StrS(strongSelf);
        [strongSelf failureRequestMessage:@"请求超时" tag:tag];
    }];
}

// 上拉加载重复请求
- (void)upLoadWithPath:(NSString *)path params:(NSDictionary *)params tag:(NSString *)tag count:(NSInteger)count {
    WS(weakSelf);
    DLog(@"%@, param=%@", path, params);
    [ApiClient getWithPath:path params:params success:^(id JSON) {
        StrS(strongSelf);
        NSString *status = JSON[@"status"];
        if ([status isEqualToString:@"ok"]) {
            [strongSelf successRequestForDict:JSON toInsert:YES tag:tag];
            // 增加下拉加载请求数据
            NSInteger value = [strongSelf.dictionary[NSStringFromClass(strongSelf.class)] integerValue] + 30;
            [strongSelf.dictionary setObject:[NSString stringWithFormat:@"%ld", (long)value] forKey:NSStringFromClass(strongSelf.class)];
        }else if ([status isEqualToString:@"relogin"]) {
            [strongSelf reloginRequest];
        }else {
            [strongSelf failureRequestMessage:JSON[@"msg"] tag:tag];
        }
    } failure:^(NSError *error) {
        DLog(@"System error=%@", error);
        StrS(strongSelf);
        [strongSelf failureRequestMessage:@"请求超时" tag:tag];
    }];
}

- (void)successRequestForDict:(NSDictionary *)dic toInsert:(BOOL)insert tag:(NSString *)tag {}
- (void)reloginRequest {}
- (void)failureRequestMessage:(NSString *)msg tag:(NSString *)tag {
    [self.view showBadtipsAlert:msg];
}

- (void)netReachable{}
- (void)headerRefresh{}

//#pragma mark - 禁止横屏
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [self.view layoutIfNeeded];
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
//
//- (void)viewDidLayoutSubviews {
//    if ([[UIDevice currentDevice] orientation] != UIInterfaceOrientationPortrait) {
//        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//    }
//}

#pragma mark - getter and setter
- (NSMutableDictionary *)dictionary {
    if (!_dictionary) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return _dictionary;
}

- (Reachability *)reachability {
    if (!_reachability) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    return _reachability;
}
- (BOOL) netWorkEnable {
    if (self.reachability.currentReachabilityStatus == NotReachable) {
        return NO;
    }
    return YES;
}

@end
