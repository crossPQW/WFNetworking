//
//  WFTestCase.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/16.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "WFTestCase.h"

@implementation WFTestCase

- (void)setUp {
    self.networkTimeout = 60;
}

- (void)tearDown {
    [super tearDown];
}

- (void)waitForExpectationsWithCommonTimeout {
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    [self waitForExpectationsWithTimeout:self.networkTimeout handler:handler];
}
@end
