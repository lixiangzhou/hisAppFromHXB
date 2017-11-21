//
//  HXMacros_BLog.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#ifndef HXMacros_BLog_h
#define HXMacros_BLog_h

//NSLog宏， 仅在debug状态下打印log
#ifdef DEBUG
# define LogPrint(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define LogPrint(...);
#endif

//dealloc宏
#define kDealloc - (void) dealloc  {\
    NSLog(@"%@ - ✅被销毁",self.class);\
}

//网络错误宏
#define kNetWorkError(some) LogPrint(@"🌶%@ - %@ -网络数据出错", (some) ,self.class);

#endif /* HXMacros_BLog_h */
