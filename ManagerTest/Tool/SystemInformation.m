//
//  SystemInformation.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "SystemInformation.h"
#import "SSKeychain.h"

@implementation SystemInformation

+ (NSString *)getDeviceName{
    return [[UIDevice currentDevice] name]; // Name of the phone as named by user
}

+ (NSString *)getDeviceSystemName{
    return [[UIDevice currentDevice] systemName]; // "iPhone OS"
}
+ (NSString *)getDeviceSystemVersion{
    return [[UIDevice currentDevice] systemVersion]; // "7.0"
}
+ (NSString *)getDeviceModel{
    return [[UIDevice currentDevice] model]; // "iPhone" on both devices
}
+ (NSString *)getDeviceLocalModel{
    return [[UIDevice currentDevice] localizedModel]; // "iPhone" on both devices
}

+(NSString *)getUniqueDeviceIdentifierAsString
{
    
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    
    return strApplicationUUID;
}


@end
