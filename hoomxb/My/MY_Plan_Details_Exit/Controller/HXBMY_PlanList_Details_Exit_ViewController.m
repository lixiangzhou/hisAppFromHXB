//
//  HXBMY_PlanList_Details_Exit_ViewController.m
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanList_Details_Exit_ViewController.h"
#import "HXBMyPlanDetailsExitMainView.h"
#import "HXBMyPlanDetailsExitViewModel.h"
#import "HXBVerificationCodeAlertVC.h"

@interface HXBMY_PlanList_Details_Exit_ViewController ()
@property (nonatomic,strong) HXBMyPlanDetailsExitMainView *mainView;
@property (nonatomic,strong) HXBMyPlanDetailsExitViewModel *viewModel;
@property (nonatomic, strong) HXBVerificationCodeAlertVC *alertVC;
@end

@implementation HXBMY_PlanList_Details_Exit_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setFrame];
    [self downLoadData];
}

- (void)downLoadData {
    kWeakSelf
    [self.viewModel loadPlanListDetailsExitInfoWithPlanID:self.planID resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.mainView.myPlanDetailsExitModel = weakSelf.viewModel.myPlanDetailsExitModel;
        }
    }];
}

- (void)setupView {
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"红利计划退出";
    
    [self.view addSubview:self.mainView];
}

- (void)setFrame {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)getNetworkAgain
{
    [self downLoadData];
}

// 获取短验
- (void)getVerifyCode
{
    kWeakSelf
    [self.viewModel getVerifyCodeRequesWithExitPlanWithAction:@"" andWithType:@"sms" andCallbackBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
//            weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [KeyChain.mobile replaceStringWithStartLocation:3 lenght:4]];
            [weakSelf displayVerifyingCodeAlert];
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
        self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [KeyChain.mobile replaceStringWithStartLocation:3 lenght:4]];
        kWeakSelf
        self.alertVC.sureBtnClick = ^(NSString *pwd) {
            [weakSelf.viewModel exitPlanResultRequestWithSmscode:pwd andCallBackBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
                    // push 到退出结果页
                    // 传过去 结果描述
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
        _mainView = [[HXBMyPlanDetailsExitMainView alloc]init];
        _mainView.exitBtnClickBlock = ^{
            [weakSelf getVerifyCode];
        };
        _mainView.cancelBtnClickBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _mainView;
}

@end
