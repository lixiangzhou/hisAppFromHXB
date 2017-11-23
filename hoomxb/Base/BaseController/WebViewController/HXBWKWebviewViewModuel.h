//
//  HXBWKWebviewViewModuel.h
//  hoomxb
//
//  Created by caihongji on 2017/11/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PageLoadEnd,
    PageLoadStart,
    PageLoadFaile
} EMPageLoadState;

@interface HXBWKWebviewViewModuel : NSObject

typedef void (^ PageLoadStateBlock) (EMPageLoadState state);

//页面加载状态回调
@property (nonatomic, strong) PageLoadStateBlock loadStateBlock;
@end
