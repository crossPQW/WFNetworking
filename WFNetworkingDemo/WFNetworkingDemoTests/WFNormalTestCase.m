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

#import "AFNetworking.h"
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
    XCTestExpectation *ex = [self expectationWithDescription:@"Post request"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.httpMethod = kWFHTTPMethodPOST;
        request.api = @"post";
        request.parameters = @{@"key": @"huangshaohua"};
    } success:^(id  _Nullable response) {
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        NSString *value = response[@"form"][@"key"];
        XCTAssertTrue([value isEqualToString:@"huangshaohua"]);
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        NSString *value = response[@"form"][@"key"];
        XCTAssertTrue([value isEqualToString:@"huangshaohua"]);
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testHEAD {
    XCTestExpectation *ex = [self expectationWithDescription:@"Head request"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"get";
        request.httpMethod = kWFHTTPMethodHEAD;
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertNil(error);
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPUT {
    XCTestExpectation *ex = [self expectationWithDescription:@"PUT request"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"put";
        request.httpMethod = kWFHTTPMethodPUT;
        request.parameters = @{@"key":@"huangshaohua"};
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertTrue([response[@"form"][@"key"] isEqualToString:@"huangshaohua"]);
        XCTAssertNil(error);
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testDELETE {
    XCTestExpectation *expectation = [self expectationWithDescription:@"DELETE request"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"delete";
        request.httpMethod = kWFHTTPMethodDELETE;
        request.parameters = @{@"key":@"huangshaohua"};
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertTrue([response[@"args"][@"key"] isEqualToString:@"huangshaohua"]);
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPATCH {
    XCTestExpectation *expectation = [self expectationWithDescription:@"PATCH request"];
    [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"patch";
        request.httpMethod = kWFHTTPMethodPATCH;
        request.parameters = @{@"key": @"huangshaohua"};
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertTrue([response[@"form"][@"key"] isEqualToString:@"huangshaohua"]);
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithCommonTimeout];
}

- (void)testCancelRequest {
    XCTestExpectation *ex = [self expectationWithDescription:@"test cancel request"];
    NSUInteger ID = [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
        request.url = @"https://kangzubin.cn/test/timeout.php";
        request.httpMethod = kWFHTTPMethodGET;
    } success:^(id  _Nullable response) {
        XCTAssertNil(response);
    } failure:^(NSError * _Nullable error) {
        XCTAssertTrue(error.code == NSURLErrorCancelled);
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertNil(response);
        XCTAssertTrue(error.code == NSURLErrorCancelled);
        [ex fulfill];
    }];
    
    sleep(5);
    [WFNetworkManager cancelRquest:ID];
    
    [self waitForExpectationsWithCommonTimeout];
}

@end
