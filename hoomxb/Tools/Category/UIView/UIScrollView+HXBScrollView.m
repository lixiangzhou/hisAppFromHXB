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

// MARK: 默认的下拉刷新
- (void)hxb_headerWithRefreshBlock:(void (^)())headerRefreshCallBack
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerRefreshCallBack];
    header.stateLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    header.stateLabel.textColor = COR6;
    header.lastUpdatedTimeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    header.lastUpdatedTimeLabel.textColor = COR6;
    self.mj_header = header;
}

// MARK: 默认的上拉加载
- (void)hxb_footerWithRefreshBlock:(void (^)())footerRefreshCallBack
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:footerRefreshCallBack];
    footer.stateLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    footer.stateLabel.textColor = COR6;
    [footer setTitle:footerNoMoreDataStr forState:MJRefreshStateNoMoreData];
    footer.automaticallyHidden = YES;
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
 3. 设置footer在没有数据的时候隐藏： （默认为NO）
 footer.automaticallyHidden = YES;
 */

