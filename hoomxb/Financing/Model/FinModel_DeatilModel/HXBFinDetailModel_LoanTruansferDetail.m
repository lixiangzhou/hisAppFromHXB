//
//  HXBFinDetailModel_LoanTruansferDetail.m
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailModel_LoanTruansferDetail.h"

@implementation HXBFinDetailModel_LoanTruansferDetail


/**
 标的id
 */
-(NSString *)loanId {
    return self.loanVo.loanId;
}
/**
 转让id
 */
-(NSString *)transferId {
    return self.transferDetail.transferId;
}
/**
 是否可以购买(true:可以购买；false:不可以购买)
 */
-(BOOL) isEnabledBuy {
    if ([self.enabledBuy isEqualToString:@"true"]) {
        return YES;
    }
    return NO;
}

/**
 剩余期数
 */
-(NSString *) leftMonths {
    return self.transferDetail.leftMonths;
}
/**
 借款期数
 */
-(NSString *) loanMonths {
    return self.transferDetail.loanMonths;
}
/**
 初始转让金额
 */
-(NSString *) creatTransAmount {
    return self.transferDetail.creatTransAmount;
}
/**
 剩余金额
 */
-(NSString *) leftTransAmount {
    return self.transferDetail.leftTransAmount;
}
/**
 状态
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
-(NSString *) status {
    return self.loanVo.status;
}
@end

@implementation HXBFinDetailModel_LoanTruansferDetail_loanVO
@end



@implementation HXBFinDetailModel_LoanTruansferDetail_transferDetail
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"creatTransAmount" : @"initTransAmount"};
}
@end


@implementation HXBFinDetailModel_LoanTruansferDetail_userLoanRecord
@end


@implementation HXBFinDetailModel_LoanTruansferDetail_idCardInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end


@implementation HXBFinDetailModel_LoanTruansferDetail_creditInfo
@end


@implementation HXBFinDetailModel_LoanTruansferDetail_userVo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end
