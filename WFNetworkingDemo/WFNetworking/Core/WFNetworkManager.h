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
- (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock;
- (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock;

+ (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock;
+ (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (NSUInteger)sendRequest:(WFRequestConfigBlock)requestBlock
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock;

#pragma mark - cancel request
+ (void)cancelRquest:(NSUInteger)requestIdentifier;
+ (void)cancelAllRequest;

+ (void)clearAllCache;
+ (WFRequest * _Nullable )getRequest:(NSUInteger)requestIdentifier;
@end

NS_ASSUME_NONNULL_END
