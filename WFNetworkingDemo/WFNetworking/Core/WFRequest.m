//
//  WFRequest.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "WFRequest.h"

@implementation WFRequest

+ (instancetype) request {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        
        //设置默认配置
        self.httpMethod = kWFHTTPMethodGET;
        self.timeoutInterval = 60;
    }
    return self;
}

+ (instancetype)requestWithApi:(NSString *)api parameters:(NSDictionary<NSString *,id> *)parameters {
    WFRequest *request = [self request];
    request.api = api;
    request.parameters = parameters;
    return request;
}

- (void)clearCallBack {
    _successBlock = nil;
    _failureBlock = nil;
    _progressBlock = nil;
    _finishBlock = nil;
}
@end
