//
//  HXBFinModel_AddRecortdModel_LoanTruansfer.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"

@implementation HXBFinModel_AddRecortdModel_LoanTruansfer
/**
 债权出售人
 */

/**
 债权购买人
 */
//- (void)setToUserId:(NSString *)toUserId {
//    _toUserId = [NSString hiddenStr:toUserId MidWithFistLenth:3 andLastLenth:2];
//}
/**
 交易金额
 */
///	int	投资金额
- (void) setAmount:(NSString *)amount {
    _amount = amount;
    _amount = [NSString hxb_getPerMilWithDouble:amount.floatValue];
}
/**
 转让时间
 */
///	int	投资时间
- (void)setCreateTime:(NSString *)createTime {
    
    _createTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:createTime andDateFormat:@"yyyy-MM-dd HH:mm"];
}
@end
