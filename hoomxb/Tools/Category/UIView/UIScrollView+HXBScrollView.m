//
//  UIScrollView+HXBScrollView.m
//  hoomxb
//
//  Created by HXB on 2017/4/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIScrollView+HXBScrollView.h"

@implementation UIScrollView (HXBScrollView)

//带有动画的上拉刷新
- (void)hxb_GifHeaderWithIdleImages:(NSArray<UIImage *>*)idleImages
                    andPullingImages:(NSArray <UIImage*>*)pullingImages
                   andFreshingImages:(NSArray<UIImage*>*)refreshingImages
                andRefreshDurations:(NSArray<NSNumber*>*)durations
                     andRefreshBlock:(void(^)())headerRefreshCallBack
              andSetUpGifHeaderBlock:(void(^)(MJRefreshGifHeader *gifHeader))gifHeaderBlock{
    //创建header
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (headerRefreshCallBack) headerRefreshCallBack();
    }];
    //设置header
    if (gifHeaderBlock) gifHeaderBlock(header);
    
    //设置动画数组
    //默认状态下的动画
    [header setImages:idleImages duration:durations[0].longValue forState:MJRefreshStateIdle];
    //即将刷新
    [header setImages:idleImages duration:durations[1].longValue forState:MJRefreshStatePulling];
    //正在刷新
    [header setImages:idleImages duration:durations[2].longValue forState:MJRefreshStateRefreshing];
    self.mj_header = header;
}

//带有动画的下拉刷新
- (void)hxb_GifFooterWithIdleImages:(NSArray<UIImage*>*)idleImages
                    andPullingImages:(NSArray <UIImage*>*)pullingImages
                   andFreshingImages:(NSArray<UIImage*>*)refreshingImages
                 andRefreshDurations:(NSArray<NSNumber*>*)durations
                     andRefreshBlock:(void(^)())footerRefreshCallBack
              andSetUpGifFooterBlock:(void(^)(MJRefreshBackGifFooter *footer))gifFooterBlock{
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        if (footerRefreshCallBack) footerRefreshCallBack();
    }];
    //设置header
    if (gifFooterBlock) gifFooterBlock(footer);
    
    //设置动画数组
    //默认状态下的动画
    [footer setImages:idleImages duration:durations[0].longValue forState:MJRefreshStateIdle];
    //即将刷新
    [footer setImages:idleImages duration:durations[1].longValue forState:MJRefreshStatePulling];
    //正在刷新
    [footer setImages:idleImages duration:durations[2].longValue forState:MJRefreshStateRefreshing];
    footer.automaticallyHidden = true;
    self.mj_footer = footer;
}


//MARK: 默认的下拉加载
- (void)hxb_HeaderWithHeaderRefreshCallBack:(void(^)())headerRefreshCallBack
                     andSetUpGifHeaderBlock:(void(^)(MJRefreshNormalHeader *header))headerBlock{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(headerRefreshCallBack) headerRefreshCallBack();
    }];
    
    if (headerBlock) headerBlock(header);
    self.mj_header = header;
}

//MARK: 默认的上拉刷新
- (void)hxb_FooterWithRefreshBlock:(void(^)())footerRefreshCallBack
            andSetUpGifFooterBlock:(void(^)(MJRefreshBackNormalFooter *footer))footerBlock{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (footerRefreshCallBack) footerRefreshCallBack();
    }];
    if (footerBlock) footerBlock(footer);
    footer.automaticallyHidden = true;
    self.mj_footer = footer;
}
@end


// ---------------- readMe -----------------------
/**
 * 相关设置
 1. 状态的lable
 footer.stateLabel header.stateLabel
 2. 记录时间的label
 header.lastUpdatedTimeLabel
 3. 设置footer在没有数据的时候隐藏： （默认为false）
 footer.automaticallyHidden = true;
 */

