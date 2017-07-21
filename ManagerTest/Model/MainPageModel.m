//
//  MainPageModel.m
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "MainPageModel.h"

@implementation MainPageModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MainPageDetailModel class]};
}

@end

@implementation MainPageDetailModel

@end

@implementation MainPageUpperModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MainPageUpperModel class]};
}

@end
