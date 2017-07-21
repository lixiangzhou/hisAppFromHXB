//
//  HXBFinDetailViewModel_LoanTruansferDetail.h
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailModel_LoanTruansferDetail.h"
@interface HXBFinDetailViewModel_LoanTruansferDetail : HXBBaseViewModel
@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail *loanTruansferDetailModel;
/**
 1000 起投 1000递增
 */
@property (nonatomic,copy) NSString * startIncrease_Amount;
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
/**
 状态 (汉字)
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
@property (nonatomic,copy) NSString *status_UI;
/**
 * 剩余期数
 */
@property (nonatomic,copy) NSString *leftMonths;
/**
 * 贷款期数
 */
@property (nonatomic,copy) NSString *loanMonths;

/**
 初始转让金额
 */
@property (nonatomic,copy) NSString * creatTransAmount;
/**
 剩余金额
 */
@property (nonatomic,copy) NSString * leftTransAmount;
/**
 复议协议 《贷款协议》
 */
@property (nonatomic,copy) NSString *agreementTitle;
/**
 是否可以点击确认投资
 */
@property (nonatomic,assign) BOOL isAddButtonEditing;
/**
 协议URL
 */
@property (nonatomic,copy) NSString * agreementURL;
@end
