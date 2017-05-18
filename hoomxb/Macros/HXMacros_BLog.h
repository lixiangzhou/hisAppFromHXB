//
//  HXMacros_BLog.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#ifndef HXMacros_BLog_h
#define HXMacros_BLog_h


#define kDealloc - (void) dealloc  {\
    NSLog(@"%@ - ✅被销毁",self.class);\
}

#define kNetWorkError(some) NSLog(@"🌶%@ - %@ -网络数据出错", (some) ,self.class);
#endif /* HXMacros_BLog_h */
