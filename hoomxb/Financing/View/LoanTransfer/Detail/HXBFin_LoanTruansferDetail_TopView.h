//
//  HXBFin_LoanTruansferDetail_TopView.h
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBaseView_TwoLable_View_ViewModel,HXBFin_LoanTruansferDetail_TopViewManager;
@interface HXBFin_LoanTruansferDetail_TopView : UIView
- (void)setUPValueWithManager: (HXBFin_LoanTruansferDetail_TopViewManager *(^)(HXBFin_LoanTruansferDetail_TopViewManager *manager))setUPValueManagerBlock;
@end

@interface HXBFin_LoanTruansferDetail_TopViewManager : NSObject
/**
 顶部的后面的遮罩
 */
@property (nonatomic,copy) NSString *topMaskView;
/**
 下个还款日 05-31
 品字形 上右
 */
@property (nonatomic,copy) NSString *nextOneLabel;
/**
 年利率 label
 品字形 上
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *interestLabelManager;
/**
 剩余期限
 品字形 左
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *remainTimeLabelManager;
/**
 待转让金额
 品字形 右
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *truansferAmountLabelManager;
@end
