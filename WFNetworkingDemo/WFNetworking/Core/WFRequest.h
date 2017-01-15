//
//  WFRequest.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFRequest : NSObject

@property (nonatomic, assign) NSUInteger identifier;

@property (nonatomic, copy, nullable) NSString *host;
@property (nonatomic, copy, nullable) NSString *api;
@property (nonatomic, copy, nullable) NSString *url;

@property (nonatomic, strong, nullable) NSDictionary <NSString *, id> *parameters;
@property (nonatomic, strong, nullable) NSDictionary <NSString *, NSString *> *headers;
@property (nonatomic, strong, nullable) NSDictionary *userInfo;

@property (nonatomic, assign) WFHTTPMethod httpMethod;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) NSInteger retryTime;

@property (nonatomic, copy, readonly, nullable) WFSuccessBlock successBlock;
@property (nonatomic, copy, readonly, nullable) WFFailureBlock failureBlock;
@property (nonatomic, copy, readonly, nullable) WFFinishBlock finishBlock;
@property (nonatomic, copy, readonly, nullable) WFProgressBlock progressBlock;

+ (instancetype _Nonnull) request;
+ (instancetype _Nonnull) requestWithApi:(NSString * )api parameters:( NSDictionary <NSString *, id>* _Nullable)parameters;
- (void)clearCallBack;
@end

NS_ASSUME_NONNULL_END
