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

/**
 * 默认的下拉刷新方法
 * @param headerRefreshCallBack 刷新启动执行的回调
 */
- (void)hxb_headerWithRefreshBlock:(void(^)())headerRefreshCallBack;

/**
 * 可配置的的下拉刷新，可自定义header
 * @param headerRefreshCallBack 刷新启动执行的回调
 * @param configHeaderBlock 对header进行设置
 */

- (void)hxb_headerWithRefreshBlock:(void(^)())headerRefreshCallBack
                      configHeaderBlock:(void(^)(MJRefreshNormalHeader *header))configHeaderBlock;

/// 默认的上拉刷新方法
- (void)hxb_footerWithRefreshBlock:(void(^)())footerRefreshCallBack;

/**
 可配置的的上拉刷新方法

 @param footerRefreshCallBack 刷新启动执行的回调
 @param configFooterBlock 对footer进行设置
 */
- (void)hxb_footerWithRefreshBlock:(void(^)())footerRefreshCallBack
                 configFooterBlock:(void(^)(MJRefreshBackNormalFooter *footer))configFooterBlock;

@end
