//
//  TestModel.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestModelData;

@interface TestModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray <TestModelData *> *data;

@end

@interface TestModelData : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;

@end
