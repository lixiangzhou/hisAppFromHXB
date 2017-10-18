//
//  HXBFinPlanContract_contraceWebViewVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
    self.title = @"";
    [self setUP];
    self.isColourGradientNavigationBar = YES;
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self.contractWebVeiw loadURL:self.URL];
}

- (void)setUP {
    self.contractWebVeiw = [[HXBFinPlanContract_ContractWebView alloc]init];
    [self.view addSubview:self.contractWebVeiw];
    self.contractWebVeiw.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    [self.contractWebVeiw loadURL: self.URL];
    [self.contractWebVeiw addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.contractWebVeiw) {
            self.title = [HXBMiddlekey H5Title:self.contractWebVeiw.title];
        }else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc
{
    [self.contractWebVeiw removeObserver:self forKeyPath:@"title"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
