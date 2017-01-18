//
//  ViewController.m
//  WFNetworkingDemo
//
//  Created by 黄少华 on 2017/1/11.
//  Copyright © 2017年 黄少华. All rights reserved.
//

#import "ViewController.h"
#import "WFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    WFRequest *request = [WFNetworkManager sendRequest:^(WFRequest * _Nonnull request) {
//        request.url = @"https://kangzubin.cn/test/timeout.php";
//        request.httpMethod = kWFHTTPMethodGET;
//    } success:^(id  _Nullable response) {
//        
//    } failure:^(NSError * _Nullable error) {
//        NSLog(@"error %ld",error.code);
//    } finish:^(id  _Nullable response, NSError * _Nullable error) {
//        
//    }];
//    
//    sleep(3);
//    [WFNetworkManager cancelRquest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
