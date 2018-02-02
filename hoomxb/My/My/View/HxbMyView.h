//
//  HxbMyView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyViewDelegate
- (void)didLeftHeadBtnClick:(UIButton *_Nullable)sender;
- (void)didClickTopUpBtn:(UIButton *_Nullable)sender;
- (void)didClickWithdrawBtn:(UIButton *_Nullable)sender;
@end
@class HXBMyRequestAccountModel;
@interface HxbMyView : UIView

/**
 下拉加载回调的Block
 */
@property (nonatomic, copy) void(^ _Nonnull homeRefreshHeaderBlock)();
/**
 是否停止刷新
 */
@property (nonatomic,assign) BOOL isStopRefresh_Home;
@property (nonatomic, strong) HXBRequestUserInfoViewModel * _Nonnull userInfoViewModel;
@property (nonatomic, strong) HXBMyRequestAccountModel *_Nonnull accountModel;
@property (nonatomic,weak,nullable) id<MyViewDelegate>delegate;
///点击了 总资产
- (void)clickAllFinanceButtonWithBlock: (void(^_Nullable)(UILabel * button))clickAllFinanceButtonBlock;
@end
