//
//  UIScrollView+HXBScrollView.h
//  hoomxb
//
//  Created by HXB on 2017/4/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HXBScrollView)
/**
 * 没有动图的下拉刷新
 * @param headerRefreshCallBack 刷新启动执行的回调
 * @param headerBlock 对header进行设置
 */

- (void)hxb_HeaderWithHeaderRefreshCallBack:(void(^)())headerRefreshCallBack
                      andSetUpGifHeaderBlock:(void(^)(MJRefreshNormalHeader *header))headerBlock;

/**
 * 没有动图的上拉加载
 * @param footerRefreshCallBack 刷新启动执行的回调
 * @param gifFooterBlock 对footer进行设置
 */
- (void)hxb_FooterWithRefreshBlock:(void(^)())footerRefreshCallBack
             andSetUpGifFooterBlock:(void(^)(MJRefreshBackNormalFooter *footer))gifFooterBlock;

/**
 * 带有动画的上拉刷新自定义
 * @param idleImages 平常状态下的gif数组
 * @param pullingImages 正在刷新的gif
 * @param refreshingImages 刷新完成的gif
 * @param durations 时间的集合（顺序按照 平常状态的时长->正在刷新的时长->完成时的动画时长）
 * @param headerRefreshCallBack 刷新启动执行的回调
 * @param gifHeaderBlock 对header进行设置
 */
- (void)hxb_GifHeaderWithIdleImages:(NSArray<UIImage *>*)idleImages
                   andPullingImages:(NSArray <UIImage*>*)pullingImages
                  andFreshingImages:(NSArray<UIImage*>*)refreshingImages
                andRefreshDurations:(NSArray<NSNumber*>*)durations
                    andRefreshBlock:(void(^)())headerRefreshCallBack
             andSetUpGifHeaderBlock:(void(^)(MJRefreshGifHeader *gifHeader))gifHeaderBlock;

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
