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

@interface WFNetWorkAgent(){
    pthread_mutex_t _lock;
}

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) AFJSONRequestSerializer *afJSONRequestSerializer;
@property (nonatomic, strong) AFJSONResponseSerializer *afJSONResponseSerializer;

@property (nonatomic, strong) dispatch_queue_t requestCompleteQueue;

@property (nonatomic, strong) NSMutableDictionary <NSNumber *,WFRequest *>*requestCache;
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
        _requestCache = @{}.mutableCopy;
    }
    return self;
}

- (void)dealloc {
    if (_sessionManager) {
        [_sessionManager invalidateSessionCancelingTasks:YES];
    }
}

- (NSUInteger)sendRequest:(WFRequest *)request complete:(WFCompletedHandler)handler {
    if (request.requestType == kWFRequestTypeNormal) {
        return [self dataTaskWithRequest:request complete:handler];
    }else if (request.requestType == kWFRequestTypeDownload) {
        return [self downloadWithRequest:request complete:handler];
    }else if (request.requestType == kWFRequestTypeUpload){
        return [self uploadWithRequest:request complete:handler];
    }else{
        NSAssert(NO, @"request type should not be exist");
        return 0;
    }
}

- (NSUInteger)dataTaskWithRequest:(WFRequest *)request complete:(WFCompletedHandler)handler {
    
    NSError *error;
    NSString *httpMethod = [self getHTTPMethodWithRequest:request];
    
    
    NSMutableURLRequest *urlRequest = [self.sessionManager.requestSerializer requestWithMethod:httpMethod URLString:request.url parameters:request.parameters error:&error];
    urlRequest.timeoutInterval = request.timeoutInterval;
    
    if (error && handler) {
        dispatch_async(self.requestCompleteQueue, ^{
            handler(nil, error);
        });
        return 0;
    }
    
    [self addHeaderForUrlRequest:urlRequest withRequest:request];
    
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
    [self bindingRequest:request forTask:task];
    return request.identifier;
}

- (NSUInteger)downloadWithRequest:(WFRequest *)request complete:(WFCompletedHandler)handler {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.url] cachePolicy:0 timeoutInterval:request.timeoutInterval];
    [self addHeaderForUrlRequest:urlRequest withRequest:request];
    
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:request.downloadCachePath isDirectory:&isDirectory]) {
        isDirectory = NO;
    }
    
    NSURL *downloadCachePathURL;
    if (isDirectory) {
        NSString *fileName = [urlRequest.URL lastPathComponent];
        downloadCachePathURL = [NSURL fileURLWithPath:[NSString pathWithComponents:@[request.downloadCachePath, fileName]] isDirectory:NO];
    }else{
        downloadCachePathURL = [NSURL fileURLWithPath:request.downloadCachePath isDirectory:NO];
    }
    
    NSURLSessionDownloadTask *downloadTask = [self.sessionManager downloadTaskWithRequest:urlRequest progress:request.progressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return downloadCachePathURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (handler) {
            handler(filePath, error);
        }
    }];
    [self bindingRequest:request forTask:downloadTask];
    return request.identifier;
}

- (NSUInteger)uploadWithRequest:(WFRequest *)request complete:(WFCompletedHandler)handler {
    
    __block NSError *serializationError;
    NSMutableURLRequest *urlRequest = [self.sessionManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:request.url parameters:request.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [request.uploadDatas enumerateObjectsUsingBlock:^(WFUploadData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //upload Data
            if (obj.fileData) {
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileData:obj.fileData name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
                }else{
                    [formData appendPartWithFormData:obj.fileData name:obj.name];
                }
            }else if (obj.fileURL){//upload by URL
                NSError *error;
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileURL:obj.fileURL name:obj.name fileName:obj.fileName mimeType:obj.mimeType error:&error];
                }else{
                    [formData appendPartWithFileURL:obj.fileURL name:obj.name error:&error];
                }
                if (error) {
                    serializationError = error;
                    *stop = YES;
                }
            }
        }];
    } error:&serializationError];
    
    if (serializationError && handler) {
        dispatch_async(self.requestCompleteQueue, ^{
            handler(nil, serializationError);
        });
        return 0;
    }
    
    urlRequest.timeoutInterval = request.timeoutInterval;
    [self addHeaderForUrlRequest:urlRequest withRequest:request];
    NSURLSessionUploadTask *uploadTask = [self.sessionManager uploadTaskWithStreamedRequest:urlRequest progress:request.progressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
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
    [self bindingRequest:request forTask:uploadTask];
    return 0;
}

- (void)bindingRequest:(WFRequest *)request forTask:(NSURLSessionTask *)task {
    request.identifier = task.taskIdentifier;
    [self cacheRequest:request];
    [task resume];
}

- (void)addHeaderForUrlRequest:(NSMutableURLRequest *)urlRequest withRequest:(WFRequest *)request {
    //添加header
    if (request.headers.count > 0) {
        [request.headers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [urlRequest setValue:obj forHTTPHeaderField:key];
        }];
    }
}

- (void)cacheRequest:(WFRequest *)request {
    WFLock();
    self.requestCache[@(request.identifier)] = request;
    WFUnlock();
}

- (void)removeRequestFromCache:(WFRequest *)request {
    WFLock();
    [self.requestCache removeObjectForKey:@(request.identifier)];
    WFUnlock();
}

- (WFRequest *)getRequestFromCacheWithID:(NSUInteger)identifier {
    WFLock();
    WFRequest *request = self.requestCache[@(identifier)];
    WFUnlock();
    return request;
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
    WFRequest *request = [self getRequestFromCacheWithID:requestID];
    WFLock();
    [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (request.identifier == obj.taskIdentifier) {
            [obj cancel];
            *stop = YES;
        }
    }];
    WFUnlock();
    [self removeRequestFromCache:request];
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
        _afJSONRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
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
