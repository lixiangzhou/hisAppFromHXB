//
//  HXBconfirmBuyReslut.m
//  hoomxb
//
//  Created by HXB on 2017/6/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinModel_BuyResoult_PlanModel.h"

@implementation HXBFinModel_BuyResoult_PlanModel
/**
 开始计息
 */
- (NSString *) lockStart {
    NSString *timeStr = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:_lockStart andDateFormat:@"MM月dd日"];
    _lockStart = [NSString stringWithFormat:@"预计%@开始计息", _lockStart ? timeStr : @"--月--日"];
    return _lockStart;
}

@end

@implementation HXBFinModel_BuyResoult_PlanModel_context

@end


@implementation HXBFinModel_BuyResoult_PlanModel_stateInput

@end

@implementation HXBFinModel_BuyResoult_PlanModel_context_transInput

@end

@implementation HXBFinModel_BuyResoult_PlanModel_context_transInput_reserve2

@end
