//
//  HXBCircleViewConst.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCircleViewConst.h"

@implementation HXBCircleViewConst
+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:gesture forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getGestureWithKey:(NSString *)key
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
