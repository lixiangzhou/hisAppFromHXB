//
//  HXBAlertManager.m
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAlertManager.h"

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
        ///退出登录
        [[KeyChainManage sharedInstance] signOut];
        //到登录界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }];
    
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
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
@end
