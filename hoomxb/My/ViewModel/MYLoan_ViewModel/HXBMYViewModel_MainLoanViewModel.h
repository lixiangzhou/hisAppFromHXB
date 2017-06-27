//
//  HXBMYViewModel_MainLoanViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestType_MYManager.h"
@class HXBMyModel_MainLoanModel;




///我的 loan ViewModel
@interface HXBMYViewModel_MainLoanViewModel : NSObject

@property (nonatomic,strong) HXBMyModel_MainLoanModel *loanModel;

/**
 待收本息
 */
@property (nonatomic,copy) NSString * toRepay;
/**
 已还期数
 */
@property (nonatomic,copy) NSString * goBackLoanTime;

/**
 下次还款日
 */
@property (nonatomic,copy) NSString * nextRepayDate;

/**
 月收本息(元)
 */
@property (nonatomic,copy) NSString * monthlyRepay;


/**
 投资金额
 */
@property (nonatomic,copy) NSString * amount;
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
 已收本息
 */
@property (nonatomic,copy) NSString * repaid;

/////请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanResponsType responsType;
/////请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanRequestType requestType;
///相应的类型
//@property (nonatomic,copy) NSString *responsStatus;

@end




