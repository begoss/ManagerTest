//
//  ApiClient.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "ApiClient.h"
#import "SystemInformation.h"

@implementation ApiClient

#pragma mark - 增加请求公共参数
+ (NSString *)appendSignatureParameters:(NSString *)APIaddr {
    NSString *newAPIaddr = [APIaddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([newAPIaddr rangeOfString:@"?"].location == NSNotFound) {
        newAPIaddr = [NSString stringWithFormat:@"%@?os_type=%@&os_version=%@&_time=%.0f&version=%@&device_id=%@", newAPIaddr, @"iOS", [UIDevice currentDevice].systemVersion, [[NSDate date] timeIntervalSince1970], kappversion, [SystemInformation getUniqueDeviceIdentifierAsString]];
    } else {
        newAPIaddr = [NSString stringWithFormat:@"%@&os_type=%@&os_version=%@&_time=%.0f&version=%@&device_id=%@", newAPIaddr, @"iOS", [UIDevice currentDevice].systemVersion, [[NSDate date] timeIntervalSince1970], kappversion, [SystemInformation getUniqueDeviceIdentifierAsString]];
    }
    return newAPIaddr;
}

@end
