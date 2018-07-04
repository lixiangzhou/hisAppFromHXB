//
//  HXBFinanctingViewModel_PlanList.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageModel_PlanList;
///红利计划的首页ViewModel

typedef enum : NSUInteger {
    planType_newComer,
    playType_HXB,
    planType_invest
} PlanType;

@interface HXBFinHomePageViewModel_PlanList : NSObject
///红利计划的model
@property (nonatomic,strong) HXBFinHomePageModel_PlanList *planListModel;
///红利计划列表页的年计划利率
@property (nonatomic,copy) NSAttributedString *expectedYearRateAttributedStr;
///红利计划待出售状态
@property (nonatomic,copy) NSString *unifyStatus;
///是否隐藏倒计时
@property (nonatomic,assign) BOOL isHidden;
///是否需要倒计时
@property (nonatomic,assign) BOOL isCountDown;
///倒计时的String
@property (nonatomic,copy) NSString *countDownLastStr;
///储存倒计时时间的string
@property (nonatomic,copy) NSString *countDownString;
/// 等待加入的时候，剩余时间大于一小时
@property (nonatomic,copy) NSString *remainTimeString;
/// 加入按钮的图片
@property (nonatomic,strong) UIImage *addButtonBackgroundImage;
///加入按钮的字体颜色
@property (nonatomic,strong) UIColor *addButtonTitleColor;

#pragma mark --- 新手专区新增辅助属性
// 计划类型
@property (nonatomic, assign) PlanType planType;
// 计划期限 （天就取天 月取月 没有值 --）
@property (nonatomic, copy) NSAttributedString *lockPeriod;


@property (nonatomic, copy) NSAttributedString *nameAttributeString;
@property (nonatomic, copy) NSAttributedString *tagAttributeString;
/// 是否有 加息、满减、抵扣
@property (nonatomic, assign) BOOL hasHappyThing;

@end
