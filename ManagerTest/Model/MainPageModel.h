//
//  MainPageModel.h
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainPageDetailModel;
@class MainPageUpperModel;

@interface MainPageModel : NSObject

@property (copy, nonatomic) NSString *status;

@property (strong, nonatomic) NSArray <MainPageDetailModel *> *data;

@end

@interface MainPageDetailModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *text;

@property (copy, nonatomic) NSString *img;

@end

@interface MainPageUpperModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) NSArray *imgArray;

@property (strong, nonatomic) NSArray *titleArray;

@end
