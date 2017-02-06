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

    [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
        request.api = @"get";
    } success:^(id  _Nullable response) {
        XCTAssertNotNil(response);
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        [expectation fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testGetWithParameters {
    XCTestExpectation *ex = [self expectationWithDescription:@"Get request with perameter"];
    
    [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.api = @"get";
        request.parameters = @{@"key": @"test"};
    } success:^(id  _Nullable response) {
        XCTAssertNotNil(response);
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        NSString *value = response[@"args"][@"key"];
        XCTAssertTrue([value isEqualToString:@"test"]);
        [ex fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPost {
    XCTestExpectation *ex = [self expectationWithDescription:@"Post request"];
    [WFNetworkManager postRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.api = @"post";
        request.parameters = @{@"key": @"test"};
    } success:^(id  _Nullable response) {
        XCTAssertTrue([response isKindOfClass:[NSDictionary class]]);
        NSString *value = response[@"form"][@"key"];
        XCTAssertTrue([value isEqualToString:@"test"]);
        [ex fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testHEAD {
    XCTestExpectation *ex = [self expectationWithDescription:@"Head request"];
    [WFNetworkManager headRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"get";
    } success:^(id  _Nullable response) {
        [ex fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPUT {
    XCTestExpectation *ex = [self expectationWithDescription:@"PUT request"];
    [WFNetworkManager putRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"put";
        request.parameters = @{@"key":@"test"};
    } success:^(id  _Nullable response) {
        XCTAssertTrue([response[@"form"][@"key"] isEqualToString:@"test"]);
        [ex fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testDELETE {
    XCTestExpectation *expectation = [self expectationWithDescription:@"DELETE request"];
    
    [WFNetworkManager deleteRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"delete";
        request.parameters = @{@"key":@"test"};
    } success:^(id  _Nullable response) {
        XCTAssertTrue([response[@"args"][@"key"] isEqualToString:@"test"]);
        [expectation fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPATCH {
    XCTestExpectation *expectation = [self expectationWithDescription:@"PATCH request"];
    [WFNetworkManager patchRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org";
        request.api = @"patch";
        request.parameters = @{@"key": @"test"};
    } success:^(id  _Nullable response) {
        XCTAssertTrue([response[@"form"][@"key"] isEqualToString:@"test"]);
        [expectation fulfill];
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithCommonTimeout];
}

- (void)testCancelRequest {
    XCTestExpectation *ex = [self expectationWithDescription:@"test cancel request"];
    WFRequest *request = [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
        request.url = @"https://kangzubin.cn/test/timeout.php";
    } success:^(id  _Nullable response) {
        XCTAssertNil(response);
    } failure:^(NSError * _Nullable error) {
        XCTAssertTrue(error.code == NSURLErrorCancelled);
        [ex fulfill];
    }];
    
    sleep(5);
    [WFNetworkManager cancelRquest:request];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testCancelAllRequest {
    XCTestExpectation *ex = [self expectationWithDescription:@"test cancel all request"];
    [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
        request.url = @"https://kangzubin.cn/test/timeout.php";
    } success:^(id  _Nullable response) {
        XCTAssertNil(response);
    } failure:^(NSError * _Nullable error) {
        XCTAssertTrue(error.code == NSURLErrorCancelled);
        [ex fulfill];
    }];
    
    sleep(5);
    [WFNetworkManager cancelAllRequest];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testDownloadRequest {
    XCTestExpectation *ex = [self expectationWithDescription:@"test download request"];
    [WFNetworkManager downloadRequest:^(WFRequest * _Nonnull request) {
        request.url = @"http://cimg2.163.com/catchpic/1/1A/1AE6BA37579B21A3D3C40BB58643952C.jpg";
        request.downloadCachePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/test3.png"];
    } progress:^(NSProgress * _Nonnull progress) {
        NSLog(@"*********progress = %lld,%lld,%f",progress.totalUnitCount,progress.completedUnitCount,progress.fractionCompleted);
        if (progress.fractionCompleted == 1) {
        }
    } success:^(id  _Nullable response) {
        NSLog(@"success block response == %@",response);
        XCTAssertNotNil(response);
        XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:((NSURL *)response).path]);
    } failure:^(NSError * _Nullable error) {
        NSLog(@"error block == %@",error);
        XCTAssertNil(error);
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:((NSURL *)response).path]);
        XCTAssertNil(error);
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testUploadRequest {
    XCTestExpectation *ex = [self expectationWithDescription:@"test upload request"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"5784519b580b4" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
    
    [WFNetworkManager uploadRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.api = @"post";
        [request addFormDataWithName:@"image" fileName:@"5784519b580b4.jpg" mimeType:@"image/jpeg" fileData:fileData];
    } progress:^(NSProgress * _Nonnull progress) {
        NSLog(@"*********progress = %lld,%lld,%f",progress.totalUnitCount,progress.completedUnitCount,progress.fractionCompleted);
        if (progress.fractionCompleted == 1) {
            
        }
    } success:^(id  _Nullable response) {
        XCTAssertNotNil(response);
        XCTAssertNotNil(response[@"files"][@"image"]);
    } failure:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(response[@"files"][@"image"]);
        XCTAssertNotNil(response);
        XCTAssertNil(error);
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testCancelDownloadRequest {
    XCTestExpectation *ex = [self expectationWithDescription:@"test cancel download request"];
    WFRequest *request = [WFNetworkManager downloadRequest:^(WFRequest * _Nonnull request) {
        request.url = @"http://cimg2.163.com/catchpic/1/1A/1AE6BA37579B21A3D3C40BB58643952C.jpg";
        request.downloadCachePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/test2.png"];
    } progress:^(NSProgress * _Nonnull progress) {
        NSLog(@"*********progress = %lld,%lld,%f",progress.totalUnitCount,progress.completedUnitCount,progress.fractionCompleted);
        if (progress.fractionCompleted == 1) {
            
        }
    } success:^(id  _Nullable response) {
        XCTAssertNil(response);
    } failure:^(NSError * _Nullable error) {
        XCTAssertTrue(error.code == NSURLErrorCancelled);
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        XCTAssertNil(response);
        XCTAssertTrue(error.code == NSURLErrorCancelled);
        [ex fulfill];
    }];
    
    [WFNetworkManager cancelRquest:request];
    
    [self waitForExpectationsWithCommonTimeout];
}
@end
