//
//  WFNetworkSchdule.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFNetworkManager : NSObject

@property (nonatomic, strong, nullable) dispatch_queue_t callbackQueue;

+ (instancetype) defaultManager;


#pragma mark - send request
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock;
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(WFFinishBlock)finishBlock;
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                   finish:(WFFinishBlock)finishBlock;
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock;

+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock;
+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(WFFinishBlock)finishBlock;
+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                   finish:(WFFinishBlock)finishBlock;
+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (WFRequest *)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock;

#pragma mark - cancel request
+ (void)cancelRquest:(WFRequest *)request;

+ (void)clearAllCache;
@end

NS_ASSUME_NONNULL_END
