//
//  BaseNetWorkViewController.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNetWorkViewController : UIViewController

/** 有网络就会调用 */
@property (nonatomic, copy) void(^ReachableBlock)(void);
/** 无网络 */
@property (nonatomic, copy) void(^NotReachbleBlock)(void);
/** Wifi */
@property (nonatomic, copy) void(^ReachableViaWiFiBlock)(void);
/** GPRS或3G */
@property (nonatomic, copy) void(^ReachableViaWWANBlock)(void);
/** 4G */
@property (nonatomic, copy) void(^ReachableVia4GBlock)(void);
/** 3G */
@property (nonatomic, copy) void(^ReachableVia3GBlock)(void);
/** 2G */
@property (nonatomic, copy) void(^ReachableVia2GBlock)(void);
/**
 *  判断当前网络是否可用
 */
@property (nonatomic) BOOL netWorkEnable;
/*
 非切换网络状态时无网络
 */
@property (nonatomic, copy) void(^netWorkError)();
#pragma mark - 网络请求
/**
 *  开启网络请求（get请求，子类调用）
 *
 *  @param path   url
 *  @param params 参数
 *  @param insert 是否上拉加载
 *  @param tag    请求标识
 */
- (void)getRequestWithPath:(NSString *)path params:(NSDictionary *)params toInsert:(BOOL)insert tag:(NSString *)tag;

/**
 *  开启网络请求（论坛专用）
 *
 *  @param path   url
 *  @param params 参数
 *  @param insert 是否上拉加载
 *  @param tag    请求标识
 */
- (void)getRequestForLinkWithPathPath:(NSString *)path params:(NSDictionary *)params toInsert:(BOOL)insert tag:(NSString *)tag;

/**
 *  开启网络请求（get请求，子类调用）
 *
 *  @param path   url
 *  @param params 参数
 */
- (void)postRequestWithPath:(NSString *)path params:(NSDictionary *)params tag:(NSString *)tag;

/** post请求成功 */
@property (nonatomic, copy) void(^PostSuccessBlock)(id JSON, NSString *tag);
/** post请求失败 */
@property (nonatomic, copy) void(^PostFailureBlock)(NSError *error, NSString *tag);

/**
 *  get请求成功方法（子类重写）
 *
 *  @param dic    请求的数据
 *  @param insert 是否上拉加载
 *  @param tag    请求标识
 */
- (void)successRequestForDict:(NSDictionary *)dic toInsert:(BOOL)insert tag:(NSString *)tag;

/**
 *  relogin方法: 跳转到登录页面
 */
- (void)reloginRequest;

/**
 *  failure方法
 */
- (void)failureRequestMessage:(NSString *)msg tag:(NSString *)tag;

/* 子类重写该方法,网络恢复*/
- (void)netReachable;

/* 子类重写该方法,下拉刷新*/
- (void)headerRefresh;

@end
