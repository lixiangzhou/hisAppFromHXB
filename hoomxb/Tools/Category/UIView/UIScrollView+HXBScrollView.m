//
//  UIScrollView+HXBScrollView.m
//  hoomxb
//
//  Created by HXB on 2017/4/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

static NSString * const footerNoMoreDataStr = @"已加载全部";

#import "UIScrollView+HXBScrollView.h"

@implementation UIScrollView (HXBScrollView)

//MARK: 默认的下拉刷新
- (void)hxb_headerWithRefreshBlock:(void (^)())headerRefreshCallBack
{
    [self hxb_headerWithRefreshBlock:headerRefreshCallBack configHeaderBlock:nil];
}

- (void)hxb_headerWithRefreshBlock:(void(^)())headerRefreshCallBack
                     configHeaderBlock:(void(^)(MJRefreshNormalHeader *header))configHeaderBlock{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerRefreshCallBack];
    header.stateLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    header.stateLabel.textColor = COR6;
    header.lastUpdatedTimeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    header.lastUpdatedTimeLabel.textColor = COR6;
    if (configHeaderBlock) configHeaderBlock(header);
    self.mj_header = header;
}

//带有动画的上拉加载
- (void)hxb_GifFooterWithIdleImages:(NSArray<UIImage*>*)idleImages
                    andPullingImages:(NSArray <UIImage*>*)pullingImages
                   andFreshingImages:(NSArray<UIImage*>*)refreshingImages
                 andRefreshDurations:(NSArray<NSNumber*>*)durations
                     andRefreshBlock:(void(^)())footerRefreshCallBack
              andSetUpGifFooterBlock:(void(^)(MJRefreshBackGifFooter *footer))gifFooterBlock{
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        if (footerRefreshCallBack) footerRefreshCallBack();
    }];
    footer.stateLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    footer.stateLabel.textColor = COR6;
    [footer setTitle:footerNoMoreDataStr forState:MJRefreshStateNoMoreData];
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
    if (!idleImages.count) {
        MJRefreshAutoNormalFooter *autoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (footerRefreshCallBack) footerRefreshCallBack();
        }];
        [autoNormalFooter setTitle:footerNoMoreDataStr forState:MJRefreshStateNoMoreData];
        self.mj_footer = autoNormalFooter;
    }
}




//MARK: 默认的上拉加载
- (void)hxb_FooterWithRefreshBlock:(void(^)())footerRefreshCallBack
            andSetUpGifFooterBlock:(void(^)(MJRefreshBackNormalFooter *footer))footerBlock{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (footerRefreshCallBack) footerRefreshCallBack();
    }];
    footer.stateLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    footer.stateLabel.textColor = COR6;
    [footer setTitle:footerNoMoreDataStr forState:MJRefreshStateNoMoreData];
    
    if (footerBlock) footerBlock(footer);
    footer.automaticallyHidden = true;
    self.mj_footer = footer;
}


- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
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

