//
//  HXBTransferCreditorViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/9/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransferCreditorViewController.h"
#import "HXBTransferCreditorTopView.h"
#import "HXBTransferCreditorBottomView.h"
#import "HXBMYRequest.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBFBase_BuyResult_VC.h"
#import "HXBMY_LoanListViewController.h"
#import "HXBTransferConfirmModel.h"
#import "HXBTransactionPasswordView.h"
@interface HXBTransferCreditorViewController ()

@property (nonatomic, strong) HXBTransferCreditorTopView *topView;

@property (nonatomic, strong) HXBTransferCreditorBottomView *bottomView;

@property (nonatomic, strong) HXBFinBaseNegotiateView *agreementView;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, weak) HXBTransactionPasswordView *passwordView;

@property (nonatomic, strong) HXBTransferConfirmModel *transferConfirmModel;

@end

@implementation HXBTransferCreditorViewController



#pragma mark - life生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认转让债权";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.isRedColorWithNavigationBar = YES;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.agreementView];
    [self.view addSubview:self.sureBtn];
    [self setupFrame];
}

- (void)setupFrame
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(HxbNavigationBarY);
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
        make.left.equalTo(self.view);
        make.height.offset(kScrAdaptationH750(26));
        make.right.equalTo(self.view);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.view).offset(kScrAdaptationW750(-40));
        make.height.offset(kScrAdaptationH750(82));
        make.top.equalTo(self.bottomView.mas_bottom).offset(kScrAdaptationH750(147));
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    kWeakSelf
    HXBMYRequest *transferRequest = [[HXBMYRequest alloc] init];
    [transferRequest transferRequest_AccountRequestTransferID:self.creditorID SuccessBlock:^(HXBTransferConfirmModel *transferConfirmModel) {
        weakSelf.topView.transferConfirmModel = transferConfirmModel;
        weakSelf.bottomView.transferConfirmModel = transferConfirmModel;
        weakSelf.transferConfirmModel = transferConfirmModel;
    } andFailureBlock:^(NSError *error) {
        
    }];
}


#pragma mark - Event事件
- (void)sureBtnClick
{
    kWeakSelf
    self.passwordView = [HXBTransactionPasswordView show];
    self.passwordView.getTransactionPasswordBlock = ^(NSString *password) {
        [weakSelf checkWithdrawals:password];
    };
}

- (void)checkWithdrawals:(NSString *)pwd
{
    kWeakSelf
    HXBMYRequest *transferRequest = [[HXBMYRequest alloc] init];
    [transferRequest transferResultRequest_AccountRequestTransferID:self.creditorID andPWD:pwd andCurrentTransferValue:self.transferConfirmModel.currentTransValue SuccessBlock:^(id responseObject) {
        HXBFBase_BuyResult_VC *successVC = [[HXBFBase_BuyResult_VC alloc] init];
        successVC.isShowInviteBtn = NO;
        successVC.imageName = @"successful";
        successVC.buy_title = @"转让成功";
        successVC.buy_description = @"确认成功，债权已进入转让中，具体完成时间以实际转让成功时间为准";
        successVC.buy_ButtonTitle = @"我知道了";
        successVC.title = @"债权转让";
        [successVC clickButtonWithBlock:^{
            for (UIViewController *VC in self.navigationController.viewControllers) {
                if ([VC isKindOfClass:[HXBMY_LoanListViewController class]]) {
                    [weakSelf.navigationController popToViewController:VC animated:YES];
                }
            }
        }];
        [weakSelf.passwordView closePasswordView];
        [weakSelf.navigationController pushViewController:successVC animated:YES];
    } andFailureBlock:^(NSError *error,id responseObject) {
        if (error) {
            if (kHXBCode_Enum_NoConnectionNetwork == error.code || kHXBCode_Enum_ConnectionTimeOut == error.code) return ;
        } else {
            NSInteger status = [responseObject[kResponseStatus] integerValue];
            if (status == kHXBTransaction_Password_Error) {
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
                [weakSelf.passwordView clearUpPassword];
                return;
            }
            [weakSelf transferFailure:responseObject];
        }
    }];
}

- (void)transferFailure:(id) responseObject{
    HXBFBase_BuyResult_VC *failureVC = [[HXBFBase_BuyResult_VC alloc] init];
    failureVC.imageName = @"failure";
    failureVC.buy_title = @"转让失败";
    failureVC.buy_description = responseObject[@"message"];
    failureVC.buy_ButtonTitle = @"重新转让";
    failureVC.title = @"债权转让";
    [failureVC clickButtonWithBlock:^{
        for (UIViewController *VC in self.navigationController.viewControllers) {
            if ([VC isKindOfClass:[HXBMY_LoanListViewController class]]) {
                [self.navigationController popToViewController:VC animated:YES];
            }
        }
    }];
    [self.passwordView closePasswordView];
    [self.navigationController pushViewController:failureVC animated:YES];
}

#pragma mark - getter(懒加载)
- (HXBFinBaseNegotiateView *)agreementView
{
    if (!_agreementView) {
        _agreementView = [[HXBFinBaseNegotiateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(200))];
        _agreementView.negotiateStr = @"债权转让及受让协议";
        kWeakSelf
        [_agreementView clickNegotiateWithBlock:^{
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_LoanTruansferURL] fromController:weakSelf];
        }];
        [_agreementView clickCheckMarkWithBlock:^(BOOL isSelected) {
            if (isSelected) {
                weakSelf.sureBtn.userInteractionEnabled = YES;
                [weakSelf.sureBtn setBackgroundColor:COR29];
            }else
            {
                weakSelf.sureBtn.userInteractionEnabled = NO;
                [weakSelf.sureBtn setBackgroundColor:COR26];
            }
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
- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton btnwithTitle:@"确定" andTarget:self andAction:@selector(sureBtnClick) andFrameByCategory:CGRectZero];
    }
    return _sureBtn;
}
@end
