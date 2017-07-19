//
//  UIScrollView+Refresh.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpLoadBlock)(void);
typedef void(^PullDwonBlock)(void);

@interface UIScrollView (Refresh)

/** 当前刷新状态 */
@property (nonatomic, getter=isHeadRefreshing, assign) BOOL headRefreshing;
@property (nonatomic, getter=isFootRefreshing, assign) BOOL footRefreshing;

/**
 *  添加下拉刷新
 *
 *  @param block 刷新时需要调用的方法
 */
- (void)viewWithPullDown:(PullDwonBlock)block;

/**
 *  添加上拉加载（子类调用）
 *
 *  @param block 加载时需要调用的方法
 */
- (void)viewWithUpLoad:(UpLoadBlock)block;

- (void)viewWithPullDownIgnoreInsetTop:(PullDwonBlock)block;
/**
 *  开始下拉刷新
 */
- (void)startHeaderRefreshing;

/**
 *  停止下拉刷新
 */
- (void)stopHeaderRefreshing;

/**
 *  开始上拉加载
 */
- (void)startFooterRefreshing;

/**
 *  停止下拉加载
 */
- (void)stopFooterRefreshing;

/**
 *  移除下拉控件
 */
- (void)removeFooterRefreshing;
/**
 *  隐藏下拉控件
 */
-(void)hideFooterRefreshing;
/**
 *  显示下拉控件
 */
-(void)showFooterRefreshing;


@end
