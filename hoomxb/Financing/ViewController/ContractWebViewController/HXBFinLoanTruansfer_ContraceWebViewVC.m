//
//  HXBFinLoanTruansfer_ContraceWebViewVC.m
//  hoomxb
//
//  Created by HXB on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinLoanTruansfer_ContraceWebViewVC.h"
#import "HXBFinPlanContract_ContractWebView.h"
@interface HXBFinLoanTruansfer_ContraceWebViewVC ()
@property (nonatomic,strong) HXBFinPlanContract_ContractWebView *contractWebVeiw;
@end

@implementation HXBFinLoanTruansfer_ContraceWebViewVC

- (void) setURL:(NSString *)URL {
    _URL = URL;
    [self.contractWebVeiw loadURL:URL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.title = @"借款协议";
}


- (void)setUP {
    self.contractWebVeiw = [[HXBFinPlanContract_ContractWebView alloc]init];
    [self.view addSubview:self.contractWebVeiw];
    self.contractWebVeiw.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
    [self.contractWebVeiw loadURL: self.URL];
}

@end
