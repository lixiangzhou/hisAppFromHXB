//
//  HXBAlertManager.m
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAlertManager.h"
#import "HXBVersionUpdateModel.h"

#import "HxbSecurityCertificationViewController.h"
#import "HXBSetGesturePasswordRequest.h"
#import "HXBRiskAssessmentViewController.h"
#import "HXBMiddlekey.h"
#import "HXBOpenDepositAccountViewController.h"
@interface HXBAlertManager ()

@property (nonatomic, strong) UIAlertController * alertController;

@end

@implementation HXBAlertManager
+ (void)alertManager_loginAgainAlertWithView: (UIView *)view {
    UIViewController *vc = [self getCurrentViewControllerWithView:view];
    [self reLoginAlertWithViewVC:vc];
}
//重新登录
+ (void)reLoginAlertWithViewVC: (UIViewController *)vc {
    //弹窗提示是否找回，点击找回退出登录到登录页面
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"您已经被强迫下线，请重新登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //到登录界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        ///退出登录
        [KeyChainManage sharedInstance].isLogin = false;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
//        [[KeyChainManage sharedInstance] signOut];
    }];
    
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
        ///退出登录
         [KeyChainManage sharedInstance].isLogin = false;
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancalAction];
    
    [vc.navigationController presentViewController:alertController animated:YES completion:nil];
}
/** 获取当前View的控制器对象 */
+ (UIViewController *)getCurrentViewControllerWithView: (UIView *)view{
    UIResponder *next = [view nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
/**
 强制更新
 */
+ (void)checkversionUpdateWith:(HXBVersionUpdateModel *)versionUpdateModel
{
    if ([versionUpdateModel.force isEqualToString:@"1"]) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"更新提示" message:versionUpdateModel.updateinfo preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:versionUpdateModel.url];
            [[UIApplication sharedApplication] openURL:url];
        }];
        [alertController addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

/**
 判断购买 判断
 */
+ (void)checkOutRiskAssessmentWithSuperVC:(UIViewController *)vc andWithPushBlock:(void(^)())pushBlock
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
//        //判断是否安全认证
//        if([viewModel.userInfoModel.userInfo.isAllPassed isEqualToString:@"0"]) {
//            ///没有实名
//            HxbSecurityCertificationViewController *securityCertificationVC = [[HxbSecurityCertificationViewController alloc]init];
//            securityCertificationVC.popToClass = NSStringFromClass([weakSelf class]);
//            [vc.navigationController pushViewController:securityCertificationVC animated:true];
//            return;
//        }
        //开通存管银行账户
        if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
            HXBBaseAlertViewController *alertVC = [[HXBBaseAlertViewController alloc]initWithMassage:@"您尚未开通存管账户请开通后在进行投资" andLeftButtonMassage:@"立即开通" andRightButtonMassage:@"取消"];
            [alertVC setClickLeftButtonBlock:^{
                HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                openDepositAccountVC.title = @"开通存管账户";
                openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [vc.navigationController pushViewController:openDepositAccountVC animated:YES];
            }];
            return;
        }
        ///完善信息
        if (![viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"])
        {
            HXBBaseAlertViewController *alertVC = [[HXBBaseAlertViewController alloc]initWithMassage:@"您尚未完善信息请完善信息后在进行投资" andLeftButtonMassage:@"立即完善" andRightButtonMassage:@"取消"];
            [alertVC setClickLeftButtonBlock:^{
                HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                openDepositAccountVC.title = @"完善信息";
                openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [vc.navigationController pushViewController:openDepositAccountVC animated:YES];
            }];
            return;
        }
        ///风险评测
        if ([viewModel.userInfoModel.userInfo.riskType isEqualToString:@"立即评测"]) {
            HXBBaseAlertViewController *alertVC = [[HXBBaseAlertViewController alloc]initWithMassage:@"您尚未进行风险评估请评估后在进行投资" andLeftButtonMassage:@"立即评估" andRightButtonMassage:@"我是保守型"];
            [alertVC setClickLeftButtonBlock:^{
                HXBRiskAssessmentViewController *riskAssessmentVC = [[HXBRiskAssessmentViewController alloc] init];
                [vc.navigationController pushViewController:riskAssessmentVC animated:YES];
                __weak typeof(riskAssessmentVC) weakRiskAssessmentVC = riskAssessmentVC;
                [riskAssessmentVC popWithBlock:^(NSString *type) {
                    if (type) {
                        [weakRiskAssessmentVC.navigationController popToViewController:vc animated:true];
                    }
                }];
            }];
            [alertVC setClickRightButtonBlock:^{
                HXBSetGesturePasswordRequest *riskModifyScore = [[HXBSetGesturePasswordRequest alloc] init];
                [riskModifyScore riskModifyScoreRequestWithScore:@"0" andSuccessBlock:^(id responseObject) {
                } andFailureBlock:^(NSError *error) {
                }];
                NSString *string = [NSString stringWithFormat:@"您是保守型用户"];
                [HxbHUDProgress showMessageCenter:string inView:vc.view];
            }];
            [vc.navigationController presentViewController:alertVC animated:YES completion:nil];
        }
//        
        ///条件全部满足
        if (pushBlock) {
            pushBlock();
        }
    } andFailure:^(NSError *error) {
        
    }];
}
/**
 初始化警告视图
 
 @param title title
 @param message message
 @return 创建的对象
 */
+ (instancetype)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    HXBAlertManager *alertManager =  [[self alloc] init];
    alertManager.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    return alertManager;
}
/**
 添加一个按钮
 
 @param btnName 按钮的名字
 @param handler 处理的事件
 */

- (void)addButtonWithBtnName:(NSString *)btnName andWitHandler:(void(^)())handler
{
    UIAlertAction *actionBtn = [UIAlertAction actionWithTitle:btnName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }];
    [self.alertController addAction:actionBtn];
}
/**
 显示
 
 @param vc 显示在哪个VC
 */
- (void)showWithVC:(UIViewController *)vc
{
    [vc presentViewController:self.alertController animated:YES completion:nil];
}

@end
