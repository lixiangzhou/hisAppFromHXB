//
//  HXBMY_Loan_DetailView.h
//  hoomxb
//
//  Created by HXB on 2017/6/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBBaseView_TwoLable_View.h"//上下或者左右的label
#import "HXBBaseView_MoreTopBottomView.h"///多个上下 层的view

@class HXBMY_Loan_DetailViewManager;
@interface HXBMY_Loan_DetailView : UIView
- (void)setUPValueWithManagerBlock: (HXBMY_Loan_DetailViewManager *(^)(HXBMY_Loan_DetailViewManager *manager))managerBlock;
/**
 投资记录的点击事件
 协议
 */
- (void)clickBottomTableViewCellBloakFunc:(void(^)(NSInteger index))clickBottomTableViewCell;
@end

@interface HXBMY_Loan_DetailViewManager : NSObject
/**
 代售金额
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *toRepayLableManager;
/**
 下一个还款日
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *nextRepayDateLableManager;
/**
 月收本金
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *monthlyPrincipalManager;
/**
 已还期数
 */
@property (nonatomic,copy) NSString *termsLeftStr;
@property (nonatomic,copy) NSString *statusImageName;

/**
 中间的展示信息的view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *infoViewManager;
/**
 合同
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *contractLabelManager;
///一个cell只有一个字符串的
@property (nonatomic,strong) NSArray <NSString *>*strArray;
@end
