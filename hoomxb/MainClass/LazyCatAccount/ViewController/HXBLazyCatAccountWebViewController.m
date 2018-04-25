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
@property (nonatomic, strong) NSMutableDictionary* pageClassDic;
@end

@implementation HXBLazyCatAccountWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupJavascriptBridge];
}

/**
 注册结果页的类到属性：pageClassDic
 */
- (void)registerPageClass {
    self.pageClassDic = [NSMutableDictionary dictionary];
    
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
    NSDictionary *dic = data;
    NSString *action = [dic stringAtPath:@"action"];
    HXBLazyCatResponseModel *responseModel = [[HXBLazyCatResponseModel alloc] initWithAction:action];
    [responseModel yy_modelSetWithDictionary:data];
    
    Class pageClass = (Class)[self.pageClassDic objectAtPath:action];
    if(pageClass) {
        UIViewController<HXBLazyCatResponseDelegate> *vc = [[pageClass alloc] init];
        if([vc respondsToSelector:@selector(setResultPageProperty:)]) {
            [vc setResultPageProperty:responseModel];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
