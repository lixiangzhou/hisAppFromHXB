//
//  HXBVersionUpdateManager.h
//  hoomxb
//
//  Created by HXB-C on 2017/12/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBVersionUpdateManager : HXBBaseViewModel

/**
 是否为强制升级
 */
@property (nonatomic, assign, readonly) BOOL isMandatoryUpdate;

/**
 是否展示过升级弹框
 */
@property (nonatomic, assign) BOOL isShow;

//单例
+ (instancetype)sharedInstance;

//请求版本更新接口（目前只在HXBRootVCManager内使用）
- (void)checkVersionUpdate;

//在首页需要进行显示
- (void)show;

@end
