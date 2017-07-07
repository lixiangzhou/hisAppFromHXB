//
//  HXBBindBankCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBindBankCardViewController.h"
#import "HXBCardholderInformationView.h"
@interface HXBBindBankCardViewController ()

@property (nonatomic, strong) HXBCardholderInformationView *cardholderInformationView;
@end

@implementation HXBBindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cardholderInformationView];
    
    [self setSubViewFrame];
}

- (void)setSubViewFrame
{
    [self.cardholderInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@kScrAdaptationH(80));
    }];
}


#pragma mark - 懒加载
- (HXBCardholderInformationView *)cardholderInformationView
{
    if (!_cardholderInformationView) {
        _cardholderInformationView = [[HXBCardholderInformationView alloc] init];
    }
    return _cardholderInformationView;
}

@end
