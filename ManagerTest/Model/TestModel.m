//
//  TestModel.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [TestModelData class]};
}

@end

@implementation TestModelData

@end
