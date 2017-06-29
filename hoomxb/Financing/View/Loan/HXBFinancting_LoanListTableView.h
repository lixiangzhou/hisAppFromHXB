//
//  HXBFinancting_LoanListTableView.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_LoanList;
@interface HXBFinancting_LoanListTableView : HXBBaseTableView
///点击散标列表后回调，跳转详情页
@property (nonatomic,copy) void (^clickLoanListCellBlock)(NSIndexPath *index, id model);
///年利率文字
@property (nonatomic,strong) NSString *expectedYearRateLable_ConstStr;
///期限
@property (nonatomic,strong) NSString *lockPeriodLabel_ConstStr;
///数据源
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_LoanList *>*loanListViewModelArray;

- (void)setSubView;
@end
