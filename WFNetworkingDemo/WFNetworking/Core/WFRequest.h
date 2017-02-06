//
//  WFRequest.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFMacro.h"
#import "WFUploadData.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFRequest : NSObject<NSCopying>

/**
 The server address for request, this value can be nil,if nil, use defaultHost in "WFMacro.h"
 */
@property (nonatomic, copy, nullable) NSString *host;

/**
 The API interface path request, default is nil
 */
@property (nonatomic, copy, nullable) NSString *api;

/**
 URL for the request which is combined by host and api property, if you set url, host and api will be ignored
 */
@property (nonatomic, copy, nullable) NSString *url;


/**
 The parameters for request
 */
@property (nonatomic, strong, nullable) NSDictionary <NSString *, id> *parameters;


/**
 The Headers for request
 */
@property (nonatomic, strong, nullable) NSDictionary <NSString *, NSString *> *headers;

/**
 request type, default is Normal, see "WFRequestType" in "WFMacro.h" for detail
 */
@property (nonatomic, assign) WFRequestType requestType;

/**
 request http method, default is GET, see "WFHTTPMethod" in "WFMacro.h" for detail
 */
@property (nonatomic, assign) WFHTTPMethod httpMethod;

/**
 The timeout time for request, default is 60s
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 retry time for request when error occurred, default is 0
 */
@property (nonatomic, assign) NSInteger retryTime;

/** request call back */
@property (nonatomic, copy, readonly, nullable) WFSuccessBlock successBlock;
@property (nonatomic, copy, readonly, nullable) WFFailureBlock failureBlock;
@property (nonatomic, copy, readonly, nullable) WFFinishBlock finishBlock;
@property (nonatomic, copy, readonly, nullable) WFProgressBlock progressBlock;

/**
 local cache path for download request ,default is nil
 @warning This value is valid only when requestType is "Download"
 */
@property (nonatomic, copy, nullable) NSString *downloadCachePath;

/**
 upload file fomatter data ,default
 @warning This value is valid only when requestType is "Upload"
 */
@property (nonatomic, strong, nullable) NSMutableArray<WFUploadData *>*uploadDatas;


/**
 request block call bacl queue
 */
@property (nonatomic, strong, nullable) dispatch_queue_t callbackQueue;

/**
 The underlying NSURLSessionTask.
 */
@property (nonatomic, strong) NSURLSessionTask *task;

/**
 clear all call back
 */
- (void)clearCallBack;


/**
 add upload data for upload request
 */
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
@end

NS_ASSUME_NONNULL_END
