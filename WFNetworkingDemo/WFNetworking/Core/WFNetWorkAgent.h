//
//  WFNetWork.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/11.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFRequest.h"

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^WFCompletedHandler)(id _Nullable response, NSError *error);

@interface WFNetWorkAgent : NSObject



+ (instancetype)shareAgent;


- (NSUInteger)sendRequest:(WFRequest *)request complete:(WFCompletedHandler)handler;

- (void)cancelRequest:(NSUInteger)requestID;
@end

NS_ASSUME_NONNULL_END
