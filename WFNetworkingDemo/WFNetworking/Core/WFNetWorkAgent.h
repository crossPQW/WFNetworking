//
//  WFNetWork.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/11.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFRequest.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^WFCompletedHandler)(id _Nullable response, NSError *error);

@interface WFNetWorkAgent : NSObject

+ (instancetype)shareAgent;


/**
 send a http request

 @param request http request
 @param handler complete call back
 @return  current request
 */
- (WFRequest *)sendRequest:(WFRequest *)request complete:(WFCompletedHandler)handler;


/**
 cancel a request
 
 @param request Request that need to be canceled
 */
- (void)cancelRequest:(WFRequest *)request;


/**
 cancel all running request
 */
- (void)cancelAllRequest;
@end

NS_ASSUME_NONNULL_END
