//
//  HXBFinDetailViewModel_LoanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinDatailModel_LoanDetail;
///散标投递的详情页的ViewModel
@interface HXBFinDetailViewModel_LoanDetail : NSObject
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail *loanDetailModel;


/**
 status 标的状态
 */
@property (nonatomic,copy) NSString * status;
/**
 string	剩余可投金额
 */
@property (nonatomic,copy) NSString *surplusAmount;
/**
 剩余可投：为0时或状态为已满标、收益中时，字段变为标的金额
 */
@property (nonatomic,copy) NSString *surplusAmount_ConstStr;

///左边的月数
@property (nonatomic,copy) NSString *leftMonths;

///收益方法
@property (nonatomic,copy) NSString *loanType;
/// ￥1000起投，1000递增 placeholder
@property (nonatomic,copy) NSString *addCondition;
///加入上线
@property (nonatomic,copy) NSString *unRepaid;
///预计收益 在 加入计划的 view 内部计算
@property (nonatomic,copy) NSString *totalInterestPer100;
///服务协议 button str
@property (nonatomic,copy) NSString *agreementTitle;
/**
 标的期限
 */
@property (nonatomic,copy) NSString * lockPeriodStr;

/**
 ///确认加入的Buttonstr
 */
@property (nonatomic,copy) NSString * addButtonStr;

/**
 addButton是否可以点击
 */
@property (nonatomic,assign) BOOL isAddButtonEditing;

@end
