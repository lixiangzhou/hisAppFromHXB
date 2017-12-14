//
//  UserDefaultManage.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "UserDefaultManage.h"

// 手势密码
NSString const *kHXBGesturePWD = @"kHXBGesturePWD";
// 是否忽略手势密码
NSString const *kHXBGesturePwdSkipeKey = @"kHXBGesturePwdSkipeKey";

@implementation UserDefaultManage

+ (id)sharedInstance
{
    static UserDefaultManage *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)setHasLaunched:(BOOL)hasLaunched
{
    [kUserDefaults setBool:hasLaunched forKey:@"hasLaunched"];
}

- (BOOL)hasLaunched
{
    return [kUserDefaults boolForKey:@"hasLaunched"];
}

- (void)setAppVersion:(NSString *)version
{
    [kUserDefaults setValue:version forKey:@"version"];
}

- (BOOL)tryRedPlan
{
    return [kUserDefaults boolForKey:@"tryRedPlan"];
}

- (void)setTryRedPlan:(BOOL)tryRedPlan
{
    [kUserDefaults setBool:tryRedPlan forKey:@"tryRedPlan"];
}

@end

