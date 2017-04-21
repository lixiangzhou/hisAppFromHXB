//
//  HXBServerAndClientTime.m
//  HXBServerAndClientTime
//
//  Created by HXB on 2017/4/20.
//  Copyright © 2017年 HXB. All rights reserved.
//

#import "HXBServerAndClientTime.h"

@interface HXBServerAndClientTime ()

@end

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


//MARK: setter
- (void)setServerTime:(NSString *)serverTime {
    _serverTime = serverTime;
   double serverTimeDouble = serverTime.longLongValue;
   
    //计算当前的时间秒数
    NSTimeInterval currentDateInterval = [[[NSDate alloc]init] timeIntervalSince1970];
    //计算时差
     NSNumber *timeDifferenceTemp = @(serverTimeDouble - currentDateInterval);
    [self setValue:timeDifferenceTemp forKey:@"timeDifference"];
}

//MARK: getter
- (NSDate *)serverAndClientDate {
    return [NSDate dateWithTimeIntervalSinceNow:self.timeDifference.doubleValue];;
}

- (NSNumber *)serverAndClientTimeInterval {
    return @([self.serverAndClientDate timeIntervalSince1970]);
}


@end
