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

#ifdef DEBUG
#import <UIKit/UIKit.h>
#else
#endif
@interface WFNetworkManager()

@property (nonatomic, strong) WFNetworkConfig *config;
@end
@implementation WFNetworkManager

#pragma mark - life cycle
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

+ (void)setupConfig:(void(^)(WFNetworkConfig *config))configBlock {
    [[self defaultManager] setupConfig:configBlock];
}

- (void)setupConfig:(void(^)(WFNetworkConfig *config))configBlock {
    WFNetworkConfig *config = [[WFNetworkConfig alloc] init];
    if (configBlock) {
        configBlock(config);
    }
    self.config = config;
}

#pragma mark - ---------------public method-----------------
- (WFRequest *)getRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequestWithRquestType:Normal httpMethod:GET configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)postRequest:(WFRequestConfigBlock)configBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequestWithRquestType:Normal httpMethod:POST configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)headRequest:(WFRequestConfigBlock)configBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequestWithRquestType:Normal httpMethod:HEAD configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)putRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequestWithRquestType:Normal httpMethod:PUT configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)deleteRequest:(WFRequestConfigBlock)configBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequestWithRquestType:Normal httpMethod:DELETE configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)patchRequest:(WFRequestConfigBlock)configBlock
                    success:(nullable WFSuccessBlock)successBlock
                    failure:(nullable WFFailureBlock)failureBlock {
    return [self sendRequestWithRquestType:Normal httpMethod:PATCH configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)downloadRequest:(WFRequestConfigBlock)configBlock
                      progress:(nullable WFProgressBlock)progressBlock
                       success:(nullable WFSuccessBlock)successBlock
                       failure:(nullable WFFailureBlock)failureBlock
                        finish:(WFFinishBlock)finishBlock {
    return [self sendRequestWithRquestType:Download httpMethod:-1 configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
- (WFRequest *)uploadRequest:(WFRequestConfigBlock)configBlock
                    progress:(nullable WFProgressBlock)progressBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock
                      finish:(WFFinishBlock)finishBlock {
    return [self sendRequestWithRquestType:Upload httpMethod:-1 configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}

+ (WFRequest *)getRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequestWithRquestType:Normal httpMethod:GET configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
+ (WFRequest *)postRequest:(WFRequestConfigBlock)configBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequestWithRquestType:Normal httpMethod:POST configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
+ (WFRequest *)headRequest:(WFRequestConfigBlock)configBlock
                   success:(nullable WFSuccessBlock)successBlock
                   failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequestWithRquestType:Normal httpMethod:HEAD configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
+ (WFRequest *)putRequest:(WFRequestConfigBlock)configBlock
                  success:(nullable WFSuccessBlock)successBlock
                  failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequestWithRquestType:Normal httpMethod:PUT configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
+ (WFRequest *)deleteRequest:(WFRequestConfigBlock)configBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequestWithRquestType:Normal httpMethod:DELETE configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
+ (WFRequest *)patchRequest:(WFRequestConfigBlock)configBlock
                    success:(nullable WFSuccessBlock)successBlock
                    failure:(nullable WFFailureBlock)failureBlock {
    return [[self defaultManager] sendRequestWithRquestType:Normal httpMethod:PATCH configBlock:configBlock Progress:nil success:successBlock failure:failureBlock finish:nil];
}
+ (WFRequest *)downloadRequest:(WFRequestConfigBlock)configBlock
                      progress:(nullable WFProgressBlock)progressBlock
                       success:(nullable WFSuccessBlock)successBlock
                       failure:(nullable WFFailureBlock)failureBlock
                        finish:(WFFinishBlock)finishBlock {
    return [[self defaultManager] sendRequestWithRquestType:Download httpMethod:-1 configBlock:configBlock Progress:progressBlock success:successBlock failure:failureBlock finish:finishBlock];
}
+ (WFRequest *)uploadRequest:(WFRequestConfigBlock)configBlock
                    progress:(nullable WFProgressBlock)progressBlock
                     success:(nullable WFSuccessBlock)successBlock
                     failure:(nullable WFFailureBlock)failureBlock
                      finish:(WFFinishBlock)finishBlock {
    return [[self defaultManager] sendRequestWithRquestType:Upload httpMethod:-1 configBlock:configBlock Progress:progressBlock success:successBlock failure:failureBlock finish:finishBlock];
}
#pragma mark - send request

- (WFRequest *)sendRequestWithRquestType:(WFRequestType)requestType
                              httpMethod:(WFHTTPMethod)httpMethod
                             configBlock:(WFRequestConfigBlock)configBlock
                                Progress:(WFProgressBlock)progressBlock
                                 success:(WFSuccessBlock)successBlock
                                 failure:(WFFailureBlock)failureBlock
                                  finish:(WFFinishBlock)finishBlock {
    WFRequest *request = [[WFRequest alloc] init];
    if (configBlock) {
        configBlock(request);
    }
    request.requestType = requestType;
    request.httpMethod = httpMethod;
    [self processRequest:request progress:progressBlock success:successBlock failure:failureBlock finished:finishBlock];
    return [self beginSendRequest:request];
}


#pragma mark - cancel request
+ (void)cancelRquest:(WFRequest *)request {
    [[WFNetWorkAgent shareAgent] cancelRequest:request];
}

+ (void)cancelAllRequest {
    [[WFNetWorkAgent shareAgent] cancelAllRequest];
}

#pragma mark - clear cache
+ (void)clearAllCache {
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
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
    
    if (self.config.generalHeaders) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:request.headers];
        [dict addEntriesFromDictionary:self.config.generalHeaders];
        request.headers = dict.copy;
    }
    
    if (self.config.generalParameters) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:request.parameters];
        [dict addEntriesFromDictionary:self.config.generalParameters];
        request.parameters = dict.copy;
    }
    
    if (self.config.generalTimeout) {
        request.timeoutInterval = self.config.generalTimeout;
    }
    
    if (request.url.length == 0) {
        if (request.host.length == 0) {
            if (self.config.generalHost.length > 0) {
                request.host = self.config.generalHost;
            }
            NSAssert(request.host.length > 0, @" request host can't be null.");
        }
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

- (WFRequest *)beginSendRequest:(WFRequest *)request {
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
#ifdef DEBUG
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
            NSString *message = [NSString stringWithFormat:@"Request:\n %@ \n Error:\n %@",request.description,error.localizedDescription];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请求出错(该弹窗只会在测试环境出现)" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [vc presentViewController:alert animated:YES completion:nil];
        });
#else
#endif
        if (request.callbackQueue) {
            dispatch_async(request.callbackQueue, ^{
                if (request.failureBlock) {
                    request.failureBlock(error);
                }
                if (request.finishBlock) {
                    request.finishBlock(nil,error);
                }
                [request clearCallBack];
            });
        }else{
            if (request.failureBlock) {
                request.failureBlock(error);
            }
            if (request.finishBlock) {
                request.finishBlock(nil,error);
            }
            [request clearCallBack];
        }
    }
}

- (void)handleSuccess:(id)responseObject withRequest:(WFRequest *)request
{
    if (request.callbackQueue) {
        __weak typeof(self)weakSelf = self;
        dispatch_async(request.callbackQueue, ^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf performSuccessCallBackWithResponseobject:responseObject Request:request];
        });
    }else{
        [self performSuccessCallBackWithResponseobject:responseObject Request:request];
    }
    
}

- (void)performSuccessCallBackWithResponseobject:(id)responseObject Request:(WFRequest *)request {
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        if (request.successBlock) {
            request.successBlock(responseObject);
        }
        if (request.finishBlock) {
            request.finishBlock(responseObject,nil);
        }
        
        [request clearCallBack];
    }
}
@end
