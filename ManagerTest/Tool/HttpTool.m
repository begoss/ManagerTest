//
//  HttpTool.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "HttpTool.h"

@implementation AFHttpClient

+ (instancetype)sharedClient {
    static AFHttpClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [AFHttpClient manager];
        client.responseSerializer = [AFJSONResponseSerializer serializer];
        //        client.requestSerializer = [AFJSONRequestSerializer serializer];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        client.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [client.requestSerializer setValue:@"http://api.maxjia.com/" forHTTPHeaderField:@"Referer"];
        [client.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
        [client.requestSerializer setValue:@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0" forHTTPHeaderField:@"User-Agent"];
        client.requestSerializer.timeoutInterval = 20;
    });
    //cookie
//    if (YES) {
//        NSString *cookie = @"";
//        [client.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
//    }
    return client;
}

@end

@implementation HttpTool

#pragma mark - GET请求
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    AFHttpClient *manager = [AFHttpClient sharedClient];
    DLog(@"url=%@, params=%@",  path, params);
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        if (success == nil)
            return;
        success(JSON);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure == nil) return;
        failure(error);
        
    }];
    
}

#pragma mark - POST请求
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    AFHttpClient *manager = [AFHttpClient sharedClient];
    DLog(@"%@%@",path,params);
    [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        if (success == nil) return;
        success(JSON);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure == nil) return;
        failure(error);
        
    }];
}

@end
