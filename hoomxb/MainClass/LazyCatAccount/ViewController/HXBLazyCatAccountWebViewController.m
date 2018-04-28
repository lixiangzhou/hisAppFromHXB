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
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
    [self setupJavascriptBridge];
    [self registerPageClass];
}

/**
 注册结果页的类到属性：pageClassDic
 */
- (void)registerPageClass {
    self.pageClassDic = [NSMutableDictionary dictionary];
    self.pageClassDic[@"quickpay"] = NSClassFromString(@"");
    self.pageClassDic[@"withdraw"] = NSClassFromString(@"");
    //绑卡结果页
    self.pageClassDic[@"bindcard"] = NSClassFromString(@"HXBWithdrawCardResultViewController");
    //解绑卡结果页
    self.pageClassDic[@"unbindcard"] = NSClassFromString(@"HXBUnBindCardResultViewController");
    //修改交易密码结果页
    self.pageClassDic[@"passwordedit"] = NSClassFromString(@"HXBModifyTransactionPasswordResultViewController");
    //计划购买结果
    self.pageClassDic[@"plan"] = NSClassFromString(@"HXBPlanBuyResultViewController");
    //散标购买结果
    self.pageClassDic[@"loan"] = NSClassFromString(@"HXBLoanBuyResultViewController");
    //债转购买结果
    self.pageClassDic[@"transfer"] = NSClassFromString(@"HXBCreditorBuyResultViewController");
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
    
    if ([self jumpToResultLogicalProcessingWithResponseModel:responseModel]) {
        [self.navigationController popToViewController:self.popVC animated:YES];
        if ([self.popVC respondsToSelector:@selector(updateNetWorkData)]) {
            [self.popVC updateNetWorkData];
        }
    }else if(pageClass) {
        UIViewController<HXBLazyCatResponseDelegate> *vc = [[pageClass alloc] init];
        if([vc respondsToSelector:@selector(setResultPageProperty:)]) {
            [vc setResultPageProperty:responseModel];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (BOOL)jumpToResultLogicalProcessingWithResponseModel:(HXBLazyCatResponseModel *)responseModel{
    if ([self findBuyVC] && !([responseModel.action isEqualToString:@"plan"] || [responseModel.action isEqualToString:@"loan"] ||[responseModel.action isEqualToString:@"transfer"]) && [responseModel.result isEqualToString:@"success"]) {
        
        return YES;
    }
    return NO;
}

/**
 查找self.navigationController.viewControllers中是否包含购买控制器

 @return 是否存在
 */
- (BOOL)findBuyVC {
    for (int i = 0; i< self.navigationController.viewControllers.count - 1; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HXBFin_Plan_Buy_ViewController")]
            || [self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HXBFin_Loan_Buy_ViewController")]
            ||[self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HXBFin_creditorChange_buy_ViewController")]) {
            self.popVC = self.navigationController.viewControllers[i];
            return YES;
        }
    }
    return NO;
}



@end
