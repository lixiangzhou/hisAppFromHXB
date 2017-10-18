//
//  HXBBaseVersionUpdateManager.h
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///版本更新管理者
@interface HXBBaseVersionUpdateManager : NSObject
+ (BOOL) isUPDataAPPWithAPPID: (CGFloat)APPID;
+ (BOOL) isFirstStartUPAPP;
@end
