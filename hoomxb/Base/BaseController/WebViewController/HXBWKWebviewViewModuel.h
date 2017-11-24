//
//  HXBWKWebviewViewModuel.h
//  hoomxb
//
//  Created by caihongji on 2017/11/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef enum : NSUInteger {
    HXBPageLoadStateEnd,
    HXBPageLoadStateStart,
    HXBPageLoadStateFaile
} HXBPageLoadState;

@interface HXBWKWebviewViewModuel : NSObject<WKNavigationDelegate>

typedef void (^ HXBPageLoadStateBlock) (HXBPageLoadState state);

//页面加载状态回调
@property (nonatomic, copy) HXBPageLoadStateBlock loadStateBlock;
@end
