//
//  WFMacro.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#ifndef WFMacro_h
#define WFMacro_h

#define WFLock() pthread_mutex_lock(&_lock)
#define WFUnlock() pthread_mutex_unlock(&_lock)

NS_ASSUME_NONNULL_BEGIN
@class WFRequest;

typedef NS_ENUM(NSInteger, WFRequestType) {
    Normal = 0,
    Download,
    Upload
};

typedef NS_ENUM(NSInteger, WFHTTPMethod) {
    GET = 0,
    POST,
    HEAD,
    PUT ,
    DELETE,
    PATCH
};


#pragma mark - callBackBlock
typedef void (^WFRequestConfigBlock)(WFRequest *request);
typedef void (^WFProgressBlock)(NSProgress  *progress);
typedef void (^WFSuccessBlock)(id _Nullable response);
typedef void (^WFFailureBlock)(NSError *_Nullable error);
typedef void (^WFFinishBlock)(id _Nullable response, NSError *_Nullable error);
NS_ASSUME_NONNULL_END
#endif /* WFMacro_h */
