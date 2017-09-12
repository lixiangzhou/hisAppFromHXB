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

//+ (NSDate *)getInternetDate
//{
//    NSString *urlString = @"http://m.baidu.com";
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString: urlString]];
//    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
//    [request setTimeoutInterval: 2];
//    [request setHTTPShouldHandleCookies:FALSE];
//    [request setHTTPMethod:@"GET"];
//    NSHTTPURLResponse *response;
//    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//    
//    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
//    date = [date substringFromIndex:5];
//    date = [date substringToIndex:[date length]-4];
//    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
//    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
//    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: netDate];
//    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
//    return localeDate;
//}

//MARK:时间戳 对应毫秒级别
+ (NSString *)getCurrentTime_Millisecond {
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    return curTime;
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
- (void)dealloc{
    NSLog(@"%@ - ✅被销毁",self.class);
}

@end
