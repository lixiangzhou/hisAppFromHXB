//
//  HxbHomeView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBBannerView.h"
#import "HxbHomePageViewModel.h"
#import "HxbHomePageViewModel_dataList.h"
@interface HxbHomeView : UIView
@property (nonatomic,strong)HXBBannerView *bannerView;

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray<HxbHomePageViewModel_dataList *> *homeDataListViewModelArray;
/**
 下拉加载回调的Block
 */
@property (nonatomic, copy) void(^homeRefreshHeaderBlock)();
/**
 点击cell中回调的Block
 */
@property (nonatomic, copy) void(^purchaseButtonClickBlock)();
/**
 是否停止刷新
 */
@property (nonatomic,assign) BOOL isStopRefresh_Home;

- (void)changeIndicationView;
- (void)hideBulletinView;
- (void)showBulletinView;
- (void)showSecurityCertificationOrInvest;
- (void)setDataModel:(HxbHomePageViewModel *)dataModel;

@end
