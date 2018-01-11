//
//  HxbHomeView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HXBBannerView.h"
#import "HxbHomePageViewModel_dataList.h"
@class HXBHomeBaseModel,BannerModel;
@interface HxbHomeView : UIView

@property (nonatomic, strong) UITableView *mainTableView;


/**
 用户信息
 */
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
/**
 请求下来的数据模型
 */
@property (nonatomic, strong) HXBHomeBaseModel *homeBaseModel;

/**
 下拉加载回调的Block
 */
@property (nonatomic, copy) void(^homeRefreshHeaderBlock)();
/**
 点击cell中按钮回调的Block
 */
@property (nonatomic, copy) void(^purchaseButtonClickBlock)();

/**
 点击cell回调的Block
 */
@property (nonatomic, copy) void (^homeCellClickBlick)(NSIndexPath *indexPath);

/**
 各种认证按钮的点击回调Block
 */
@property (nonatomic, copy) void(^tipButtonClickBlock_homeView)();
/**
 公告的回调
 */
@property (nonatomic, copy) void (^noticeBlock)();

/*
 点击banner的回调
 */
@property (nonatomic, copy) void (^clickBannerImageBlock)(BannerModel *model);

/**
 是否停止刷新
 */
@property (nonatomic,assign) BOOL isStopRefresh_Home;

- (void)changeIndicationView:(HXBRequestUserInfoViewModel *)viewModel;
- (void)showBulletinView;
- (void)showSecurityCertificationOrInvest:(HXBRequestUserInfoViewModel *)viewModel;

@end
