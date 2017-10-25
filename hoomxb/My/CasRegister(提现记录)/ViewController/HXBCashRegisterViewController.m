//
//  HXBCashRegisterViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCashRegisterViewController.h"
#import "HXBCasRegisterViewModel.h"
@interface HXBCashRegisterViewController ()

@end

@implementation HXBCashRegisterViewController
#pragma mark – Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCashRegisterData];
}
#pragma mark - Events

#pragma mark – Private Methods
- (void)loadCashRegisterData {
    [HXBCasRegisterViewModel checkCardBinResultRequestWithSmscode:@"" andSuccessBlock:^{
        
    } andFailureBlock:^(NSError *error) {
        
    }];
}
#pragma mark - UITextFieldDelegate

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - Custom Delegates

#pragma mark – Getters and Setters


@end
