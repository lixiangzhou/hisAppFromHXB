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

#import "HXBAccountActivationViewController.h"
#import "HXBUserMigrationViewController.h"
@interface HXBAccountActivationManager()
@property (nonatomic, strong) HXBUserMigrationViewController* accountActivationVC;
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

/**
 激活账户
 */
- (void)entryActiveAccountPage {
    self.isPoped = YES;
    UIViewController* topVC = [HXBRootVCManager manager].topVC;
    HXBUserMigrationViewController* vc = [[HXBUserMigrationViewController alloc] init];
//    vc.pushBlock = ^() {
//        [topVC.navigationController pushViewController:[NSClassFromString(@"HXBUserMigrationResultViewController") new] animated:true];
//    };
    self.accountActivationVC = vc;
    
    if(self.accountActivationVC) {
        [topVC presentViewController:self.accountActivationVC animated:YES completion:nil];
    }
}

/**
 退出账户激活页
 */
- (void)exitActiveAccountPage {
    if(self.accountActivationVC.presentingViewController) {
        [self.accountActivationVC dismissViewControllerAnimated:NO completion:nil];
    }
    
}

@end
