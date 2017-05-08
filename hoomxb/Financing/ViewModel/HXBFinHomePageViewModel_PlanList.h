//
//  HXBFinanctingViewModel_PlanList.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageModel_PlanList;
@interface HXBFinHomePageViewModel_PlanList : NSObject
///红利计划的model
@property (nonatomic,strong) HXBFinHomePageModel_PlanList *planListModel;
///红利计划列表页的年计划利率
@property (nonatomic,copy) NSAttributedString *expectedYearRateAttributedStr;
///红利计划待出售状态
@property (nonatomic,copy) NSString *unifyStatus;

///倒计时的String
@property (nonatomic,copy) NSString *countDownLastStr;
///储存倒计时时间的string
@property (nonatomic,copy) NSString *countDownString;
///倒计时的block
@property (nonatomic,copy) void(^countDownBlock)(NSString *countDownString);
@end
