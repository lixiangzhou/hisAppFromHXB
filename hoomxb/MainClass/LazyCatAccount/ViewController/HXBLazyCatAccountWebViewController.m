//
//  HXBLazyCatAccountWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatAccountWebViewController.h"
#import "HXBLazyCatRequestModel.h"
@interface HXBLazyCatAccountWebViewController ()

@end

@implementation HXBLazyCatAccountWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupJavascriptBridge];
}

/**
 重写父类加载H5的方法
 */
- (void)loadWebPage {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    if (self.requestModel.url) {
        [urlRequest setURL:[NSURL URLWithString:self.requestModel.url]];
    } else {
        [urlRequest setURL:[NSURL URLWithString:self.pageUrl]];
    }
    urlRequest = [self processingEmptyDataWithURLRequest:urlRequest];
    
    [self.webView loadRequest:urlRequest];
}

- (NSMutableURLRequest *)processingEmptyDataWithURLRequest:(NSMutableURLRequest *)urlRequest{
    if (self.requestModel.serviceName) {
        [urlRequest setValue:self.requestModel.serviceName forHTTPHeaderField:@"serviceName"];
    }
    if (self.requestModel.platformNo) {
        [urlRequest setValue:self.requestModel.platformNo forHTTPHeaderField:@"platformNo"];
    }
    if (self.requestModel.keySerial) {
        [urlRequest setValue:self.requestModel.keySerial forHTTPHeaderField:@"keySerial"];
    }
    if (self.requestModel.reqData) {
        [urlRequest setValue:self.requestModel.reqData forHTTPHeaderField:@"reqData"];
    }
    if (self.requestModel.sign) {
        [urlRequest setValue:self.requestModel.sign forHTTPHeaderField:@"sign"];
    }
    return urlRequest;
}


/**
 桥接H5回调
 */
- (void)setupJavascriptBridge {
    //恒丰异步回调成功
    kWeakSelf
    [self registJavascriptBridge:@"" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        //根据数据跳转到响应的结果页面
        [weakSelf jumpToResultPageWithData:data];
    }];
}
//根据数据跳转到响应的结果页面
- (void)jumpToResultPageWithData:(id)data {
   
}




@end
