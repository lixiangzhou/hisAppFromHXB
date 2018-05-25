//
//  HXBAccountActivationManager.m
//  hoomxb
//
//  Created by caihongji on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountActivationManager.h"
#import "HXBRootVCManager.h"
#import "HXBVersionUpdateManager.h"
#import "HXBHomePopViewManager.h"

#import "HXBUserMigrationViewController.h"
#import "HXBVersionUpdateManager.h"

@interface HXBAccountActivationManager() {
    BOOL _isCanPoped;
}
@property (nonatomic, weak) HXBUserMigrationViewController* accountActivationVC;
@property (nonatomic, copy) NSString* popFlag;
@end

@implementation HXBAccountActivationManager

+ (instancetype)sharedInstance
{
    static HXBAccountActivationManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)isCanPoped {
    if(!KeyChain.isLogin) {
        return NO;
    }
    else {
        if(!_popFlag) {
            return YES;
        }
    }
    return _isCanPoped;
}

- (void)setIsCanPoped:(BOOL)isCanPoped {
    _isCanPoped = isCanPoped;
    
    BOOL isShowVersionPopview = _popFlag? NO : YES;
    _popFlag = @"pop";
    if(isShowVersionPopview && !isCanPoped) {
        UIViewController *topVC = ((UINavigationController *)[HXBRootVCManager manager].mainTabbarVC.selectedViewController).topViewController;
        if ([topVC isKindOfClass:NSClassFromString(@"HxbHomeViewController")]) {
            [[HXBVersionUpdateManager sharedInstance] show];
        }
    }
}

- (void)popActiveAccountPage {
    
    if (!self.accountActivationVC) {
        UIViewController* topVC = [HXBRootVCManager manager].topVC;
        if([topVC isKindOfClass:NSClassFromString(@"HxbSignInViewController")]) {
            topVC = ((UINavigationController*)[HXBRootVCManager manager].mainTabbarVC.selectedViewController).topViewController;
        }
        HXBUserMigrationViewController* vc = [[HXBUserMigrationViewController alloc] init];
        //    vc.pushBlock = ^() {
        //        [topVC.navigationController pushViewController:[NSClassFromString(@"HXBUserMigrationResultViewController") new] animated:true];
        //    };
        
        self.accountActivationVC = vc;
        
        if(self.accountActivationVC) {
            [topVC presentViewController:self.accountActivationVC animated:YES completion:nil];
        }
    }
}
/**
 激活账户
 */
- (void)entryActiveAccountPage {
    
    if (_popFlag && self.isCanPoped) {
        UIViewController *topVC = ((UINavigationController *)[HXBRootVCManager manager].mainTabbarVC.selectedViewController).topViewController;
        if (![topVC isKindOfClass:NSClassFromString(@"HxbHomeViewController")]) {
            [self popActiveAccountPage];
        }
        else {
            if([HXBVersionUpdateManager sharedInstance].isShow){
               [self popActiveAccountPage];
            }
        }
    }
}

/**
 退出账户激活页
 */
- (void)exitActiveAccountPage {
    if(self.accountActivationVC.presentingViewController) {
        self.isCanPoped = NO;
        [self.accountActivationVC dismissViewControllerAnimated:NO completion:nil];
        self.accountActivationVC = nil;
        
        UIViewController *topVC = ((UINavigationController *)[HXBRootVCManager manager].mainTabbarVC.selectedViewController).topViewController;
        if ([topVC isKindOfClass:NSClassFromString(@"HxbHomeViewController")]) {
            [[HXBVersionUpdateManager sharedInstance] show];
        }
    }
    
}

@end
