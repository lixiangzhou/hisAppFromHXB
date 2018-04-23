//
//  HXBLazyCatAccountWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatAccountWebViewController.h"
#import "HXBLazyCatRequestModel.h"
#import "HXBLazyCatResponseModel.h"

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
    //由于wkwebview不支持POST方式， 所以此处采用JS直接POST表单的加载方式
    NSDictionary* paramDic = @{@"serviceName":self.requestModel.serviceName, @"platformNo":self.requestModel.platformNo, @"userDevice":@"MOBILE", @"keySerial":self.requestModel.keySerial, @"sign":self.requestModel.sign, @"reqData":self.requestModel.reqData};
    NSString* pageUrl = self.requestModel.url;
    if(!pageUrl) {
        pageUrl = self.pageUrl;
    }
    NSString* jsonString = [paramDic jsonString];
    NSString * js = [NSString stringWithFormat:@"%@my_post(\"%@\", %@)",HXB_POST_JS,pageUrl,jsonString];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable element, NSError * _Nullable error) {
        
    }];
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
    HXBLazyCatResponseModel* response = [[HXBLazyCatResponseModel alloc] init];
    [response yy_modelSetWithDictionary:data];
    
    //根据具体的动作分发结果页, 将response做为结果页的参数
}




@end
