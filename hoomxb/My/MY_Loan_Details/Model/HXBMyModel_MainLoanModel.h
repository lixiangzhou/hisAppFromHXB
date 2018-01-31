//
//  HXBMyModel_MainLoanModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///我的 loan Model
@interface HXBMyModel_MainLoanModel : NSObject
///月还利息
@property (nonatomic,copy) NSString *monthlyInterest;// 1053,
///总期数
@property (nonatomic,copy) NSString *termsInTotal;//12,
///剩余期数
@property (nonatomic,copy) NSString *termsLeft;//12,
//贷款散标
@property (nonatomic,copy) NSString *loanTitle;
///金额
@property (nonatomic,copy) NSString *amount;//95500,

@property (nonatomic,copy) NSString *share;//95500
///利率
@property (nonatomic,copy) NSString *interest;//10.8
///"XYRZ",
@property (nonatomic,copy) NSString *loanType;
///
@property (nonatomic,copy) NSString *monthlyPrincipal;//9276.74
////月还本金
@property (nonatomic,copy) NSString *monthlyRepay;//10329.74
///月还本息
@property (nonatomic,copy) NSString *status;
///还款中
@property (nonatomic,copy) NSString *repaid;//0
///已收本息
@property (nonatomic,copy) NSString *transferable;
///散标ID
@property (nonatomic,copy) NSString *loanId;//761215
///下次还款日
@property (nonatomic,copy) NSString *nextRepayDate;//1497168004000,
///待收本息
@property (nonatomic,copy) NSString *toRepay;//123956.92
///投标进度
@property (nonatomic,copy) NSString *progress;
///是否为债权转让
@property (nonatomic, assign) BOOL isBuyTransfer;

/**
 判断是否可以进行转让
 */
@property (nonatomic, assign) BOOL isTransferable;

- (void)steUPProperty;
@end
