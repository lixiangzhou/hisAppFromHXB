//
//  HXBLazyCatAccountWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatAccountWebViewController.h"

#import "HXBLazyCatResponseModel.h"
#import "HXBLazyCatRequestResultModel.h"
#import "WebViewJavascriptBridge.h"

@interface HXBLazyCatAccountWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) NSMutableDictionary* pageClassDic;
@property (nonatomic, strong) NSMutableArray *popViewControllers;

@property (nonatomic, copy) NSString* redirectUrl;
@end

@implementation HXBLazyCatAccountWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupJavascriptBridge];
    [self registerPageClass];
    [self findPopVC];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

-(void)leftBackBtnClick {
    if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [super leftBackBtnClick];
    }
}

- (void)setRequestModel:(HXBLazyCatRequestModel *)requestModel {
    _requestModel = requestModel;
    
    NSDictionary* dic = [requestModel.result.reqData toDictionary];
    self.redirectUrl = [dic stringAtPath:@"redirectUrl"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* url = request.URL.absoluteString;
    if([url containsString:@"objc://"]) {
        self.hiddenReturnButton = YES;
        return NO;
    }
    return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    
    if([webView.request.URL.absoluteString isEqualToString:self.redirectUrl]) {
        NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
        BOOL interactive = [readyState isEqualToString:@"interactive"];
        if (interactive) {
            [self.webView stringByEvaluatingJavaScriptFromString:HXB_LOAD_LISTEN];
        }
        else{
            self.hiddenReturnButton = YES;
        }
    }
}

- (void)findPopVC {
    _popViewControllers = [[NSMutableArray alloc] init];
    
    NSSet *subVC = [NSSet setWithObjects:NSClassFromString(@"HXBFin_Plan_Buy_ViewController"),NSClassFromString(@"HXBFin_Loan_Buy_ViewController"),NSClassFromString(@"HXBFin_creditorChange_buy_ViewController"),NSClassFromString(@"HxbMyTopUpViewController"),NSClassFromString(@"HxbWithdrawCardViewController"),NSClassFromString(@"HXBOpenDepositAccountViewController"),NSClassFromString(@"HXBBindBankCardViewController"), nil];
    
    NSInteger count = self.navigationController.viewControllers.count;
    for (int i = 0; i <  count- 1; i++) {
        if ([subVC containsObject:self.navigationController.viewControllers[i].class]) {
            [self.popViewControllers addObject:self.navigationController.viewControllers[i]];
        }
    }
    
    if(self.popViewControllers.count<=0 && count>1) {
        //如果找不到指定页面， 直接将前一个页面添加到列表
        [self.popViewControllers addObject:self.navigationController.viewControllers[count-2]];
    }
}

/**
 注册结果页的类到属性：pageClassDic
 */
- (void)registerPageClass {
    self.pageClassDic = [NSMutableDictionary dictionary];
    //存管开户
    self.pageClassDic[kEscrow] = NSClassFromString(@"HXBOpenDepositoryResultController");
    //提现
    self.pageClassDic[kWithdrawal] = NSClassFromString(@"HxbWithdrawResultViewController");
    //快捷充值
    self.pageClassDic[kQuickrecharge] = NSClassFromString(@"HXBRechargeCompletedViewController");
    //绑卡结果页
    self.pageClassDic[kBindcard] = NSClassFromString(@"HXBWithdrawCardResultViewController");
    //解绑卡结果页
    self.pageClassDic[kUnbindcard] = NSClassFromString(@"HXBUnBindCardResultViewController");
    //修改交易密码结果页
    self.pageClassDic[kPasswordedit] = NSClassFromString(@"HXBModifyTransactionPasswordResultViewController");
    //计划购买结果
    self.pageClassDic[kPlan] = NSClassFromString(@"HXBPlanBuyResultViewController");
    //散标购买结果
    self.pageClassDic[kLoan] = NSClassFromString(@"HXBLoanBuyResultViewController");
    //债转购买结果
    self.pageClassDic[kTransfer] = NSClassFromString(@"HXBCreditorBuyResultViewController");
    //债转转让结果
    self.pageClassDic[kTransfersale] = NSClassFromString(@"HXBAccountTransferBuyViewController");
    //账户激活结果
    self.pageClassDic[kAccountactive] = NSClassFromString(@"HXBUserMigrationResultViewController");
}

/**
 重写父类加载H5的方法
 */
- (void)loadWebPage {
    //由于wkwebview不支持POST方式， 所以此处采用JS直接POST表单的加载方式
//    NSDictionary* paramDic = @{@"serviceName":self.requestModel.result.serviceName, @"platformNo":self.requestModel.result.platformNo, @"userDevice":@"MOBILE", @"keySerial":self.requestModel.result.keySerial, @"sign":self.requestModel.result.sign, @"reqData":self.requestModel.result.reqData};
//    NSString* pageUrl = self.requestModel.url;
//    if(!pageUrl) {
//        pageUrl = self.pageUrl;
//    }
//    NSString* jsonString = [paramDic jsonString];
//    NSString * js = [NSString stringWithFormat:@"%@my_post(\"%@\", %@)",HXB_POST_JS,pageUrl,jsonString];
//    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable element, NSError * _Nullable error) {
//
//    }];
    
    NSString* serviceName = self.requestModel.result.serviceName;
    NSString* platformNo = self.requestModel.result.platformNo;
    NSString* userDevice = @"MOBILE";
    NSString* keySerial = self.requestModel.result.keySerial;
    NSString* sign = self.requestModel.result.sign;
    NSString* reqData = self.requestModel.result.reqData;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    NSString* pageUrl = self.requestModel.url;
    [urlRequest setURL:[NSURL URLWithString:pageUrl]];
    NSString* param = [NSString stringWithFormat:@"serviceName=%@&platformNo=%@&userDevice=%@&keySerial=%@&reqData=%@&sign=%@", serviceName, platformNo, userDevice, keySerial, [reqData URLEncoding], [sign URLEncoding] ];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self.webView loadRequest:urlRequest];
}

/**
 桥接H5回调
 */
- (void)setupJavascriptBridge {
    //恒丰异步回调成功
    kWeakSelf
    [self registJavascriptBridge:@"showResult" handler:^(id data, WVJBResponseCallback responseCallback) {
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
        [self.navigationController popToViewController:self.popViewControllers.firstObject animated:YES];
        if ([self.popViewControllers.firstObject respondsToSelector:@selector(updateNetWorkData)]) {
            [self.popViewControllers.firstObject updateNetWorkData];
        }
    }else if(pageClass) {
        UIViewController<HXBLazyCatResponseDelegate> *vc = [[pageClass alloc] init];
        if([vc respondsToSelector:@selector(setResultPageProperty:)]) {
            [vc setResultPageProperty:responseModel];
        }
        if ([vc respondsToSelector:@selector(setResultPageWithPopViewControllers:)]) {
            [vc setResultPageWithPopViewControllers:self.popViewControllers];
        }
        [self.navigationController pushViewController:vc animated:YES];
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
    NSSet *subVC = [NSSet setWithObjects:NSClassFromString(@"HXBFin_Plan_Buy_ViewController"),NSClassFromString(@"HXBFin_Loan_Buy_ViewController"),NSClassFromString(@"HXBFin_creditorChange_buy_ViewController"), nil];
    UIViewController *popVC = self.popViewControllers.firstObject;
    if ([subVC containsObject:popVC.class]) {
        return YES;
    }
    return NO;
}



@end
