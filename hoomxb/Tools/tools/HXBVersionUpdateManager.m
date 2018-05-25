//
//  HXBVersionUpdateManager.m
//  hoomxb
//
//  Created by HXB-C on 2017/12/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVersionUpdateManager.h"
#import "HXBVersionUpdateModel.h"
#import "HXBRootVCManager.h"
#import "HXBHomePopViewManager.h"

@interface HXBVersionUpdateManager ()

/**
 是否为强制升级
 */
@property (nonatomic, assign) BOOL isMandatoryUpdate;
//是否已经被弹出
@property (nonatomic, assign) BOOL isPoped;
//只在appdelegate里面使用
@property (nonatomic, strong) HXBVersionUpdateModel *versionUpdateModel;

@end


@implementation HXBVersionUpdateManager

+ (instancetype)sharedInstance {
    static HXBVersionUpdateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXBVersionUpdateManager alloc] initWithBlock:^UIView *{
            return nil;
        }];
    });
    return manager;
}

- (void)checkVersionUpdate {
    kWeakSelf
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBMY_VersionUpdateURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.showHud = NO;
    versionUpdateAPI.requestArgument = @{
                                         @"versionCode" : version
                                         };
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        weakSelf.versionUpdateModel = [HXBVersionUpdateModel yy_modelWithDictionary:responseObject[@"data"]];
        
        if ([KeyWindow.rootViewController isKindOfClass:NSClassFromString(@"HXBBaseTabBarController")]) {
            //获取顶部控制器
            if (![[HXBRootVCManager manager].topVC isKindOfClass:NSClassFromString(@"HXBGesturePasswordViewController")]) {
                [weakSelf show];
            }
        }
        
        if ([weakSelf.versionUpdateModel.force isEqualToString:@"1"]) {
            weakSelf.isMandatoryUpdate = YES;
        }
        else {
            weakSelf.isMandatoryUpdate = NO;
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        weakSelf.isShow = YES;

        [[HXBHomePopViewManager sharedInstance] popHomeViewfromController:[HXBRootVCManager manager].topVC];//展示首页弹窗
    }];
}

- (void)show {
    if (self.versionUpdateModel && !self.isPoped) {
        self.isPoped = YES;
        [HXBAlertManager checkversionUpdateWith:self.versionUpdateModel];
    }
    
    if(self.isShow) {
        UIViewController *topVC = ((UINavigationController *)[HXBRootVCManager manager].mainTabbarVC.selectedViewController).topViewController;
        [[HXBHomePopViewManager sharedInstance] popHomeViewfromController:topVC];//展示首页弹窗
    }
}


@end
