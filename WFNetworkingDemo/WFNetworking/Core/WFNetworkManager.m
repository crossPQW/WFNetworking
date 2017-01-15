//
//  WFNetworkSchdule.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "WFNetworkManager.h"
#import "WFRequest.h"
#import "WFNetWorkAgent.h"

@interface WFNetworkManager()
@property (nonatomic, copy, nullable) NSString *defaultHost;
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, id> *defaultParameters;
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, NSString *> *defaultHeaders;
@end
@implementation WFNetworkManager

+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    static WFNetworkManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [self manager];
    });
    return manager;
}

- (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock {
    return [self sendRequest:request Progress:nil success:successBlock failure:nil finish:nil];
}
- (NSUInteger)sendRequest:(WFRequest *)request
                  failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequest:request Progress:nil success:nil failure:failureBlock finish:nil];
}
- (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequest:request Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequest:request Progress:progressBlock success:successBlock failure:failureBlock finish:nil];
}

- (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(WFProgressBlock)progressBlock
                  success:(WFSuccessBlock)successBlock
                  failure:(WFFailureBlock)failureBlock
                   finish:(WFFinishBlock)finishBlock {
    [self processRequest:request progress:progressBlock success:successBlock failure:failureBlock finished:finishBlock];
    return [self beginSendRequest:request];
}

+ (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock {
    return [[self defaultManager] sendRequest:request success:successBlock];
}
+ (NSUInteger)sendRequest:(WFRequest *)request
                  failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequest:request failure:failureBlock];
}
+ (NSUInteger)sendRequest:(WFRequest *)request
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequest:request success:successBlock failure:failureBlock];
}
+ (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequest:request Progress:progressBlock success:successBlock failure:failureBlock];
}
+ (NSUInteger)sendRequest:(WFRequest *)request
                 Progress:(nullable WFProgressBlock)progressBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock
                   finish:(nullable WFFinishBlock)finishBlock {
    return [[self defaultManager] sendRequest:request Progress:progressBlock success:successBlock failure:failureBlock finish:finishBlock];
}

#pragma mark - private method
- (void)processRequest:(WFRequest *)request
               progress:(WFProgressBlock)progressBlock
                success:(WFSuccessBlock)successBlock
                failure:(WFFailureBlock)failureBlock
               finished:(WFFinishBlock)finishedBlock {
    
    if (successBlock) {
        [request setValue:successBlock forKey:@"_successBlock"];
    }
    if (failureBlock) {
        [request setValue:failureBlock forKey:@"_failureBlock"];
    }
    if (finishedBlock) {
        [request setValue:finishedBlock forKey:@"_finishBlock"];
    }
    if (progressBlock) {
        [request setValue:progressBlock forKey:@"_progressBlock"];
    }
    
    if (request.url.length == 0) {
        if (request.api.length > 0) {
            NSURL *baseUrl = [NSURL URLWithString:request.host];
            if (baseUrl.path.length > 0 && ![baseUrl.absoluteString hasSuffix:@"/"]) {
                baseUrl = [baseUrl URLByAppendingPathComponent:@""];
            }
            request.url = [NSURL URLWithString:request.api relativeToURL:baseUrl].absoluteString;
        }else{
            request.url = request.host;
        }
    }
    NSAssert(request.url.length > 0, @"request url can't be null.");
}

- (NSUInteger)beginSendRequest:(WFRequest *)request {
    return [[WFNetWorkAgent shareAgent] sendRequest:request complete:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        if (error) {
            [self handleFailure:error withRequest:request];
        }else{
            [self handleSuccess:responseObject withRequest:request];
        }
    }];
}

- (void)handleFailure:(NSError *)error withRequest:(WFRequest *)request {
    if (request.retryTime > 0) {
        request.retryTime--;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self beginSendRequest:request];
        });
        return;
    }else{
        if (request.failureBlock) {
            request.failureBlock(error);
        }
        [request clearCallBack];
    }
}

- (void)handleSuccess:(id)responseObject withRequest:(WFRequest *)request {
    if (request.successBlock) {
        request.successBlock(responseObject);
    }
}

+ (void)cancelRquest:(NSUInteger)requestIdentifier {
    [[WFNetWorkAgent shareAgent] cancelRequestByIdentifier:requestIdentifier];
}

+ (void)cancelAllRequest {
    [[WFNetWorkAgent shareAgent] cancelAllRequest];
}

@end
