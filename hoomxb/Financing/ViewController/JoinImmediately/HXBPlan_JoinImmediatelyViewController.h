//
//  HXBPlan_JoinImmediatelyViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetailViewModel_PlanDetail;
///plan 立即加入
@interface HXBPlan_JoinImmediatelyViewController : HXBBaseViewController
@property (nonatomic,assign) BOOL isPlan;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) HXBFinDetailViewModel_PlanDetail *planViewModel;
@end
