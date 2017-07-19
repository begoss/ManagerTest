//
//  ApiClient.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "HttpTool.h"

@interface ApiClient : HttpTool

/**
 *   为url添加公共的参数, 只包含机器信息
 *
 *  @param APIaddr 原始的url
 *
 *  @return 带公共参数的url
 */
+ (NSString *)appendSignatureParameters:(NSString *)APIaddr;

@end
