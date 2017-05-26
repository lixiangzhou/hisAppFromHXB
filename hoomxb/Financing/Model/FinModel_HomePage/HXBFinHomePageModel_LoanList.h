//
//  HXBFinHomePageModel_LoanList.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

////接口 lend/loanindex
@interface HXBFinHomePageModel_LoanList : NSObject

///	string	借款总额
@property (nonatomic,copy) NSString *amount;
///	string	借款周期（月）
@property (nonatomic,copy) NSString *months;
//	string	借款标题
@property (nonatomic,copy) NSString *title;
///	string	交易状态(参考通用说明里标的状态)
@property (nonatomic,copy) NSString *status;
///	string	利率
@property (nonatomic,copy) NSString *interest;
///	string	信用认证：’XYRZ’-信用认证标、’SDRZ’-实地认证标、’JGDB’-机构担保标、’ZNLC’-智能理财标
@property (nonatomic,copy) NSString *certificateType;
///	string	等级名称（HR、E、D、C、B、A、AA）
@property (nonatomic,copy) NSString *borrowerLevel;
///	string	完成率
@property (nonatomic,copy) NSString *finishedRatio;
///string	标ID
@property (nonatomic,copy) NSString *loanId;
///	Int	总条数
@property (nonatomic,copy) NSString *totalCount;
///	Int	每页多少条
@property (nonatomic,copy) NSString *pageSize;
///	Int	第几页
@property (nonatomic,copy) NSString *pageNumber;
@end
/**
 "amount": "6000.0",
 "months": "12",
 "title": "这个必须得填，否则接口啥也不给你返回！",
 "status": "OPEN",
 "interest": "9.0",
 "certificateType": "SDRZ",
 "borrowerLevel": "HR",
 "finishedRatio": "99.0",
 "loanId": "760645"
 */
