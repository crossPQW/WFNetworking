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

@property (nonatomic, strong) NSURLSessionTask *task;

/**
 可为空，若为空，则使用WFMacro中默认host值
 */
@property (nonatomic, copy, nullable) NSString *host;

/**
 api
 */
@property (nonatomic, copy, nullable) NSString *api;

/**
 如果设置了url，则直接使用该url，忽略host与api
 */
@property (nonatomic, copy, nullable) NSString *url;


/**
 请求参数
 */
@property (nonatomic, strong, nullable) NSDictionary <NSString *, id> *parameters;


/**
 请求header
 */
@property (nonatomic, strong, nullable) NSDictionary <NSString *, NSString *> *headers;

/**
 请求类型，默认为Normal，用于区分常规请求与download、upload请求
 */
@property (nonatomic, assign) WFRequestType requestType;

/**
 请求的http方法，支持的类型有GET、POST、HEAD、PUT、DELETE、PATCH
 */
@property (nonatomic, assign) WFHTTPMethod httpMethod;

/**
 超时时间，默认60秒
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 请求失败重试次数,默认为0
 */
@property (nonatomic, assign) NSInteger retryTime;

/** 请求的回调 */
@property (nonatomic, copy, readonly, nullable) WFSuccessBlock successBlock;
@property (nonatomic, copy, readonly, nullable) WFFailureBlock failureBlock;
@property (nonatomic, copy, readonly, nullable) WFFinishBlock finishBlock;
@property (nonatomic, copy, readonly, nullable) WFProgressBlock progressBlock;

/**
 download请求的下载路径
 */
@property (nonatomic, copy, nullable) NSString *downloadCachePath;

/**
 上传请求的 data 体
 该参数只在upload请求的时候才有用，具体见 WFUploadData 类
 */
@property (nonatomic, strong, nullable) NSMutableArray<WFUploadData *>*uploadDatas;


/**
 清空回调，防止产生 retain cycle
 */
- (void)clearCallBack;


/**
 upload 请求添加 data
 */
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
@end

NS_ASSUME_NONNULL_END
