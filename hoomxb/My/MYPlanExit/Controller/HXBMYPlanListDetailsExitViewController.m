//
//  HXBMYPlanListDetailsExitViewController.m
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYPlanListDetailsExitViewController.h"
#import "HXBMyPlanDetailsExitMainView.h"
#import "HXBMyPlanDetailsExitViewModel.h"
#import "HXBVerificationCodeAlertVC.h"
#import "HXBMyPlanExitSuccessController.h"

@interface HXBMYPlanListDetailsExitViewController ()
@property (nonatomic,strong) HXBMyPlanDetailsExitMainView *mainView;
@property (nonatomic,strong) HXBMyPlanDetailsExitViewModel *viewModel;
@property (nonatomic, strong) HXBVerificationCodeAlertVC *alertVC;
//@property (nonatomic, assign) BOOL isAlertVCShow;
@end

@implementation HXBMYPlanListDetailsExitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self downLoadData];
}

- (void)downLoadData {
    kWeakSelf
    [self.viewModel loadPlanListDetailsExitInfoWithPlanID:self.planID resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.mainView.myPlanDetailsExitModel = weakSelf.viewModel.myPlanDetailsExitModel;
            [weakSelf setMyPlanDetailsExitMainViewValue];
        }
    }];
}

- (void)setMyPlanDetailsExitMainViewValue {
    kWeakSelf
    [self.mainView setValueManager_PlanDetail_Detail:^HXBMyPlanDetailsExitMainViewManager *(HXBMyPlanDetailsExitMainViewManager *manager) {
        
        if (!weakSelf.viewModel.myPlanDetailsExitModel) {
            return manager;
        }
        
        manager.topViewManager.leftStrArray = @[
                                                @"加入本金",
                                                @"当前已赚",
                                                @"退出时间"
                                                ];
        manager.topViewManager.rightStrArray = @[
                                                 weakSelf.viewModel.myPlanDetailsExitModel.amount,
                                                 weakSelf.viewModel.myPlanDetailsExitModel.earnInterestNow,
                                                 weakSelf.viewModel.myPlanDetailsExitModel.endLockingTime
                                                 ];
        return manager;
    }];
    [self.mainView setMyPlanDetailsExitModel:self.viewModel.myPlanDetailsExitModel];
}

- (void)setupView {
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"红利计划退出";
    
    [self.view addSubview:self.mainView];
}

- (void)getNetworkAgain
{
    [self downLoadData];
}

// 获取短验
- (void)getVerifyCode
{
    kWeakSelf
    [self.viewModel getVerifyCodeRequesWithExitPlanWithAction:@"planquit" andWithType:@"sms" andCallbackBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf displayVerifyingCodeAlert];
        if (isSuccess) {
//            weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [KeyChain.mobile replaceStringWithStartLocation:3 lenght:4]];
            
//            [weakSelf displayVerifyingCodeAlert];
            [weakSelf.alertVC.verificationCodeAlertView disEnabledBtns];
        } else {
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
        }
    }];
}

// 弹出验证码弹窗
- (void)displayVerifyingCodeAlert {
    if (!self.presentedViewController) {
        self.alertVC = [[HXBVerificationCodeAlertVC alloc] init];
        self.alertVC.messageTitle = @"请输入短信验证码";
        self.mobile = !self.mobile?KeyChain.mobile:self.mobile;
        self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.mobile replaceStringWithStartLocation:3 lenght:4]];
        kWeakSelf
        self.alertVC.sureBtnClick = ^(NSString *pwd) {
            [weakSelf.viewModel exitPlanResultRequestWithPlanID:weakSelf.planID andSmscode:pwd andCallBackBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
                    // push 到退出结果页
                    HXBMyPlanExitSuccessController *exitResultVC = [[HXBMyPlanExitSuccessController alloc]init];
                    exitResultVC.descString = weakSelf.viewModel.myPlanDetailsExitResultModel.quitDesc;
                    exitResultVC.titleString = @"红利计划退出";
//                    if ([exitResultVC.exitType iseq]) {
//                        exitResultVC.titleString = @"";
//                    } else if ([exitResultVC.exitType iseq]) {
//                        exitResultVC.titleString = @"";
//                    }
                } else {
                    // 短信弹窗不消失 toast提示
                }
            }];
        };
        self.alertVC.getVerificationCodeBlock = ^{
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
            [weakSelf getVerifyCode];
        };
        
        [self presentViewController:self.alertVC animated:NO completion:nil];
    }
}

- (HXBMyPlanDetailsExitViewModel *)viewModel {
    if (!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBMyPlanDetailsExitViewModel alloc]initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    return _viewModel;
}

- (HXBMyPlanDetailsExitMainView *)mainView{
    if (!_mainView) {
        kWeakSelf
        _mainView = [[HXBMyPlanDetailsExitMainView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
        _mainView.exitBtnClickBlock = ^{
//            _isAlertVCShow = NO;
            [weakSelf getVerifyCode];
        };
        _mainView.cancelBtnClickBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _mainView;
}

@end