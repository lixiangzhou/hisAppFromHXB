//
//  HXBLazyCatAccountWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatAccountWebViewController.h"

#import "HXBLazyCatResponseModel.h"

@interface HXBLazyCatAccountWebViewController ()
@property (nonatomic, strong) NSMutableDictionary* pageClassDic;
@property (nonatomic, strong) UIViewController<HXBRemoteUpdateInterface> *popVC;
@end

@implementation HXBLazyCatAccountWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupJavascriptBridge];
    [self registerPageClass];
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
    
    if ([self jumpToResultLogicalProcessingWithAction:action] && [responseModel.result isEqualToString:@"success"]) {
        [self.navigationController popToViewController:self.popVC animated:YES];
        [self.popVC updateNetWorkData];
    }else if(pageClass) {
        UIViewController<HXBLazyCatResponseDelegate> *vc = [[pageClass alloc] init];
        if([vc respondsToSelector:@selector(setResultPageProperty:)]) {
            [vc setResultPageProperty:responseModel];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (BOOL)jumpToResultLogicalProcessingWithAction:(NSString *)action {
    
    if ([self findBuyVCWithViewControllerName:@"HXBFin_Plan_Buy_ViewController"]
        || [self findBuyVCWithViewControllerName:@"HXBFin_Loan_Buy_ViewController"]
        || [self findBuyVCWithViewControllerName:@"HXBFin_creditorChange_buy_ViewController"]) {
        
        if (!([action isEqualToString:@"plan"] || [action isEqualToString:@"loan"] ||[action isEqualToString:@"plan"])) {
            return YES;
        }
    }
    return NO;
}

/**
 查找self.navigationController.viewControllers中是否包含某个控制器

 @param vcName 需要查找的控制器的名称
 @return 是否存在
 */
- (BOOL)findBuyVCWithViewControllerName:(NSString *)vcName {
    for (int i = 0; i< self.navigationController.viewControllers.count - 1; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(vcName)]) {
            self.popVC = self.navigationController.viewControllers[i];
            return YES;
        }
    }
    return NO;
}



@end
