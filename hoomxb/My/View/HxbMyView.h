//
//  HxbMyView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyViewDelegate
- (void)didLeftHeadBtnClick:(UIButton *_Nullable)sender;
- (void)didClickTopUpBtn:(UIButton *_Nullable)sender;
- (void)didClickWithdrawBtn:(UIButton *_Nullable)sender;
@end
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
@property (nonatomic,weak,nullable) id<MyViewDelegate>delegate;

@end
