//
//  NYNetworkConfig.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkConfig.h"
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "NSDate+HXB.h"

///通用接口Header必传字段 userAgent
static NSString *const User_Agent = X_Hxb_User_Agent;
///通用接口Header必传字段 token
static NSString *const X_HxbAuth_Token = @"X-Hxb-Auth-Token";

///网络数据的基本数据类
@interface NYNetworkConfig ()

@property (nonatomic, strong, readwrite) NSDictionary *additionalHeaderFields;

@property (nonatomic, strong) NSString *systemVision;

@property (nonatomic, strong) NSString *userAgent;

@end

@implementation NYNetworkConfig

+ (NYNetworkConfig *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        //网络实时监控
        [sharedInstance networkMonitoring];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.systemVision = [[UIDevice currentDevice] systemVersion];
        self.version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        self.userAgent = [NSString stringWithFormat:@"%@/IOS %@/v%@ iphone" ,[HXBDeviceVersion deviceVersion],self.systemVision,self.version];
        _additionalHeaderFields = @{};
        self.baseUrl = @"";
        self.defaultAcceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
        self.defaultAcceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/javascript", @"application/json",@"application/x-www-form-urlencoded",nil];
    }
    return self;
}

//MARK: 设置请求基本信息
- (NSDictionary *)additionalHeaderFields
{
    NSDictionary *dict = @{
                           X_HxbAuth_Token:[KeyChain token],
                           User_Agent:self.userAgent,
                           @"IDFA":[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],
                           @"X-Request-Id":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                           @"X-Hxb-Auth-Timestamp": [NSDate milliSecondSince1970]
                           };

    return dict;
}

//MARK: 网络实时监控
- (void)networkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开启网络监控
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
//                NSLog(@"🐯未知网络");
                break;
            case 0:
//                NSLog(@"🐯网络不可达");
                break;
            case 1:
//                NSLog(@"🐯GPRS网络");
                break;
            case 2:
//                NSLog(@"🐯wifi网络");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"🐯有网");
            KeyChain.ishaveNet = YES;
        }else
        {
            KeyChain.ishaveNet = NO;
            NSLog(@"🐯没有网");
            [HxbHUDProgress showMessageCenter:kNoNetworkText inView:nil];
        }
    }];
}
@end
