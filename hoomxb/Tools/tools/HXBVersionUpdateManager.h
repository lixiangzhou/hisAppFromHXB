//
//  HXBVersionUpdateManager.h
//  hoomxb
//
//  Created by HXB-C on 2017/12/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBVersionUpdateManager : NSObject


/**
 是否展示过升级弹框
 */
@property (nonatomic, assign, readonly) BOOL isShow;

//单例
+ (instancetype)sharedInstance;

//请求版本更新接口（目前只在HXBRootVCManager内使用）
- (void)checkVersionUpdate;

//在首页需要进行显示
- (void)show;

@end
