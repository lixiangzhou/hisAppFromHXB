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
#define kHXBGesturePWD [NSString stringWithFormat:@"kHXBGesturePWD%@", KeyChain.mobile ?: @""]

@interface UserDefaultManage : NSObject

/**
 *  获取UserDefaultManage单例
 */
+ (id)sharedInstance;

@property (nonatomic, assign) BOOL hasLaunched;
@property (nonatomic, assign) BOOL tryRedPlan;

-(void)setAppVersion:(NSString *)version;

@end
