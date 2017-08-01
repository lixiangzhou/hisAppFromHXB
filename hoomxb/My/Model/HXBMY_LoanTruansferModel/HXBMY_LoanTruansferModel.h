//
//  HXBMY_LoanTruansferModel.h
//  hoomxb
//
//  Created by HXB on 2017/8/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseModel.h"

@interface HXBMY_LoanTruansferModel : HXBBaseModel
/**
转让id
 */
@property (nonatomic,copy) NSString * transferId;
/**
 标的id
 */
@property (nonatomic,copy) NSString * loanId;
/**
 	借款标题
 */
@property (nonatomic,copy) NSString * title;
/**
 利率
 */
@property (nonatomic,copy) NSString * interest;
/**
 剩余期数
 */
@property (nonatomic,copy) NSString * leftMonths;
/**
 借款期数
 */
@property (nonatomic,copy) NSString * loanMonths;
/**
 初始转让金额
 */
@property (nonatomic,copy) NSString * creatTruansAmount;
/**
 剩余金额
 */
@property (nonatomic,copy) NSString * leftTransAmount;
/**
 状态
 */
@property (nonatomic,copy) NSString * status;
@end
