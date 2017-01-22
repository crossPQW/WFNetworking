//
//  WFRequest.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/10.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "WFRequest.h"

@implementation WFRequest

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        //设置默认配置
        self.requestType = Normal;
        self.httpMethod = GET;
        self.timeoutInterval = 60;
        self.retryTime = 0;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    WFRequest *copy = [[[self class] alloc] init];
    return copy;
}

#pragma mark - private method
- (void)clearCallBack {
    _successBlock = nil;
    _failureBlock = nil;
    _progressBlock = nil;
    _finishBlock = nil;
}

- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL {
    WFUploadData *data = [WFUploadData dataWithName:name fileName:fileName mimeType:mimeType fileURL:fileURL];
    [self.uploadDatas addObject:data];
}

- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData {
    WFUploadData *data = [WFUploadData dataWithName:name fileName:fileName mimeType:mimeType fileData:fileData];
    [self.uploadDatas addObject:data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"request : host: %@ \n api: %@ \n url: %@ \n parameters: %@ \n httpmethod: %ld",self.host,self.api,self.url,self.parameters,(long)self.httpMethod];
}
#pragma mark - getter
- (NSMutableArray<WFUploadData *> *)uploadDatas {
    if (!_uploadDatas) {
        _uploadDatas = @[].mutableCopy;
    }
    return _uploadDatas;
}
@end
