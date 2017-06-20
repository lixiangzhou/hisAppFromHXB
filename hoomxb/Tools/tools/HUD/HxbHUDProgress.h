//
//  HxbHUDProgress.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HxbHUDProgress : NSObject

+ (void)showTextWithMessage:(NSString *)message;
+ (void)errorWithErrorCode:(NSInteger)errorCode;
- (void)showAnimationWithText:(NSString *)text;
- (void)showAnimation;
- (void)hide;
@end
