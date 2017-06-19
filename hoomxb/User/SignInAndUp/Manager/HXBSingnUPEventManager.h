//
//  HXBSingnUPEventManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBSingnUPEventManager : NSObject
@property (nonatomic,copy) void (^signUPEvent_ClickNextButtonBlock)();
+ (void)signUPEvent_ClickNextButtonFunc: (void (^)())signUPEvent_ClickNextButtonBlock;
@end
