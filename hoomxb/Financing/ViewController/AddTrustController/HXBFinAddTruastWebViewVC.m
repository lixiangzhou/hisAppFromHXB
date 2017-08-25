//
//  HXBFinAddTruastWebViewVC.m
//  hoomxb
//
//  Created by HXB on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddTruastWebViewVC.h"
#import "HXBFinPlanContract_ContractWebView.h"
@interface HXBFinAddTruastWebViewVC ()
@property (nonatomic,strong) HXBFinPlanContract_ContractWebView *contractWebVeiw;
@end



@implementation HXBFinAddTruastWebViewVC

- (void) setURL:(NSString *)URL {
    _URL = URL;
    [self.contractWebVeiw loadURL:URL];
    kWeakSelf
    baseNAV.getNetworkAgainBlock = ^{
        [weakSelf.contractWebVeiw loadURL:URL];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.isColourGradientNavigationBar = YES;
}


- (void)setUP {
    self.isTransparentNavigationBar = false;
    self.contractWebVeiw = [[HXBFinPlanContract_ContractWebView alloc]init];
    [self.view addSubview:self.contractWebVeiw];
    self.contractWebVeiw.frame = CGRectMake(0, 64, self.view.width, kScreenHeight - 64);
    [self.contractWebVeiw loadURL: self.URL];
    self.title = self.contractWebVeiw.title;
    
    [self.contractWebVeiw addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.contractWebVeiw) {
        self.title = self.contractWebVeiw.title;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self.contractWebVeiw removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
