//
//  HXBServerAndClientTime.m
//  HXBServerAndClientTime
//
//  Created by HXB on 2017/4/20.
//  Copyright © 2017年 HXB. All rights reserved.
//

#import "HXBServerAndClientTime.h"

@implementation HXBServerAndClientTime

+ (instancetype) sharedServerAndClientTime {
    static dispatch_once_t onceToken;
    static HXBServerAndClientTime *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}


+ (instancetype) hxbSerVerAndClientTimeWithServerTime: (NSString *)serverTime {
    HXBServerAndClientTime *serverAndClientTime = [HXBServerAndClientTime sharedServerAndClientTime];
    serverAndClientTime.serverTime = serverTime;
    return serverAndClientTime;
}

- (void)setServerTime:(NSString *)serverTime {
    _serverTime = serverTime;
   double serverTimeDouble = serverTime.longLongValue;
   
    NSTimeInterval currentDateInterval = [[[NSDate alloc]init] timeIntervalSince1970];
    
    _serverAndClientDate = [NSDate dateWithTimeIntervalSinceNow:serverTimeDouble - currentDateInterval];
}
@end
