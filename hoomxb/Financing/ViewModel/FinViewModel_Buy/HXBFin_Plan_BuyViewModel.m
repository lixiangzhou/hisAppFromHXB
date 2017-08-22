//
//  HXBFin_Plan_BuyViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Plan_BuyViewModel.h"

@implementation HXBFin_Plan_BuyViewModel

/**
 开始计息
 */
- (NSString *) lockStart {
    if (!_lockStart) {
        _lockStart = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.buyPlanModel.lockStart andDateFormat:@"MM月dd日"];
        _lockStart = [NSString stringWithFormat:@"预计%@开始计息",_lockStart];  
    }
    return _lockStart;
}
@end
