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
///总计100美元
@property (nonatomic,copy) NSString *totalInterestPer100;
///string	剩余可投金额
@property (nonatomic,copy) NSString *surplusAmount;
///左边的月数
@property (nonatomic,copy) NSString *leftMonths;
@end
