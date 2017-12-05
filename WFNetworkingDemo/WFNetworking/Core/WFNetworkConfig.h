//
//  WFNetworkConfig.h
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/3/13.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFNetworkConfig : NSObject

/**
 The general server address
 */
@property (nonatomic, copy, nullable) NSString *generalHost;

/**
 The general parameters
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *generalParameters;

/**
 The general headers
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> *generalHeaders;


/**
 超时时间
 */
@property (nonatomic, assign) NSTimeInterval generalTimeout;

@end
