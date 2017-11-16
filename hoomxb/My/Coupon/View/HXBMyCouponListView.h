//
//  HXBMyCouponListView.h
//  hoomxb
//
//  Created by hxb on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBMyCouponListModel;

typedef void(^tapToInviteVCBlock)(void);

@interface HXBMyCouponListView : UIView

//@property (nonatomic, strong) HXBMyCouponListModel *_Nonnull myCouponListModel;
@property (nonatomic,strong) NSArray <HXBMyCouponListModel *>* _Nullable myCouponListModelArray;

/**
 是否停止刷新
 */
@property (nonatomic,assign) BOOL isStopRefresh_Home;
/**
 点击cell中按钮回调的Block
 */
@property (nonatomic, copy) void(^actionButtonClickBlock)();
@property (nonatomic, copy) tapToInviteVCBlock block;
/**
 下拉加载回调的Block
 */
@property (nonatomic, copy) void(^ _Nonnull homeRefreshHeaderBlock)();

@end
