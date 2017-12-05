
##WFNetworking

WFNetworking is a lightweight network library base on AFNetworking

##安装 

`pod 'WFNetWorking', '~> 1.0.1'`

##使用
```
    [WFNetworkManager getRequest:^(WFRequest * _Nonnull request) {
      //config your request
        request.api = @"get";
    } success:^(id  _Nullable response) {

    } failure:^(NSError * _Nullable error) {

    }];

```

