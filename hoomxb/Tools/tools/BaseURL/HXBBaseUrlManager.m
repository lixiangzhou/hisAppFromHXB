//
//  HXBBaseUrlManager.m
//  hoomxb
//
//  Created by lxz on 2017/11/16.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseUrlManager.h"



#define HXBBaseUrlKey @"HXBBaseUrlKey"

@interface HXBBaseUrlManager ()

@end

@implementation HXBBaseUrlManager

+ (instancetype)manager {
    static HXBBaseUrlManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [HXBBaseUrlManager new];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (HXBShakeChangeBaseUrl == NO) {
            // 线上环境
            _baseUrl = @"https://api.hoomxb.com";
        } else {
            NSString *storedBaseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:HXBBaseUrlKey];
            // http://192.168.1.36:3100 长度24
            if (storedBaseUrl.length > 0) {
                _baseUrl = storedBaseUrl;
            } else {
                _baseUrl = @"http://192.168.1.36:3100";
            }
        }
    }
    return self;
}

- (void)setBaseUrl:(NSString *)baseUrl {
    if (HXBShakeChangeBaseUrl == NO) {
        return;
    }
    _baseUrl = baseUrl;
    [[NSUserDefaults standardUserDefaults] setObject:baseUrl forKey:HXBBaseUrlKey];
}

//#define BASEURL                                       @"http://10.1.80.11:9001"

//叶
//#define BASEURL                                       @"https://api.hoomxb.com"
//#define BASEURL                                       @"http://api.hongxiaobao.com"//线上环境
//#define BASEURL                                       @"http://myapi.hoomxb.com"//线上环境
//#define BASEURL                                       @"http://192.168.1.21:3000"//后台
//#define BASEURL                                       @"http://192.168.1.133:3000"//王鹏 端测试
//#define BASEURL                                       @"http://192.168.1.199:3000"//杜宇 测试
//#define BASEURL                                       @"http://192.168.1.31:3100"//后台、
//#define BASEURL                                       @"http://192.168.1.243:3100"//杨老板
//#define BASEURL                                       @"http://192.168.1.35:4100"//后台 测试
//#define BASEURL                                       @"http://192.168.1.31:3100"//后台、
//#define BASEURL                                       @"http://192.168.1.35:4100"//后台、
//#define BASEURL                                       @"http://192.168.1.27:5100"//后台、
//#define BASEURL                                       @"http://192.168.1.28:3100"//后台、
//#define BASEURL                                       @"http://192.168.1.36:3100"
//#define BASEURL                                       @"http://192.168.1.26:3100"
//#define BASEURL                                       @"http://192.168.1.243:3100"//杨老板
//#define BASEURL                                       @"http://yourapi.hoomxb.com"
//#define kHXBH5_BaseURL                                @"http://192.168.1.21:3300"//后台 测试 （协议测试）
//#define kHXBH5_BaseURL                                @"http://192.168.1.235:3000"//欧朋 测试 （协议测试）
//#define kHXB_Banner_BaseURL                             @"http://192.168.1.31:4001"//后台


//http://192.168.1.133:3000
//http://192.168.1.21:3000
//#define BASEURL                                       @"http://120.25.102.84:9001"
//#define BASEURL                                       @"http://10.1.80.146:6666"//

//// 本机服务器-njm

//#define BASEURL                                         @"http://10.1.81.125:9001"
//#define BASEURL                                         @"http://10.1.81.125:9001"
//#define BASEURL                                         @"http://10.1.81.125:9009"

//曹曹曹曹曹曹曹曹曹曹
//#define BASEURL                                       @"http://10.1.80.10:9001"

@end
