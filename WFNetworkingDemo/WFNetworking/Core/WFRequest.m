//
//  WFRequest.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "WFRequest.h"

@implementation WFRequest

- (instancetype)init {
    if (self = [super init]) {
        //设置默认配置
        self.httpMethod = kWFHTTPMethodGET;
        self.timeoutInterval = 60;
        self.cacheOption = kWFHTTPCacheOptionUseCache;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    WFRequest *copy = [[[self class] alloc] init];
    return copy;
}

- (void)clearCallBack {
    _successBlock = nil;
    _failureBlock = nil;
    _progressBlock = nil;
    _finishBlock = nil;
}
@end
