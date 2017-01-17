//
//  WFNormalTestCase.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/16.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WFTestCase.h"
#import "WFNetworking.h"

@interface WFNormalTestCase : WFTestCase

@end

@implementation WFNormalTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testGet {
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET request"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.api = @"get";
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(response);
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testGetWithParameters {
    XCTestExpectation *ex = [self expectationWithDescription:@"Get request with perameter"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.api = @"get";
        request.parameters = @{@"key": @"huangshaohua"};
    } success:^(id  _Nullable response) {
        XCTAssertNotNil(response);
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        NSString *value = response[@"args"][@"key"];
        XCTAssertTrue([value isEqualToString:@"huangshaohua"]);
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(response);
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        NSString *value = response[@"args"][@"key"];
        XCTAssertTrue([value isEqualToString:@"huangshaohua"]);
        XCTAssertNil(error);
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPost {
    
}

@end
