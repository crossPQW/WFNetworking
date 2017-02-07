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
 send GET request

 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)getRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;

/**
 send POST request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)postRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 send HEAD request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)headRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 send PUT request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)putRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 send DELETE request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)deleteRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 send PATCH request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)patchRequest:(WFRequestConfigBlock)configBlock
                    success:(nullable WFSuccessBlock)successBlock
                    failure:(nullable WFFailureBlock)failureBlock;

/**
 send DOWNLOAD request
 @warning all call back will be called on callBackQueue of request except progressBlock, progressBlock will be called on session queue
 
 @param configBlock The config block to setup a new WFRequest object
 @param progressBlock  download progress block, called on session block
 @param successBlock Success call back for the request
 @param failureBlock Failure call back for the request
 @param finishBlock Finish call back for the download request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)downloadRequest:(WFRequestConfigBlock)configBlock
                     progress:(nullable WFProgressBlock)progressBlock
                      success:(nullable WFSuccessBlock)successBlock
                      failure:(nullable WFFailureBlock)failureBlock
                       finish:(WFFinishBlock)finishBlock;

/**
 send UPLOAD request
 @warning all call back will be called on callBackQueue of request except progressBlock, progressBlock will be called on session queue
 
 @param configBlock The config block to setup a new WFRequest object
 @param progressBlock  download progress block, called on session block
 @param successBlock Success call back for the request
 @param failureBlock Failure call back for the request
 @param finishBlock Finish call back for the upload request
 @return current request, can be used for cancel the request
 */
- (WFRequest *)uploadRequest:(WFRequestConfigBlock)configBlock
                    progress:(nullable WFProgressBlock)progressBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock
                      finish:(WFFinishBlock)finishBlock;

#pragma mark - class method
/**
 send GET request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)getRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 send POST request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)postRequest:(WFRequestConfigBlock)configBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock;
/**
 send HEAD request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)headRequest:(WFRequestConfigBlock)configBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock;
/**
 send PUT request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)putRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock;
/**
 send DELETE request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)deleteRequest:(WFRequestConfigBlock)configBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock;
/**
 send PATCH request
 
 @param configBlock The config block to setup a new WFRequest object
 @param successBlock  Success call back for the request
 @param failureBlock Failure call back for the request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)patchRequest:(WFRequestConfigBlock)configBlock
                    success:(nullable WFSuccessBlock)successBlock
                    failure:(nullable WFFailureBlock)failureBlock;
/**
 send DOWNLOAD request
 @warning all call back will be called on callBackQueue of request except progressBlock, progressBlock will be called on session queue
 
 @param configBlock The config block to setup a new WFRequest object
 @param progressBlock  download progress block, called on session block
 @param successBlock Success call back for the request
 @param failureBlock Failure call back for the request
 @param finishBlock Finish call back for the download request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)downloadRequest:(WFRequestConfigBlock)configBlock
                      progress:(nullable WFProgressBlock)progressBlock
                       success:(nullable WFSuccessBlock)successBlock
                       failure:(nullable WFFailureBlock)failureBlock
                        finish:(WFFinishBlock)finishBlock;
/**
 send UPLOAD request
 @warning all call back will be called on callBackQueue of request except progressBlock, progressBlock will be called on session queue
 
 @param configBlock The config block to setup a new WFRequest object
 @param progressBlock  download progress block, called on session block
 @param successBlock Success call back for the request
 @param failureBlock Failure call back for the request
 @param finishBlock Finish call back for the upload request
 @return current request, can be used for cancel the request
 */
+ (WFRequest *)uploadRequest:(WFRequestConfigBlock)configBlock
                    progress:(nullable WFProgressBlock)progressBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock
                      finish:(WFFinishBlock)finishBlock;

#pragma mark - cancel request

/**
 cancel a request

 @param request Request that need to be canceled
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
