//
//  WFUploadData.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/20.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "WFUploadData.h"

@implementation WFUploadData


+ (instancetype)dataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData {
    WFUploadData *data = [[WFUploadData alloc] init];
    data.name = name;
    data.fileName = fileName;
    data.mimeType = mimeType;
    data.fileData = fileData;
    return data;
}

+ (instancetype)dataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL {
    WFUploadData *data = [[WFUploadData alloc] init];
    data.name = name;
    data.fileName = fileName;
    data.mimeType = mimeType;
    data.fileURL = fileURL;
    return data;
}
@end
