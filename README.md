
## WFNetworking

WFNetworking is a lightweight network library base on AFNetworking

## 安装 

`pod 'WFNetWorking', '~> 1.0.1'`

## 使用
你可以在项目初始化的时候设置网络请求通用配置：
设置了通用请求后，如果在后续的请求中没有设置 host、请求头、参数、超时时间，那么会自动使用通用配置。
```
[WFNetworkManager setupConfig:^(WFNetworkConfig * _Nonnull config) {
        config.generalHost = @"https://httpbin.org/";
        config.generalHeaders = @{@"key" : @"value"};
        config.generalParameters = @{@"key" : @"value"};
        config.generalTimeout = 30;
    }];
```
发起`GET`请求
```
    [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
      //config your request
        request.api = @"get";
    } success:^(id  _Nullable response) {

    } failure:^(NSError * _Nullable error) {

    }];

```
发起`POST`请求
```
    [WFNetworkManager postRequest:^(WFRequest * _Nonnull request) {
        request.host = @"https://httpbin.org/";
        request.api = @"post";
        request.parameters = @{@"key": @"test"};
    } success:^(id  _Nullable response) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
```
其他`HEAD、PUT、DELETE、PATCH`请求示例参见项目中`WFNetworkingDemoTests/WFNormalTestCase`。

发起`Dodnload`请求：
```
[WFNetworkManager downloadRequest:^(WFRequest * _Nonnull request) {
        request.url = @"http://cimg2.163.com/catchpic/1/1A/1AE6BA37579B21A3D3C40BB58643952C.jpg";
        request.downloadCachePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/test3.png"];
    } progress:^(NSProgress * _Nonnull progress) {
        NSLog(@"*********progress = %lld,%lld,%f",progress.totalUnitCount,progress.completedUnitCount,progress.fractionCompleted);
        if (progress.fractionCompleted == 1) {
        }
    } success:^(id  _Nullable response) {
        NSLog(@"success block response == %@",response);
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"error block == %@",error);
        
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        
        
    }];
```
发起`Upload`请求
```
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
        
    } failure:^(NSError * _Nullable error) {
        
    } finish:^(id  _Nullable response, NSError * _Nullable error) {
        
    }];

```

如何取消一个网络请求：
```
WFRequest *request = [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
        request.url = @"https://kangzubin.cn/test/timeout.php";
    } success:^(id  _Nullable response) {
        
    } failure:^(NSError * _Nullable error) {

    }];
    
    sleep(5);
    [WFNetworkManager cancelRquest:request];
```

