//
//  HXBPlan_JoinImmediatelyViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetailViewModel_PlanDetail,HXBJoinImmediateView_Model;
///plan 立即加入
@interface HXBFin_Plan_BuyViewController : HXBBaseViewController

@property (nonatomic,assign) BOOL isPlan;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) HXBFinDetailViewModel_PlanDetail *planViewModel;
//可用余额；
@property (nonatomic,copy) NSString *availablePoint;
///设置 值
- (void)setUPValueWithJoinImmediateView_Model: (HXBJoinImmediateView_Model *)model;
@property (nonatomic,copy) void(^callBackBlock)();
- (void)clickLookMYInfoButtonWithBlock: (void(^)())clickLoockMYInfoButton;

@end
