//
//  UIScrollView+HXBScrollView.h
//  hoomxb
//
//  Created by HXB on 2017/4/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HXBScrollView)

///停止刷新
- (void)endRefresh;

/**
 * 没有动图的下拉刷新，不可自定义header
 * @param headerRefreshCallBack 刷新启动执行的回调
 */
- (void)hxb_headerWithRefreshBlock:(void(^)())headerRefreshCallBack;

/**
 * 没有动图的下拉刷新，可自定义header
 * @param headerRefreshCallBack 刷新启动执行的回调
 * @param configHeaderBlock 对header进行设置
 */

- (void)hxb_headerWithRefreshBlock:(void(^)())headerRefreshCallBack
                      configHeaderBlock:(void(^)(MJRefreshNormalHeader *header))configHeaderBlock;

/**
 * 没有动图的上拉加载
 * @param footerRefreshCallBack 刷新启动执行的回调
 * @param gifFooterBlock 对footer进行设置
 */
- (void)hxb_FooterWithRefreshBlock:(void(^)())footerRefreshCallBack
             andSetUpGifFooterBlock:(void(^)(MJRefreshBackNormalFooter *footer))gifFooterBlock;







/**
 * 带有动画的下拉加载自定义
 * @param idleImages 平常状态下的gif数组
 * @param pullingImages 正在刷新的gif
 * @param refreshingImages 刷新完成的gif
 * @param durations 时间的集合（顺序按照 平常状态的时长->正在刷新的时长->完成时的动画时长）
 * @param footerRefreshCallBack 刷新启动执行的回调
 * @param gifFooterBlock 对footer进行设置
 */
- (void)hxb_GifFooterWithIdleImages:(NSArray<UIImage*>*)idleImages
                   andPullingImages:(NSArray <UIImage*>*)pullingImages
                  andFreshingImages:(NSArray<UIImage*>*)refreshingImages
                andRefreshDurations:(NSArray<NSNumber*>*)durations
                    andRefreshBlock:(void(^)())footerRefreshCallBack
             andSetUpGifFooterBlock:(void(^)(MJRefreshBackGifFooter *footer))gifFooterBlock;
@end
