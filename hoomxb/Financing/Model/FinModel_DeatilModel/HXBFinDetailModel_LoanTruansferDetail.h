//
//  HXBFinDetailModel_LoanTruansferDetail.h
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseModel.h"

@interface HXBFinDetailModel_LoanTruansferDetail : HXBBaseModel
/**
 标的id
 */
@property (nonatomic,copy) NSString * loanId;
/**
 转让id
 */
@property (nonatomic,copy) NSString * transferId;
/**
 是否可以购买(true:可以购买；false:不可以购买)
 */
@property (nonatomic,copy) NSString * enabledBuy;
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
@property (nonatomic,copy) NSString * creatTransAmount;
/**
 剩余金额
 */
@property (nonatomic,copy) NSString * leftTransAmount;
/**
 状态
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
@property (nonatomic,copy) NSString * status;

@end
