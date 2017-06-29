//
//  HXBMYViewModel_MainLoanViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestType_MYManager.h"

#import "HXBMyModel_MainLoanModel.h"



///我的 loan ViewModel
@interface HXBMYViewModel_MainLoanViewModel : NSObject

@property (nonatomic,strong) HXBMyModel_MainLoanModel *loanModel;

/**
 待收本息 如果是收益中（为利率）
 */
@property (nonatomic,copy) NSString * toRepay;
///@"已获收益（元）"
@property (nonatomic,copy) NSString * toBeReceived_const;
/**
 已还期数
 */
@property (nonatomic,copy) NSString * goBackLoanTime;

/**
 下次还款日
 */
@property (nonatomic,copy) NSString * nextRepayDate;
/**
 下次还款日 UI
 */
@property (nonatomic,copy) NSString * nextRepaymentDay_const;

/**
 月收本息(元)
 */
@property (nonatomic,copy) NSString * monthlyRepay;


/**
 投资金额
 */
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * investmentAmountLable_const;
/**
 利率
 */
@property (nonatomic,copy) NSString * interest;
/**
 期限
 */
@property (nonatomic,copy) NSString * termsInTotal;
/**
 还款方式
 */
@property (nonatomic,copy) NSString * loanType;

/**
 状态
 */
@property (nonatomic,copy) NSString *status;
/**
 已收本息
 */
@property (nonatomic,copy) NSString * repaid;


// -------------------- 针对cell
/**
   如果是收益中（待收本息） ： 投标中（利率）
 */
@property (nonatomic,copy) NSString *toRepayCellValue;
// 如果为收益中 （下一还款日） ： 投标中（投资进度）
@property (nonatomic,copy) NSString *nextRepayDateCellValue;
///如果为收益中 （已还期数） ： 投标中（期限）
@property (nonatomic,copy) NSString *goBackLoanTimeCellValue;


/////请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanResponsType responsType;
/////请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanRequestType requestType;
///相应的类型
//@property (nonatomic,copy) NSString *responsStatus;

@end




