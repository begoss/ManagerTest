//
//  OneCell.h
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MainPageModel.h"

@interface OneCell : BaseTableViewCell

@property (strong, nonatomic) void(^touchBlock)(NSString *str);
@property (strong, nonatomic) MainPageUpperModel *model;

@end
