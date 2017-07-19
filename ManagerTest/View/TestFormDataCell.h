//
//  TestFormDataCell.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TestModel.h"

@interface TestFormDataCell : BaseTableViewCell

@property (nonatomic, strong) void(^editBlock)(BOOL selected);
@property (nonatomic, strong) TestModelData *model;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isSelected;

@end
