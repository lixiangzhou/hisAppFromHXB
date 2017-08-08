//
//  HXBBaseView_MYList_TableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;
@class HXBMYViewModel_MainLoanViewModel;
@class HXBBaseView_MYList_TableViewCellManager;
///红利计划的tableView 的cell
@interface HXBBaseView_MYList_TableViewCell : UITableViewCell
- (void)setUPValueWithManagerBlock: (HXBBaseView_MYList_TableViewCellManager *(^)(HXBBaseView_MYList_TableViewCellManager *manager))setUPValueManagerBlock;
///数据源
@property (nonatomic,strong) HXBMYViewModel_MianPlanViewModel *planViewMode;
@property (nonatomic,strong) HXBMYViewModel_MainLoanViewModel *loanViewModel;
@end

@interface HXBBaseView_MYList_TableViewCellManager : NSObject
/**
 名字
 */
@property (nonatomic,copy) NSString * nameLable;
////左边的
@property (nonatomic,copy) NSString * investmentAmountLable;
///计划的 已获利息
@property (nonatomic,copy) NSString * toBeReceived;
///预期年利率
@property (nonatomic,copy) NSString * nextRepaymentDay;
///计划状态
@property (nonatomic,copy) NSString * theNumberOfPeriods;
///@"加入金额(元)";
@property (nonatomic,copy) NSString * investmentAmountLable_const;
///@"已获收益（元）";
@property (nonatomic,copy) NSString * toBeReceived_const;
///@"预期年利率";
@property (nonatomic,copy) NSString * nextRepaymentDay_const;
@end


