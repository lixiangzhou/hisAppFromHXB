//
//  HXBHomePageHeadView.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBBannerView.h"
@class HXBHomeBaseModel;
@protocol HXBHomePageHeadViewDelegate <NSObject>

@optional

- (void)resetHeadView;

@end

@interface HXBHomePageHeadView : UIView

@property (nonatomic, strong) HXBBannerView *bannerView;

/**
 用户信息
 */
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
/**
 请求下来的数据模型
 */
@property (nonatomic, strong) HXBHomeBaseModel *homeBaseModel;

@property (nonatomic, strong) id <HXBHomePageHeadViewDelegate> delegate;

@property (nonatomic, assign) BOOL network;

/**
 各种认证按钮的点击回调Block
 */
@property (nonatomic, copy) void(^tipButtonClickBlock_homePageHeadView)();

/*
点击banner的回调
*/
@property (nonatomic, copy) void (^clickBannerImageBlock)(BannerModel *model);

/**
 公告的回调
 */
@property (nonatomic, copy) void (^noticeBlock)();

/**
 新手视图点击方法
 */
@property (nonatomic, copy) void (^newbieAreaActionBlock)();

/**
 未投资显示的页面
 */
- (void)showNotValidatedView;
/**
 已投资显示的页面
 */
- (void)showAlreadyInvestedView;


- (void)showSecurityCertificationOrInvest:(HXBRequestUserInfoViewModel *)viewModel;


@end
