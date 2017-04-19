//
//  UserDefaultManage.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserDefault [UserDefaultManage sharedInstance]
#define kUserDefaults [NSUserDefaults standardUserDefaults]
@interface UserDefaultManage : NSObject

/**
 *  获取UserDefaultManage单例
 */
+ (id)sharedInstance;

@property (nonatomic, assign) BOOL hasLaunched;
@property (nonatomic, assign) BOOL tryRedPlan;

-(void)setAppVersion:(NSString *)version;

@end
