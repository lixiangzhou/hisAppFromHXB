//
//  HXBWebViewProgress.h
//  DemoApp
//
//  Created by caihongji on 2018/5/3.
//  Copyright © 2018年 Satoshi Asano. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HXBWebViewProgressDelegate;

@interface HXBWebViewProgress : NSObject<UIWebViewDelegate>

@property (nonatomic, weak) id<HXBWebViewProgressDelegate> progressDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate> webViewProxyDelegate;

@end

@protocol HXBWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(HXBWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end
