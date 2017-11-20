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

#define FYCallBackUrl                                 @"/fyCallback/app/0"
#define TOKENURL                                      @"/token"
static NSString *const HXBTokenInvalidCode = @"401";

#endif /* HXBAPI_h */
