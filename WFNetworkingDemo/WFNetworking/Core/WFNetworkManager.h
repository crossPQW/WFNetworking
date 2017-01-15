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
- (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock;
- (NSUInteger)sendRequest:(WFRequest *)request
                  failure:(nullable WFFailureBlock)failureBlock;
- (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
- (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock;

+ (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock;
+ (NSUInteger)sendRequest:(WFRequest *)request
                  failure:(nullable WFFailureBlock)failureBlock;
+ (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
+ (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock;

#pragma mark - cancel request
+ (void)cancelRquest:(NSUInteger)requestIdentifier;
+ (void)cancelAllRequest;
@end

NS_ASSUME_NONNULL_END
