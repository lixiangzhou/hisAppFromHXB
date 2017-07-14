//
//  HXBFinHomePageViewModel_LoanTruansferViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBFinHomePageModel_LoanTruansferList.h"
@interface HXBFinHomePageViewModel_LoanTruansferViewModel : NSObject
@property (nonatomic,strong) HXBFinHomePageModel_LoanTruansferList *loanTruansferListModel;

/**
 transferId	int	转让id
 */
@property (nonatomic,copy) NSString * transferId;
/**
 借款标题
 */
@property (nonatomic,copy) NSString * title;
/**
 利率
 */
@property (nonatomic,copy) NSString * interest;
/**
 详情用的利率 富文本
 */
@property (nonatomic,copy) NSAttributedString *interestAttibute;
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
@property (nonatomic,copy) NSString * transAmount;
/**
 剩余金额 （元）
 */
@property (nonatomic,copy) NSString * leftTransAmount;
/**
 剩余金额 (带了 待转让金额：000元)
 */
@property (nonatomic,copy) NSString * leftTransAmount_YUAN;

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
