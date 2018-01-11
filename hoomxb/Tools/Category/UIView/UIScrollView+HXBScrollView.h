//
//  UIScrollView+HXBScrollView.h
//  hoomxb
//
//  Created by HXB on 2017/4/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HXBScrollView)

/// 停止刷新
- (void)endRefresh;

/// 默认的下拉刷新方法
- (void)hxb_headerWithRefreshBlock:(void(^)())headerRefreshCallBack;


/// 默认的上拉刷新方法
- (void)hxb_footerWithRefreshBlock:(void(^)())footerRefreshCallBack;

@end
