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

@interface HXBAccountActivationManager()
@property (nonatomic, strong) UIViewController* accountActivationVC;
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
    
    if(self.accountActivationVC) {
        [topVC presentViewController:self.accountActivationVC animated:YES completion:^{
            
        }];
    }
}

/**
 退出账户激活页
 */
- (void)exitActiveAccountPage {
    [self.accountActivationVC dismissViewControllerAnimated:NO completion:nil];
}

@end
