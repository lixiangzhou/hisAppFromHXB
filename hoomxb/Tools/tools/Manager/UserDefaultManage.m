//
//  UserDefaultManage.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "UserDefaultManage.h"

#define UserDefaults [NSUserDefaults standardUserDefaults]

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
    [UserDefaults setBool:hasLaunched forKey:@"hasLaunched"];
}

- (BOOL)hasLaunched
{
    return [UserDefaults boolForKey:@"hasLaunched"];
}

- (void)setAppVersion:(NSString *)version
{
    [UserDefaults setValue:version forKey:@"version"];
}

- (BOOL)tryRedPlan
{
    return [UserDefaults boolForKey:@"tryRedPlan"];
}

- (void)setTryRedPlan:(BOOL)tryRedPlan
{
    [UserDefaults setBool:tryRedPlan forKey:@"tryRedPlan"];
}

@end

