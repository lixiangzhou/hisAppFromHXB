//
//  UserDefaultManage.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 手势密码
UIKIT_EXTERN NSString const *kHXBGesturePWD;
// 是否出现过忽略手势密码弹窗
UIKIT_EXTERN NSString const *kHXBGesturePwdSkipeAppeardKey;
// 是否忽略手势密码
UIKIT_EXTERN NSString const *kHXBGesturePwdSkipeKey;

@interface UserDefaultManage : NSObject

/**
 *  获取UserDefaultManage单例
 */
+ (id)sharedInstance;

@property (nonatomic, assign) BOOL hasLaunched;
@property (nonatomic, assign) BOOL tryRedPlan;

-(void)setAppVersion:(NSString *)version;

@end
