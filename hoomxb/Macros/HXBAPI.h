//
//  HXBAPI.h
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/16.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#ifndef HXBAPI_h
#define HXBAPI_h

// FOUNDATION_EXPORT NSString * const kString;   --> .h & .m (stringInstance == kString)

// 调用富友web前 需先做permission判断
//#import "FYUserLevelAPI.h"
//#import "UserPermissioHongXiaoBao/PrefixHeader.pchnModel.h"

//新版接口宏定义
#define FORCE_LOGOUT_URL                              @"ab"
#define FAQ_URL                                       @"https://www.hoomxb.com/app-files/questions"    //常见问题url
#define PLAN_FAQ_URL                                  @"https://hoomxb.com/app-files/common_questions.html"
#define PLAN_SAFE_GUARD_URL                           @"https://hoomxb.com/app-files/plan-safeguard.html"
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
#define BASEURL                                       @"http://192.168.1.36:3100"
//#define BASEURL                                       @"http://192.168.1.243:3100"//杨老板
//#define BASEURL                                                  @"http://yourapi.hoomxb.com"
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
#define FYCallBackUrl                                 @"/fyCallback/app/0"
#define TOKENURL                                      @"/token"
static NSString *const HXBTokenInvalidCode = @"401";

#endif /* HXBAPI_h */
