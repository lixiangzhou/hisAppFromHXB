//
//  HXBTransferCreditorViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/9/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransferCreditorViewController.h"
#import "HXBTransferCreditorTopView.h"
#import "HXBTransferCreditorBottomView.h"

@interface HXBTransferCreditorViewController ()

@property (nonatomic, strong) HXBTransferCreditorTopView *topView;

@property (nonatomic, strong) HXBTransferCreditorBottomView *bottomView;

@property (nonatomic, strong) HXBFinBaseNegotiateView *agreementView;

@end

@implementation HXBTransferCreditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认转让债权";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.isReadColorWithNavigationBar = YES;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.agreementView];
    [self setupFrame];
}

- (void)setupFrame
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.right.left.equalTo(self.view);
        make.height.offset(kScrAdaptationH750(270));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.right.left.equalTo(self.view);
        make.height.offset(kScrAdaptationH750(262));
    }];
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom).offset(kScrAdaptationH750(21));
        make.left.equalTo(self.view).offset(kScrAdaptationH750(40));
    }];
}



#pragma mark - getter(懒加载)

- (HXBFinBaseNegotiateView *)agreementView
{
    if (!_agreementView) {
        _agreementView = [[HXBFinBaseNegotiateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(200))];
        _agreementView.negotiateStr = @"债权转让及受让协议";
        [_agreementView clickNegotiateWithBlock:^{
            
        }];
        [_agreementView clickCheckMarkWithBlock:^(BOOL isSelected) {
            
        }];
    }
    return _agreementView;
}

- (HXBTransferCreditorTopView *)topView
{
    if (!_topView) {
        _topView = [[HXBTransferCreditorTopView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (HXBTransferCreditorBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HXBTransferCreditorBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
