//
//  HXBFinHomePageViewModel_LoanList.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinHomePageModel_LoanList;
///散标列表页- 一级界面ViewModel
@interface HXBFinHomePageViewModel_LoanList : NSObject
@property (nonatomic,strong) HXBFinHomePageModel_LoanList *loanListModel;
///状态
@property (nonatomic,copy) NSString *status;
///红利计划列表页的年计划利率
@property (nonatomic,copy) NSAttributedString *expectedYearRateAttributedStr;
@end
