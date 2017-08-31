//
//  HXBFinPlanContract_contraceWebViewVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinContract_contraceWebViewVC_Loan.h"
#import "HXBFinPlanContract_ContractWebView.h"
@interface HXBFinContract_contraceWebViewVC_Loan ()
@property (nonatomic,strong) HXBFinPlanContract_ContractWebView *contractWebVeiw;
@end

@implementation HXBFinContract_contraceWebViewVC_Loan

- (void) setURL:(NSString *)URL {
    _URL = URL;
    [self.contractWebVeiw loadURL:URL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.isColourGradientNavigationBar = YES;
    if (!self.title.length) {
        self.title = @"借款合同";
    }
}


- (void)setUP {
    self.contractWebVeiw = [[HXBFinPlanContract_ContractWebView alloc]init];
    [self.view addSubview:self.contractWebVeiw];
    self.contractWebVeiw.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    [self.contractWebVeiw loadURL: self.URL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
