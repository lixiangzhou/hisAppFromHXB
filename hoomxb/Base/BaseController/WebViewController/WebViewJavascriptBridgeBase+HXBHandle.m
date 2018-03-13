//
//  WKWebViewJavascriptBridge+HXBHandle.m
//  hoomxb
//
//  Created by caihongji on 2018/3/6.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "WebViewJavascriptBridgeBase+HXBHandle.h"
#import <objc/runtime.h>
#import "SGInfoAlert.h"

@implementation WebViewJavascriptBridgeBase(HXBHandle)

+(void)load{
    
    Class class = NSClassFromString(@"WebViewJavascriptBridgeBase");
    
    Method m1 = class_getInstanceMethod(class, @selector(flushMessageQueue:));
    
    Method m2 = class_getInstanceMethod(class, @selector(ll_flushMessageQueue:));
    
    
    
    method_exchangeImplementations(m1, m2);
    
}

- (void)ll_flushMessageQueue:(NSString *)messageQueueString {
    id messages = [NSJSONSerialization JSONObjectWithData:[messageQueueString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    if (![messages isKindOfClass:[NSArray class]]) {
        NSLog(@"WebViewJavascriptBridge: WARNING: Invalid %@ received: %@", [messages class], messages);
        return;
    }
    
    BOOL canFlush = YES;
    for (WVJBMessage* message in messages) {
        WVJBHandler handler;
        if (message[@"handlerName"]) {
            handler = self.messageHandlers[message[@"handlerName"]];
        } else {
            handler = self.messageHandler;
        }
        
        if (!handler) {
            canFlush = NO;
#ifdef DEBUG
            NSString* log = [NSString stringWithFormat:@"WebViewJavascriptBridge: WARNING: 不能处理js调用： %@ received: %@", message[@"handlerName"], messages];
            NSLog(@"%@", log);
            [SGInfoAlert showInfo:log bgColor:[UIColor blackColor].CGColor inView:[UIApplication sharedApplication].keyWindow vertical:0.3];
#endif
            break;
        }
    }
    
    if(canFlush) {
        [self ll_flushMessageQueue:messageQueueString];
    }
}
@end
