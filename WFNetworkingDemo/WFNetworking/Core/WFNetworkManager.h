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

+ (instancetype) defaultManager;

#pragma mark - send request

/**
 发送 GET 请求

 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)getRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;

/**
 发送 POST 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)postRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 HEAD 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)headRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 PUT 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)putRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 DELETE 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)deleteRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 PATCH 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)patchRequest:(WFRequestConfigBlock)requestBlock
                    success:(nullable WFSuccessBlock)successBlock
                    failure:(nullable WFFailureBlock)failureBlock;

/**
 发送 DOWNLOAD 请求
 除 progressBlock 外其他回调均在 callBackQueue 中执行，progressBlock 会在 session queue 中执行
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param progressBlock 下载进度 block
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @param finishBlock 请求完成回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)downloadRequest:(WFRequestConfigBlock)requestBlock
                     progress:(nullable WFProgressBlock)progressBlock
                      success:(nullable WFSuccessBlock)successBlock
                      failure:(nullable WFFailureBlock)failureBlock
                       finish:(WFFinishBlock)finishBlock;

/**
 发送 UPLOAD 请求
 除 progressBlock 外其他回调均在 callBackQueue 中执行，progressBlock 会在 session queue 中执行
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param progressBlock 下载进度 block
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @param finishBlock 请求完成回调
 @return 返回当前request，用于以后取消请求
 */
- (WFRequest *)uploadRequest:(WFRequestConfigBlock)requestBlock
                    progress:(nullable WFProgressBlock)progressBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock
                      finish:(WFFinishBlock)finishBlock;

#pragma mark - class method
/**
 发送 GET 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)getRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 POST 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)postRequest:(WFRequestConfigBlock)requestBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 HEAD 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)headRequest:(WFRequestConfigBlock)requestBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 PUT 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)putRequest:(WFRequestConfigBlock)requestBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 DELETE 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)deleteRequest:(WFRequestConfigBlock)requestBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 PATCH 请求
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param successBlock  请求成功回调
 @param failureBlock 请求失败回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)patchRequest:(WFRequestConfigBlock)requestBlock
                    success:(nullable WFSuccessBlock)successBlock
                    failure:(nullable WFFailureBlock)failureBlock;
/**
 发送 DOWNLOAD 请求
 除 progressBlock 外其他回调均在 callBackQueue 中执行，progressBlock 会在 session queue 中执行
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param progressBlock 下载进度 block
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @param finishBlock 请求完成回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)downloadRequest:(WFRequestConfigBlock)requestBlock
                      progress:(nullable WFProgressBlock)progressBlock
                       success:(nullable WFSuccessBlock)successBlock
                       failure:(nullable WFFailureBlock)failureBlock
                        finish:(WFFinishBlock)finishBlock;
/**
 发送 UPLOAD 请求
 除 progressBlock 外其他回调均在 callBackQueue 中执行，progressBlock 会在 session queue 中执行
 
 @param requestBlock 用于配置请求信息的 block，具体参见 WFRequest
 @param progressBlock 下载进度 block
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @param finishBlock 请求完成回调
 @return 返回当前request，用于以后取消请求
 */
+ (WFRequest *)uploadRequest:(WFRequestConfigBlock)requestBlock
                    progress:(nullable WFProgressBlock)progressBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock
                      finish:(WFFinishBlock)finishBlock;

#pragma mark - cancel request

/**
 cancel a request

 @param request a running request
 */
+ (void)cancelRquest:(WFRequest *)request;


/**
 cancel all runing requests
 */
+ (void)cancelAllRequest;


/**
 clear all cache
 */
+ (void)clearAllCache;
@end

NS_ASSUME_NONNULL_END
