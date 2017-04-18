//
//  NYNetworkConfig.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkConfig.h"
#import <AdSupport/AdSupport.h>

@interface NYNetworkConfig ()

//终端，1代表iOS平台
@property (nonatomic, copy) NSString *terminal;

@property (nonatomic, strong, readwrite) NSDictionary *additionalHeaderFields;

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
        self.version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        _additionalHeaderFields = @{};
        self.baseUrl = @"";
        self.defaultAcceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
        self.defaultAcceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/javascript", @"application/json", nil];
    }
    return self;
}

//MARK: 设置请求基本信息
- (NSDictionary *)additionalHeaderFields
{
    
    NSDictionary *dict = @{
                           @"X-HxbAuth-Token":[KeyChain token],
                           @"Version":self.version,
                           @"Terminal":@"1",
                           @"IDFA":[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],
                           @"X-Request-Id":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                           };

    return dict;
}

//MARK: 网络实时监控
- (void)networkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开启网络监控
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"🐯未知网络");
                break;
            case 0:
                NSLog(@"🐯网络不可达");
                break;
            case 1:
                NSLog(@"🐯GPRS网络");
                break;
            case 2:
                NSLog(@"🐯wifi网络");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"🐯有网");
        }else
        {
            NSLog(@"🐯没有网");
        }
    }];
}


@end
