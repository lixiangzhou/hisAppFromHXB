//
//  HXBSignUPAgreementWebViewVC.m
//  hoomxb
//
//  Created by HXB on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAgreementWebViewVC.h"
#import "HXBFinPlanContract_ContractWebView.h"
@interface HXBSignUPAgreementWebViewVC ()
@property (nonatomic,strong) HXBFinPlanContract_ContractWebView *contractWebVeiw;
@end

@implementation HXBSignUPAgreementWebViewVC

- (void) setURL:(NSString *)URL {
    _URL = URL;
    [self.contractWebVeiw loadURL:URL];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.title = @"注册服务协议";
    self.isColourGradientNavigationBar = YES;
    
}


- (void)setUP {
    self.contractWebVeiw = [[HXBFinPlanContract_ContractWebView alloc]init];
    self.contractWebVeiw.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.view addSubview:self.contractWebVeiw];
    self.contractWebVeiw.frame = CGRectMake(0, 64, self.view.width, kScreenHeight - 64);
    [self.contractWebVeiw loadURL: self.URL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
