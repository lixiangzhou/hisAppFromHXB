//
//  HXBFinPlanDetail_DetailView.h
//  hoomxb
//
//  Created by HXB on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinPlanDetail_DetailViewManager;
@interface HXBFinPlanDetail_DetailView : UIView
@property (nonatomic,strong) HXBFinPlanDetail_DetailViewManager *manager;


- (instancetype) initWithFrame:(CGRect)frame withCashType:(NSString *) cashType;

- (void)setValueManager_PlanDetail_Detail: (HXBFinPlanDetail_DetailViewManager *(^)(HXBFinPlanDetail_DetailViewManager *manager))planDDetailManagerBlock;

///点击了红利智投服务协议
- (void)clickServerButtonWithBlock: (void(^)(UILabel *button))clickServerButtonBlock;


@end
@interface HXBFinPlanDetail_DetailViewManager: NSObject

/**
 适合人群
 */
//@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *pursuitsViewManager;
/**
 计划金额
 加入条件
 加入上线
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *addViewManager;
/**
 开始加入日期
 退出日期
 期限
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *dateViewManager;
/**
 到期退出方式
 安全屏障
 受益处理方式
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *typeViewManager;
/**
 服务费
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *serverViewManager;

/**
 服务费 富文本
 */
@property (nonatomic,copy) NSAttributedString *serverViewAttributedStr;

/**
 退出方式说明
 */
@property (nonatomic, copy) NSString *quitWaysDesc;
@end
