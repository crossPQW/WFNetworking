//
//  WFUploadData.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/20.
//  Copyright © 2017年 黄少华. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFUploadData : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy, nullable) NSString *fileName;
@property (nonatomic, copy, nullable) NSString *mimeType;


@property (nonatomic, strong, nullable) NSData *fileData;
@property (nonatomic, strong, nullable) NSURL *fileURL;

+ (instancetype)dataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
+ (instancetype)dataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;

@end

NS_ASSUME_NONNULL_END
