//
//  HXBFin_LoanDetailView_TopView.h
//  hoomxb
//
//  Created by HXB on 2017/7/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXBBaseView_TwoLable_View.h"

@class HXBFin_LoanDetailView_TopViewManager;

@interface HXBFin_LoanDetailView_TopView : HXBColourGradientView
- (void)setUPValueWithManager: (HXBFin_LoanDetailView_TopViewManager *(^)(HXBFin_LoanDetailView_TopViewManager *manager))managerBlock;
@end

@interface HXBFin_LoanDetailView_TopViewManager : NSObject
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *topViewManager;//年利率
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *leftViewManager;//期限
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *rightViewManager;//剩余可投金额
@end
