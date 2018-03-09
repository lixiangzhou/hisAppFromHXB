//
//  HXBMy_Plan_Buy_ViewController.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBFinDetailViewModel_PlanDetail,HXBJoinImmediateView_Model;

@interface HXBMy_Plan_Buy_ViewController : HXBBaseViewController

@property (nonatomic,assign) BOOL isPlan;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) HXBFinDetailViewModel_PlanDetail *planViewModel;

@property (nonatomic,copy) NSString *availablePoint;    //可用余额

@property (nonatomic,copy) void(^callBackBlock)();
- (void)clickLookMYInfoButtonWithBlock: (void(^)())clickLoockMYInfoButton;
@end
