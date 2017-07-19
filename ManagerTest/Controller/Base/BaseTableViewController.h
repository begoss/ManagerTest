//
//  BaseTableViewController.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

/** 当前视图的tableView，子类自己去实现delelgate与dataSource，注册cell */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL needRefresh;
/**
 *  刷新视图frame（子类调用）
 */
- (void)refreshFrame;
/** 加载指示器图片 */
@property (nonatomic, strong) UIImageView *loadImage;
@property (nonatomic, strong) UIImageView *loadBackgroundImage;
/** 开启刷新指示器 */
- (void)startLoad;

/** 停止刷新指示器 */
- (void)stopLoad;

@end
