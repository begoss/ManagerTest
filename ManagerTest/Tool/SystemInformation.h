//
//  SystemInformation.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInformation : NSObject

+ (NSString *)getDeviceName;           //e.g. @"My iphone"
+ (NSString *)getDeviceSystemName;     //e.g. @"iOS"
+ (NSString *)getDeviceSystemVersion;  //e.g. @"4.0"
+ (NSString *)getDeviceModel;          //e.g. @"iPhone", @"iPod touch"
+ (NSString *)getDeviceLocalModel;     //localized version of model
+ (NSString *)getUniqueDeviceIdentifierAsString;

@end
