//
//  HXBFinDetailViewModel_LoanTruansferDetail.h
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"
@interface HXBFinDetailViewModel_LoanTruansferDetail : HXBBaseViewModel
@property (nonatomic,strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferDetailModel;
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
@end