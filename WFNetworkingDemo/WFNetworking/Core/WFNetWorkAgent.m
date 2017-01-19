//
//  WFNetWork.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/11.
//  Copyright © 2017年 黄少华. All rights reserved.
//


#import "WFNetWorkAgent.h"
#import "WFMacro.h"
#import <pthread/pthread.h>
#import <objc/runtime.h>

@implementation NSObject (BindingRequestForNSURLSessionTask)

static NSString * const kWFRequestBindingKey = @"kXMRequestBindingKey";

- (void)bindingRequest:(WFRequest *)request {
    objc_setAssociatedObject(self, (__bridge CFStringRef)kWFRequestBindingKey, request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WFRequest *)bindedRequest {
    WFRequest *request = objc_getAssociatedObject(self, (__bridge CFStringRef)kWFRequestBindingKey);
    return request;
}
@end

@interface WFNetWorkAgent(){
    pthread_mutex_t _lock;
}

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) AFJSONRequestSerializer *afJSONRequestSerializer;
@property (nonatomic, strong) AFJSONResponseSerializer *afJSONResponseSerializer;

@property (nonatomic, strong) dispatch_queue_t requestCompleteQueue;

@end

@implementation WFNetWorkAgent

+ (instancetype)shareAgent {
    static WFNetWorkAgent *agent;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [[[self class] alloc] init];
    });
    return agent;
}

- (instancetype)init {
    if (self = [super init]) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)dealloc {
    if (_sessionManager) {
        [_sessionManager invalidateSessionCancelingTasks:YES];
    }
}

- (NSUInteger)sendRequest:(WFRequest *)request complete:(WFCompletedHandler)handler {
    return [self dataTaskWithRequest:request complete:handler];
}

- (NSUInteger)dataTaskWithRequest:(WFRequest *)request complete:(WFCompletedHandler)handler {
    
    NSError *error;
    NSString *httpMethod = [self getHTTPMethodWithRequest:request];
    
    AFHTTPRequestSerializer *requestSerializer = self.sessionManager.requestSerializer;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:httpMethod URLString:request.url parameters:request.parameters error:&error];
    urlRequest.timeoutInterval = request.timeoutInterval;
    
//    if (request.cacheOption == kWFHTTPCacheOptionUseCache) {
//        urlRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
//    }else if(request.cacheOption == kWFHTTPCacheOptionIgnoringCache){
//        urlRequest.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    }
    
    if (error && handler) {
        dispatch_async(self.requestCompleteQueue, ^{
            handler(nil, error);
        });
        return 0;
    }
    
    //添加header
    if (request.headers.count > 0) {
        [request.headers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [urlRequest setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:urlRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSError *serializationError;
            responseObject = [self.afJSONResponseSerializer responseObjectForResponse:response data:responseObject error:&serializationError];
            if (handler) {
                if (serializationError) {
                    handler(nil, serializationError);
                }else{
                    handler(responseObject, error);
                }
            }
        }else{
            if (handler) {
                handler(responseObject, error);
            }
        }
        
    }];
    [task bindingRequest:request];
    request.identifier = task.taskIdentifier;
    [task resume];
    return request.identifier;
}


- (NSString *)getHTTPMethodWithRequest:(WFRequest *)request {
    NSArray * httpMethodArray = @[@"GET", @"POST", @"HEAD", @"PUT", @"DELETE", @"PATCH"];
    NSString *methodString = httpMethodArray[request.httpMethod];
    return methodString;
}

- (void)cancelRequest:(NSUInteger)requestID {
    if (requestID == 0) {
        return;
    }
    __block WFRequest *request;
    WFLock();
    [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (requestID == obj.taskIdentifier) {
            request = obj.bindedRequest;
            [obj cancel];
            *stop = YES;
        }
    }];
    WFUnlock();
}

- (dispatch_queue_t)requestCompleteQueue {
    //请求完线程
    static dispatch_queue_t request_completion_callback_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request_completion_callback_queue = dispatch_queue_create("com.wfnetworking.request.completion.callback.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return request_completion_callback_queue;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.completionQueue = self.requestCompleteQueue;
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    }
    return _sessionManager;
}

- (AFJSONRequestSerializer *)afJSONRequestSerializer {
    if (!_afJSONRequestSerializer) {
        _afJSONRequestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    return _afJSONRequestSerializer;
}
- (AFJSONResponseSerializer *)afJSONResponseSerializer {
    if (!_afJSONResponseSerializer) {
        _afJSONResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _afJSONResponseSerializer;
}
@end
